Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3383F6B7F44
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCMRSL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjCMRSA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:18:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14FC81CE4;
        Mon, 13 Mar 2023 10:17:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 319AE6142F;
        Mon, 13 Mar 2023 17:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91440C433EF;
        Mon, 13 Mar 2023 17:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678727744;
        bh=LTJK1Q5mjYuDFo6XOCu0Yts3P4bL4yj+TgvZBGYtFVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=juz5mfjIHepuK/C9slExugzY1AT/hTly2K0djTFKQtMPZLNdsnTYzJnhImV3McZFf
         gP7768wE2sjelp9jgF6+BqLpQNziHenoA8Dqz++Bm+kYY8mlQFwJ1XwFgo706aqARH
         gJFidpFNx2JfKW2xGQN3mMdTAVlesx4ziduuwSKQYkFCXSOzyb2FVwtWxz6HIuHWRy
         XtqtVvZp+46HjJkDoHwwFlckYrF6ozr1KNRcSR1fkFMpK2UHnbsLinHqPnadrBuw7T
         IqYcX1S35y1wm/hwPjtcFt3/cBzq/DN6P3EufNXDfo5fs6APztcnbczjE5JzhP3y3R
         +JCWfbkyOWZEA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] dmaengine: dw-axi-dmac: support dma-channel-mask
Date:   Tue, 14 Mar 2023 01:04:47 +0800
Message-Id: <20230313170450.897-9-jszhang@kernel.org>
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

Some dma channels may not be available, so we need to tell the driver
the available dma channels, use the general dt binding
"dma-channel-mask" for this purpose.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 19 +++++++++++++++++++
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index edb1c089a8eb..a6e46cb66000 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -216,6 +216,8 @@ static void axi_dma_hw_init(struct axi_dma_chip *chip)
 	u32 i;
 
 	for (i = 0; i < chip->dw->hdata->nr_channels; i++) {
+		if (!(chip->dw->hdata->channels_mask & (1 << i)))
+			continue;
 		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
 		axi_chan_disable(&chip->dw->chan[i]);
 	}
@@ -1390,6 +1392,14 @@ static int parse_device_properties(struct axi_dma_chip *chip)
 		chip->dw->hdata->axi_rw_burst_len = tmp;
 	}
 
+	/*
+	 * Use all channels if there's no dma-channel-mask property
+	 */
+	ret = device_property_read_u32(dev, "dma-channel-mask", &tmp);
+	if (ret)
+		tmp = GENMASK(chip->dw->hdata->nr_channels - 1, 0);
+	chip->dw->hdata->channels_mask = tmp;
+
 	chip->dw->hdata->perch_irq = device_property_read_bool(dev, "snps,perch_irq");
 
 	return 0;
@@ -1450,6 +1460,10 @@ static int dw_probe(struct platform_device *pdev)
 	if (hdata->perch_irq) {
 		char irqname[8];
 		for (i = 0; i < hdata->nr_channels; i++) {
+			if (!(hdata->channels_mask & (1 << i))) {
+				dw->chan[i].irq = -1;
+				continue;
+			}
 			snprintf(irqname, sizeof(irqname), "ch%u", i);
 			dw->chan[i].irq = platform_get_irq_byname(pdev, irqname);
 			if (dw->chan[i].irq < 0)
@@ -1475,6 +1489,9 @@ static int dw_probe(struct platform_device *pdev)
 	for (i = 0; i < hdata->nr_channels; i++) {
 		struct axi_dma_chan *chan = &dw->chan[i];
 
+		if (!(hdata->channels_mask & (1 << i)))
+			continue;
+
 		chan->chip = chip;
 		chan->id = i;
 		chan->chan_regs = chip->regs + COMMON_REG_LEN + i * CHAN_REG_LEN;
@@ -1572,6 +1589,8 @@ static int dw_remove(struct platform_device *pdev)
 	clk_prepare_enable(chip->core_clk);
 	axi_dma_irq_disable(chip);
 	for (i = 0; i < dw->hdata->nr_channels; i++) {
+		if (!(dw->hdata->channels_mask & (1 << i)))
+			continue;
 		axi_chan_disable(&chip->dw->chan[i]);
 		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
 	}
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 83ac839b4394..f57961620d2d 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -30,6 +30,7 @@ struct dw_axi_dma_hcfg {
 	u32	priority[DMAC_MAX_CHANNELS];
 	/* maximum supported axi burst length */
 	u32	axi_rw_burst_len;
+	u32	channels_mask;
 	/* Register map for DMAX_NUM_CHANNELS <= 8 */
 	bool	reg_map_8_channels;
 	bool	restrict_axi_burst_len;
-- 
2.39.2

