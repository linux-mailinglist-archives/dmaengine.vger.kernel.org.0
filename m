Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0C429CBA4
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 22:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374670AbgJ0V5B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 17:57:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6181 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374677AbgJ0V5B (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Oct 2020 17:57:01 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CLQXZ54CMz15NHJ;
        Wed, 28 Oct 2020 05:57:02 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.153) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 05:56:50 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        "Linus Walleij" <linus.walleij@linaro.org>
Subject: [PATCH v2 09/10] dmaengine: ste_dma40: remove redundant irqsave and irqrestore in hardIRQ
Date:   Wed, 28 Oct 2020 10:52:51 +1300
Message-ID: <20201027215252.25820-10-song.bao.hua@hisilicon.com>
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

