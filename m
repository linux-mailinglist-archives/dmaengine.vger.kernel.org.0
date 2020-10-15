Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96CB28FBDA
	for <lists+dmaengine@lfdr.de>; Fri, 16 Oct 2020 02:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgJPADH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Oct 2020 20:03:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727930AbgJPADG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Oct 2020 20:03:06 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4E7C52D898FC0DEC8AA8;
        Fri, 16 Oct 2020 08:03:05 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.187) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 16 Oct 2020 08:02:56 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH 05/10] dmaengine: milbeaut-xdmac: remove redundant irqsave and irqrestore in hardIRQ
Date:   Fri, 16 Oct 2020 12:59:16 +1300
Message-ID: <20201015235921.21224-6-song.bao.hua@hisilicon.com>
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

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/dma/milbeaut-xdmac.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/milbeaut-xdmac.c b/drivers/dma/milbeaut-xdmac.c
index 85a597228fb0..584c931e807a 100644
--- a/drivers/dma/milbeaut-xdmac.c
+++ b/drivers/dma/milbeaut-xdmac.c
@@ -160,10 +160,9 @@ static irqreturn_t milbeaut_xdmac_interrupt(int irq, void *dev_id)
 {
 	struct milbeaut_xdmac_chan *mc = dev_id;
 	struct milbeaut_xdmac_desc *md;
-	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&mc->vc.lock, flags);
+	spin_lock(&mc->vc.lock);
 
 	/* Ack and Stop */
 	val = FIELD_PREP(M10V_XDDSD_IS_MASK, 0x0);
@@ -177,7 +176,7 @@ static irqreturn_t milbeaut_xdmac_interrupt(int irq, void *dev_id)
 
 	milbeaut_xdmac_start(mc);
 out:
-	spin_unlock_irqrestore(&mc->vc.lock, flags);
+	spin_unlock(&mc->vc.lock);
 	return IRQ_HANDLED;
 }
 
-- 
2.25.1

