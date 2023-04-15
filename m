Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654F96E30D4
	for <lists+dmaengine@lfdr.de>; Sat, 15 Apr 2023 12:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjDOKsD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 15 Apr 2023 06:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjDOKsD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 15 Apr 2023 06:48:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3148AF14;
        Sat, 15 Apr 2023 03:47:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97FC061376;
        Sat, 15 Apr 2023 10:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E07C433D2;
        Sat, 15 Apr 2023 10:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681555618;
        bh=R7SwTXxq4n6vsL5nvON8lNyUl7g6u9nqIP9ZCvDXMeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vm4+HXJ58/UX9/57jm4JxlWyQwuSKMa6I9jcjkcvoJQ9StIJw1dF21zYloiplq+Gb
         q+b9IDyjPBO8JigcByB7O8kLMQK9LUs9nOKtRi8yWpgiz9wJpsFpGUNhVKmtzkIEyi
         40KVCO+BcwfgBT2fRRppdMIWLkBn6g2daqrvf/KGFTD3GSEclUhn4yUlMgcu4XWHdW
         M0mgpiM9IE9ILsV3oFylUOIR047zMb0a/jPCnd1WVeMe+GiO0Ty138VsE9p9hfgE7K
         h76r1vc8OjMGa6ExoOuoa/h6Yn61PETb0hlCYynTOUOyHjD1Jj0nOAA/IGxtVg9ThM
         3kul41SlS7/sQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/11] dmaengine: dw-axi-dmac: fix reading register when runtime suspended
Date:   Sat, 15 Apr 2023 18:35:51 +0800
Message-Id: <20230415103601.2979-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230415103601.2979-1-jszhang@kernel.org>
References: <20230415103601.2979-1-jszhang@kernel.org>
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
axi_chan_is_hw_enable(), otherwise we may see cpu aborts when
accessing registers in axi_chan_is_hw_enable().

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

