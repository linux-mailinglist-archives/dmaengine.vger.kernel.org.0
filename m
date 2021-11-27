Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC60A45F94F
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346029AbhK0B0e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:26:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35546 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345987AbhK0BYY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:24:24 -0500
Message-ID: <20211126230524.600490756@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rnKORZE/4q0+dcWq5txOsnvSH8CsBB5Zw8/HocPRCso=;
        b=qS9f2NkK0r+z0LvL1ffdUS9y1b2C+JINxyh5UP9JUaDeY6E/gk5QARggKP8tASyvh7WAHK
        uKSx3IcQ4w62lyDAQU3WN7DKuXRvkAbRyJf515EEY96JIGudC49MgE4d1SLOlNiyNiI3cO
        /bx/sKu0dSlHMq7xqRFfFCc8FL4jAZMiCiTsnXuzFfc2lRvFJv26Wd+iK8hnckUseuxmsA
        DXLWJXAswomGH2z4c+rOvxNUwfFyD1TUJTQx1Myv9pLADZe4p42k4xxO+xTck+RUuxBUhc
        I3zdepkeBMxJil8A3xeFSEVuXowhQPmbvAuw9szDYTp9oAIm0t4ltlyagMr4zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rnKORZE/4q0+dcWq5txOsnvSH8CsBB5Zw8/HocPRCso=;
        b=vhD3cmRCZH91LKAGRQEzR87rH9zcB4J0sfS6Lph75ZQBWWwci6udi8uV2PwOTRPb9ByuxQ
        gJmbrXCJzc5CZYAQ==
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
Subject: [patch 11/37] genirq/msi: Remove the original sysfs interfaces
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:20:24 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

No more users. Refactor the core code accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   12 -----------
 kernel/irq/msi.c    |   53 +++++++++++++++++++---------------------------------
 2 files changed, 20 insertions(+), 45 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -246,21 +246,9 @@ void pci_msi_unmask_irq(struct irq_data
 #ifdef CONFIG_SYSFS
 int msi_device_populate_sysfs(struct device *dev);
 void msi_device_destroy_sysfs(struct device *dev);
-
-const struct attribute_group **msi_populate_sysfs(struct device *dev);
-void msi_destroy_sysfs(struct device *dev,
-		       const struct attribute_group **msi_irq_groups);
 #else
 static inline int msi_device_populate_sysfs(struct device *dev) { return 0; }
 static inline void msi_device_destroy_sysfs(struct device *dev) { }
-
-static inline const struct attribute_group **msi_populate_sysfs(struct device *dev)
-{
-	return NULL;
-}
-static inline void msi_destroy_sysfs(struct device *dev, const struct attribute_group **msi_irq_groups)
-{
-}
 #endif
 
 /*
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -132,12 +132,8 @@ static ssize_t msi_mode_show(struct devi
 /**
  * msi_populate_sysfs - Populate msi_irqs sysfs entries for devices
  * @dev:	The device(PCI, platform etc) who will get sysfs entries
- *
- * Return attribute_group ** so that specific bus MSI can save it to
- * somewhere during initilizing msi irqs. If devices has no MSI irq,
- * return NULL; if it fails to populate sysfs, return ERR_PTR
  */
-const struct attribute_group **msi_populate_sysfs(struct device *dev)
+static const struct attribute_group **msi_populate_sysfs(struct device *dev)
 {
 	const struct attribute_group **msi_irq_groups;
 	struct attribute **msi_attrs, *msi_attr;
@@ -228,41 +224,32 @@ int msi_device_populate_sysfs(struct dev
 }
 
 /**
- * msi_destroy_sysfs - Destroy msi_irqs sysfs entries for devices
- * @dev:		The device(PCI, platform etc) who will remove sysfs entries
- * @msi_irq_groups:	attribute_group for device msi_irqs entries
- */
-void msi_destroy_sysfs(struct device *dev, const struct attribute_group **msi_irq_groups)
-{
-	struct device_attribute *dev_attr;
-	struct attribute **msi_attrs;
-	int count = 0;
-
-	if (msi_irq_groups) {
-		sysfs_remove_groups(&dev->kobj, msi_irq_groups);
-		msi_attrs = msi_irq_groups[0]->attrs;
-		while (msi_attrs[count]) {
-			dev_attr = container_of(msi_attrs[count],
-					struct device_attribute, attr);
-			kfree(dev_attr->attr.name);
-			kfree(dev_attr);
-			++count;
-		}
-		kfree(msi_attrs);
-		kfree(msi_irq_groups[0]);
-		kfree(msi_irq_groups);
-	}
-}
-
-/**
  * msi_device_destroy_sysfs - Destroy msi_irqs sysfs entries for a device
  * @dev:		The device(PCI, platform etc) for which to remove
  *			sysfs entries
  */
 void msi_device_destroy_sysfs(struct device *dev)
 {
-	msi_destroy_sysfs(dev, dev->msi.data->attrs);
+	const struct attribute_group **msi_irq_groups = dev->msi.data->attrs;
+	struct device_attribute *dev_attr;
+	struct attribute **msi_attrs;
+	int count = 0;
+
 	dev->msi.data->attrs = NULL;
+	if (!msi_irq_groups)
+		return;
+
+	sysfs_remove_groups(&dev->kobj, msi_irq_groups);
+	msi_attrs = msi_irq_groups[0]->attrs;
+	while (msi_attrs[count]) {
+		dev_attr = container_of(msi_attrs[count], struct device_attribute, attr);
+		kfree(dev_attr->attr.name);
+		kfree(dev_attr);
+		++count;
+	}
+	kfree(msi_attrs);
+	kfree(msi_irq_groups[0]);
+	kfree(msi_irq_groups);
 }
 #endif
 

