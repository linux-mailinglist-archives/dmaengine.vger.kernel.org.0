Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6131929CB9E
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 22:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374674AbgJ0V4v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 17:56:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6178 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374670AbgJ0V4v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Oct 2020 17:56:51 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CLQXN3smCz15MPy;
        Wed, 28 Oct 2020 05:56:52 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.153) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 05:56:39 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        Green Wan <green.wan@sifive.com>
Subject: [PATCH v2 03/10] dmaengine: sf-pdma: remove redundant irqsave and irqrestore in hardIRQ
Date:   Wed, 28 Oct 2020 10:52:45 +1300
Message-ID: <20201027215252.25820-4-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20201027215252.25820-1-song.bao.hua@hisilicon.com>
References: <20201027215252.25820-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.153]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Running in hardIRQ, disabling IRQ is redundant since hardIRQ has disabled
IRQ. This patch removes the irqsave and irqstore to save some instruction
cycles.

Cc: Green Wan <green.wan@sifive.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 528deb5d9f31..981ddcc42d70 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -326,10 +326,9 @@ static irqreturn_t sf_pdma_done_isr(int irq, void *dev_id)
 {
 	struct sf_pdma_chan *chan = dev_id;
 	struct pdma_regs *regs = &chan->regs;
-	unsigned long flags;
 	u64 residue;
 
-	spin_lock_irqsave(&chan->vchan.lock, flags);
+	spin_lock(&chan->vchan.lock);
 	writel((readl(regs->ctrl)) & ~PDMA_DONE_STATUS_MASK, regs->ctrl);
 	residue = readq(regs->residue);
 
@@ -346,7 +345,7 @@ static irqreturn_t sf_pdma_done_isr(int irq, void *dev_id)
 		sf_pdma_xfer_desc(chan);
 	}
 
-	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+	spin_unlock(&chan->vchan.lock);
 
 	return IRQ_HANDLED;
 }
@@ -355,11 +354,10 @@ static irqreturn_t sf_pdma_err_isr(int irq, void *dev_id)
 {
 	struct sf_pdma_chan *chan = dev_id;
 	struct pdma_regs *regs = &chan->regs;
-	unsigned long flags;
 
-	spin_lock_irqsave(&chan->lock, flags);
+	spin_lock(&chan->lock);
 	writel((readl(regs->ctrl)) & ~PDMA_ERR_STATUS_MASK, regs->ctrl);
-	spin_unlock_irqrestore(&chan->lock, flags);
+	spin_unlock(&chan->lock);
 
 	tasklet_schedule(&chan->err_tasklet);
 
-- 
2.25.1

