Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E3B2F561C
	for <lists+dmaengine@lfdr.de>; Thu, 14 Jan 2021 02:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbhANBls (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jan 2021 20:41:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:56665 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbhANBlp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 Jan 2021 20:41:45 -0500
IronPort-SDR: rTSuQnKhQFVcZWqhxtJCCvBzjAmfc7Brk0Fjxf7qlrEAJ2S4rgiTQbAqtLctpkjv1IeRAlftzM
 j1O9PUBig1yA==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="175714772"
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="175714772"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 17:38:32 -0800
IronPort-SDR: wxb+MIQIs1FT2a1uMpvv5Cq8bB2sNzYIToEKc887iA0TcQmFB6Si8qUMU7epSgRVO8FaAzOjH7
 hFV/JsDj5x3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="569582552"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jan 2021 17:38:24 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     tglx@linutronix.de, ashok.raj@intel.com, kevin.tian@intel.com,
        dave.jiang@intel.com, megha.dey@intel.com, dwmw2@infradead.org
Cc:     alex.williamson@redhat.com, bhelgaas@google.com,
        dan.j.williams@intel.com, will@kernel.org, joro@8bytes.org,
        dmaengine@vger.kernel.org, eric.auger@redhat.com,
        jacob.jun.pan@intel.com, jgg@mellanox.com, kvm@vger.kernel.org,
        kwankhede@nvidia.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        maz@kernel.org, mona.hossain@intel.com, netanelg@mellanox.com,
        parav@mellanox.com, pbonzini@redhat.com, rafael@kernel.org,
        samuel.ortiz@intel.com, sanjay.k.kumar@intel.com,
        shahafs@mellanox.com, tony.luck@intel.com, vkoul@kernel.org,
        yan.y.zhao@linux.intel.com, yi.l.liu@intel.com, leon@kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [RFC PATCH v3 2/2] platform-msi: Add platform check for subdevice irq domain
Date:   Thu, 14 Jan 2021 09:30:03 +0800
Message-Id: <20210114013003.297050-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114013003.297050-1-baolu.lu@linux.intel.com>
References: <20210114013003.297050-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pci_subdevice_msi_create_irq_domain() should fail if the underlying
platform is not able to support IMS (Interrupt Message Storage). Otherwise,
the isolation of interrupt is not guaranteed.

For x86, IMS is only supported on bare metal for now. We could enable it
in the virtualization environments in the future if interrupt HYPERCALL
domain is supported or the hardware has the capability of interrupt
isolation for subdevices.

Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/linux-pci/87pn4nk7nn.fsf@nanos.tec.linutronix.de/
Link: https://lore.kernel.org/linux-pci/877dqrnzr3.fsf@nanos.tec.linutronix.de/
Link: https://lore.kernel.org/linux-pci/877dqqmc2h.fsf@nanos.tec.linutronix.de/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/pci/common.c       | 71 +++++++++++++++++++++++++++++++++++++
 drivers/base/platform-msi.c |  8 +++++
 include/linux/msi.h         |  1 +
 3 files changed, 80 insertions(+)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 3507f456fcd0..9deb826fb242 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
+#include <linux/iommu.h>
 
 #include <asm/acpi.h>
 #include <asm/segment.h>
@@ -724,3 +725,73 @@ struct pci_dev *pci_real_dma_dev(struct pci_dev *dev)
 	return dev;
 }
 #endif
+
+/*
+ * We want to figure out which context we are running in. But the hardware
+ * does not introduce a reliable way (instruction, CPUID leaf, MSR, whatever)
+ * which can be manipulated by the VMM to let the OS figure out where it runs.
+ * So we go with the below probably on_bare_metal() function as a replacement
+ * for definitely on_bare_metal() to go forward only for the very simple reason
+ * that this is the only option we have.
+ */
+static const char * const vmm_vendor_name[] = {
+	"QEMU", "Bochs", "KVM", "Xen", "VMware", "VMW", "VMware Inc.",
+	"innotek GmbH", "Oracle Corporation", "Parallels", "BHYVE"
+};
+
+static void read_type0_virtual_machine(const struct dmi_header *dm, void *p)
+{
+	u8 *data = (u8 *)dm + 0x13;
+
+	/* BIOS Information (Type 0) */
+	if (dm->type != 0 || dm->length < 0x14)
+		return;
+
+	/* Bit 4 of BIOS Characteristics Extension Byte 2*/
+	if (*data & BIT(4))
+		*((bool *)p) = true;
+}
+
+static bool smbios_virtual_machine(void)
+{
+	bool bit_present = false;
+
+	dmi_walk(read_type0_virtual_machine, &bit_present);
+
+	return bit_present;
+}
+
+static bool on_bare_metal(struct device *dev)
+{
+	int i;
+
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return false;
+
+	if (smbios_virtual_machine())
+		return false;
+
+	if (iommu_capable(dev->bus, IOMMU_CAP_VIOMMU))
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(vmm_vendor_name); i++)
+		if (dmi_match(DMI_SYS_VENDOR, vmm_vendor_name[i]))
+			return false;
+
+	pr_info("System running on bare metal, report to bugzilla.kernel.org if not the case.");
+
+	return true;
+}
+
+bool arch_support_pci_device_ims(struct pci_dev *pdev)
+{
+	/*
+	 * When we are running in a VMM context, the device IMS could only be
+	 * enabled when the underlying hardware supports interrupt isolation
+	 * of the subdevice, or any mechanism (trap, hypercall) is added so
+	 * that changes in the interrupt message store could be managed by the
+	 * VMM. For now, we only support the device IMS when we are running on
+	 * the bare metal.
+	 */
+	return on_bare_metal(&pdev->dev);
+}
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 8432a1bf4e28..88e5fe4dae67 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -512,6 +512,11 @@ struct irq_domain *device_msi_create_irq_domain(struct fwnode_handle *fn,
 #ifdef CONFIG_PCI
 #include <linux/pci.h>
 
+bool __weak arch_support_pci_device_ims(struct pci_dev *pdev)
+{
+	return false;
+}
+
 /**
  * pci_subdevice_msi_create_irq_domain - Create an irq domain for subdevices
  * @pdev:	Pointer to PCI device for which the subdevice domain is created
@@ -523,6 +528,9 @@ struct irq_domain *pci_subdevice_msi_create_irq_domain(struct pci_dev *pdev,
 	struct irq_domain *domain, *pdev_msi;
 	struct fwnode_handle *fn;
 
+	if (!arch_support_pci_device_ims(pdev))
+		return NULL;
+
 	/*
 	 * Retrieve the MSI domain of the underlying PCI device's MSI
 	 * domain. The PCI device domain's parent domain is also the parent
diff --git a/include/linux/msi.h b/include/linux/msi.h
index f319d7c6a4ef..6fda81c4b859 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -478,6 +478,7 @@ struct irq_domain *device_msi_create_irq_domain(struct fwnode_handle *fn,
 						struct irq_domain *parent);
 
 # ifdef CONFIG_PCI
+bool arch_support_pci_device_ims(struct pci_dev *pdev);
 struct irq_domain *pci_subdevice_msi_create_irq_domain(struct pci_dev *pdev,
 						       struct msi_domain_info *info);
 # endif
-- 
2.25.1

