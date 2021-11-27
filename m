Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E794D45F9E6
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346544AbhK0B2y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:28:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35802 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhK0B0p (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:26:45 -0500
Message-ID: <20211126230525.942768779@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=p/qcF7fn4OxVhWuReK+wMgikFJMOqHr6o9RPZFmkX94=;
        b=itabOq2/goNmVeWHFB5h7LUlNokKCJwhxIqr2TNaqXG3rE+msDvgxF3R8d+lDMQdpFLFMB
        2rvVZrnGq081hsY5QdIU8qQUR+To3tHna4hN0zbgKDRe26TS0apCiD1wKBPybv2NLvQ1a/
        jA0wq+xDF/7BTVvOy7SzFYqYzOVwwz4O59fL4fmQfvywkIdw6RdHxwDugA0I2P+ohTzCH/
        DszOAxkAAjMZ/U0A9nyPD2gEp8K6D3Z+7NgnuGuS9kvWeuiUZua5kcgjgMzJuSNbAQEkTu
        B1FubAjMmOJK1BcNvleDd2vf7jIIYRBftQir9TNTQwPabnrpSIpj7WCZOws6wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=p/qcF7fn4OxVhWuReK+wMgikFJMOqHr6o9RPZFmkX94=;
        b=p5ubsedSnSr6AcduksWDB4MJEZscofhI5yEISG/LcUOqL4vr2FI2SDc+JOX/1dXjavNAQK
        l3vnrVRpfKqxIqCA==
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
Subject: [patch 34/37] mailbox: bcm-flexrm-mailbox: Rework MSI interrupt handling
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:21:01 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

No point in retrieving the MSI descriptors. Just query the Linux interrupt
number.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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

