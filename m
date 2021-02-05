Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334663112DA
	for <lists+dmaengine@lfdr.de>; Fri,  5 Feb 2021 21:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhBETL4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Feb 2021 14:11:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:6227 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233586AbhBETLO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 5 Feb 2021 14:11:14 -0500
IronPort-SDR: N8rosoZSrIN3n1L1OaA1rrmz/3I1sMiGESLFJLvGQCUPbO1SqGo7NOEy0yfP0bzniR2PHnp91a
 G5ge1YLp5w/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="169161978"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="169161978"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 12:52:54 -0800
IronPort-SDR: OydNoMEQySfChi59hrH8Kgse9Penneee+remZqi1CKoDFQuCE2Z7yvqwkvL03iELQlC0BhThJC
 22Tg/LZqCuRA==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="373680327"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 12:52:53 -0800
Subject: [PATCH v5 00/14] Add VFIO mediated device support and DEV-MSI support
 for the idxd driver
From:   Dave Jiang <dave.jiang@intel.com>
To:     alex.williamson@redhat.com, kwankhede@nvidia.com,
        tglx@linutronix.de, vkoul@kernel.org
Cc:     megha.dey@intel.com, jacob.jun.pan@intel.com, ashok.raj@intel.com,
        jgg@mellanox.com, yi.l.liu@intel.com, baolu.lu@intel.com,
        kevin.tian@intel.com, sanjay.k.kumar@intel.com,
        tony.luck@intel.com, dan.j.williams@intel.com,
        eric.auger@redhat.com, parav@mellanox.com, netanelg@mellanox.com,
        shahafs@mellanox.com, pbonzini@redhat.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Date:   Fri, 05 Feb 2021 13:52:53 -0700
Message-ID: <161255810396.339900.7646244556839438765.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

- Thomas, thank you for the previous reviews. I've made the appropriate
  changes based on your feedback. Please take a look again at patches 5 and
  11 for IMS setup. I'd really appreciate an ack if they look good.
- Dan and Vinod, I'd really appreciate it if you can review patches 1-3 for
  idxd driver bits and provide an ack if they look good.
- Alex and Kirti, I'd very much appreciate it if you can review the series
  and consider inclusion for 5.13 kernel if everything looks good.
Thank you all!

v5:
- Split out non driver IMS code to its own series.
- Removed device devsec detection code.
- Reworked irq_entries for IMS so emulated vector is also included.
- Reworked vidxd_send_interrupt() to take irq_entry directly (data ready for
  consumption) (Thomas)
- Removed pointer to msi_entry in irq_entries (Thomas)
- Removed irq_domain check on free entries (Thomas)
- Split out irqbypass management code (Thomas)
- Fix EXPORT_SYMBOL to EXPORT_SYMBOL_GPL (Thomas)
- Refactored code to use auxiliary bus (Jason)

v4:
dev-msi:
- Make interrupt remapping code more readable (Thomas)
- Add flush writes to unmask/write and reset ims slots (Thomas)
- Interrupt Message Storm-> Interrupt Message Store (Thomas)
- Merge in pasid programming code. (Thomas)

mdev:
- Fixed up domain assignment (Thomas)
- Define magic numbers (Thomas)
- Move siov detection code to PCI common (Thomas)
- Remove duplicated MSI entry info (Thomas)
- Convert code to use ims_slot (Thomas)
- Add explanation of pasid programming for IMS entry (Thomas)
- Add release int handle release support due to spec 1.1 update.

v3:
Dev-msi:
- No need to add support for 2 different dev-msi irq domains, a common
once can be used for both the cases(with IR enabled/disabled)
- Add arch specific function to specify additions to msi_prepare callback
instead of making the callback a weak function
- Call platform ops directly instead of a wrapper function
- Make mask/unmask callbacks as void functions
dev->msi_domain should be updated at the device driver level before
calling dev_msi_alloc_irqs()
dev_msi_alloc/free_irqs() cannot be used for PCI devices
Followed the generic layering scheme: infrastructure bits->arch
bits->enabling bits

Mdev:
- Remove set kvm group notifier (Yan Zhao)
- Fix VFIO irq trigger removal (Yan Zhao)
- Add mmio read flush to ims mask (Jason)

v2:
IMS (now dev-msi):
- With recommendations from Jason/Thomas/Dan on making IMS more generic:
- Pass a non-pci generic device(struct device) for IMS management instead of
mdev
- Remove all references to mdev and symbol_get/put
- Remove all references to IMS in common code and replace with dev-msi
- Remove dynamic allocation of platform-msi interrupts: no groups,no
new msi list or list helpers
- Create a generic dev-msi domain with and without interrupt remapping
enabled.
- Introduce dev_msi_domain_alloc_irqs and dev_msi_domain_free_irqs apis

mdev:
- Removing unrelated bits from SVA enabling that’s not necessary for
the submission. (Kevin)
- Restructured entire mdev driver series to make reviewing easier (Kevin)
- Made rw emulation more robust (Kevin)
- Removed uuid wq type and added single dedicated wq type (Kevin)
- Locking fixes for vdev (Yan Zhao)
- VFIO MSIX trigger fixes (Yan Zhao)

This code series will match the support of the 5.6 kernel (stage 1) driver
but on guest.

The code has dependency on IMS enabling code:
https://lore.kernel.org/linux-pci/1612385805-3412-1-git-send-email-megha.dey@intel.com/T/#t

Stage 1 of the driver has been accepted in v5.6 kernel. It supports dedicated
workqueue (wq) without Shared Virtual Memory (SVM) support.

Stage 2 of the driver supports shared wq and SVM and has been accepted in
kernel v5.11.

VFIO mediated device framework allows vendor drivers to wrap a portion of
device resources into virtual devices (mdev). Each mdev can be assigned
to different guest using the same set of VFIO uAPIs as assigning a
physical device. Accessing to the mdev resource is served with mixed
policies. For example, vendor drivers typically mark data-path interface
as pass-through for fast guest operations, and then trap-and-mediate the
control-path interface to avoid undesired interference between mdevs. Some
level of emulation is necessary behind vfio mdev to compose the virtual
device interface.

This series brings mdev to idxd driver to enable Intel Scalable IOV
(SIOV), a hardware-assisted mediated pass-through technology. SIOV makes
each DSA wq independently assignable through PASID-granular resource/DMA
isolation. It helps improve scalability and reduces mediation complexity
against purely software-based mdev implementations. Each assigned wq is
configured by host and exposed to the guest in a read-only configuration
mode, which allows the guest to use the wq w/o additional setup. This
design greatly reduces the emulation bits to focus on handling commands
from guests.

There are two possible avenues to support virtual device composition:
1. VFIO mediated device (mdev) or 2. User space DMA through char device
(or UACCE). Given the small portion of emulation to satisfy our needs
and VFIO mdev having the infrastructure already to support the device
passthrough, we feel that VFIO mdev is the better route. For more in depth
explanation, see documentation in Documents/driver-api/vfio/mdev-idxd.rst.

Introducing mdev types “1dwq-v1” type. This mdev type allows
allocation of a single dedicated wq from available dedicated wqs. After
a workqueue (wq) is enabled, the user will generate an uuid. On mdev
creation, the mdev driver code will find a dwq depending on the mdev
type. When the create operation is successful, the user generated uuid
can be passed to qemu. When the guest boots up, it should discover a
DSA device when doing PCI discovery.

For example of “1dwq-v1” type:
1. Enable wq with “mdev” wq type
2. A user generated uuid.
3. The uuid is written to the mdev class sysfs path:
echo $UUID > /sys/class/mdev_bus/0000\:00\:0a.0/mdev_supported_types/idxd-1dwq-v1/create
4. Pass the following parameter to qemu:
"-device vfio-pci,sysfsdev=/sys/bus/pci/devices/0000:00:0a.0/$UUID"

The wq exported through mdev will have the read only config bit set
for configuration. This means that the device does not require the
typical configuration. After enabling the device, the user must set the
WQ type and name. That is all is necessary to enable the WQ and start
using it. The single wq configuration is not the only way to create the
mdev. Multi wqs support for mdev will be in the future works.

The mdev utilizes Interrupt Message Store or IMS[3], a device-specific
MSI implementation, instead of MSIX for interrupts for the guest. This
preserves MSIX for host usages and also allows a significantly larger
number of interrupt vectors for guest usage.

The idxd driver implements IMS as on-device memory mapped unified
storage. Each interrupt message is stored as a DWORD size data payload
and a 64-bit address (same as MSI-X). Access to the IMS is through the
host idxd driver.

The idxd driver makes use of the generic IMS irq chip and domain which
stores the interrupt messages as an array in device memory. Allocation and
freeing of interrupts happens via the generic msi_domain_alloc/free_irqs()
interface. One only needs to ensure the interrupt domain is stored in
the underlying device struct.

[1]: https://lore.kernel.org/lkml/157965011794.73301.15960052071729101309.stgit@djiang5-desk3.ch.intel.com/
[2]: https://software.intel.com/en-us/articles/intel-sdm
[3]: https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
[4]: https://software.intel.com/en-us/download/intel-data-streaming-accelerator-preliminary-architecture-specification
[5]: https://01.org/blogs/2019/introducing-intel-data-streaming-accelerator
[6]: https://intel.github.io/idxd/
[7]: https://github.com/intel/idxd-driver idxd-stage2.5

---

Dave Jiang (14):
      vfio/mdev: idxd: add theory of operation documentation for idxd mdev
      dmaengine: idxd: add IMS detection in base driver
      dmaengine: idxd: add device support functions in prep for mdev
      vfio/mdev: idxd: Add auxialary device plumbing for idxd mdev support
      vfio/mdev: idxd: add basic mdev registration and helper functions
      vfio/mdev: idxd: add mdev type as a new wq type
      vfio/mdev: idxd: add 1dwq-v1 mdev type
      vfio/mdev: idxd: add emulation rw routines
      vfio/mdev: idxd: prep for virtual device commands
      vfio/mdev: idxd: virtual device commands emulation
      vfio/mdev: idxd: ims setup for the vdcm
      vfio/mdev: idxd: add irq bypass for IMS vectors
      vfio/mdev: idxd: add new wq state for mdev
      vfio/mdev: idxd: add error notification from host driver to mediated device


 .../ABI/stable/sysfs-driver-dma-idxd          |    6 +
 MAINTAINERS                                   |    8 +-
 drivers/dma/idxd/Makefile                     |    2 +
 drivers/dma/idxd/cdev.c                       |    6 +-
 drivers/dma/idxd/device.c                     |  137 +-
 drivers/dma/idxd/idxd.h                       |   48 +-
 drivers/dma/idxd/init.c                       |   98 +-
 drivers/dma/idxd/irq.c                        |    8 +-
 drivers/dma/idxd/registers.h                  |   36 +-
 drivers/dma/idxd/sysfs.c                      |   33 +-
 drivers/vfio/mdev/Kconfig                     |   10 +
 drivers/vfio/mdev/Makefile                    |    1 +
 drivers/vfio/mdev/idxd/Makefile               |    4 +
 drivers/vfio/mdev/idxd/mdev.c                 | 1295 +++++++++++++++++
 drivers/vfio/mdev/idxd/mdev.h                 |  119 ++
 drivers/vfio/mdev/idxd/vdev.c                 | 1014 +++++++++++++
 drivers/vfio/mdev/idxd/vdev.h                 |   28 +
 include/uapi/linux/idxd.h                     |    2 +
 kernel/irq/msi.c                              |    2 +
 19 files changed, 2814 insertions(+), 43 deletions(-)
 create mode 100644 drivers/vfio/mdev/idxd/Makefile
 create mode 100644 drivers/vfio/mdev/idxd/mdev.c
 create mode 100644 drivers/vfio/mdev/idxd/mdev.h
 create mode 100644 drivers/vfio/mdev/idxd/vdev.c
 create mode 100644 drivers/vfio/mdev/idxd/vdev.h

--

