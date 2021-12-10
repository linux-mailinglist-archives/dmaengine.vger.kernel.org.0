Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A447470D6E
	for <lists+dmaengine@lfdr.de>; Fri, 10 Dec 2021 23:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345109AbhLJWXg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Dec 2021 17:23:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51086 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344932AbhLJWXK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Dec 2021 17:23:10 -0500
Message-ID: <20211210221815.148331680@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639174773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1mcUFIyf9ySwp0yGA9BXrnZ9ta7jfneNSCIqf6wYVGk=;
        b=oKS80X/kJKLB8GB+c0SIKmguD/kevr7iZutS3fVTQ+rGCeSum9bn5Q+v1Est6NyleDXcvj
        C2TzfgyjVUEpqtu5aaWZcLjJlLFf0vRy+2ceD1IEYbC6SY7NiYO3pa/K3tveERBEi2lJ+W
        LrV7kcXBnYzWCcxOpkhXAviCnM6+blWD3RE5ejV9PjRrOFaNsJDbWBAt4YGwG4M9YMgqFp
        ixEY9UW4+wZWMAyVzTPe7Ms2nyLA/mEG6RCm8A0SFpOGFd1HIpzokfKB41UHXnSURcCa5O
        ptjXGZ9/US9gmPa1yw0KaJD2RG+xIPdfx7ti5vbGRnDGULGvRIPGUkdJ9s5kLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639174773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1mcUFIyf9ySwp0yGA9BXrnZ9ta7jfneNSCIqf6wYVGk=;
        b=7Nl66lpVGonXIzUJuEqPSV3MziV+dwsh1VZ137uXNOy+N9tDDG/1eW2YpLYeL3y+xjSQjH
        DDQUDmuZmfQw0OCw==
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
        Jassi Brar <jassisinghbrar@gmail.com>,
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
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [patch V3 32/35] mailbox: bcm-flexrm-mailbox: Rework MSI interrupt handling
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 10 Dec 2021 23:19:32 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

No point in retrieving the MSI descriptors. Just query the Linux interrupt
number.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>

---
 drivers/mailbox/bcm-flexrm-mailbox.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1497,7 +1497,6 @@ static int flexrm_mbox_probe(struct plat
 	int index, ret = 0;
 	void __iomem *regs;
 	void __iomem *regs_end;
-	struct msi_desc *desc;
 	struct resource *iomem;
 	struct flexrm_ring *ring;
 	struct flexrm_mbox *mbox;
@@ -1608,10 +1607,8 @@ static int flexrm_mbox_probe(struct plat
 		goto fail_destroy_cmpl_pool;
 
 	/* Save alloced IRQ numbers for each ring */
-	for_each_msi_entry(desc, dev) {
-		ring = &mbox->rings[desc->msi_index];
-		ring->irq = desc->irq;
-	}
+	for (index = 0; index < mbox->num_rings; index++)
+		mbox->rings[index].irq = msi_get_virq(dev, index);
 
 	/* Check availability of debugfs */
 	if (!debugfs_initialized())

