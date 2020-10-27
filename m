Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90B329CBA0
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 22:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898307AbgJ0V45 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 17:56:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:6431 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374677AbgJ0V44 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Oct 2020 17:56:56 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CLQXV0Kxmz6yLQ;
        Wed, 28 Oct 2020 05:56:58 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.153) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 05:56:47 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v2 07/10] dmaengine: hisi_dma: remove redundant irqsave and irqrestore in hardIRQ
Date:   Wed, 28 Oct 2020 10:52:49 +1300
Message-ID: <20201027215252.25820-8-song.bao.hua@hisilicon.com>
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

Acked-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/dma/hisi_dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index e1a958ae7925..a259ee010e9b 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -431,9 +431,8 @@ static irqreturn_t hisi_dma_irq(int irq, void *data)
 	struct hisi_dma_dev *hdma_dev = chan->hdma_dev;
 	struct hisi_dma_desc *desc;
 	struct hisi_dma_cqe *cqe;
-	unsigned long flags;
 
-	spin_lock_irqsave(&chan->vc.lock, flags);
+	spin_lock(&chan->vc.lock);
 
 	desc = chan->desc;
 	cqe = chan->cq + chan->cq_head;
@@ -452,7 +451,7 @@ static irqreturn_t hisi_dma_irq(int irq, void *data)
 		chan->desc = NULL;
 	}
 
-	spin_unlock_irqrestore(&chan->vc.lock, flags);
+	spin_unlock(&chan->vc.lock);
 
 	return IRQ_HANDLED;
 }
-- 
2.25.1

