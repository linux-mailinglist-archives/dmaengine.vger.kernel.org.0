Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CC545FA59
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346673AbhK0BbK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:31:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40454 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349784AbhK0B3G (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:29:06 -0500
Message-ID: <20211126230525.603398433@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OStoQ1k4lhD67pt01NEuqrVFlk3DmZUUJiTL5O5hAPA=;
        b=p/NPVHkYkWacp959EAGV63t+QF44M4nmwyJpkmxhobzHMy0oLeXCml4Dr7nGtmPNC0j+WY
        B7A+XOX+bUiQGGnqmMeYDCi6nuPATIptOhpsfS6cXI93itu1a39nmOe3EbTIHJPYHxHJl/
        XJKPi6FmSn54C8eYngXdjjlg5nTuN6a/ZboSRqT6YWuNUK9jSxbqg8/oAYI5jlkVYTdMCt
        H1C6eAWCV+Ct3UnEO7kwgd8AlvWgSHDYcClguXlcmdH6z2n0jDEfUP11605adYmJ3lTsWt
        0veZehPwbKT+6+xkp5lhiaNBDoo35OX5lr/p1bk3ueG0H0O/j/Dbx0Y1nbMU1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OStoQ1k4lhD67pt01NEuqrVFlk3DmZUUJiTL5O5hAPA=;
        b=myakaVvhQTfIHvDEKNp6aQzHpJx42UzrH2h+7Ogy2xKClVuLIsMQRKwjYYVfx3QxA0yElw
        jWtiyr7lcC5BO3BQ==
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
Subject: [patch 28/37] genirq/msi: Provide interface to retrieve Linux
 interrupt number
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:22:01 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This allows drivers to retrieve the Linux interrupt number instead of
fiddling with MSI descriptors.

msi_get_virq() returns the Linux interrupt number or 0, __msi_get_virq()
has more detailed return codes so pci_irq_vector() can use it as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   16 ++++++++++++++++
 kernel/irq/msi.c    |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -169,6 +169,22 @@ static inline bool msi_device_has_proper
 }
 #endif
 
+int __msi_get_virq(struct device *dev, unsigned int index);
+
+/**
+ * msi_get_virq - Return Linux interrupt number of a MSI interrupt
+ * @dev:	Device to operate on
+ * @index:	MSI interrupt index to look for (0-based)
+ *
+ * Return: The Linux interrupt number on success (> 0), 0 if not found
+ */
+static inline unsigned int msi_get_virq(struct device *dev, unsigned int index)
+{
+	int ret = __msi_get_virq(dev, index);
+
+	return ret < 0 ? 0 : ret;
+}
+
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
 #define dev_to_msi_list(dev)		(&(dev)->msi_list)
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -120,6 +120,44 @@ int msi_setup_device_data(struct device
 	return 0;
 }
 
+/**
+ * __msi_get_virq - Return Linux interrupt number of a MSI interrupt
+ * @dev:	Device to operate on
+ * @index:	MSI interrupt index to look for (0-based)
+ *
+ * Return: The Linux interrupt number on success (> 0)
+ *	   -ENODEV when the device is not using MSI
+ *	   -ENOENT if no such entry exists
+ */
+int __msi_get_virq(struct device *dev, unsigned int index)
+{
+	struct msi_desc *desc;
+	bool pcimsi;
+
+	if (!dev->msi.data)
+		return -ENODEV;
+
+	pcimsi = msi_device_has_property(dev, MSI_PROP_PCI_MSI);
+
+	for_each_msi_entry(desc, dev) {
+		/* PCI-MSI has only one descriptor for multiple interrupts. */
+		if (pcimsi) {
+			if (desc->irq && index < desc->nvec_used)
+				return desc->irq + index;
+			break;
+		}
+
+		/*
+		 * PCI-MSIX and platform MSI use a descriptor per
+		 * interrupt.
+		 */
+		if (desc->msi_index == index)
+			return desc->irq;
+	}
+	return -ENOENT;
+}
+EXPORT_SYMBOL_GPL(__msi_get_virq);
+
 #ifdef CONFIG_SYSFS
 static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)

