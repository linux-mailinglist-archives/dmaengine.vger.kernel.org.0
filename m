Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5EB26E731
	for <lists+dmaengine@lfdr.de>; Thu, 17 Sep 2020 23:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgIQVPQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Sep 2020 17:15:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:49526 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgIQVPQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Sep 2020 17:15:16 -0400
IronPort-SDR: oo4HCNJy8bCdH1N7ajAzxGUYVZy8otkcc2kGq8tw3ICCTPgKcyiKWOcWBxRCMrto5uN1G1Djgi
 9jQkV6yO7NqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="147482221"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="147482221"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 14:15:11 -0700
IronPort-SDR: 3SlFe7dPrSedK6ReDX9jb77NrQiJecgcjsIrY7x6a1t4u54R6spD11FPfO/2lG60zcbaB+sM6S
 l2yNTgmGYRwQ==
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="452477797"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 14:15:10 -0700
Subject: [PATCH v4 0/5] Add shared workqueue support for idxd driver
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
        jing.lin@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Sep 2020 14:15:10 -0700
Message-ID: <160037680630.3777.16356270178889649944.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

v4:
- Rebased against latest dmaengine/next tree
- Split out enqcmd and pasid dependency.

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
[2]: https://lore.kernel.org/lkml/20200916080510.GA32552@8bytes.org/
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


 Documentation/ABI/stable/sysfs-driver-dma-idxd |   14 ++
 arch/x86/include/asm/io.h                      |   46 +++++---
 arch/x86/include/asm/special_insns.h           |   17 +++
 drivers/dma/Kconfig                            |   10 ++
 drivers/dma/idxd/cdev.c                        |   49 ++++++++
 drivers/dma/idxd/device.c                      |   91 ++++++++++++++-
 drivers/dma/idxd/dma.c                         |    9 --
 drivers/dma/idxd/idxd.h                        |   33 +++++-
 drivers/dma/idxd/init.c                        |   92 ++++++++++++---
 drivers/dma/idxd/irq.c                         |  143 ++++++++++++++++++++++--
 drivers/dma/idxd/registers.h                   |   14 ++
 drivers/dma/idxd/submit.c                      |   33 +++++-
 drivers/dma/idxd/sysfs.c                       |  127 +++++++++++++++++++++
 13 files changed, 608 insertions(+), 70 deletions(-)

--
