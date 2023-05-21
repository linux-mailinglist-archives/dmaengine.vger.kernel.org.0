Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4787470ADE0
	for <lists+dmaengine@lfdr.de>; Sun, 21 May 2023 13:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjEULsX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 May 2023 07:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjEUK1w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 May 2023 06:27:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75B810E4;
        Sun, 21 May 2023 03:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C9F360E05;
        Sun, 21 May 2023 10:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01046C433D2;
        Sun, 21 May 2023 10:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684664610;
        bh=mJ5yS9oI4b3i7UhOvVPGcZz88NvjaTzXIsaTK0vbsRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJbg/qlKueDxxcK7o7KMD+7lkG+dw3yGQVp3s/fUr7dngLT8jEbqbe3smC5PAioeS
         YWERFWjBpl3cvQHKJ5G8jjwOZWMGx8WQrjovmylKiQ7dQqzX0KS5btxTJTtYaB6A12
         vBa3i25d1tSBD4TzIFOdzO19vN9c+yzjDGd4Ny8X8Od08hEDwJCjAYE7AW6Ld2QE8w
         xG8501nXb0L9kIlalaufG0ywHwtEID+ngGLVUh0tv524eXTjNV3cBKzrxRTqY5xvIT
         ep10J2F4/SPlyOvrP7bdVbHWEQzsZbEDHT6ILLB5+g6X4cg437Qov98+SCJ+/P7ffG
         Ma3SaL75VSZZw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/11] dmaengine: dw-axi-dmac: remove redundant axi_dma_disable() calling
Date:   Sun, 21 May 2023 18:12:09 +0800
Message-Id: <20230521101216.4084-5-jszhang@kernel.org>
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

axi_dma_suspend() will soon call axi_dma_disable(), remove the redundant
axi_dma_disable() callin.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 4378134eea63..e596910e9f84 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1556,7 +1556,6 @@ static int dw_remove(struct platform_device *pdev)
 		axi_chan_disable(&chip->dw->chan[i]);
 		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
 	}
-	axi_dma_disable(chip);
 
 	pm_runtime_disable(chip->dev);
 	axi_dma_suspend(chip);
-- 
2.40.0

