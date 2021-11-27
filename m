Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C1345F92C
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345502AbhK0B0P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:26:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35196 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345656AbhK0BYN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:24:13 -0500
Message-ID: <20211126230524.478418625@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6Kf8uoDdfqcgp3MpzFvCoiTWQV1YmFn3oOwS+G3NmiU=;
        b=iWolB7GTQpESFLCRMVKgPs1KrxaKC2ow1tGQffcaDNv2F0xW3vx0KvkQyu9E3HoqpLbjwF
        a1DMLtRU5UQi+E6tXiG7XgZSenRjWBZ95EguzyhGqxM8+8j1umUpkDH563q1Yt15pe9KgW
        /7Jxt5orP58QzGcs9NGfHM2D7jy6vbZFC00c4OO6SMHMXlCTv97VIWnLj085ApIev+4lMm
        AzMxX8cGljCptpTHoj6VaH8H7zpAxG8rZl+SpEqQ0BhNzR6xvOZlrjhoboEFBMtQ5wcmxv
        QLLD+xUVD7tM30wav2yu47nC6rzmcxUaWTmvPTRzKZEbeEVH6dF/47vx12DYwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6Kf8uoDdfqcgp3MpzFvCoiTWQV1YmFn3oOwS+G3NmiU=;
        b=0U7PCipwIXxPj9e5b6tNbyglTbNA/F6jyYdL9UjWoQb8at8gcc4eTSOpgaxNCw926RLOpS
        s+s7MXXsuD+XUuBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sinan Kaya <okaya@kernel.org>
Subject: [patch 09/37] PCI/MSI: Let the irq code handle sysfs groups
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:20:20 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Set the domain info flag which makes the core code handle sysfs groups and
put an explicit invocation into the legacy code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
@@ -71,10 +71,14 @@ int pci_msi_legacy_setup_msi_irqs(struct
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
@@ -415,7 +410,6 @@ static int msi_verify_entries(struct pci
 static int msi_capability_init(struct pci_dev *dev, int nvec,
 			       struct irq_affinity *affd)
 {
-	const struct attribute_group **groups;
 	struct msi_desc *entry;
 	int ret;
 
@@ -439,14 +433,6 @@ static int msi_capability_init(struct pc
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
@@ -574,7 +560,6 @@ static void msix_mask_all(void __iomem *
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 				int nvec, struct irq_affinity *affd)
 {
-	const struct attribute_group **groups;
 	void __iomem *base;
 	int ret, tsize;
 	u16 control;
@@ -616,14 +601,6 @@ static int msix_capability_init(struct p
 
 	msix_update_entries(dev, entries);
 
-	groups = msi_populate_sysfs(&dev->dev);
-	if (IS_ERR(groups)) {
-		ret = PTR_ERR(groups);
-		goto out_free;
-	}
-
-	dev->msi_irq_groups = groups;
-
 	/* Set MSI-X enabled bits and unmask the function */
 	pci_intx_for_msi(dev, 0);
 	dev->msix_enabled = 1;
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -474,7 +474,6 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_MSI
 	void __iomem	*msix_base;
-	const struct attribute_group **msi_irq_groups;
 #endif
 	struct pci_vpd	vpd;
 #ifdef CONFIG_PCIE_DPC

