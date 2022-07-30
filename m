Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A0E585BF8
	for <lists+dmaengine@lfdr.de>; Sat, 30 Jul 2022 22:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbiG3UHy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 30 Jul 2022 16:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiG3UHx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 30 Jul 2022 16:07:53 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D4315707
        for <dmaengine@vger.kernel.org>; Sat, 30 Jul 2022 13:07:51 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id HskUod8n5AeI9HskUoZ6S9; Sat, 30 Jul 2022 22:07:49 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 30 Jul 2022 22:07:49 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dmaengine: stm32-dmamux: Simplify code and save a few bytes of memory
Date:   Sat, 30 Jul 2022 22:07:45 +0200
Message-Id: <2d8c24359b2daa32ce0597a2949b7b2bebaf23de.1659211633.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

STM32_DMAMUX_MAX_DMA_REQUESTS is small (i.e. 32) and when the 'dma_inuse'
bitmap is allocated, there is already a check that 'dma_req' is <= this
limit.

So, there is no good reason to dynamically allocate this bitmap. This
just waste some memory and some cycles.

Use DECLARE_BITMAP with the maximum bitmap size instead.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/stm32-dmamux.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index eee0c5aa5fb5..212c332f14f9 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -39,7 +39,7 @@ struct stm32_dmamux_data {
 	u32 dma_requests; /* Number of DMA requests connected to DMAMUX */
 	u32 dmamux_requests; /* Number of DMA requests routed toward DMAs */
 	spinlock_t lock; /* Protects register access */
-	unsigned long *dma_inuse; /* Used DMA channel */
+	DECLARE_BITMAP(dma_inuse, STM32_DMAMUX_MAX_DMA_REQUESTS); /* Used DMA channel */
 	u32 ccr[STM32_DMAMUX_MAX_DMA_REQUESTS]; /* Used to backup CCR register
 						 * in suspend
 						 */
@@ -229,12 +229,6 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 
 	stm32_dmamux->dma_requests = dma_req;
 	stm32_dmamux->dma_reqs[0] = count;
-	stm32_dmamux->dma_inuse = devm_kcalloc(&pdev->dev,
-					       BITS_TO_LONGS(dma_req),
-					       sizeof(unsigned long),
-					       GFP_KERNEL);
-	if (!stm32_dmamux->dma_inuse)
-		return -ENOMEM;
 
 	if (device_property_read_u32(&pdev->dev, "dma-requests",
 				     &stm32_dmamux->dmamux_requests)) {
-- 
2.34.1

