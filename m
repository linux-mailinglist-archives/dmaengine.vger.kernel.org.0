Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CEC29CBA2
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 22:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374680AbgJ0V5A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 17:57:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6180 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374670AbgJ0V5A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Oct 2020 17:57:00 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CLQXZ4wnHz15NHD;
        Wed, 28 Oct 2020 05:57:02 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.153) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 05:56:48 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v2 08/10] dmaengine: moxart-dma: remove redundant irqsave and irqrestore in hardIRQ
Date:   Wed, 28 Oct 2020 10:52:50 +1300
Message-ID: <20201027215252.25820-9-song.bao.hua@hisilicon.com>
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
 drivers/dma/moxart-dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index 347146a6e1d0..74755093e14b 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -524,7 +524,6 @@ static irqreturn_t moxart_dma_interrupt(int irq, void *devid)
 	struct moxart_dmadev *mc = devid;
 	struct moxart_chan *ch = &mc->slave_chans[0];
 	unsigned int i;
-	unsigned long flags;
 	u32 ctrl;
 
 	dev_dbg(chan2dev(&ch->vc.chan), "%s\n", __func__);
@@ -541,14 +540,14 @@ static irqreturn_t moxart_dma_interrupt(int irq, void *devid)
 		if (ctrl & APB_DMA_FIN_INT_STS) {
 			ctrl &= ~APB_DMA_FIN_INT_STS;
 			if (ch->desc) {
-				spin_lock_irqsave(&ch->vc.lock, flags);
+				spin_lock(&ch->vc.lock);
 				if (++ch->sgidx < ch->desc->sglen) {
 					moxart_dma_start_sg(ch, ch->sgidx);
 				} else {
 					vchan_cookie_complete(&ch->desc->vd);
 					moxart_dma_start_desc(&ch->vc.chan);
 				}
-				spin_unlock_irqrestore(&ch->vc.lock, flags);
+				spin_unlock(&ch->vc.lock);
 			}
 		}
 
-- 
2.25.1

