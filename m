Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DFC53ED2C
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jun 2022 19:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiFFRtV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jun 2022 13:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiFFRtV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Jun 2022 13:49:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D43C6B7D4
        for <dmaengine@vger.kernel.org>; Mon,  6 Jun 2022 10:49:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09F1C61237
        for <dmaengine@vger.kernel.org>; Mon,  6 Jun 2022 17:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D926C385A9;
        Mon,  6 Jun 2022 17:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654537759;
        bh=XESz0V62p2Tw3llJ7XikMWR70E1Nv+baXOSgoK0/eCM=;
        h=From:To:Cc:Subject:Date:From;
        b=PXlc8UILPIdtvukkt94zD8uEEb/LQL+ONY/ceF9BJYT9DKg3ZQZOux4zkuKsSCeNF
         tcmoOxe+3viCwZgGP6TXtBK70fAZB9XiRS1rQcoYS889Xo5ueSx5Uew7rDTJ/5uwT0
         EtdilZoVcjcc8EyRsLmgy7TqhipqXmQ5O+ih2i74Av9as15+0MpO8ohArL8IoJ0X4U
         i4qUFXT+kHcQgUD+IyJV8XgvR7kRO26Aig6Ok5ay6lXcneF+BfL9NezZm9heDXbeO0
         6xRiSk7lnsRiz7UvrU6jle4QYMhQLlAu6eiM5DhAkmvPAlrAcBSkqCf9+Pp3hIeMcR
         vTbrf4nhk+zWA==
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dmaengine: Revert "dmaengine: add verification of DMA_INTERRUPT capability for dmatest"
Date:   Mon,  6 Jun 2022 23:19:06 +0530
Message-Id: <20220606174906.3979283-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This reverts commit a8facc7b9885 ("dmaengine: add verification of
DMA_INTERRUPT capability for dmatest") as it causes regression due to
the fact that DMA_INTERRUPT in linked to dma_prep_interrupt() so
checking that is incorrect here

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dmatest.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 0a2168a4ccb0..f696246f57fd 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -675,16 +675,10 @@ static int dmatest_func(void *data)
 	/*
 	 * src and dst buffers are freed by ourselves below
 	 */
-	if (params->polled) {
+	if (params->polled)
 		flags = DMA_CTRL_ACK;
-	} else {
-		if (dma_has_cap(DMA_INTERRUPT, dev->cap_mask)) {
-			flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
-		} else {
-			pr_err("Channel does not support interrupt!\n");
-			goto err_pq_array;
-		}
-	}
+	else
+		flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
 
 	ktime = ktime_get();
 	while (!(kthread_should_stop() ||
@@ -912,7 +906,6 @@ static int dmatest_func(void *data)
 	runtime = ktime_to_us(ktime);
 
 	ret = 0;
-err_pq_array:
 	kfree(dma_pq);
 err_srcs_array:
 	kfree(srcs);
-- 
2.34.3

