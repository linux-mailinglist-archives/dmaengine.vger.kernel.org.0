Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1FE29CB9C
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 22:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374668AbgJ0V4q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 17:56:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5580 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374669AbgJ0V4p (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Oct 2020 17:56:45 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CLQXH4MHdzhc2G;
        Wed, 28 Oct 2020 05:56:47 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.153) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 05:56:35 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v2 01/10] dmaengine: ipu_idmac: remove redundant irqsave and restore in hardIRQ
Date:   Wed, 28 Oct 2020 10:52:43 +1300
Message-ID: <20201027215252.25820-2-song.bao.hua@hisilicon.com>
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

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/dma/ipu/ipu_idmac.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index 38036db284cb..104ad420abbe 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -1160,14 +1160,13 @@ static irqreturn_t idmac_interrupt(int irq, void *dev_id)
 	struct idmac_tx_desc *desc, *descnew;
 	bool done = false;
 	u32 ready0, ready1, curbuf, err;
-	unsigned long flags;
 	struct dmaengine_desc_callback cb;
 
 	/* IDMAC has cleared the respective BUFx_RDY bit, we manage the buffer */
 
 	dev_dbg(dev, "IDMAC irq %d, buf %d\n", irq, ichan->active_buffer);
 
-	spin_lock_irqsave(&ipu_data.lock, flags);
+	spin_lock(&ipu_data.lock);
 
 	ready0	= idmac_read_ipureg(&ipu_data, IPU_CHA_BUF0_RDY);
 	ready1	= idmac_read_ipureg(&ipu_data, IPU_CHA_BUF1_RDY);
@@ -1176,7 +1175,7 @@ static irqreturn_t idmac_interrupt(int irq, void *dev_id)
 
 	if (err & (1 << chan_id)) {
 		idmac_write_ipureg(&ipu_data, 1 << chan_id, IPU_INT_STAT_4);
-		spin_unlock_irqrestore(&ipu_data.lock, flags);
+		spin_unlock(&ipu_data.lock);
 		/*
 		 * Doing this
 		 * ichan->sg[0] = ichan->sg[1] = NULL;
@@ -1188,7 +1187,7 @@ static irqreturn_t idmac_interrupt(int irq, void *dev_id)
 			 chan_id, ready0, ready1, curbuf);
 		return IRQ_HANDLED;
 	}
-	spin_unlock_irqrestore(&ipu_data.lock, flags);
+	spin_unlock(&ipu_data.lock);
 
 	/* Other interrupts do not interfere with this channel */
 	spin_lock(&ichan->lock);
@@ -1251,9 +1250,9 @@ static irqreturn_t idmac_interrupt(int irq, void *dev_id)
 		if (unlikely(sgnew)) {
 			ipu_submit_buffer(ichan, descnew, sgnew, !ichan->active_buffer);
 		} else {
-			spin_lock_irqsave(&ipu_data.lock, flags);
+			spin_lock(&ipu_data.lock);
 			ipu_ic_disable_task(&ipu_data, chan_id);
-			spin_unlock_irqrestore(&ipu_data.lock, flags);
+			spin_unlock(&ipu_data.lock);
 			ichan->status = IPU_CHANNEL_READY;
 			/* Continue to check for complete descriptor */
 		}
-- 
2.25.1

