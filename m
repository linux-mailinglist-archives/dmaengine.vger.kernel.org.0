Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA9429CBA3
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 22:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374677AbgJ0V5B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 17:57:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6182 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374679AbgJ0V5B (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Oct 2020 17:57:01 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CLQXZ5BvSz15NHN;
        Wed, 28 Oct 2020 05:57:02 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.153) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 05:56:52 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        "Daniel Mack" <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>
Subject: [PATCH v2 10/10] dmaengine: pxa_dma: remove redundant irqsave and irqrestore in hardIRQ
Date:   Wed, 28 Oct 2020 10:52:52 +1300
Message-ID: <20201027215252.25820-11-song.bao.hua@hisilicon.com>
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

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/dma/pxa_dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 349fb312c872..4a2a796e348c 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -606,7 +606,6 @@ static irqreturn_t pxad_chan_handler(int irq, void *dev_id)
 	struct pxad_chan *chan = phy->vchan;
 	struct virt_dma_desc *vd, *tmp;
 	unsigned int dcsr;
-	unsigned long flags;
 	bool vd_completed;
 	dma_cookie_t last_started = 0;
 
@@ -616,7 +615,7 @@ static irqreturn_t pxad_chan_handler(int irq, void *dev_id)
 	if (dcsr & PXA_DCSR_RUN)
 		return IRQ_NONE;
 
-	spin_lock_irqsave(&chan->vc.lock, flags);
+	spin_lock(&chan->vc.lock);
 	list_for_each_entry_safe(vd, tmp, &chan->vc.desc_issued, node) {
 		vd_completed = is_desc_completed(vd);
 		dev_dbg(&chan->vc.chan.dev->device,
@@ -658,7 +657,7 @@ static irqreturn_t pxad_chan_handler(int irq, void *dev_id)
 			pxad_launch_chan(chan, to_pxad_sw_desc(vd));
 		}
 	}
-	spin_unlock_irqrestore(&chan->vc.lock, flags);
+	spin_unlock(&chan->vc.lock);
 	wake_up(&chan->wq_state);
 
 	return IRQ_HANDLED;
-- 
2.25.1

