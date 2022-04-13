Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C16B4FED05
	for <lists+dmaengine@lfdr.de>; Wed, 13 Apr 2022 04:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiDMCiO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 22:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiDMCiL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 22:38:11 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D33036B53;
        Tue, 12 Apr 2022 19:35:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V9xY8iS_1649817284;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V9xY8iS_1649817284)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Apr 2022 10:35:49 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     gustavo.pimentel@synopsys.com
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] dmaengine: dw-edma: Fix inconsistent indenting
Date:   Wed, 13 Apr 2022 10:34:42 +0800
Message-Id: <20220413023442.18856-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Eliminate the follow smatch warning:

drivers/dma/dw-edma/dw-edma-v0-core.c:419 dw_edma_v0_core_start() warn:
inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index b5b8f8181e77..33bc1e6c4cf2 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -414,17 +414,18 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
 		/* Linked list */
+
 		#ifdef CONFIG_64BIT
-			/* llp is not aligned on 64bit -> keep 32bit accesses */
-			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-				  lower_32_bits(chunk->ll_region.paddr));
-			SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-				  upper_32_bits(chunk->ll_region.paddr));
+		/* llp is not aligned on 64bit -> keep 32bit accesses */
+		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+			  lower_32_bits(chunk->ll_region.paddr));
+		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+			  upper_32_bits(chunk->ll_region.paddr));
 		#else /* CONFIG_64BIT */
-			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-				  lower_32_bits(chunk->ll_region.paddr));
-			SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-				  upper_32_bits(chunk->ll_region.paddr));
+		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+			  lower_32_bits(chunk->ll_region.paddr));
+		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+			  upper_32_bits(chunk->ll_region.paddr));
 		#endif /* CONFIG_64BIT */
 	}
 	/* Doorbell */
-- 
2.20.1.7.g153144c

