Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA73F46ACA4
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 23:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358244AbhLFWnu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 17:43:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47068 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358139AbhLFWm5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 17:42:57 -0500
Message-ID: <20211206210438.688216619@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638830367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rDy+I3ErSIwPbhu7X1CCkhe4PGVkrX5FRQ61OeZYbi0=;
        b=rdxELXqqCUvF6w5maDZkJ1DUVcE8xtOFQuqB//kVE8LutIsp9x7oY88xYjjcJZGehvl20I
        R+i6TJmT/vTW79Nv4ctZJYRheEWHSoWoguFGJMgyW+Y78A4gZheDTRjB7MKWo1i1SNciQv
        MAkGYA8bGBoVVnZcIEV3q2C/xmLuWz4pSytUusJpxR9xdD6KElclS1+2OYVVTkq2CTV5v0
        K7Qk55Cr9KK7t23ybVmifYXu8ldnDmpJ27OX5lTB0ymWjBlgUMjTEseTLZ8Qod83UjgC9D
        tbU/slR0lNW5luPAEZ2uA0pSeOSKTDgFQBd2KUoEvNi5EWLt9sMAqB45SFUrIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638830367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rDy+I3ErSIwPbhu7X1CCkhe4PGVkrX5FRQ61OeZYbi0=;
        b=tGgA6BqJjARLsTeCWAn17BXxaUG282LmcuxVJy035n8FdUpejfTN0J30/E3k5C2sIwZD1h
        pHsGs8TzGh+VOpBg==
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
Subject: [patch V2 19/36] PCI/MSI: Store properties in device::msi::data
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:39:26 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Store the properties which are interesting for various places so the MSI
descriptor fiddling can be removed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Use the setter function
---
 drivers/pci/msi/msi.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -244,6 +244,8 @@ static void free_msi_irqs(struct pci_dev
 		iounmap(dev->msix_base);
 		dev->msix_base = NULL;
 	}
+
+	msi_device_set_properties(&dev->dev, 0);
 }
 
 static void pci_intx_for_msi(struct pci_dev *dev, int enable)
@@ -341,6 +343,7 @@ msi_setup_entry(struct pci_dev *dev, int
 {
 	struct irq_affinity_desc *masks = NULL;
 	struct msi_desc *entry;
+	unsigned long prop;
 	u16 control;
 
 	if (affd)
@@ -372,6 +375,10 @@ msi_setup_entry(struct pci_dev *dev, int
 	if (entry->pci.msi_attrib.can_mask)
 		pci_read_config_dword(dev, entry->pci.mask_pos, &entry->pci.msi_mask);
 
+	prop = MSI_PROP_PCI_MSI;
+	if (entry->pci.msi_attrib.is_64)
+		prop |= MSI_PROP_64BIT;
+	msi_device_set_properties(&dev->dev, prop);
 out:
 	kfree(masks);
 	return entry;
@@ -514,6 +521,7 @@ static int msix_setup_entries(struct pci
 		if (masks)
 			curmsk++;
 	}
+	msi_device_set_properties(&dev->dev, MSI_PROP_PCI_MSIX | MSI_PROP_64BIT);
 	ret = 0;
 out:
 	kfree(masks);

