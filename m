Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2AB267942
	for <lists+dmaengine@lfdr.de>; Sat, 12 Sep 2020 11:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgILJnp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 12 Sep 2020 05:43:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11822 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbgILJnp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 12 Sep 2020 05:43:45 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 01879FBF42DAF4F7A8DB;
        Sat, 12 Sep 2020 17:43:43 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.134) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Sat, 12 Sep 2020 17:43:34 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <dmaengine@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] dmaengine: zx: remove redundant irqsave in hardIRQ
Date:   Sat, 12 Sep 2020 21:40:36 +1200
Message-ID: <20200912094036.32112-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.134]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Running in hardIRQ context, disabling IRQ is redundant.

Cc: Jun Nie <jun.nie@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/dma/zx_dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/zx_dma.c b/drivers/dma/zx_dma.c
index 5fe2e8b9a7b8..b057582b2fac 100644
--- a/drivers/dma/zx_dma.c
+++ b/drivers/dma/zx_dma.c
@@ -285,9 +285,7 @@ static irqreturn_t zx_dma_int_handler(int irq, void *dev_id)
 		p = &d->phy[i];
 		c = p->vchan;
 		if (c) {
-			unsigned long flags;
-
-			spin_lock_irqsave(&c->vc.lock, flags);
+			spin_lock(&c->vc.lock);
 			if (c->cyclic) {
 				vchan_cyclic_callback(&p->ds_run->vd);
 			} else {
@@ -295,7 +293,7 @@ static irqreturn_t zx_dma_int_handler(int irq, void *dev_id)
 				p->ds_done = p->ds_run;
 				task = 1;
 			}
-			spin_unlock_irqrestore(&c->vc.lock, flags);
+			spin_unlock(&c->vc.lock);
 			irq_chan |= BIT(i);
 		}
 	}
-- 
2.25.1


