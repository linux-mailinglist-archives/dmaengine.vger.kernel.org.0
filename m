Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3794F45F972
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346832AbhK0B1C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:27:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36344 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347181AbhK0BZB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:25:01 -0500
Message-ID: <20211126230525.076279841@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gZLgk03W9BPqX4Y47drAtN3rUO/Oc3l0uTHU4EywtJI=;
        b=haWzMt4KR9DWFpGWdGE1l1s2+vs+6A08HfUC3wCsW3ct8bY8hzzw5Zksb1QAtSqqKXiTLV
        90HL8F+IY3f388igePB9oG82ZtrhY+pUqOOsbCmR2UT/4VVzeLQMGXQ7XBpjTJVwJYV4gI
        WYrto37nJcH9GJjyMqoKYfnwaCKd3a9/AJtrxjeb2TiAS5tmTf34lQJzwzHb8XlIXVJWOr
        i65Z3V0NA6W4UMX3WRllvGzZNGYs2fwg6buB6N3fX2WBKGLJIFIaq0bn5EZ88rtrKujv++
        Pb6chN5PsN34skBdrvROx5hCigMHTKQgd0gRtXaVoWnySgsBCrEuicXBelakSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gZLgk03W9BPqX4Y47drAtN3rUO/Oc3l0uTHU4EywtJI=;
        b=pmIRurktZCqaSiTjEwau1BH/cen1Z4IWsZYOdf1qJ4Pt16qpjmgbTpo368LzRvhdZG1dgu
        sjE9naEhMlft7uAw==
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
Subject: [patch 19/37] genirq/msi: Add msi_device_data::properties
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:20:37 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a properties field which allows core code to store information for easy
retrieval in order to replace MSI descriptor fiddling.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   17 +++++++++++++++++
 kernel/irq/msi.c    |   12 ++++++++++++
 2 files changed, 29 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -4,6 +4,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/bits.h>
 #include <asm/msi.h>
 
 /* Dummy shadow structures if an architecture does not define them */
@@ -141,17 +142,33 @@ struct msi_desc {
 /**
  * msi_device_data - MSI per device data
  * @lock:		Spinlock to protect register access
+ * @properties:		MSI properties which are interesting to drivers
  * @attrs:		Pointer to the sysfs attribute group
  * @platform_data:	Platform-MSI specific data
  */
 struct msi_device_data {
 	raw_spinlock_t			lock;
+	unsigned long			properties;
 	const struct attribute_group    **attrs;
 	struct platform_msi_priv_data	*platform_data;
 };
 
 int msi_setup_device_data(struct device *dev);
 
+/* MSI device properties */
+#define MSI_PROP_PCI_MSI		BIT(0)
+#define MSI_PROP_PCI_MSIX		BIT(1)
+#define MSI_PROP_64BIT			BIT(2)
+
+#ifdef CONFIG_GENERIC_MSI_IRQ
+bool msi_device_has_property(struct device *dev, unsigned long prop);
+#else
+static inline bool msi_device_has_property(struct device *dev, unsigned long prop)
+{
+	return false;
+}
+#endif
+
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
 #define dev_to_msi_list(dev)		(&(dev)->msi_list)
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -60,6 +60,18 @@ void free_msi_entry(struct msi_desc *ent
 	kfree(entry);
 }
 
+/**
+ * msi_device_has_property - Check whether a device has a specific MSI property
+ * @dev:	Pointer to the device which is queried
+ * @prop:	Property to check for
+ */
+bool msi_device_has_property(struct device *dev, unsigned long prop)
+{
+	if (!dev->msi.data)
+		return false;
+	return !!(dev->msi.data->properties & prop);
+}
+
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	*msg = entry->msg;

