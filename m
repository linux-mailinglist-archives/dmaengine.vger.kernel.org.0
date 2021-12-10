Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3B8470DA1
	for <lists+dmaengine@lfdr.de>; Fri, 10 Dec 2021 23:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345404AbhLJWYq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Dec 2021 17:24:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50238 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344713AbhLJWWl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Dec 2021 17:22:41 -0500
Message-ID: <20211210221813.988659194@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639174744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=oE2eGYCYBsqhTiqWwROCSzBN1PHvDBTxc4ApBbpWErQ=;
        b=Du2AaeyfQ64dP3dBs4P+iX/eFtTtuCyElkywg4oYr94298FnFHpAop9t86vUsn4VVyrVCl
        lGFyPgrvSs0Gr8kuj771Eh/3xQ8clx37P2uIDld9f7h+STIe4QjMB1lNIq8aFa6qmzcjnK
        ay+m0Xlfk66F93sm9gAN9zblzf0wZsVdVR/m5/BXpezRfWcYkI8p02Y74sGyJQfgJA30nA
        rqbyJQqYND31ug87CWMo7Va00A2e5kmACGXuAKhdEYFcuBoXlbaLCxWV3+5wzPYP6RyyPz
        PWzzT0WZAAnVAI5zp20wKtXbAm26pTRbjZaW7zp6VGBl5Re0rxuPRFo21zuz0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639174744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=oE2eGYCYBsqhTiqWwROCSzBN1PHvDBTxc4ApBbpWErQ=;
        b=CDqZUrLAr3/IbkCTIDZp0THg1iNwgAbMiICWCbxnRLGjU3FnBGAqbCSc84YSFhBleVyNIj
        Oj6FzJ0V6tLDbaAw==
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
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
        Stuart Yoder <stuyoder@gmail.com>,
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
Subject: [patch V3 13/35] genirq/msi: Provide msi_device_populate/destroy_sysfs()
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 10 Dec 2021 23:19:03 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Add new allocation functions which can be activated by domain info
flags. They store the groups pointer in struct msi_device_data.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/msi.h |    4 ++++
 kernel/irq/msi.c    |   42 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -56,6 +56,8 @@ struct irq_data;
 struct msi_desc;
 struct pci_dev;
 struct platform_msi_priv_data;
+struct attribute_group;
+
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 #ifdef CONFIG_GENERIC_MSI_IRQ
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
@@ -174,9 +176,11 @@ struct msi_desc {
 /**
  * msi_device_data - MSI per device data
  * @properties:		MSI properties which are interesting to drivers
+ * @attrs:		Pointer to the sysfs attribute group
  */
 struct msi_device_data {
 	unsigned long			properties;
+	const struct attribute_group    **attrs;
 };
 
 int msi_setup_device_data(struct device *dev);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -200,6 +200,20 @@ const struct attribute_group **msi_popul
 }
 
 /**
+ * msi_device_populate_sysfs - Populate msi_irqs sysfs entries for a device
+ * @dev:	The device (PCI, platform etc) which will get sysfs entries
+ */
+int msi_device_populate_sysfs(struct device *dev)
+{
+	const struct attribute_group **group = msi_populate_sysfs(dev);
+
+	if (IS_ERR(group))
+		return PTR_ERR(group);
+	dev->msi.data->attrs = group;
+	return 0;
+}
+
+/**
  * msi_destroy_sysfs - Destroy msi_irqs sysfs entries for devices
  * @dev:		The device(PCI, platform etc) who will remove sysfs entries
  * @msi_irq_groups:	attribute_group for device msi_irqs entries
@@ -225,6 +239,17 @@ void msi_destroy_sysfs(struct device *de
 		kfree(msi_irq_groups);
 	}
 }
+
+/**
+ * msi_device_destroy_sysfs - Destroy msi_irqs sysfs entries for a device
+ * @dev:		The device (PCI, platform etc) for which to remove
+ *			sysfs entries
+ */
+void msi_device_destroy_sysfs(struct device *dev)
+{
+	msi_destroy_sysfs(dev, dev->msi.data->attrs);
+	dev->msi.data->attrs = NULL;
+}
 #endif
 
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
@@ -672,8 +697,19 @@ int msi_domain_alloc_irqs(struct irq_dom
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
+	int ret;
 
-	return ops->domain_alloc_irqs(domain, dev, nvec);
+	ret = ops->domain_alloc_irqs(domain, dev, nvec);
+	if (ret)
+		return ret;
+
+	if (!(info->flags & MSI_FLAG_DEV_SYSFS))
+		return 0;
+
+	ret = msi_device_populate_sysfs(dev);
+	if (ret)
+		msi_domain_free_irqs(domain, dev);
+	return ret;
 }
 
 void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
@@ -712,7 +748,9 @@ void msi_domain_free_irqs(struct irq_dom
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
 
-	return ops->domain_free_irqs(domain, dev);
+	if (info->flags & MSI_FLAG_DEV_SYSFS)
+		msi_device_destroy_sysfs(dev);
+	ops->domain_free_irqs(domain, dev);
 }
 
 /**

