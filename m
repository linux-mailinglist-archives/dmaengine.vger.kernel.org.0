Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665A6470D95
	for <lists+dmaengine@lfdr.de>; Fri, 10 Dec 2021 23:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344771AbhLJWYd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Dec 2021 17:24:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50058 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344744AbhLJWWs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Dec 2021 17:22:48 -0500
Message-ID: <20211210221814.287680528@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639174751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=zIZczyRlH4Mx4fB5mmlODqe9FKNOKEFU5ncWnwPgL4o=;
        b=A7TX/LnwMZ3WbXEnRoPrDP/wLd2iphxwXGgFB2xNDcix6PjdERSNAqWZP3cDL+ul1e+OgS
        XZwjDctIfCLuV18Dm1hv3qTKEaY6pfv6/JrJwTE0Zi/Mq6iBPgIO6QtvtT1kN6nSLPvNPW
        0u0s7/PZpPkZNxO2RTqbZAkwSRF23scy5J5cf67INwsZCQZA1X62o97PiKxMfxj6o8/GxZ
        aO9H2WxcI08XgbYFKtYRHKYr0lWyDUFfBt68wukumRk/J7k3llF+aqTWeB78Uo5s/n8eAj
        eO0F5f71EAQkycZW2+2rOZR7xc5Gp2SnvBytgZ4S05qo6bkqWTDwARQoLAvwQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639174751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=zIZczyRlH4Mx4fB5mmlODqe9FKNOKEFU5ncWnwPgL4o=;
        b=/snRPAepbgN6BXoxpR9Y/cwG/pUn2U+BFbd6X9S/kPABlfdlYLuradGw7bcnIwrFcdQcFh
        R0NHGOxeEpedSOCw==
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
Subject: [patch V3 18/35] platform-msi: Store platform private data pointer in
 msi_device_data
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 10 Dec 2021 23:19:11 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Storing the platform private data in a MSI descriptor is sloppy at
best. The data belongs to the device and not to the descriptor.
Add a pointer to struct msi_device_data and store the pointer there.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/base/platform-msi.c |   79 +++++++++++++++++---------------------------
 include/linux/msi.h         |    4 +-
 2 files changed, 34 insertions(+), 49 deletions(-)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -38,9 +38,7 @@ static DEFINE_IDA(platform_msi_devid_ida
  */
 static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
 {
-	u32 devid;
-
-	devid = desc->platform.msi_priv_data->devid;
+	u32 devid = desc->dev->msi.data->platform_data->devid;
 
 	return (devid << (32 - DEV_ID_SHIFT)) | desc->platform.msi_index;
 }
@@ -85,11 +83,8 @@ static void platform_msi_update_dom_ops(
 static void platform_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
-	struct platform_msi_priv_data *priv_data;
-
-	priv_data = desc->platform.msi_priv_data;
 
-	priv_data->write_msg(desc, msg);
+	desc->dev->msi.data->platform_data->write_msg(desc, msg);
 }
 
 static void platform_msi_update_chip_ops(struct msi_domain_info *info)
@@ -126,9 +121,7 @@ static void platform_msi_free_descs(stru
 }
 
 static int platform_msi_alloc_descs_with_irq(struct device *dev, int virq,
-					     int nvec,
-					     struct platform_msi_priv_data *data)
-
+					     int nvec)
 {
 	struct msi_desc *desc;
 	int i, base = 0;
@@ -144,7 +137,6 @@ static int platform_msi_alloc_descs_with
 		if (!desc)
 			break;
 
-		desc->platform.msi_priv_data = data;
 		desc->platform.msi_index = base + i;
 		desc->irq = virq ? virq + i : 0;
 
@@ -161,11 +153,9 @@ static int platform_msi_alloc_descs_with
 	return 0;
 }
 
-static int platform_msi_alloc_descs(struct device *dev, int nvec,
-				    struct platform_msi_priv_data *data)
-
+static int platform_msi_alloc_descs(struct device *dev, int nvec)
 {
-	return platform_msi_alloc_descs_with_irq(dev, 0, nvec, data);
+	return platform_msi_alloc_descs_with_irq(dev, 0, nvec);
 }
 
 /**
@@ -199,9 +189,8 @@ struct irq_domain *platform_msi_create_i
 	return domain;
 }
 
-static struct platform_msi_priv_data *
-platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
-			     irq_write_msi_msg_t write_msi_msg)
+static int platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
+					irq_write_msi_msg_t write_msi_msg)
 {
 	struct platform_msi_priv_data *datap;
 	int err;
@@ -213,41 +202,44 @@ platform_msi_alloc_priv_data(struct devi
 	 * capable devices).
 	 */
 	if (!dev->msi.domain || !write_msi_msg || !nvec || nvec > MAX_DEV_MSIS)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	if (dev->msi.domain->bus_token != DOMAIN_BUS_PLATFORM_MSI) {
 		dev_err(dev, "Incompatible msi_domain, giving up\n");
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	err = msi_setup_device_data(dev);
 	if (err)
-		return ERR_PTR(err);
+		return err;
 
-	/* Already had a helping of MSI? Greed... */
-	if (!list_empty(dev_to_msi_list(dev)))
-		return ERR_PTR(-EBUSY);
+	/* Already initialized? */
+	if (dev->msi.data->platform_data)
+		return -EBUSY;
 
 	datap = kzalloc(sizeof(*datap), GFP_KERNEL);
 	if (!datap)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	datap->devid = ida_simple_get(&platform_msi_devid_ida,
 				      0, 1 << DEV_ID_SHIFT, GFP_KERNEL);
 	if (datap->devid < 0) {
 		err = datap->devid;
 		kfree(datap);
-		return ERR_PTR(err);
+		return err;
 	}
 
 	datap->write_msg = write_msi_msg;
 	datap->dev = dev;
-
-	return datap;
+	dev->msi.data->platform_data = datap;
+	return 0;
 }
 
-static void platform_msi_free_priv_data(struct platform_msi_priv_data *data)
+static void platform_msi_free_priv_data(struct device *dev)
 {
+	struct platform_msi_priv_data *data = dev->msi.data->platform_data;
+
+	dev->msi.data->platform_data = NULL;
 	ida_simple_remove(&platform_msi_devid_ida, data->devid);
 	kfree(data);
 }
@@ -264,14 +256,13 @@ static void platform_msi_free_priv_data(
 int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 				   irq_write_msi_msg_t write_msi_msg)
 {
-	struct platform_msi_priv_data *priv_data;
 	int err;
 
-	priv_data = platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
-	if (IS_ERR(priv_data))
-		return PTR_ERR(priv_data);
+	err = platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
+	if (err)
+		return err;
 
-	err = platform_msi_alloc_descs(dev, nvec, priv_data);
+	err = platform_msi_alloc_descs(dev, nvec);
 	if (err)
 		goto out_free_priv_data;
 
@@ -284,8 +275,7 @@ int platform_msi_domain_alloc_irqs(struc
 out_free_desc:
 	platform_msi_free_descs(dev, 0, nvec);
 out_free_priv_data:
-	platform_msi_free_priv_data(priv_data);
-
+	platform_msi_free_priv_data(dev);
 	return err;
 }
 EXPORT_SYMBOL_GPL(platform_msi_domain_alloc_irqs);
@@ -296,15 +286,9 @@ EXPORT_SYMBOL_GPL(platform_msi_domain_al
  */
 void platform_msi_domain_free_irqs(struct device *dev)
 {
-	if (!list_empty(dev_to_msi_list(dev))) {
-		struct msi_desc *desc;
-
-		desc = first_msi_entry(dev);
-		platform_msi_free_priv_data(desc->platform.msi_priv_data);
-	}
-
 	msi_domain_free_irqs(dev->msi.domain, dev);
 	platform_msi_free_descs(dev, 0, MAX_DEV_MSIS);
+	platform_msi_free_priv_data(dev);
 }
 EXPORT_SYMBOL_GPL(platform_msi_domain_free_irqs);
 
@@ -351,10 +335,11 @@ struct irq_domain *
 	struct irq_domain *domain;
 	int err;
 
-	data = platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
-	if (IS_ERR(data))
+	err = platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
+	if (err)
 		return NULL;
 
+	data = dev->msi.data->platform_data;
 	data->host_data = host_data;
 	domain = irq_domain_create_hierarchy(dev->msi.domain, 0,
 					     is_tree ? 0 : nvec,
@@ -372,7 +357,7 @@ struct irq_domain *
 free_domain:
 	irq_domain_remove(domain);
 free_priv:
-	platform_msi_free_priv_data(data);
+	platform_msi_free_priv_data(dev);
 	return NULL;
 }
 
@@ -420,7 +405,7 @@ int platform_msi_device_domain_alloc(str
 	struct platform_msi_priv_data *data = domain->host_data;
 	int err;
 
-	err = platform_msi_alloc_descs_with_irq(data->dev, virq, nr_irqs, data);
+	err = platform_msi_alloc_descs_with_irq(data->dev, virq, nr_irqs);
 	if (err)
 		return err;
 
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -108,11 +108,9 @@ struct pci_msi_desc {
 
 /**
  * platform_msi_desc - Platform device specific msi descriptor data
- * @msi_priv_data:	Pointer to platform private data
  * @msi_index:		The index of the MSI descriptor for multi MSI
  */
 struct platform_msi_desc {
-	struct platform_msi_priv_data	*msi_priv_data;
 	u16				msi_index;
 };
 
@@ -177,10 +175,12 @@ struct msi_desc {
  * msi_device_data - MSI per device data
  * @properties:		MSI properties which are interesting to drivers
  * @attrs:		Pointer to the sysfs attribute group
+ * @platform_data:	Platform-MSI specific data
  */
 struct msi_device_data {
 	unsigned long			properties;
 	const struct attribute_group    **attrs;
+	struct platform_msi_priv_data	*platform_data;
 };
 
 int msi_setup_device_data(struct device *dev);

