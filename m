Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9798E2EB81B
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jan 2021 03:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbhAFCho (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Jan 2021 21:37:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:55722 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbhAFCho (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 5 Jan 2021 21:37:44 -0500
IronPort-SDR: kjHKXhCRDBTJ6MEhdNrU8lgMsg5I8RiCtrMzPMId+nWQx4mD5VCSXUzv3k/bH/eOkNm66IZXzT
 geCa9kY+rvIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="164916478"
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="164916478"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 18:35:58 -0800
IronPort-SDR: l8eZWSbUu3gwxGLlJVi+r6FoPsncy+NcV1PA5yxUi50xwIoJFgzmBu5gPx8BBeNYoGWRq8fPym
 bAJELIHMJ4RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="398061314"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jan 2021 18:35:51 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     tglx@linutronix.de, ashok.raj@intel.com, kevin.tian@intel.com,
        dave.jiang@intel.com, megha.dey@intel.com, dwmw2@infradead.org
Cc:     alex.williamson@redhat.com, bhelgaas@google.com,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        eric.auger@redhat.com, jacob.jun.pan@intel.com, jgg@mellanox.com,
        kvm@vger.kernel.org, kwankhede@nvidia.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        maz@kernel.org, mona.hossain@intel.com, netanelg@mellanox.com,
        parav@mellanox.com, pbonzini@redhat.com, rafael@kernel.org,
        samuel.ortiz@intel.com, sanjay.k.kumar@intel.com,
        shahafs@mellanox.com, tony.luck@intel.com, vkoul@kernel.org,
        yan.y.zhao@linux.intel.com, yi.l.liu@intel.com,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH v2 1/1] platform-msi: Add platform check for subdevice irq domain
Date:   Wed,  6 Jan 2021 10:27:49 +0800
Message-Id: <20210106022749.2769057-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/linux-pci/87pn4nk7nn.fsf@nanos.tec.linutronix.de/
Link: https://lore.kernel.org/linux-pci/877dqrnzr3.fsf@nanos.tec.linutronix.de/
Link: https://lore.kernel.org/linux-pci/877dqqmc2h.fsf@nanos.tec.linutronix.de/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/pci/common.c       | 47 +++++++++++++++++++++++++++++++++++++
 drivers/base/platform-msi.c |  8 +++++++
 include/linux/msi.h         |  1 +
 3 files changed, 56 insertions(+)


Background:
Learnt from the discussions in this thread:

https://lore.kernel.org/linux-pci/160408357912.912050.17005584526266191420.stgit@djiang5-desk3.ch.intel.com/

The device IMS (Interrupt Message Storage) should not be enabled in any
virtualization environments unless there is a HYPERCALL domain which
makes the changes in the message store managed by the hypervisor.

As the initial step, we allow the IMS to be enabled only if we are
running on the bare metal. It's easy to enable IMS in the virtualization
environments if above preconditions are met in the future.

We ever thought about moving on_bare_metal() to a generic file so that
it could be well maintained and used. But we need some suggestions about
where to put it. Your comments are very appreciated.

This patch is only for comments purpose. Please don't merge it. We will
include it in the Intel IMS implementation later once we reach a
consensus.

Change log:
v1->v2:
 - v1:
   https://lore.kernel.org/linux-pci/20201210004624.345282-1-baolu.lu@linux.intel.com/
 - Rename probably_on_bare_metal() with on_bare_metal();
 - Some vendors might use the same name for both bare metal and virtual
   environment. Before we add vendor specific code to distinguish
   between them, let's return false in on_bare_metal(). This won't
   introduce any regression. The only impact is that the coming new
   platform msi feature won't be supported until the vendor specific code
   is provided.

Best regards,
baolu

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 3507f456fcd0..963e0401f2b2 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -724,3 +724,50 @@ struct pci_dev *pci_real_dma_dev(struct pci_dev *dev)
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
+ *
+ * People might use the same vendor name for both bare metal and virtual
+ * environment. We can remove those names once we have vendor specific code to
+ * distinguish between them.
+ */
+static const char * const vmm_vendor_name[] = {
+	"QEMU", "Bochs", "KVM", "Xen", "VMware", "VMW", "VMware Inc.",
+	"innotek GmbH", "Oracle Corporation", "Parallels", "BHYVE",
+	"Microsoft Corporation", "Amazon EC2"
+};
+
+static bool on_bare_metal(void)
+{
+	int i;
+
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
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
+	return on_bare_metal();
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

