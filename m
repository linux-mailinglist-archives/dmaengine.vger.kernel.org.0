Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6843E283931
	for <lists+dmaengine@lfdr.de>; Mon,  5 Oct 2020 17:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgJEPLp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Oct 2020 11:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgJEPLp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 5 Oct 2020 11:11:45 -0400
Received: from localhost (unknown [192.55.55.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C81D20774;
        Mon,  5 Oct 2020 15:11:44 +0000 (UTC)
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, kevin.tian@intel.com,
        fenghua.yu@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/5] Add shared workqueue support for idxd driver
Date:   Mon,  5 Oct 2020 08:11:21 -0700
Message-Id: <20201005151126.657029-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

v7:
- Add sign-off and review tag from Boris
Boris:
- Fixed up ENQCMDS patch
Vinod:
- Fix line formatting
- Add comment for completion address compare

v6:
Boris:
- Fixup MOBDIR64B inline asm input/output constraints

v5:
Boris:
- Fixup commit headers
- Fixup var names for movdir64b()
- Move enqcmds() to special_insns.h
- Fix up comments for enqcmds()
- Change enqcmds() to reflect instruction return. 0 as success, -EAGAIN for fail.

DavidL:
- Fixup enqcmds() gas constraints

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

Dave Jiang (5):
  x86/asm: Carve out a generic movdir64b() helper for general usage
  x86/asm: Add an enqcmds() wrapper for the ENQCMDS instruction
  dmaengine: idxd: Add shared workqueue support
  dmaengine: idxd: Clean up descriptors with fault error
  dmaengine: idxd: Add ABI documentation for shared wq

 .../ABI/stable/sysfs-driver-dma-idxd          |  14 ++
 arch/x86/include/asm/io.h                     |  17 +-
 arch/x86/include/asm/special_insns.h          |  64 ++++++++
 drivers/dma/Kconfig                           |  10 ++
 drivers/dma/idxd/cdev.c                       |  49 +++++-
 drivers/dma/idxd/device.c                     |  91 ++++++++++-
 drivers/dma/idxd/dma.c                        |   9 --
 drivers/dma/idxd/idxd.h                       |  33 +++-
 drivers/dma/idxd/init.c                       |  92 ++++++++---
 drivers/dma/idxd/irq.c                        | 146 ++++++++++++++++--
 drivers/dma/idxd/registers.h                  |  14 ++
 drivers/dma/idxd/submit.c                     |  35 ++++-
 drivers/dma/idxd/sysfs.c                      | 127 +++++++++++++++
 13 files changed, 631 insertions(+), 70 deletions(-)

-- 
2.26.2

