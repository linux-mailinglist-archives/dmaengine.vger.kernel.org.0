Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B5229CB9F
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 22:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374678AbgJ0V4z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 17:56:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:6429 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374676AbgJ0V4z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Oct 2020 17:56:55 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CLQXV04Rvz6yJc;
        Wed, 28 Oct 2020 05:56:58 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.153) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 05:56:45 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v2 06/10] dmaengine: k3dma: remove redundant irqsave and irqrestore in hardIRQ
Date:   Wed, 28 Oct 2020 10:52:48 +1300
Message-ID: <20201027215252.25820-7-song.bao.hua@hisilicon.com>
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
 drivers/dma/k3dma.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index f609a84c493c..d0b2e601e3e5 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -223,24 +223,23 @@ static irqreturn_t k3_dma_int_handler(int irq, void *dev_id)
 		i = __ffs(stat);
 		stat &= ~BIT(i);
 		if (likely(tc1 & BIT(i)) || (tc2 & BIT(i))) {
-			unsigned long flags;
 
 			p = &d->phy[i];
 			c = p->vchan;
 			if (c && (tc1 & BIT(i))) {
-				spin_lock_irqsave(&c->vc.lock, flags);
+				spin_lock(&c->vc.lock);
 				if (p->ds_run != NULL) {
 					vchan_cookie_complete(&p->ds_run->vd);
 					p->ds_done = p->ds_run;
 					p->ds_run = NULL;
 				}
-				spin_unlock_irqrestore(&c->vc.lock, flags);
+				spin_unlock(&c->vc.lock);
 			}
 			if (c && (tc2 & BIT(i))) {
-				spin_lock_irqsave(&c->vc.lock, flags);
+				spin_lock(&c->vc.lock);
 				if (p->ds_run != NULL)
 					vchan_cyclic_callback(&p->ds_run->vd);
-				spin_unlock_irqrestore(&c->vc.lock, flags);
+				spin_unlock(&c->vc.lock);
 			}
 			irq_chan |= BIT(i);
 		}
-- 
2.25.1

