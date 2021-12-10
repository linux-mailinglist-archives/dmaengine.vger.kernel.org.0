Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21239470D9F
	for <lists+dmaengine@lfdr.de>; Fri, 10 Dec 2021 23:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345156AbhLJWYp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Dec 2021 17:24:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50274 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344717AbhLJWWn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Dec 2021 17:22:43 -0500
Message-ID: <20211210221814.048612053@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639174745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TChehWVkaCDXWslfOqt9SsdG5fg+7v6o6aA6KtRbeHM=;
        b=Z11uvvxgirAW72rICp0vfbanS84UF82Nhb6VQydo25+LJ6YqYAbpXkmM7xdJXeTdznCw1s
        erlLzvS3f8S8X3MqKG6FWkDbzvp7PQ01OSu3pmt6X/fqLdRuw+xf/tSng+pQE/QA3EVuJa
        JvpnsrGVQpSL/3nyMTJIBfAiiT+kUUJ3ssX8tU5sGnGPYjGGWGGM83LFKfBPbHkqRu8STR
        ghiqR/QIHyPv2LwcuKChQWwCEtBFQEHKUTL6+PT9gOax11YdzEWoTVht9qcQ8QqZBnEz6n
        JMmNdgKrS9iGoaCLMEB/xcBcfHGnMd7m6HmEh/Jj9qHhvvs3t2TqzewDPQIdXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639174745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TChehWVkaCDXWslfOqt9SsdG5fg+7v6o6aA6KtRbeHM=;
        b=KlfpjkCvcrQosgJ4ChgS7lGyZYuQ96QJI/yz5x/JhIyB7M0oc7AC8htzC3Lr6XT++gnAIE
        k/pOg57H/xU1JEBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [patch V3 14/35] PCI/MSI: Let the irq code handle sysfs groups
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 10 Dec 2021 23:19:05 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Set the domain info flag which makes the core code handle sysfs groups and
put an explicit invocation into the legacy code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi/irqdomain.c |    2 +-
 drivers/pci/msi/legacy.c    |    6 +++++-
 drivers/pci/msi/msi.c       |   23 -----------------------
 include/linux/pci.h         |    1 -
 4 files changed, 6 insertions(+), 26 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -159,7 +159,7 @@ struct irq_domain *pci_msi_create_irq_do
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		pci_msi_domain_update_chip_ops(info);
 
-	info->flags |= MSI_FLAG_ACTIVATE_EARLY;
+	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
 		info->flags |= MSI_FLAG_MUST_REACTIVATE;
 
--- a/drivers/pci/msi/legacy.c
+++ b/drivers/pci/msi/legacy.c
@@ -70,10 +70,14 @@ int pci_msi_legacy_setup_msi_irqs(struct
 {
 	int ret = arch_setup_msi_irqs(dev, nvec, type);
 
-	return pci_msi_setup_check_result(dev, type, ret);
+	ret = pci_msi_setup_check_result(dev, type, ret);
+	if (!ret)
+		ret = msi_device_populate_sysfs(&dev->dev);
+	return ret;
 }
 
 void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
 {
+	msi_device_destroy_sysfs(&dev->dev);
 	arch_teardown_msi_irqs(dev);
 }
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -233,11 +233,6 @@ static void free_msi_irqs(struct pci_dev
 			for (i = 0; i < entry->nvec_used; i++)
 				BUG_ON(irq_has_action(entry->irq + i));
 
-	if (dev->msi_irq_groups) {
-		msi_destroy_sysfs(&dev->dev, dev->msi_irq_groups);
-		dev->msi_irq_groups = NULL;
-	}
-
 	pci_msi_teardown_msi_irqs(dev);
 
 	list_for_each_entry_safe(entry, tmp, msi_list, list) {
@@ -417,7 +412,6 @@ static int msi_verify_entries(struct pci
 static int msi_capability_init(struct pci_dev *dev, int nvec,
 			       struct irq_affinity *affd)
 {
-	const struct attribute_group **groups;
 	struct msi_desc *entry;
 	int ret;
 
@@ -448,14 +442,6 @@ static int msi_capability_init(struct pc
 	if (ret)
 		goto err;
 
-	groups = msi_populate_sysfs(&dev->dev);
-	if (IS_ERR(groups)) {
-		ret = PTR_ERR(groups);
-		goto err;
-	}
-
-	dev->msi_irq_groups = groups;
-
 	/* Set MSI enabled bits	*/
 	pci_intx_for_msi(dev, 0);
 	pci_msi_set_enable(dev, 1);
@@ -584,7 +570,6 @@ static void msix_mask_all(void __iomem *
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 				int nvec, struct irq_affinity *affd)
 {
-	const struct attribute_group **groups;
 	void __iomem *base;
 	int ret, tsize;
 	u16 control;
@@ -629,14 +614,6 @@ static int msix_capability_init(struct p
 
 	msix_update_entries(dev, entries);
 
-	groups = msi_populate_sysfs(&dev->dev);
-	if (IS_ERR(groups)) {
-		ret = PTR_ERR(groups);
-		goto out_free;
-	}
-
-	dev->msi_irq_groups = groups;
-
 	/* Disable INTX and unmask MSI-X */
 	pci_intx_for_msi(dev, 0);
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -475,7 +475,6 @@ struct pci_dev {
 #ifdef CONFIG_PCI_MSI
 	void __iomem	*msix_base;
 	raw_spinlock_t	msi_lock;
-	const struct attribute_group **msi_irq_groups;
 #endif
 	struct pci_vpd	vpd;
 #ifdef CONFIG_PCIE_DPC

