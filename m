Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F0A6B7F31
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjCMRRf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjCMRRX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:17:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C56E5D44F;
        Mon, 13 Mar 2023 10:16:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DABE6134E;
        Mon, 13 Mar 2023 17:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7667C4339C;
        Mon, 13 Mar 2023 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678727735;
        bh=18h7yJ4dungwOKffwnbsdGXL7tiydULOEDbCcZ66iBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OynKBULDCoI/qcQGwd4Pr1fRMeE9xZRbwZyH/ENX9IxzsA5qb6ew9/0hl/W8SkZsa
         kPUXJz/V21M9lpDz9ycnnp8FdcNLsMBN1ECYYu6Ngpua00Kk5MEp8k+avfYhE3UuTj
         2rtzJtf/mlB05WgEK1xQ2mZWWo0Hc2PZmvI12Zhe8qo4kiy5SW9EB897FJOZEoGVz+
         xmqehOH+JGNeKNP/qys0RiJEupqI2F03msT/1a3Grl0aAFBHpTVEbjfleoZnjNrVoW
         zetoHu7WbstMVeEugIWb6Q77eIZFueshv1mq3AXD9T8pNmQj64tuv3mqHbDmbiixzc
         mAPVz3m2rcChg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] dmaengine: dw-axi-dmac: remove unnecessary devm_free_irq() calling
Date:   Tue, 14 Mar 2023 01:04:41 +0800
Message-Id: <20230313170450.897-3-jszhang@kernel.org>
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

In dw_remove(), We have disabled the irq from the dw-axi-dma side, so
we are safe against the case "The irq is still ON when devices remove
is executed and irq should be quiesced before remove is completed."

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 23a10dbdecb7..56f12dfa410d 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1542,8 +1542,6 @@ static int dw_remove(struct platform_device *pdev)
 	pm_runtime_disable(chip->dev);
 	axi_dma_suspend(chip);
 
-	devm_free_irq(chip->dev, chip->irq, chip);
-
 	of_dma_controller_free(chip->dev->of_node);
 
 	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
-- 
2.39.2

