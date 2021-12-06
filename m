Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43FE46ACD2
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 23:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376824AbhLFWog (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 17:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359758AbhLFWnx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 17:43:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18553C0698D0;
        Mon,  6 Dec 2021 14:39:43 -0800 (PST)
Message-ID: <20211206210439.181331216@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638830381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=VrULNCMH+O8xsmxJgHu1VunM7q/HyFmEpUljbWBlO+M=;
        b=1WyUya3l8fZi6fy1zbrOKQrTo97M/mFRNLJk70qGOPb0JPRgzFKQUP3Ap98oq2yIU+W79y
        WmvByYmwToUfcQdjSAd5N46svh0Lkih1RSbg6furNRI0+XUMr1pOBKIX+irSBkIRN609j/
        jgDcnPD7jjQZ/ZAEDMijZa34I3oXKq99mGxdyY7uvZ2xHboD3lTKRVNV1ahRc0v6NJpUyd
        2djS86MgaRG75KvoijVeoRbChYP6OBHa4h+jnI5iBX5I8xLG5cijyFLO/hLr8BePuB5G8D
        EXG5Csvz4BostgHD1hbblseyHYWXy7KyZk0QJOjUNO2iPqUZZX60PIldxOiaQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638830381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=VrULNCMH+O8xsmxJgHu1VunM7q/HyFmEpUljbWBlO+M=;
        b=4SHbAktYMF4p3JfEkG2RuP8fQBgK7GPTe1sN6CDnwn2pN1kMTUy4TffqwybjaftPt18Fji
        W4koD0rufC6aGiCQ==
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
Subject: [patch V2 28/36] PCI/MSI: Use __msi_get_virq() in pci_get_vector()
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:39:41 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use msi_get_vector() and handle the return value to be compatible.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Handle the INTx case directly instead of trying to be overly smart - Marc
---
 drivers/pci/msi/msi.c |   25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -1032,28 +1032,13 @@ EXPORT_SYMBOL(pci_free_irq_vectors);
  */
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 {
-	if (dev->msix_enabled) {
-		struct msi_desc *entry;
+	unsigned int irq;
 
-		for_each_pci_msi_entry(entry, dev) {
-			if (entry->msi_index == nr)
-				return entry->irq;
-		}
-		WARN_ON_ONCE(1);
-		return -EINVAL;
-	}
+	if (!dev->msi_enabled && !dev->msix_enabled)
+		return !nr ? dev->irq : -EINVAL;
 
-	if (dev->msi_enabled) {
-		struct msi_desc *entry = first_pci_msi_entry(dev);
-
-		if (WARN_ON_ONCE(nr >= entry->nvec_used))
-			return -EINVAL;
-	} else {
-		if (WARN_ON_ONCE(nr > 0))
-			return -EINVAL;
-	}
-
-	return dev->irq + nr;
+	irq = msi_get_virq(&dev->dev, nr);
+	return irq ? irq : -EINVAL;
 }
 EXPORT_SYMBOL(pci_irq_vector);
 

