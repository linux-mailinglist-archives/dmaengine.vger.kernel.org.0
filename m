Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C26246ACBD
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 23:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359075AbhLFWoG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 17:44:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47330 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359052AbhLFWnK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 17:43:10 -0500
Message-ID: <20211206210439.128089025@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638830380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yTGriMSBQw12ZMYwEGW0S48cT2DY3/1yk7kZdgU1pmY=;
        b=abvHkvl7MHes9mfOR9bqibGGIq+vx064Sx/2IoxZNFoXq1/arNYeM7Fbw9vyud2BFpcCyl
        8gYXLi5T6uox7YrF/wkwGrMbOYbu8YeDNLMftUhInxY9rK7K3bLobmPm3i1yFDmDTt3Sz8
        FivfavzedB+NMyNAHZGsBXI5xY3YXl5/y7Z8BJwltsgNA86ygdtVAKJ9/QL9NYaT4aF83x
        FfUbp+918U2Of/Jb3GGCZN/G6A6CFJdtTNeZeidruI3SVzDwS/Wqx5Mwzt5+j9ENoiITfF
        2EmWdlKv5+TyJK4oh9mDVyz937Nyh0L46t/la0gvE9sDn8q0Hx5sEwvmQSn/0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638830380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yTGriMSBQw12ZMYwEGW0S48cT2DY3/1yk7kZdgU1pmY=;
        b=1N0K5YuxqLac5NJ0H3KkeMbsgwgxSEc2RhXJyC59uy5mjovjdeMAYcA2crOwpjyQKiRZJy
        VIAHD13n0j3h8SAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [patch V2 27/36] genirq/msi: Provide interface to retrieve Linux
 interrupt number
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:39:39 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This allows drivers to retrieve the Linux interrupt number instead of
fiddling with MSI descriptors.

msi_get_virq() returns the Linux interrupt number or 0 in case that there
is no entry for the given MSI index.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Simplify the implementation and let PCI deal with the PCI specialities - Marc
---
 include/linux/msi.h |    2 ++
 kernel/irq/msi.c    |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -170,6 +170,8 @@ static inline bool msi_device_has_proper
 static inline void msi_device_set_properties(struct device *dev, unsigned long prop) { }
 #endif
 
+unsigned int msi_get_virq(struct device *dev, unsigned int index);
+
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
 #define dev_to_msi_list(dev)		(&(dev)->msi_list)
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -129,6 +129,42 @@ int msi_setup_device_data(struct device
 	return 0;
 }
 
+/**
+ * msi_get_virq - Return Linux interrupt number of a MSI interrupt
+ * @dev:	Device to operate on
+ * @index:	MSI interrupt index to look for (0-based)
+ *
+ * Return: The Linux interrupt number on success (> 0), 0 if not found
+ */
+unsigned int msi_get_virq(struct device *dev, unsigned int index)
+{
+	struct msi_desc *desc;
+	bool pcimsi;
+
+	if (!dev->msi.data)
+		return 0;
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
+	return 0;
+}
+EXPORT_SYMBOL_GPL(msi_get_virq);
+
 #ifdef CONFIG_SYSFS
 static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)

