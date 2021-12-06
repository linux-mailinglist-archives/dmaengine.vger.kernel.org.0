Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07E946ACC1
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 23:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359151AbhLFWoM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 17:44:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47512 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359095AbhLFWnU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 17:43:20 -0500
Message-ID: <20211206210439.455293905@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638830389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=D2KO9NgXNtQUAyqtWOzZiACp/P45gmD0I5rs+jvB/0o=;
        b=M3Bm84hHvCtrBNwRLdnOJQ8LhTnimeLoUzb7sFPpUvA1MrTtFmPG7jJY3ez6nb6d75oHYZ
        YItW1zlXrieNeQLVv1mja5y6Nsn7Af4+zqcIRigzRA4z6xxKseElSF8My8ONtxtDcbBMxB
        RU2wu+cjJc5BODY4ZEABMlFzsdpRqvn+y6tmMTQMln8ybzz0/Jyujbt0wVvxd67z54pWat
        P6701ltig/ZapqMzfQrWZq5bDgERLGtqI56xSaxFnAfkS9KMlbEOolAF+wr1giyaioGNXC
        q25gnAKxhbPlgLV44h2qmIWZqF0AC+M+K6BlmaYeIgQ0aE/P4MbJxUspA9jGVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638830389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=D2KO9NgXNtQUAyqtWOzZiACp/P45gmD0I5rs+jvB/0o=;
        b=dlz4lZgPNqH4tCZ8r0aZLbuaEV9G+vYCQYuS+28ui/Lf3zD0ZPPTaUWTBAlVcJyi4e33Dj
        inujCGHbNZwGyeCg==
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
Subject: [patch V2 33/36] mailbox: bcm-flexrm-mailbox: Rework MSI interrupt handling
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:39:49 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

No point in retrieving the MSI descriptors. Just query the Linux interrupt
number.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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

