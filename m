Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1887A3BCE
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2019 18:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfH3QTX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Aug 2019 12:19:23 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.93]:27792 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727434AbfH3QTX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Aug 2019 12:19:23 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id F1BD914B99
        for <dmaengine@vger.kernel.org>; Fri, 30 Aug 2019 11:14:25 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 3jXdil38x2qH73jXdihUbt; Fri, 30 Aug 2019 11:14:25 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aGYr2FM4QQtcTWRAHMFf23E34Ywi1aRTuyHCXd6kje0=; b=pAliF8TGvjsDz5WSKpj+xjc670
        wG3SdMnDpV0CMTt6RY56y+kj5QAhp2VlSc66xWk513X6/TkKw8+aHdNS5DlJCWj2wigHMxromxRDb
        iPMa3sVurbFOI1x6bHYrFu01Ip3EMiC/12ms7poxNoi/ph1lIjLU6lXhk48DXileLCfFVsD9pJ4vq
        cfz7hSg96NYDOrSLiAHa4CBH656OaB0m3kdO7QTCtTdurZlwthlR6Lqs+ZfQFij4WWCpJIx0nA2ZY
        4AgSPWtE4OGElW/r2HR+6Kfro853MmI01eRtd1Emp6UirKMojcshO4o8s21IWNAPiR/Gc3CBsE8U+
        0+f630WA==;
Received: from [189.152.216.116] (port=34988 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1i3jXc-000lDa-Le; Fri, 30 Aug 2019 11:14:24 -0500
Date:   Fri, 30 Aug 2019 11:14:23 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] dmaengine: stm32-dma: Use struct_size() helper
Message-ID: <20190830161423.GA3483@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.216.116
X-Source-L: No
X-Exim-ID: 1i3jXc-000lDa-Le
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.216.116]:34988
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct stm32_dma_desc {
	...
        struct stm32_dma_sg_req sg_req[];
};


Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following function:

static struct stm32_dma_desc *stm32_dma_alloc_desc(u32 num_sgs)
{
       return kzalloc(sizeof(struct stm32_dma_desc) +
                      sizeof(struct stm32_dma_sg_req) * num_sgs, GFP_NOWAIT);
}

with:

kzalloc(struct_size(desc, sg_req, num_sgs), GFP_NOWAIT)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/dma/stm32-dma.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index e4cbe38d1b83..5989b0893521 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -243,12 +243,6 @@ static void stm32_dma_write(struct stm32_dma_device *dmadev, u32 reg, u32 val)
 	writel_relaxed(val, dmadev->base + reg);
 }
 
-static struct stm32_dma_desc *stm32_dma_alloc_desc(u32 num_sgs)
-{
-	return kzalloc(sizeof(struct stm32_dma_desc) +
-		       sizeof(struct stm32_dma_sg_req) * num_sgs, GFP_NOWAIT);
-}
-
 static int stm32_dma_get_width(struct stm32_dma_chan *chan,
 			       enum dma_slave_buswidth width)
 {
@@ -853,7 +847,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
 		return NULL;
 	}
 
-	desc = stm32_dma_alloc_desc(sg_len);
+	desc = kzalloc(struct_size(desc, sg_req, sg_len), GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
@@ -954,7 +948,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
 
 	num_periods = buf_len / period_len;
 
-	desc = stm32_dma_alloc_desc(num_periods);
+	desc = kzalloc(struct_size(desc, sg_req, num_periods), GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
@@ -989,7 +983,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
 	int i;
 
 	num_sgs = DIV_ROUND_UP(len, STM32_DMA_ALIGNED_MAX_DATA_ITEMS);
-	desc = stm32_dma_alloc_desc(num_sgs);
+	desc = kzalloc(struct_size(desc, sg_req, num_sgs), GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
-- 
2.23.0

