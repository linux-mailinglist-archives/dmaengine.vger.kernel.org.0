Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88A628FBDE
	for <lists+dmaengine@lfdr.de>; Fri, 16 Oct 2020 02:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbgJPADN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Oct 2020 20:03:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15300 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731105AbgJPADM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Oct 2020 20:03:12 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6050950E5399108ECDF5;
        Fri, 16 Oct 2020 08:03:10 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.187) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 16 Oct 2020 08:03:03 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     Barry Song <song.bao.hua@hisilicon.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 09/10] dmaengine: ste_dma40: remove redundant irqsave and irqrestore in hardIRQ
Date:   Fri, 16 Oct 2020 12:59:20 +1300
Message-ID: <20201015235921.21224-10-song.bao.hua@hisilicon.com>
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

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/dma/ste_dma40.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 77ab1f4730be..4256e55bbf25 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1643,13 +1643,12 @@ static irqreturn_t d40_handle_interrupt(int irq, void *data)
 	u32 row;
 	long chan = -1;
 	struct d40_chan *d40c;
-	unsigned long flags;
 	struct d40_base *base = data;
 	u32 *regs = base->regs_interrupt;
 	struct d40_interrupt_lookup *il = base->gen_dmac.il;
 	u32 il_size = base->gen_dmac.il_size;
 
-	spin_lock_irqsave(&base->interrupt_lock, flags);
+	spin_lock(&base->interrupt_lock);
 
 	/* Read interrupt status of both logical and physical channels */
 	for (i = 0; i < il_size; i++)
@@ -1694,7 +1693,7 @@ static irqreturn_t d40_handle_interrupt(int irq, void *data)
 		spin_unlock(&d40c->lock);
 	}
 
-	spin_unlock_irqrestore(&base->interrupt_lock, flags);
+	spin_unlock(&base->interrupt_lock);
 
 	return IRQ_HANDLED;
 }
-- 
2.25.1

