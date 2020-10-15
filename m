Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F175328FBD6
	for <lists+dmaengine@lfdr.de>; Fri, 16 Oct 2020 02:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgJPADB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Oct 2020 20:03:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15223 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727314AbgJPADB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Oct 2020 20:03:01 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6C76B2582D994F87772B;
        Fri, 16 Oct 2020 08:03:00 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.187) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 16 Oct 2020 08:02:51 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     Barry Song <song.bao.hua@hisilicon.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 02/10] dmaengine: k3-udma: remove redundant irqsave and irqrestore in hardIRQ
Date:   Fri, 16 Oct 2020 12:59:13 +1300
Message-ID: <20201015235921.21224-3-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20201015235921.21224-1-song.bao.hua@hisilicon.com>
References: <20201015235921.21224-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.187]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Running in hardIRQ, disabling IRQ is redundant.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/dma/ti/k3-udma.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 82cf6c77f5c9..e508280b3d70 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1020,13 +1020,12 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
 {
 	struct udma_chan *uc = data;
 	struct udma_desc *d;
-	unsigned long flags;
 	dma_addr_t paddr = 0;
 
 	if (udma_pop_from_ring(uc, &paddr) || !paddr)
 		return IRQ_HANDLED;
 
-	spin_lock_irqsave(&uc->vc.lock, flags);
+	spin_lock(&uc->vc.lock);
 
 	/* Teardown completion message */
 	if (cppi5_desc_is_tdcm(paddr)) {
@@ -1077,7 +1076,7 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
 		}
 	}
 out:
-	spin_unlock_irqrestore(&uc->vc.lock, flags);
+	spin_unlock(&uc->vc.lock);
 
 	return IRQ_HANDLED;
 }
@@ -1086,9 +1085,8 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
 {
 	struct udma_chan *uc = data;
 	struct udma_desc *d;
-	unsigned long flags;
 
-	spin_lock_irqsave(&uc->vc.lock, flags);
+	spin_lock(&uc->vc.lock);
 	d = uc->desc;
 	if (d) {
 		d->tr_idx = (d->tr_idx + 1) % d->sglen;
@@ -1103,7 +1101,7 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
 		}
 	}
 
-	spin_unlock_irqrestore(&uc->vc.lock, flags);
+	spin_unlock(&uc->vc.lock);
 
 	return IRQ_HANDLED;
 }
-- 
2.25.1

