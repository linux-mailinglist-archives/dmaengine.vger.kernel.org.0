Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0496319866B
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2020 23:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgC3V0u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Mar 2020 17:26:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:41438 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbgC3V0u (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 30 Mar 2020 17:26:50 -0400
IronPort-SDR: dpo5ufSHwsMQXSGBtsZvtd37b9JT4QYhf3/Au0Olmy6Ym2DOfshmcakjDEhWrAUN5kbLCoT49X
 aVlpH8ALMEWA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 14:26:49 -0700
IronPort-SDR: 7OseBlbYnckWzzWxFUuPK5S1UVxpiaR16v9WTpXluCfZ/N6FX4iRn4zmNTuwO56cl1TQnmZ3E/
 05dztNm0fOGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="267064542"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002.jf.intel.com with ESMTP; 30 Mar 2020 14:26:48 -0700
Subject: [PATCH 0/6] Add shared workqueue support for idxd driver
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        ashok.raj@intel.com, fenghua.yu@intel.com,
        linux-pci@vger.kernel.org, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com
Date:   Mon, 30 Mar 2020 14:26:48 -0700
Message-ID: <158560290392.6059.16921214463585182874.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The patch series breaks down into following parts:
Patch 1: x86 arch, add a new I/O accessor based on ENQCMDS
Patches 2,3: PCI
Patch 4: device
Patches 5,6: idxd driver shared WQ support

Driver stage 1 postings for context: [1]

This patch series is dependent on Fenghua's "Tag application address space
for devices" patch series for the ENQCMD CPU command enumeration and the
PASID MSR support. [2]

This patch series introduces support for shared workqueue (swq) for the
idxd driver that is supported by the Intel Data Streaming Accelerator (DSA). In
the stage 1 patch series posting, only dedicated workqueues (dwq) are
supported. Another major feature being introduced is Shared Virtual Memory (SVM)
support.

In this patch series, we introduce the iosubmit_cmds512_sync() command.
This function enables the calling of the new ENQCMDS CPU instruction on the
Intel CPU. ENQCMDS is a ring0 CPU instruction that performs similar function as
the ENQCMD. The CPUID capability bit will enumerate ENQCMD is supported,
which implies that ENQCMDS is supported as well. The instruction creates a
non-posted write command on the PCIe bus and atomically writes all 64 bytes of a
command descriptor to the accelerator device's special BAR address. The device can
reject the command by using the zero flag. See Intel SDM [2] for additional
details. The ENQCMDS instruction is used for submitting command descriptors
to the swq. With this instruction, multiple "users" in the kernel can submit
to the swq with the synchronization done by the hardware. When the swq is
full, a 1 will be returned indicate the wq being busy. This is different than a
dwq where the command will be silently dropped without response. The dwq
requires the software to track the queue depth of a dwq.

The attribute of cmdmem device capability is being introduced to the PCI
device with ongoing discussion of adding the ability to enumerate PCIe capability
that provides the support of such device MMIO regions. A
device_supports_cmdmem(struct device *) helper function is introduced to
initially support devices that has this capability. Since the standardized
way to detect such capability is not available yet, a PCI quirk is defined
for the DSA device.

ENQCMDS moves a command descriptor (64 bytes) from memory to specific MMIO
regions on a device that supports this capability. Like MMIO, the "handle"
for these queues is just a pointer to the address of the queue in MMIO memory.
These specific MMIO regions on the device are called portals. To support
these portals, wrappers functions are introduced for ioremap() to make it clear
that the special MMIO regions that expects a response from a non-posted PCI
write are being ioremaped.

The support of SVM is done through Process Address Space ID (PASID). With
SVM support, the DMA descriptors can be programmed with virtual address for
source and destination addresses. When a page fault is encountered, the device can
fault in the memory page needed to complete the operation through the
IOMMU.  This makes calling the dma_(un)map_* API calls unnecessary which reduces
some software latencies. Both swq and dwq can support SVM.

Swq enabling has been added to the idxd char device driver to allow
exposure of the swq to the user space. User apps can call ENQCMD to submit
descriptors directly to a swq after calling mmap() on the portal. ENQCMD is
similar to the ENQCMDS instruction, but is only available to ring3
(application) code. The primary difference is that ENQCMD obtains the PASID for the
request from the IA32_PASID MSR to ensure that all virtual addresses specified by
the user are interpreted in the address space of the process that executed
ENQCMD. With the SVM enabling, the user no longer has to pin the memory and program
IO Virtual Address (IOVA) as source and address. Virtual addresses can be
programmed in the command descriptor and be submitted to the device. The
SVM handling is done through the usage of PASID. For more detailed explanation
on how ENQCMD and PASID interaction works please refer to Fenghua's submission
cover letter [6]. Multiple user apps can easily share a swq with the ENQCMD
instruction without needing software sychronization.

[1]: https://lore.kernel.org/lkml/157965011794.73301.15960052071729101309.stgit@djiang5-desk3.ch.intel.com/
[2]: https://lore.kernel.org/lkml/1585596788-193989-1-git-send-email-fenghua.yu@intel.com/
[3]: https://software.intel.com/en-us/articles/intel-sdm
[4]: https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
[5]: https://software.intel.com/en-us/download/intel-data-streaming-accelerator-preliminary-architecture-specification
[6]: https://01.org/blogs/2019/introducing-intel-data-streaming-accelerator
[7]: https://intel.github.io/idxd/
[8]: https://github.com/intel/idxd-driver idxd-stage2

---

Dave Jiang (6):
      x86/asm: add iosubmit_cmds512_sync() based on enqcmds
      device/pci: add cmdmem cap to pci_dev
      pci: add PCI quirk cmdmem fixup for Intel DSA device
      device: add cmdmem support for MMIO address
      dmaengine: idxd: add shared workqueue support
      dmaengine: idxd: add ABI documentation for shared wq


 Documentation/ABI/stable/sysfs-driver-dma-idxd |   14 ++
 arch/x86/include/asm/io.h                      |   37 ++++++
 drivers/base/core.c                            |   13 ++
 drivers/dma/Kconfig                            |    4 +
 drivers/dma/idxd/cdev.c                        |   46 +++++++-
 drivers/dma/idxd/device.c                      |  122 ++++++++++++++++++--
 drivers/dma/idxd/dma.c                         |    2 
 drivers/dma/idxd/idxd.h                        |   13 ++
 drivers/dma/idxd/init.c                        |   92 ++++++++++++---
 drivers/dma/idxd/irq.c                         |  147 ++++++++++++++++++++++--
 drivers/dma/idxd/submit.c                      |  119 ++++++++++++++-----
 drivers/dma/idxd/sysfs.c                       |  133 ++++++++++++++++++++++
 drivers/pci/quirks.c                           |   11 ++
 include/linux/device.h                         |    2 
 include/linux/io.h                             |    4 +
 include/linux/pci.h                            |    1 
 lib/devres.c                                   |   36 ++++++
 17 files changed, 721 insertions(+), 75 deletions(-)

--
