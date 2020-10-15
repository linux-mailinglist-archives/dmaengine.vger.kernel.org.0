Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAE028FBE0
	for <lists+dmaengine@lfdr.de>; Fri, 16 Oct 2020 02:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbgJPADR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Oct 2020 20:03:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59416 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733029AbgJPADR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Oct 2020 20:03:17 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 75BA9A75DA9B081B831B;
        Fri, 16 Oct 2020 08:03:15 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.187) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 16 Oct 2020 08:03:05 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     Barry Song <song.bao.hua@hisilicon.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 10/10] dmaengine: pxa_dma: remove redundant irqsave and irqrestore in hardIRQ
Date:   Fri, 16 Oct 2020 12:59:21 +1300
Message-ID: <20201015235921.21224-11-song.bao.hua@hisilicon.com>
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

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
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

