Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0996946ACD3
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 23:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376833AbhLFWog (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 17:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376257AbhLFWny (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 17:43:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915BDC0698D3;
        Mon,  6 Dec 2021 14:39:44 -0800 (PST)
Message-ID: <20211206210439.235197701@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638830383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5qM8oTMdwr/Y2E0GqvCoV+ICoCbtIN+qv9nd5yB9GSs=;
        b=JZUiFd3pdAJSDHq3VUKyD1OasA2Oro+g6/uvV4V1qDl2UvEQOxkAZViWPoRa1NZRu4vrzp
        FSTaStgm9FEmDsBsZ66XQO/bZ/+okt7KGfKcrN/2NbxpxF/R1qyGnY78CRd8GruycHQEVZ
        rkanxCjOU0JZth6BjhfeH6jyiNEl10eM8zmu0QdZv039kX8m7iaUJndnRdzGqDcBs3ZHK5
        fGBt+IglBMNHOnTm6Ak4gC7GTGciTERnIJ7HCpMCN4ClaPBo4nxP6A1orRZulEBjSPWeRe
        UwbpdXn6gbDNBMeTOE1BJabB7epz/u6ZhmrKNcIC5JFZ98DTuQ3Giaf/QufpbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638830383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5qM8oTMdwr/Y2E0GqvCoV+ICoCbtIN+qv9nd5yB9GSs=;
        b=m7lB0SchfJa9KJJz6u/QEd1BWWy3oYWAfOm6ycYh04Bv8BpwvZDfPvxc4nUATe4yTmjDlt
        Ejzuwe8vxERhfFCQ==
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
Subject: [patch V2 29/36] PCI/MSI: Simplify pci_irq_get_affinity()
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:39:42 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

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
@@ -1056,26 +1056,20 @@ EXPORT_SYMBOL(pci_irq_vector);
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
 

