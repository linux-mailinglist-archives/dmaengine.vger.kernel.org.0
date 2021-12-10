Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7BA470D31
	for <lists+dmaengine@lfdr.de>; Fri, 10 Dec 2021 23:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344761AbhLJWWu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Dec 2021 17:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344693AbhLJWWe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Dec 2021 17:22:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81939C0617A2;
        Fri, 10 Dec 2021 14:18:57 -0800 (PST)
Message-ID: <20211210221813.676660809@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639174736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=p0CEuniGVD/vlSD2Fd4mo52TznQAMRoSID0Sm2FVZu8=;
        b=n2s1uJk2XLnn3q/65Q5CrHyLj/4eIkBuDnUXjKfvDdEkXIQAVhgrtNniBJgeNBBeEVK8WP
        3E7ubu/sWhKpoeZLhX9MdGDvwf2AySwJvHs/79xoeFcHBpy5ond56xY09RrcRU4yl65sf2
        On9c13AM0+oKSQXe00/zvf0Ks0BgKdWHVE6bTlsJTFPJjil5KpBKd5ilISnzcjJZ9CMzo9
        g0xxvVb97eNNSaqP/OovaxrVT6K8rOQGOlGcPPac0rbY6spkjNIEyNoM/REkTrWoGYS4fn
        ILtghYvxX3QAIhmr759JmbEMg6QNZ8UfTN3qUoaj7g9gNiuVsRDbOTd7IIzE5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639174736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=p0CEuniGVD/vlSD2Fd4mo52TznQAMRoSID0Sm2FVZu8=;
        b=zhgOEeEWgyS9usG6W9uHpuhsscfbHbM2ZMw8+DHKOUDQaF6OiHOi+rB1GbyoR+ygezP0WN
        J/NyrFyVzR5cUZAA==
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
Subject: [patch V3 08/35] device: Add device:: Msi_data pointer and struct
 msi_device_data
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 10 Dec 2021 23:18:55 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Create struct msi_device_data and add a pointer of that type to struct
dev_msi_info, which is part of struct device. Provide an allocator function
which can be invoked from the MSI interrupt allocation code pathes.

Add a properties field to the data structure as a first member so the
allocation size is not zero bytes. The field will be uses later on.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/device.h |    5 +++++
 include/linux/msi.h    |   18 ++++++++++++++++++
 kernel/irq/msi.c       |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -45,6 +45,7 @@ struct iommu_ops;
 struct iommu_group;
 struct dev_pin_info;
 struct dev_iommu;
+struct msi_device_data;
 
 /**
  * struct subsys_interface - interfaces to device functions
@@ -374,11 +375,15 @@ struct dev_links_info {
 /**
  * struct dev_msi_info - Device data related to MSI
  * @domain:	The MSI interrupt domain associated to the device
+ * @data:	Pointer to MSI device data
  */
 struct dev_msi_info {
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 	struct irq_domain	*domain;
 #endif
+#ifdef CONFIG_GENERIC_MSI_IRQ
+	struct msi_device_data	*data;
+#endif
 };
 
 /**
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -171,6 +171,16 @@ struct msi_desc {
 	};
 };
 
+/**
+ * msi_device_data - MSI per device data
+ * @properties:		MSI properties which are interesting to drivers
+ */
+struct msi_device_data {
+	unsigned long			properties;
+};
+
+int msi_setup_device_data(struct device *dev);
+
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
 #define dev_to_msi_list(dev)		(&(dev)->msi_list)
@@ -233,10 +243,16 @@ void pci_msi_mask_irq(struct irq_data *d
 void pci_msi_unmask_irq(struct irq_data *data);
 
 #ifdef CONFIG_SYSFS
+int msi_device_populate_sysfs(struct device *dev);
+void msi_device_destroy_sysfs(struct device *dev);
+
 const struct attribute_group **msi_populate_sysfs(struct device *dev);
 void msi_destroy_sysfs(struct device *dev,
 		       const struct attribute_group **msi_irq_groups);
 #else
+static inline int msi_device_populate_sysfs(struct device *dev) { return 0; }
+static inline void msi_device_destroy_sysfs(struct device *dev) { }
+
 static inline const struct attribute_group **msi_populate_sysfs(struct device *dev)
 {
 	return NULL;
@@ -384,6 +400,8 @@ enum {
 	MSI_FLAG_MUST_REACTIVATE	= (1 << 5),
 	/* Is level-triggered capable, using two messages */
 	MSI_FLAG_LEVEL_CAPABLE		= (1 << 6),
+	/* Populate sysfs on alloc() and destroy it on free() */
+	MSI_FLAG_DEV_SYSFS		= (1 << 7),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -73,6 +73,38 @@ void get_cached_msi_msg(unsigned int irq
 }
 EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 
+static void msi_device_data_release(struct device *dev, void *res)
+{
+	WARN_ON_ONCE(!list_empty(&dev->msi_list));
+	dev->msi.data = NULL;
+}
+
+/**
+ * msi_setup_device_data - Setup MSI device data
+ * @dev:	Device for which MSI device data should be set up
+ *
+ * Return: 0 on success, appropriate error code otherwise
+ *
+ * This can be called more than once for @dev. If the MSI device data is
+ * already allocated the call succeeds. The allocated memory is
+ * automatically released when the device is destroyed.
+ */
+int msi_setup_device_data(struct device *dev)
+{
+	struct msi_device_data *md;
+
+	if (dev->msi.data)
+		return 0;
+
+	md = devres_alloc(msi_device_data_release, sizeof(*md), GFP_KERNEL);
+	if (!md)
+		return -ENOMEM;
+
+	dev->msi.data = md;
+	devres_add(dev, md);
+	return 0;
+}
+
 #ifdef CONFIG_SYSFS
 static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)

