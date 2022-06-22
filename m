Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB758554D11
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 16:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbiFVOcO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 10:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbiFVOcO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 10:32:14 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3F739BB5;
        Wed, 22 Jun 2022 07:32:10 -0700 (PDT)
X-QQ-mid: bizesmtp62t1655908324tb0lfnn9
Received: from ubuntu.localdomain ( [106.117.78.84])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 22:32:00 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000E00A0000000
X-QQ-FEAT: HoyAXBWgskmNPZB93pOxP5cN3WyfcwcVTE81w7Gelm82zB/F8H07G6L7WAeaR
        CMr9XIqPwLhobY5R53KYOu1uYvaJbI7OoY0Pxvg53cHFnRskfSGT8iPPyGu6YqpBs5oyl11
        X4OF8DM8enTAW/qh4A2VlJjKyN9P+lj8lY4AS2VOoPE/nca08GbPj18se/2d7rKgtBM4nOw
        yhuEF7xeibxRnVUr0Zc2AhbEdpgH5pwc72UZZgzde1bwV3TjkCfPXbmQppvuFLO4nxES1tI
        1Ra7pjxTsDSYqyFRG0cZs+wdqmX1BZwZ1Zqe0ppfObcSKkxO9Y70WdIC/T0uIiAR1uS+wCF
        N2kLzoGvT6Rh7b0Ss2FWzvfgr/FemktZTvJcsQV
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] dmaengine: ep93xx: Fix typo in comments
Date:   Wed, 22 Jun 2022 22:31:58 +0800
Message-Id: <20220622143158.15091-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove the repeated word 'and' from comments

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/dma/ep93xx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 971ff5f9ae84..d19ea885c63e 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -1183,7 +1183,7 @@ ep93xx_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t dma_addr,
  *
  * Synchronizes the DMA channel termination to the current context. When this
  * function returns it is guaranteed that all transfers for previously issued
- * descriptors have stopped and and it is safe to free the memory associated
+ * descriptors have stopped and it is safe to free the memory associated
  * with them. Furthermore it is guaranteed that all complete callback functions
  * for a previously submitted descriptor have finished running and it is safe to
  * free resources accessed from within the complete callbacks.
-- 
2.17.1

