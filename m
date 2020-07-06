Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F20215E35
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2020 20:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbgGFSV2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jul 2020 14:21:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:28389 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbgGFSV2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Jul 2020 14:21:28 -0400
IronPort-SDR: F0OSj33hXCgrOeqV2rZBzt/C1UxPOoE0Ytfj7fPFv73SDi56mjlbEg0DUFZ76Ae1g853pQ4LOL
 kmU4hNOywF9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="127556108"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="127556108"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 11:21:27 -0700
IronPort-SDR: ev0ZP96hyj6TSPU1iQaQWf9863WfkMZYRXDmWmbC817FNQLYu5HwBPuZVt8ybvKtqlr7G8hDZu
 KRDwRvq9DGMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="427187265"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004.jf.intel.com with ESMTP; 06 Jul 2020 11:21:26 -0700
Subject: [PATCH v3 0/6] Add shared workqueue support for idxd driver
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>, Jing Lin <jing.lin@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, dan.j.williams@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tony.luck@intel.com, jing.lin@intel.com
Date:   Mon, 06 Jul 2020 11:21:26 -0700
Message-ID: <159405827797.19216.15283540319201919054.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

V3:
- Rebased against latest dmaengine/next tree.
- Updated API doc with new kernel version and dates.
- Changed to allow driver to load without ENQCMD support.
- Break out some patches that can be sent ahead of this series for inclusion.

v2:
- Dropped device feature enabling (GregKH)
- Dropped PCI device feature enabling (Bjorn)
	- https://members.pcisig.com/wg/PCI-SIG/document/14237
- After some internal discussion, we have decided to hold off on the enabling of DMWR due to the
  following reasons. 1. Most first gen hw will not have the feature bits. 2. First gen hw that
  support the feature are all Root Complex integrated endpoints. 3. PCI devices that are not
  RCiEP’s with this capability won’t surface for a few years so we can wait until we can test the
  full code.
- Dropped special ioremap (hch)
- Added proper support for WQ flush (tony, dan)
- Changed descriptor submission to use sbitmap_queue for blocking. (dan)

Driver stage 1 postings for context: [1]

The patch series has compilation and functional dependency on Fenghua's "Tag application
address space for devices" patch series for the ENQCMD CPU command enumeration and the PASID MSR
support. [2] 

First patch in the series is only there to assist with compilation. Can be dropped once Fenghua’s
series is accepted by the x86 maintainers.

== Background ==
A typical DMA device requires the driver to translate application buffers to hardware addresses,
and a kernel-user transition to notify the hardware of new work. Shared Virtual Addressing (SVA)
allows the processor and device to use the same virtual addresses without requiring software to
translate between the address spaces. ENQCMD is a new instruction on Intel Platforms that allows
user applications to directly notify hardware of new work, much like how doorbells are used in
some hardware, but it carries a payload along with it. ENQCMDS is the supervisor version (ring0)
of ENQCMD.

== ENQCMDS ==
Introduce enqcmds(), a helper funciton that copies an input payload to a 64B aligned
destination and confirms whether the payload was accepted by the device or not.
enqcmds() wraps the new ENQCMDS CPU instruction. The ENQCMDS is a ring 0 CPU instruction that
performs similar to the ENQCMD instruction. Descriptor submission must use ENQCMD(S) for shared
workqueues (swq) on an Intel DSA device. 

== Shared WQ support ==
Introduce shared workqueue (swq) support for the idxd driver. The current idxd driver contains
dedicated workqueue (dwq) support only. A dwq accepts descriptors from a MOVDIR64B instruction.
MOVDIR64B is a posted instruction on the PCIe bus, it does not wait for any response from the
device. If the wq is full, submitted descriptors are dropped. A swq utilizes the ENQCMDS in
ring 0, which is a non-posted instruction. The zero flag would be set to 1 if the device rejects
the descriptor or if the wq is full. A swq can be shared between multiple users
(kernel or userspace) due to not having to keep track of the wq full condition for submission.
A swq requires PASID and can only run with SVA support. 

== IDXD SVA support ==
Add utilization of PASID to support Shared Virtual Addressing (SVA). With PASID support,
the descriptors can be programmed with host virtual address (HVA) rather than IOVA.
The hardware will work with the IOMMU in fulfilling page requests. With SVA support,
a user app using the char device interface can now submit descriptors without having to pin the
virtual memory range it wants to DMA in its own address space. 

The series does not add SVA support for the dmaengine subsystem. That support is coming at a
later time.

[1]: https://lore.kernel.org/lkml/157965011794.73301.15960052071729101309.stgit@djiang5-desk3.ch.intel.com/
[2]: https://lkml.org/lkml/2020/6/30/1266
[3]: https://software.intel.com/en-us/articles/intel-sdm
[4]: https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
[5]: https://software.intel.com/en-us/download/intel-data-streaming-accelerator-preliminary-architecture-specification
[6]: https://01.org/blogs/2019/introducing-intel-data-streaming-accelerator
[7]: https://intel.github.io/idxd/
[8]: https://github.com/intel/idxd-driver idxd-stage2

---

Dave Jiang (5):
      x86/asm: move the raw asm in iosubmit_cmds512() to special_insns.h
      x86/asm: add enqcmds() to support ENQCMDS instruction
      dmaengine: idxd: add shared workqueue support
      dmaengine: idxd: clean up descriptors with fault error
      dmaengine: idxd: add ABI documentation for shared wq

Fenghua Yu (1):
      x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions


 Documentation/ABI/stable/sysfs-driver-dma-idxd |   14 ++
 arch/x86/include/asm/cpufeatures.h             |    1 
 arch/x86/include/asm/io.h                      |   45 +++++---
 arch/x86/include/asm/special_insns.h           |   17 +++
 arch/x86/kernel/cpu/cpuid-deps.c               |    1 
 drivers/dma/Kconfig                            |   13 ++
 drivers/dma/idxd/cdev.c                        |   47 ++++++++
 drivers/dma/idxd/device.c                      |   91 ++++++++++++++-
 drivers/dma/idxd/dma.c                         |    9 --
 drivers/dma/idxd/idxd.h                        |   26 ++++
 drivers/dma/idxd/init.c                        |   91 ++++++++++++---
 drivers/dma/idxd/irq.c                         |  143 ++++++++++++++++++++++--
 drivers/dma/idxd/registers.h                   |   14 ++
 drivers/dma/idxd/submit.c                      |   33 +++++-
 drivers/dma/idxd/sysfs.c                       |  127 +++++++++++++++++++++
 15 files changed, 602 insertions(+), 70 deletions(-)

--
