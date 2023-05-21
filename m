Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CCA70ADDC
	for <lists+dmaengine@lfdr.de>; Sun, 21 May 2023 13:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjEULsW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 May 2023 07:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjEUK1S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 May 2023 06:27:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF7D10E0;
        Sun, 21 May 2023 03:23:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A91BD61237;
        Sun, 21 May 2023 10:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410FFC4339B;
        Sun, 21 May 2023 10:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684664607;
        bh=iRI9Nbek5uu1qAv7VQcDDGQ/jUGkxcfTM3bdHx/73/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T1wnG289rlegA31pfjTwhfCkzkkQREJxin57BHyMKFgwZslrkTJMBDYrqLldVEDJo
         L7IyA0vD/2U8mUe5DWd4rNKp2F3gjfORXPxdh9QwzkoZRcB7Jq83uuQFWsWQ9kMcZk
         gs32NhhV+TjGmeOQI5hw9Dk1Heuk2xK19/roDYZTxzkYkkRUUZ+9pB/zKXZ3zP03ZO
         5Cj4XiIx/k3t+eN+awQoKFEsN8ArRfSfhiH8p3pLcNh6tvP4gIY+RIOE1GQ9NXTl7y
         3UdKktY6e7edqUXCNubD0GU7v3FBf3jrFR/LSNo0T90GLR3mPnrm2foUnTTUnbBgJZ
         kvr+NWaTqea6A==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/11] dmaengine: dw-axi-dmac: fix reading register when runtime suspended
Date:   Sun, 21 May 2023 18:12:06 +0800
Message-Id: <20230521101216.4084-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230521101216.4084-1-jszhang@kernel.org>
References: <20230521101216.4084-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We should runtime resume the device before calling
axi_chan_is_hw_enable(), otherwise we may see cpu aborts when
accessing registers in axi_chan_is_hw_enable().

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 796b6caf0bab..203be13499e3 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -469,13 +469,17 @@ static void dw_axi_dma_synchronize(struct dma_chan *dchan)
 
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
@@ -485,13 +489,16 @@ static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
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
2.40.0

