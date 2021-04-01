Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB41D3512C7
	for <lists+dmaengine@lfdr.de>; Thu,  1 Apr 2021 11:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhDAJyT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Apr 2021 05:54:19 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:60761 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233383AbhDAJxr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Apr 2021 05:53:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UU4xAIW_1617270818;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UU4xAIW_1617270818)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 01 Apr 2021 17:53:45 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     okaya@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] dmaengine: qcom_hidma: remove unused code
Date:   Thu,  1 Apr 2021 17:53:36 +0800
Message-Id: <1617270816-36400-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix the following clang warning:

drivers/dma/qcom/hidma.c:94:20: warning: unused function 'to_hidma_desc'
[-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/dma/qcom/hidma.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 6c0f9eb..23d6448 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -90,12 +90,6 @@ static inline struct hidma_chan *to_hidma_chan(struct dma_chan *dmach)
 	return container_of(dmach, struct hidma_chan, chan);
 }
 
-static inline
-struct hidma_desc *to_hidma_desc(struct dma_async_tx_descriptor *t)
-{
-	return container_of(t, struct hidma_desc, desc);
-}
-
 static void hidma_free(struct hidma_dev *dmadev)
 {
 	INIT_LIST_HEAD(&dmadev->ddev.channels);
-- 
1.8.3.1

