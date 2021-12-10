Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D73470D7F
	for <lists+dmaengine@lfdr.de>; Fri, 10 Dec 2021 23:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344861AbhLJWYG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Dec 2021 17:24:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50696 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344868AbhLJWXD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Dec 2021 17:23:03 -0500
Message-ID: <20211210221814.900929381@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639174767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rNrzn8yRvXgsVUgYBaKAG8ZHI0uIOQ4IQLNHP2L6pxE=;
        b=nf9eyrsJJrs9ednYCFZjv8J2yY2kMTBnnjDazqRJ511KXpZJf1YcQjdYfXYm2loBQc4e51
        X1migsWpqvkVonHlgKGazqD3LQt1VEi1ONQMXlquZAUbD3bWwtHjKz6uiOhNtYIahCIAun
        mRzaRa8QncWEAJyd2oq1drpHnTqWPT1eKioZJCZmH/BKUQRxgGCPmRRh6EsC/v//nl8sL/
        boRobi4kXbHHVHnVHwhXecrQ/I8Q5OXFyHGRvTUgcBYSHxyXSCbkQ+q/m1CrmiEH4i02FY
        dX0m9VD+WaASxOutJEozXkaEXjuYirVE7txgIlds5ll8afoP9lZT4fq2oH6P3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639174767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rNrzn8yRvXgsVUgYBaKAG8ZHI0uIOQ4IQLNHP2L6pxE=;
        b=Cgugbw7jJJgW3jPH6Q3nUfo/m4UVuVoB8e3+XhsPb07BsPv7J7QZZ/uWWrdVpdYtMpcMdt
        NSwEg+9aK1hyY+CQ==
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
Subject: [patch V3 28/35] PCI/MSI: Simplify pci_irq_get_affinity()
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 10 Dec 2021 23:19:26 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Replace open coded MSI descriptor chasing and use the proper accessor
functions instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/pci/msi/msi.c |   26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -1061,26 +1061,20 @@ EXPORT_SYMBOL(pci_irq_vector);
  */
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 {
-	if (dev->msix_enabled) {
-		struct msi_desc *entry;
+	int irq = pci_irq_vector(dev, nr);
+	struct msi_desc *desc;
 
-		for_each_pci_msi_entry(entry, dev) {
-			if (entry->msi_index == nr)
-				return &entry->affinity->mask;
-		}
-		WARN_ON_ONCE(1);
+	if (WARN_ON_ONCE(irq <= 0))
 		return NULL;
-	} else if (dev->msi_enabled) {
-		struct msi_desc *entry = first_pci_msi_entry(dev);
 
-		if (WARN_ON_ONCE(!entry || !entry->affinity ||
-				 nr >= entry->nvec_used))
-			return NULL;
-
-		return &entry->affinity[nr].mask;
-	} else {
+	desc = irq_get_msi_desc(irq);
+	/* Non-MSI does not have the information handy */
+	if (!desc)
 		return cpu_possible_mask;
-	}
+
+	if (WARN_ON_ONCE(!desc->affinity))
+		return NULL;
+	return &desc->affinity[nr].mask;
 }
 EXPORT_SYMBOL(pci_irq_get_affinity);
 

