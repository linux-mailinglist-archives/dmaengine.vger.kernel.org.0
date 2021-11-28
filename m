Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5F24609ED
	for <lists+dmaengine@lfdr.de>; Sun, 28 Nov 2021 22:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359140AbhK1VFs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Nov 2021 16:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhK1VDr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Nov 2021 16:03:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134A1C06174A;
        Sun, 28 Nov 2021 13:00:29 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638133227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oVxt6RB3wq6HozhBc+E1hXItThUGltcJ9ju6gKUja04=;
        b=ovQrQWgMUuCiS2J0TbehvfgGdvNDScGgbL+6hWiymu/4hk9yeorrjvjwv2A9ri4fiF4TL3
        DSfT6C8e0bmVDuHDUQCzJRqttusZrTW5XX4wCU7Yj9sLULu1x4kK66+AlBBbjIUAjG9B8b
        64XqhOhWkg/ctdSQbKmE8BPcVfZbk2k2cR6inZtwbnSoC1F0IYB1MxGUeqWra/EysyM5Ez
        qxt0eKskFmSTQ/tAboszZk03QHU7P8ZOyTxd+7hAvKgMMi3vTl00SxM61TgYLUB2M3NMJS
        AYqARRb1pH+8qjed7HIPkZ/WNgRcJfB3t7oIWocwmnlKWlG53ZmKHDR/Q2zjcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638133227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oVxt6RB3wq6HozhBc+E1hXItThUGltcJ9ju6gKUja04=;
        b=NUA/BtE19KWnZCRSqlc8MZDe4YbQjIYarpAE6lp/GjIsHlXDmVpRZHIvnhigXdHIcoaHek
        On6pzReK20LEQhBw==
To:     Marc Zyngier <maz@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
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
Subject: Re: [patch 29/37] PCI/MSI: Use __msi_get_virq() in pci_get_vector()
In-Reply-To: <871r30rrzq.wl-maz@kernel.org>
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.660206325@linutronix.de> <871r30rrzq.wl-maz@kernel.org>
Date:   Sun, 28 Nov 2021 22:00:26 +0100
Message-ID: <87tufwdmhh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Nov 28 2021 at 19:37, Marc Zyngier wrote:
> On Sat, 27 Nov 2021 01:22:03 +0000,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
> I worked around it with the hack below, but I doubt this is the real
> thing. portdrv_core.c does complicated things, and I don't completely
> understand its logic.
>
> 	M.
>
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 1f72bc734226..b15278a5fb4b 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -1092,8 +1092,9 @@ int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
>  	int irq = __msi_get_virq(&dev->dev, nr);
>  
>  	switch (irq) {
> -	case -ENODEV: return !nr ? dev->irq : -EINVAL;
> -	case -ENOENT: return -EINVAL;
> +	case -ENOENT:
> +	case -ENODEV:
> +		return !nr ? dev->irq : -EINVAL;

Hrm. ENODEV is returned when dev->msi.data == NULL, ENOENT when there is
no MSI entry. But yes, that goes south when the device tried to enable
MSI[X} and then ended up with INTx. It still has dev->msi.data, which
causes it to return -ENOENT, which makes the above go belly up.

Moo, what was I thinking?

Thanks,

        tglx
---
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -1032,13 +1032,13 @@ EXPORT_SYMBOL(pci_free_irq_vectors);
  */
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 {
-	int irq = __msi_get_virq(&dev->dev, nr);
+	unsigned int irq;
 
-	switch (irq) {
-	case -ENODEV: return !nr ? dev->irq : -EINVAL;
-	case -ENOENT: return -EINVAL;
-	}
-	return irq;
+	if (!dev->msi_enabled && !dev->msix_enabled)
+		return !nr ? dev->irq : -EINVAL;
+
+	irq = msi_get_virq(&dev->dev, nr);
+	return irq ? irq : -EINVAL;
 }
 EXPORT_SYMBOL(pci_irq_vector);
 
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -169,21 +169,7 @@ static inline bool msi_device_has_proper
 }
 #endif
 
-int __msi_get_virq(struct device *dev, unsigned int index);
-
-/**
- * msi_get_virq - Return Linux interrupt number of a MSI interrupt
- * @dev:	Device to operate on
- * @index:	MSI interrupt index to look for (0-based)
- *
- * Return: The Linux interrupt number on success (> 0), 0 if not found
- */
-static inline unsigned int msi_get_virq(struct device *dev, unsigned int index)
-{
-	int ret = __msi_get_virq(dev, index);
-
-	return ret < 0 ? 0 : ret;
-}
+unsigned int msi_get_virq(struct device *dev, unsigned int index);
 
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -119,21 +119,19 @@ int msi_setup_device_data(struct device
 }
 
 /**
- * __msi_get_virq - Return Linux interrupt number of a MSI interrupt
+ * msi_get_virq - Return Linux interrupt number of a MSI interrupt
  * @dev:	Device to operate on
  * @index:	MSI interrupt index to look for (0-based)
  *
- * Return: The Linux interrupt number on success (> 0)
- *	   -ENODEV when the device is not using MSI
- *	   -ENOENT if no such entry exists
+ * Return: The Linux interrupt number on success (> 0), 0 if not found
  */
-int __msi_get_virq(struct device *dev, unsigned int index)
+unsigned int msi_get_virq(struct device *dev, unsigned int index)
 {
 	struct msi_desc *desc;
 	bool pcimsi;
 
 	if (!dev->msi.data)
-		return -ENODEV;
+		return 0;
 
 	pcimsi = msi_device_has_property(dev, MSI_PROP_PCI_MSI);
 
@@ -152,9 +150,9 @@ int __msi_get_virq(struct device *dev, u
 		if (desc->msi_index == index)
 			return desc->irq;
 	}
-	return -ENOENT;
+	return 0;
 }
-EXPORT_SYMBOL_GPL(__msi_get_virq);
+EXPORT_SYMBOL_GPL(msi_get_virq);
 
 #ifdef CONFIG_SYSFS
 static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
