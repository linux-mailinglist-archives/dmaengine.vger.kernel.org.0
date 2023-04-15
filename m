Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586816E30E4
	for <lists+dmaengine@lfdr.de>; Sat, 15 Apr 2023 12:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjDOKsc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 15 Apr 2023 06:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjDOKsZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 15 Apr 2023 06:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF1C5B8F;
        Sat, 15 Apr 2023 03:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B561C61507;
        Sat, 15 Apr 2023 10:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351C0C4339B;
        Sat, 15 Apr 2023 10:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681555622;
        bh=ENZtAgALgDJDO8hev1y4VgaaMjTikYo2GFGPd/DEQvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XAF7qx4JrtcHyhaFEp7ikvdsy6COz8YurVUDZLwMr9GPJEVWEfmV61SBBABqA12KX
         9VKYKynB3OnWebjl7+VW76ZbWbODbjgnAu3aWZuRdPFFDQIHw+7JNmFVkiVqaQI8E0
         hy+3Pbq+57Nh1/BPgd+HALDjDVCNnn4xSZRoq9FlGuCT4tPGMqfIS1rs7/MLX21UxT
         LYII+VVPF+UqjM47vbWg0rNuygNjY+8XtAYrcTVUup2pGqZothVSagljOd23MeG7L2
         vqJ83FVxiUHdKuW3GXNNffkPDuRBwKvz6IeTvDFqvzqInU2sVIM2S/aojD0+o2QuK1
         VuAgz+++LDM6w==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/11] dmaengine: dw-axi-dmac: remove redundant axi_dma_disable() calling
Date:   Sat, 15 Apr 2023 18:35:54 +0800
Message-Id: <20230415103601.2979-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230415103601.2979-1-jszhang@kernel.org>
References: <20230415103601.2979-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 891776528619..410222e7224c 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1535,7 +1535,6 @@ static int dw_remove(struct platform_device *pdev)
 		axi_chan_disable(&chip->dw->chan[i]);
 		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
 	}
-	axi_dma_disable(chip);
 
 	pm_runtime_disable(chip->dev);
 	axi_dma_suspend(chip);
-- 
2.39.2

