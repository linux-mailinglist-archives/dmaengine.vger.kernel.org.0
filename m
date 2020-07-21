Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D2E228479
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jul 2020 18:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGUQCT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jul 2020 12:02:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:36437 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbgGUQCS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jul 2020 12:02:18 -0400
IronPort-SDR: Ikg01JIzU+9DmhvfZXnh7DgMu7ahluJn9lmpdhH04xbEGB/PhPB9MKk1kM+BU7wvrlppmOIs3c
 cC7KQvKplMWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="211707972"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="211707972"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 09:02:16 -0700
IronPort-SDR: JMHzcjiPLeplMQlR4VYW9anJCqZ4TvwDn6hOSJgme6gv93lU3gu/moN1zQvfsvX+pglT4mvjLF
 beoMO0yTIbDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="271755813"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jul 2020 09:02:15 -0700
Subject: [PATCH RFC v2 00/18] Add VFIO mediated device support and DEV-MSI
 support for the idxd driver 
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, megha.dey@intel.com, maz@kernel.org,
        bhelgaas@google.com, rafael@kernel.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, hpa@zytor.com, alex.williamson@redhat.com,
        jacob.jun.pan@intel.com, ashok.raj@intel.com, jgg@mellanox.com,
        yi.l.liu@intel.com, baolu.lu@intel.com, kevin.tian@intel.com,
        sanjay.k.kumar@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        dan.j.williams@intel.com, kwankhede@nvidia.com,
        eric.auger@redhat.com, parav@mellanox.com, jgg@mellanox.com,
        rafael@kernel.org, dave.hansen@intel.com, netanelg@mellanox.com,
        shahafs@mellanox.com, yan.y.zhao@linux.intel.com,
        pbonzini@redhat.com, samuel.ortiz@intel.com, mona.hossain@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org
Date:   Tue, 21 Jul 2020 09:02:15 -0700
Message-ID: <159534667974.28840.2045034360240786644.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

v2:
IMS (now dev-msi):
With recommendations from Jason/Thomas/Dan on making IMS more generic:
Pass a non-pci generic device(struct device) for IMS management instead of mdev
Remove all references to mdev and symbol_get/put
Remove all references to IMS in common code and replace with dev-msi
remove dynamic allocation of platform-msi interrupts: no groups,no new msi list or list helpers
Create a generic dev-msi domain with and without interrupt remapping enabled.
Introduce dev_msi_domain_alloc_irqs and dev_msi_domain_free_irqs apis

mdev: 
Removing unrelated bits from SVA enabling that’s not necessary for the submission. (Kevin)
Restructured entire mdev driver series to make reviewing easier (Kevin)
Made rw emulation more robust (Kevin)
Removed uuid wq type and added single dedicated wq type (Kevin)
Locking fixes for vdev (Yan Zhao)
VFIO MSIX trigger fixes (Yan Zhao)

Link to previous discussions with Jason:
https://lore.kernel.org/lkml/57296ad1-20fe-caf2-b83f-46d823ca0b5f@intel.com/
The emulation part that can be moved to user space is very small due to the majority of the
emulations being control bits and need to reside in the kernel. We can revisit the necessity of
moving the small emulation part to userspace and required architectural changes at a later time.

This RFC series has been reviewed by Dan Williams <dan.j.williams@intel.com>

The actual code can be independent of the stage 2 driver code submission that adds support for SVM,
ENQCMD(S), PASID, and shared workqueues. This code series will match the support of the 5.6 kernel
(stage 1) driver but on guest. The code is dependent on Baolu’s iommu aux-domain API extensions
patches that’s still in process of being reviewed:
https://lkml.org/lkml/2020/7/14/48

Stage 1 of the driver has been accepted in v5.6 kernel. It supports dedicated workqueue (wq)
without Shared Virtual Memory (SVM) support. Stage 2 supports shared wq and SVM. It is pending
upstream review and targeting kernel v5.9.

VFIO mediated device framework allows vendor drivers to wrap a portion of device resources into
virtual devices (mdev). Each mdev can be assigned to different guest using the same set of VFIO
uAPIs as assigning a physical device. Accessing to the mdev resource is served with mixed policies.
For example, vendor drivers typically mark data-path interface as pass-through for fast guest
operations, and then trap-and-mediate the control-path interface to avoid undesired interference
between mdevs. Some level of emulation is necessary behind vfio mdev to compose the virtual device
interface. 

This series brings mdev to idxd driver to enable Intel Scalable IOV (SIOV), a hardware-assisted
mediated pass-through technology. SIOV makes each DSA wq independently assignable through
PASID-granular resource/DMA isolation. It helps improve scalability and reduces mediation
complexity against purely software-based mdev implementations. Each assigned wq is configured by
host and exposed to the guest in a read-only configuration mode, which allows the guest to use the
wq w/o additional setup. This design greatly reduces the emulation bits to focus on handling
commands from guests.

Introducing mdev types “1dwq” type. This mdev type allows allocation of a single dedicated wq from
available dedicated wqs. After a workqueue (wq) is enabled, the user will generate an uuid. On mdev
creation, the mdev driver code will find a dwq depending on the mdev type. When the create operation
is successful, the user generated uuid can be passed to qemu. When the guest boots up, it should
discover a DSA device when doing PCI discovery.

For example of “1dwq” type:
1. Enable wq with “mdev” wq type
2. A user generated uuid.
3. The uuid is written to the mdev class sysfs path:
echo $UUID > /sys/class/mdev_bus/0000\:00\:0a.0/mdev_supported_types/idxd-wq/create
4. Pass the following parameter to qemu:
"-device vfio-pci,sysfsdev=/sys/bus/pci/devices/0000:00:0a.0/$UUID"
 
The wq exported through mdev will have the read only config bit set for configuration. This means
that the device does not require the typical configuration. After enabling the device, the user
must set the WQ type and name. That is all is necessary to enable the WQ and start using it. The
single wq configuration is not the only way to create the mdev. Multi wqs support for mdev will be
in the future works.
 
The mdev utilizes Interrupt Message Store or IMS[3], a device-specific MSI implementation, instead
of MSIX for interrupts for the guest. This preserves MSIX for host usages and also allows a
significantly larger number of interrupt vectors for guest usage.

The idxd driver implements IMS as on-device memory mapped unified storage. Each interrupt message
is stored as a DWORD size data payload and a 64-bit address (same as MSI-X). Access to the IMS is
through the host idxd driver.

This patchset extends the existing platform-msi framework (which provides a generic mechanism to
support non-PCI compliant MSI interrupts) to benefit any driver which wants to allocate
msi-like(dev-msi) interrupts and provide its own ops functions (mask/unmask etc.)

Call-back functions defined by the kernel and implemented by the driver are used to
1. program the interrupt addr/data values instead of the kernel directly programming them.
2. mask/unmask the interrupt source

The kernel can specify the requirements for these callback functions (e.g., the driver is not
expected to block, or not expected to take a lock in the callback function).

Support for 2 new IRQ chip/domain is added(with and without IRQ_REMAP support- DEV-MSI/IR-DEV-MSI).

[1]: https://lore.kernel.org/lkml/157965011794.73301.15960052071729101309.stgit@djiang5-desk3.ch.intel.com/
[2]: https://software.intel.com/en-us/articles/intel-sdm
[3]: https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
[4]: https://software.intel.com/en-us/download/intel-data-streaming-accelerator-preliminary-architecture-specification
[5]: https://01.org/blogs/2019/introducing-intel-data-streaming-accelerator
[6]: https://intel.github.io/idxd/
[7]: https://github.com/intel/idxd-driver idxd-stage2.5

---

Dave Jiang (13):
      dmaengine: idxd: add support for readonly config devices
      dmaengine: idxd: add interrupt handle request support
      dmaengine: idxd: add DEV-MSI support in base driver
      dmaengine: idxd: add device support functions in prep for mdev
      dmaengine: idxd: add basic mdev registration and helper functions
      dmaengine: idxd: add emulation rw routines
      dmaengine: idxd: prep for virtual device commands
      dmaengine: idxd: virtual device commands emulation
      dmaengine: idxd: ims setup for the vdcm
      dmaengine: idxd: add mdev type as a new wq type
      dmaengine: idxd: add dedicated wq mdev type
      dmaengine: idxd: add new wq state for mdev
      dmaengine: idxd: add error notification from host driver to mediated device

Jing Lin (1):
      dmaengine: idxd: add ABI documentation for mediated device support

Megha Dey (4):
      platform-msi: Introduce platform_msi_ops
      irq/dev-msi: Add support for a new DEV_MSI irq domain
      irq/dev-msi: Create IR-DEV-MSI irq domain
      irq/dev-msi: Introduce APIs to allocate/free dev-msi interrupts


 Documentation/ABI/stable/sysfs-driver-dma-idxd |   15 
 arch/x86/include/asm/hw_irq.h                  |    6 
 arch/x86/kernel/apic/msi.c                     |   12 
 drivers/base/Kconfig                           |    7 
 drivers/base/Makefile                          |    1 
 drivers/base/dev-msi.c                         |  170 ++++
 drivers/base/platform-msi.c                    |   62 +
 drivers/base/platform-msi.h                    |   23 
 drivers/dma/Kconfig                            |    7 
 drivers/dma/idxd/Makefile                      |    2 
 drivers/dma/idxd/cdev.c                        |    6 
 drivers/dma/idxd/device.c                      |  266 +++++-
 drivers/dma/idxd/idxd.h                        |   62 +
 drivers/dma/idxd/ims.c                         |  174 ++++
 drivers/dma/idxd/ims.h                         |   17 
 drivers/dma/idxd/init.c                        |  100 ++
 drivers/dma/idxd/irq.c                         |    6 
 drivers/dma/idxd/mdev.c                        | 1106 ++++++++++++++++++++++++
 drivers/dma/idxd/mdev.h                        |  118 +++
 drivers/dma/idxd/registers.h                   |   24 -
 drivers/dma/idxd/submit.c                      |   37 +
 drivers/dma/idxd/sysfs.c                       |   55 +
 drivers/dma/idxd/vdev.c                        |  962 +++++++++++++++++++++
 drivers/dma/idxd/vdev.h                        |   28 +
 drivers/dma/mv_xor_v2.c                        |    6 
 drivers/dma/qcom/hidma.c                       |    6 
 drivers/iommu/arm-smmu-v3.c                    |    6 
 drivers/iommu/intel/irq_remapping.c            |   11 
 drivers/irqchip/irq-mbigen.c                   |    8 
 drivers/irqchip/irq-mvebu-icu.c                |    6 
 drivers/mailbox/bcm-flexrm-mailbox.c           |    6 
 drivers/perf/arm_smmuv3_pmu.c                  |    6 
 include/linux/intel-iommu.h                    |    1 
 include/linux/irqdomain.h                      |   11 
 include/linux/msi.h                            |   35 +
 include/uapi/linux/idxd.h                      |    2 
 36 files changed, 3270 insertions(+), 100 deletions(-)
 create mode 100644 drivers/base/dev-msi.c
 create mode 100644 drivers/base/platform-msi.h
 create mode 100644 drivers/dma/idxd/ims.c
 create mode 100644 drivers/dma/idxd/ims.h
 create mode 100644 drivers/dma/idxd/mdev.c
 create mode 100644 drivers/dma/idxd/mdev.h
 create mode 100644 drivers/dma/idxd/vdev.c
 create mode 100644 drivers/dma/idxd/vdev.h

--
