Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BC170ADE4
	for <lists+dmaengine@lfdr.de>; Sun, 21 May 2023 13:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjEULs2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 May 2023 07:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjEUK1S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 May 2023 06:27:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E80C10E2;
        Sun, 21 May 2023 03:23:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6F3C60C94;
        Sun, 21 May 2023 10:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C825C433D2;
        Sun, 21 May 2023 10:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684664608;
        bh=xLmFwERNLFGS44YuN2v3vab89SlNXlrWfcwD+NSS4sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PINJX4DODMB4CoA3wTX1FBA+zyOp+XmO+q/mnBCmSPeov7yP4TZ3nxL6xkr/RDTPi
         E6UVndyBT3h1d7vXfHTNuAvNKgPeOvNLdZ04FAC+sgCkHTTjvmHaNCnokQztF1f5bP
         rlapEI4CHl1x1OJFDijLkGTR9+w1QAmcEN+iH3ACxjQk3AIeiI5Js/5W8Z7G6q/An1
         Na6p98Uo6JFslD9QhscTGwocbd7yC9dwjyvQ4ySvmkQSRu+OKnn1q74g4EM5CQcfUb
         LTeVoalXU3XlWBjphsWOWcIgORzPCMcemewKU65GF/nKBPwuJc9E4R+PVWZyTNX3Da
         E00rb9AO2hw3g==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/11] dmaengine: dw-axi-dmac: remove unnecessary devm_free_irq() calling
Date:   Sun, 21 May 2023 18:12:07 +0800
Message-Id: <20230521101216.4084-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230521101216.4084-1-jszhang@kernel.org>
References: <20230521101216.4084-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In dw_remove(), We have disabled the irq from the dw-axi-dma side, so
we are safe against the case "The irq is still ON when devices remove
is executed and irq should be quiesced before remove is completed."

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 203be13499e3..a19b651ddaad 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1563,8 +1563,6 @@ static int dw_remove(struct platform_device *pdev)
 	pm_runtime_disable(chip->dev);
 	axi_dma_suspend(chip);
 
-	devm_free_irq(chip->dev, chip->irq, chip);
-
 	of_dma_controller_free(chip->dev->of_node);
 
 	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
-- 
2.40.0

