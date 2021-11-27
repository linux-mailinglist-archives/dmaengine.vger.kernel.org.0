Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2DB45F9C5
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347875AbhK0B2S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:28:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35128 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347948AbhK0B0L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:26:11 -0500
Message-ID: <20211126230525.603398433@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OStoQ1k4lhD67pt01NEuqrVFlk3DmZUUJiTL5O5hAPA=;
        b=2eIPTF3xTaHSNXBIoN6UqqgFfwD0fJ1X1T9rr9vQ/2LfENBf9x4679Mo2RuhP9n8o8RsID
        PnEAypAhi616GnVO+gsc2xOAtuWMr4zBjlVOnNOOtDv/TFaKyRNAdBMjxKS/4JHJVMVGoZ
        WM12EP6pWvV4ZsO7GlLDsIBUy/ezmXIF/1d3ZFPMW5x3TBf0XpZh+FYDE99NYyZWIvzYgi
        BIqUxvpeT1xK0s9B7mfKENI+tGzeDcNGN6l89hiOEFrHrMdVn8Hh5EnSM+v1FR2r2Ei4Jg
        6CiJ/KP+dYdUGxvoPE9tL/6S+FTAN/FPTY7BQjlvqgOjLHOCqkbvJ4Ec+bDtIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OStoQ1k4lhD67pt01NEuqrVFlk3DmZUUJiTL5O5hAPA=;
        b=F4GuDJS8gR6I0V15qge6xQbu7oE67MdRvXQDexFplNMXCIE/Lzm4ICs8dJd43R0NUCg4Ec
        uDsRCB20i1Lf70AQ==
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
Date:   Sat, 27 Nov 2021 02:20:51 +0100 (CET)
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

