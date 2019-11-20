Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43715104598
	for <lists+dmaengine@lfdr.de>; Wed, 20 Nov 2019 22:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfKTVXp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Nov 2019 16:23:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:50745 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfKTVXp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Nov 2019 16:23:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 13:23:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="209676718"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003.jf.intel.com with ESMTP; 20 Nov 2019 13:23:43 -0800
Subject: [PATCH RFC 00/14] idxd driver for Intel Data Streaming Accelerator
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Cc:     dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, axboe@kernel.dk,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Date:   Wed, 20 Nov 2019 14:23:43 -0700
Message-ID: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The patch series breaks down into following parts:
Patch 1: x86 arch / generic, add a new I/O accessor based on movdir64b
Patches 2,3,5-7,12: dmaengine subsystem additions
Patch 3: mm, moving common allocation code from blk-mq to mm
Patches 8-11,13,14: idxd driver

This patch series implements the first part of the driver for the Intel
Data Stream accelerator, the Intel Data Accelerator driver (idxd).
The Intel DSA replaces the Intel IOAT DMA engine from previous Xeon platforms
on a future processor platform. Many new features are implemented by Intel DSA.
1. Descriptors can be issued directly from kernel, user, and guest via new CPU
   instructions enqcmd, enqcmds, and movdir64b. The descriptor is written to
   an mmio address in one of the device's PCI BAR and is called a portal.
   New CPU instruction details can be found in the latest Intel Software
   Developer's Manual. [1]
2. Shared workqueues allow multiple users issue descriptors to the same
   workqueue.
3. Shared Virtual Memory (SVM) support allows using virtual address instead of
   requiring pinned physical address that traditional DMA controllers require.
   This simplifies programming and makes it easier for user space to do DMA
   operations. Page faults can be recovered through PCI Address Translation
   Service (ATS) performed by the DMA device.
4. Supports scalable IOV (SIOV) to accelerate virtualization. [2]

The submission will happen in multiple stages depending on availability of
kernel support for Process Address Space ID (PASID), IOMMU, vIOMMU, and
Interrupt Message Storage (IMS).

Stage 1 (this series): idxd driver with only dedicated workqueue support.
	- No PASID support
	- No shared workqueue (requires PASID) support
	- With DMA engine plumbing
	- With char driver for user command portal export.
Stage 2. idxd driver with PASID support and shared workqueue support
STage 3. idxd driver with VFIO mediated device (mdev) and with IMS support.

The DSA device defines sub-components called workqueues, groups, and engines.
A group is an abstract container that can have 1 or more workqueues and 1 or
more engines. The number of groups, workqueues, and engines supported by the
device can be detected from the general capabilities register. The workqueues
are where descriptors queued up before being processed by the engines.

The DSA device also has a memory BAR that contains multiple portals.
Depending on the offset from the BAR, various portals can be used to submit
descriptors with one of the CPU commands mentioned above. The types of
portals are MSIX limited, MSIX unlimited, IMS limited, and IMS unlimited as
defined by the hardware spec. The MSIX unlimited portals are reserved for
kernel submissions. The limited portals can be exported to user space for
application usages. A limited portal is configured by the workqueue threshold
attribute and can be restricted to have a workqueue size that is smaller than
the actual workqueue size. This allows the kernel to submit command descriptors
to a workqueue and not be blocked by the user application.

There are two types of workqueues that the DSA device supports, dedicated and
shared. A dedicated workqueue receives descriptors via the movdir64b
instruction. This instruction is a posted write and therefore does not wait for
a completion. Because of this, the software must keep track of the number of
descriptors submitted to the workqueue. A full workqueue will drop the
descriptor without notice. A shared workqueue accepts the enqcmds instruction in
the kernel and enqcmd instruction from user applications. The command will set
the zero flag to indicate whether the submission of the descriptor is
successful. The enqcmd(s) instruction is non-posted and waits for the write
completion before return.

The stage 1 of the patch submission provides a base driver that only support
the dedicated workqueue type without PASID support. The supported source and
destination addresses must be physical. This is similar to traditional
DMA operations where the device receives a descriptor with physical source and
destination addresses for operation. Plumbing to the existing kernel dmaengine
subsystem is added in order to support such usages. DMA memmove operation can be
tested with the in kernel dmatest module.

A large part of the base driver is the sysfs component.  There is also
no requirement for DSA to be used during early kernel boot. Configuration
of the device during initramfs should be sufficient.

A bus type (dsa_bus) is defined for a hierachy of DSA devices and 
sub-components to be connected to, /sys/bus/dsa/.
A struct device is created for each DSA device and for each of its
sub-component (workqueues, groups, and engines).  So looking under
/sys/bus/dsa/devices, one would observe entries such as dsa0, dsa1, wq0.0,
wq1.0, group0.0, engine0.0, and etc. Each of those has sysfs attributes
underneath that allows the configuration of those parts or reporting status or
capabilities of the parts that they represent.

/sys/bus/dsa/devices
├── dsa0 -> ../../../devices/pci0000:00/0000:00:0a.0/dsa0
├── engine0.0 -> ../../../devices/pci0000:00/0000:00:0a.0/dsa0/engine0.0
├── engine0.1 -> ../../../devices/pci0000:00/0000:00:0a.0/dsa0/engine0.1
├── engine0.2 -> ../../../devices/pci0000:00/0000:00:0a.0/dsa0/engine0.2
├── engine0.3 -> ../../../devices/pci0000:00/0000:00:0a.0/dsa0/engine0.3
├── group0.0 -> ../../../devices/pci0000:00/0000:00:0a.0/dsa0/group0.0
├── group0.1 -> ../../../devices/pci0000:00/0000:00:0a.0/dsa0/group0.1
├── group0.2 -> ../../../devices/pci0000:00/0000:00:0a.0/dsa0/group0.2
├── group0.3 -> ../../../devices/pci0000:00/0000:00:0a.0/dsa0/group0.3
├── wq0.0 -> ../../../devices/pci0000:00/0000:00:0a.0/dsa0/wq0.0
├── wq0.1 -> ../../../devices/pci0000:00/0000:00:0a.0/dsa0/wq0.1
├── wq0.2 -> ../../../devices/pci0000:00/0000:00:0a.0/dsa0/wq0.2
├── wq0.3 -> ../../../devices/pci0000:00/0000:00:0a.0/dsa0/wq0.3
├── wq0.4 -> ../../../devices/pci0000:00/0000:00:0a.0/dsa0/wq0.4
├── wq0.5 -> ../../../devices/pci0000:00/0000:00:0a.0/dsa0/wq0.5
├── wq0.6 -> ../../../devices/pci0000:00/0000:00:0a.0/dsa0/wq0.6
├── wq0.7 -> ../../../devices/pci0000:00/0000:00:0a.0/dsa0/wq0.7

Under /sys/bus/dsa/drivers/dsa/ there is a bind and an unbind attribute. Those
allow us to enable and disable the device and workqueue components through the
bus probe and remove functions in the driver. By writing the "device" names
(i.e. dsa0, wq0.0) into bind or unbind attributes we can enable or disable those
components respectively. This is the typical driver-core bind / unbind behavior.

The workqueue device attributes exports two attributes, type and name, to
indicate how the workqueue is being utilized. There are 2 primary types that
the driver recognizes: kernel, user. An additonal mdev type is available from
stage 3 enabling.  The "kernel" type marks the workqueue for in kernel usages.
The "user" type surfaces a char device for user application consumption.
The "name" attribute is a string type that marks the workqueue for more
specific usages. For example, for the dmaengine subsystem to claim the
workqueue the name should be "dmanegine". For "user" queue types, the name
can be any valid string useful for identification by the user application.

For the "user" workqueue that surfaces a char device, char device allows a 
limited portal region to be exported to user applications by the mmap() call
once the application opens the char device.  Character device nodes in
/dev/dsa/wqM.N will be made visible for application to open the device.
A user application can use the enqcmd CPU instruction to submit
descriptors directly to a workqueue without kernel driver involvement.

Kernel branch for easy review:
https://github.com/intel/idxd-driver.git idxd-stage1

[1]: https://software.intel.com/en-us/articles/intel-sdm
[2]: https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
[3]: https://software.intel.com/en-us/download/intel-data-streaming-accelerator-preliminary-architecture-specification
[4]: https://01.org/blogs/2019/introducing-intel-data-streaming-accelerator

---

Dave Jiang (13):
      x86/asm: add iosubmit_cmds512() based on movdir64b CPU instruction
      dmaengine: break out channel registration
      dmaengine: add new dma device registration
      mm: create common code from request allocation based from blk-mq code
      dmaengine: add dma_request support functions
      dmaengine: add dma request submit and completion path support
      dmaengine: update dmatest to support dma request
      dmaengine: idxd: Init and probe for Intel data accelerators
      dmaengine: idxd: add configuration component of driver
      dmaengine: idxd: add descriptor manipulation routines
      dmaengine: idxd: connect idxd to dmaengine subsystem
      dmaengine: request submit optimization
      dmaengine: idxd: add char driver to expose submission portal to userland

Jing Lin (1):
      dmaengine: idxd: add sysfs ABI for idxd driver


 Documentation/ABI/stable/sysfs-driver-dma-idxd |  171 +++
 MAINTAINERS                                    |    8 
 arch/x86/include/asm/io.h                      |   44 +
 block/blk-mq.c                                 |   94 -
 drivers/dma/Kconfig                            |   19 
 drivers/dma/Makefile                           |    2 
 drivers/dma/dma-request.c                      |   96 ++
 drivers/dma/dmaengine.c                        |  312 +++--
 drivers/dma/dmatest.c                          |  366 ++++--
 drivers/dma/idxd/Makefile                      |    2 
 drivers/dma/idxd/cdev.c                        |  304 +++++
 drivers/dma/idxd/device.c                      |  699 +++++++++++
 drivers/dma/idxd/dma.c                         |  120 ++
 drivers/dma/idxd/idxd.h                        |  307 +++++
 drivers/dma/idxd/init.c                        |  550 +++++++++
 drivers/dma/idxd/irq.c                         |  275 ++++
 drivers/dma/idxd/registers.h                   |  336 +++++
 drivers/dma/idxd/submit.c                      |  178 +++
 drivers/dma/idxd/sysfs.c                       | 1510 ++++++++++++++++++++++++
 include/linux/dmaengine.h                      |  132 ++
 include/linux/idxd.h                           |   23 
 include/linux/io.h                             |   11 
 include/linux/mempool.h                        |    6 
 include/uapi/linux/idxd.h                      |  214 +++
 mm/Makefile                                    |    2 
 mm/request_alloc.c                             |   95 ++
 usr/include/Makefile                           |    1 
 27 files changed, 5591 insertions(+), 286 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-dma-idxd
 create mode 100644 drivers/dma/dma-request.c
 create mode 100644 drivers/dma/idxd/Makefile
 create mode 100644 drivers/dma/idxd/cdev.c
 create mode 100644 drivers/dma/idxd/device.c
 create mode 100644 drivers/dma/idxd/dma.c
 create mode 100644 drivers/dma/idxd/idxd.h
 create mode 100644 drivers/dma/idxd/init.c
 create mode 100644 drivers/dma/idxd/irq.c
 create mode 100644 drivers/dma/idxd/registers.h
 create mode 100644 drivers/dma/idxd/submit.c
 create mode 100644 drivers/dma/idxd/sysfs.c
 create mode 100644 include/linux/idxd.h
 create mode 100644 include/uapi/linux/idxd.h
 create mode 100644 mm/request_alloc.c

--
Signature
