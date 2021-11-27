Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD09C45F9F7
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347867AbhK0B3G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:29:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35196 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbhK0B0O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:26:14 -0500
Message-ID: <20211126230525.660206325@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=jDw77Q4/ltoMqqyOm7bRFWOUZ2wme/igWfBiXxqo04E=;
        b=qcphe6heJuFhgeduvF2Reuv4MsRdWQoJvg2SS3EklVbtfQMCfMHepnA6aswHZvdCNm95JM
        ZJCqv8yvfhWXCo7kpdm0VoADVoyFe16/31gccfBww5+RFExnu8gp0atniaD79Qi3vDjbQM
        B5gEnUCbG7Qa7lbqxJ0yxhbiq2ncMH6xYARq59W2DoqThjv7anXdD9w7J/3Wlv23hDx8Yz
        toD0JJ62PtZRlhLFza6PCjm1YqhAqE6ewJ1sJP2ky4RQBZWSsTJMQv4c9KXKUsUPpmDJtm
        2sBBQv12zQ1ocJDsjCrFoBod+HNM+8Kj49KY0bhQYTebAv0oebDz+XXdkGUDnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=jDw77Q4/ltoMqqyOm7bRFWOUZ2wme/igWfBiXxqo04E=;
        b=rxtvy30SOfVqYPnNL8Cg8Y3TzkF1flw2TNQolZOnFfTQrmh4C6E16aqDKf5J1vmsXVOdd6
        srt6OU8S/yzbHDCQ==
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
Subject: [patch 29/37] PCI/MSI: Use __msi_get_virq() in pci_get_vector()
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:20:53 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use __msi_get_vector() and handle the return values to be compatible.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/msi.c |   25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -1023,28 +1023,13 @@ EXPORT_SYMBOL(pci_free_irq_vectors);
  */
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 {
-	if (dev->msix_enabled) {
-		struct msi_desc *entry;
+	int irq = __msi_get_virq(&dev->dev, nr);
 
-		for_each_pci_msi_entry(entry, dev) {
-			if (entry->msi_index == nr)
-				return entry->irq;
-		}
-		WARN_ON_ONCE(1);
-		return -EINVAL;
+	switch (irq) {
+	case -ENODEV: return !nr ? dev->irq : -EINVAL;
+	case -ENOENT: return -EINVAL;
 	}
-
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
+	return irq;
 }
 EXPORT_SYMBOL(pci_irq_vector);
 

