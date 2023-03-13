Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDB76B7F25
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjCMRRD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjCMRQz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:16:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9F977E15;
        Mon, 13 Mar 2023 10:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8DC66141D;
        Mon, 13 Mar 2023 17:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AFBC4339B;
        Mon, 13 Mar 2023 17:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678727734;
        bh=IhJqKy/lFwInJmGYo3Tizjdc1Cg9RTkiCKAvvE/5axU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ma+bhWtuu+yLhewspm0qg1DsqcCvLp67qc/WgVu6MYKqlr5ZC3LT492zAnTEtkEn0
         1WHAR73D78JEQpigWF2DcPdyFYeU9DOh+MmKqedagiobLZm8Yeykq+KDx26uALyxrQ
         6r3AEht3hmXZ7qfyZZGfVsSCbsfLdjp6hPu1ZAUJ0AzEwLGpKrWzh2+yT679FkhQh3
         BUxLuREbHdp3oJ7+gTbyhdqg0NW3Nq7DRxCvtkehJdgoxSmIYNqKbFhL/MmTxNcu3W
         H3xMcSHTS/hdZsrkKKNpPQLpx7TiNLManem5jNf7jWX8gJfCAp/TOJGVa6Gx5QkOH9
         +xHR5vlK/viNQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] dmaengine: dw-axi-dmac: fix reading register hen runtime suspended
Date:   Tue, 14 Mar 2023 01:04:40 +0800
Message-Id: <20230313170450.897-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313170450.897-1-jszhang@kernel.org>
References: <20230313170450.897-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We should runtime resume the device before calling
axi_chan_is_hw_enable().

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 7f3a60e28e38..23a10dbdecb7 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -462,13 +462,17 @@ static void dw_axi_dma_synchronize(struct dma_chan *dchan)
 
 static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
 {
+	int ret;
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 
+	pm_runtime_get(chan->chip->dev);
+
 	/* ASSERT: channel is idle */
 	if (axi_chan_is_hw_enable(chan)) {
 		dev_err(chan2dev(chan), "%s is non-idle!\n",
 			axi_chan_name(chan));
-		return -EBUSY;
+		ret = -EBUSY;
+		goto err_busy;
 	}
 
 	/* LLI address must be aligned to a 64-byte boundary */
@@ -478,13 +482,16 @@ static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
 					  64, 0);
 	if (!chan->desc_pool) {
 		dev_err(chan2dev(chan), "No memory for descriptors\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_busy;
 	}
 	dev_vdbg(dchan2dev(dchan), "%s: allocating\n", axi_chan_name(chan));
 
-	pm_runtime_get(chan->chip->dev);
-
 	return 0;
+
+err_busy:
+	pm_runtime_put(chan->chip->dev);
+	return ret;
 }
 
 static void dma_chan_free_chan_resources(struct dma_chan *dchan)
-- 
2.39.2

