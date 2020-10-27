Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7AC29CB9D
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 22:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374675AbgJ0V4v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 17:56:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6179 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374674AbgJ0V4v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Oct 2020 17:56:51 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CLQXN41HCz15NHG;
        Wed, 28 Oct 2020 05:56:52 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.153) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 05:56:41 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        "Laxman Dewangan" <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 04/10] dmaengine: tegra210-adma: remove redundant irqsave and irqrestore in hardIRQ
Date:   Wed, 28 Oct 2020 10:52:46 +1300
Message-ID: <20201027215252.25820-5-song.bao.hua@hisilicon.com>
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

Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/dma/tegra210-adma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index c5fa2ef74abc..4735742e826d 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -408,19 +408,18 @@ static irqreturn_t tegra_adma_isr(int irq, void *dev_id)
 {
 	struct tegra_adma_chan *tdc = dev_id;
 	unsigned long status;
-	unsigned long flags;
 
-	spin_lock_irqsave(&tdc->vc.lock, flags);
+	spin_lock(&tdc->vc.lock);
 
 	status = tegra_adma_irq_clear(tdc);
 	if (status == 0 || !tdc->desc) {
-		spin_unlock_irqrestore(&tdc->vc.lock, flags);
+		spin_unlock(&tdc->vc.lock);
 		return IRQ_NONE;
 	}
 
 	vchan_cyclic_callback(&tdc->desc->vd);
 
-	spin_unlock_irqrestore(&tdc->vc.lock, flags);
+	spin_unlock(&tdc->vc.lock);
 
 	return IRQ_HANDLED;
 }
-- 
2.25.1

