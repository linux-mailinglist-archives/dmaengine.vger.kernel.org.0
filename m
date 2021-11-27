Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD0D45F9D0
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348981AbhK0B2W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:28:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35300 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345708AbhK0B0S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:26:18 -0500
Message-ID: <20211126230525.717286966@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lGMoGQDOkZmCsZ8FLKTWCWUkNfIx3jWYUDFtnIf5/U4=;
        b=n4VA8TjjZsXj/YLR8uW0WeKOoBPJSySmhK2nKGm0r3Wh2p8sTvTpHR5gWBRHDThXy+K+dz
        6AiylyRSUXFPZE/Fj9Yu8hzexzr/5Vw2yAztW+xHXq/pg//du8RtZ7ybxjZR9dd4IuIcGB
        4D4E2iaVOqQX0CJ9oXuAhH/CVRrwMhVZVs3EmaM0+PRy5adQKlMMIt8usJp8vrLp+5Cbms
        gPu4H/k1GfGipgFgV/AnmLnou76HJA9/K5tVVRdabCP22CHIUF0OIf2i0+dwhOgxSHMhyl
        /ra+9LpdeRyQrOdJsnXGdZ2nkJkpwi8CtVDani6kjk+GeBlx1cer13punBJygw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lGMoGQDOkZmCsZ8FLKTWCWUkNfIx3jWYUDFtnIf5/U4=;
        b=HXPwrcAtVW7VEWtyIJ2EKcLCItORCI9ek4u23jGiih1EjCqWeRibc3sijpeTPMTbglZvdM
        3Vk2GrKWo1Ocw7BQ==
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
Subject: [patch 30/37] PCI/MSI: Simplify pci_irq_get_affinity()
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:20:54 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Replace open coded MSI descriptor chasing and use the proper accessor
functions instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/msi.c |   26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -1040,26 +1040,20 @@ EXPORT_SYMBOL(pci_irq_vector);
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
 

