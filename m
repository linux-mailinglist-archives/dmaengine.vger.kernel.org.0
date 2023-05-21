Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4107E70AD81
	for <lists+dmaengine@lfdr.de>; Sun, 21 May 2023 12:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjEUKrF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 May 2023 06:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjEUK1w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 May 2023 06:27:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D072110EA;
        Sun, 21 May 2023 03:23:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65700611F6;
        Sun, 21 May 2023 10:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A60C433EF;
        Sun, 21 May 2023 10:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684664615;
        bh=Fu9hvdidpGkytptzWtE0mzE1XOtEGG2Aj2hPihoV7C4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WNfVn5dG+4iNau0L+paN8n2y+19tX8ACn0cdeCJAKa6xPhGYSSIjbOdQGJKgIkXPu
         Bmszre4u0TYublRYrZn7OPDzgHXTjKP1DOyR+pDRsbBwvbBUdgp/gnS5MCWcjCbyyY
         1BywclxJ4TMJB2JN1Si21Qc10D6XqorqcI8YX7KZvuGooDLBaiSX3AqVljmYQ6yauB
         2ywkw5Ix1ZsNLlpko+3Hyh/vyRY7zDlmy5UGr1Lu9IIa37yCNsT8hw0hzGXYOeJNDp
         6TNMcQK4MYFmHrLsrtMpw6xLiYVPwFvk2cXe6+piSmMNQspgP1BXPUQsla277285ma
         jvTNoLDSSxfoQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/11] dmaengine: dw-axi-dmac: support dma-channel-mask
Date:   Sun, 21 May 2023 18:12:13 +0800
Message-Id: <20230521101216.4084-9-jszhang@kernel.org>
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

Some dma channels may not be available, so we need to tell the driver
the available dma channels, use the general dt binding
"dma-channel-mask" for this purpose.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 19 +++++++++++++++++++
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 3f3db48822e3..f0bd8a7e3caf 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -223,6 +223,8 @@ static void axi_dma_hw_init(struct axi_dma_chip *chip)
 	u32 i;
 
 	for (i = 0; i < chip->dw->hdata->nr_channels; i++) {
+		if (!(chip->dw->hdata->channels_mask & (1 << i)))
+			continue;
 		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
 		axi_chan_disable(&chip->dw->chan[i]);
 	}
@@ -1397,6 +1399,14 @@ static int parse_device_properties(struct axi_dma_chip *chip)
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
@@ -1471,6 +1481,10 @@ static int dw_probe(struct platform_device *pdev)
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
@@ -1496,6 +1510,9 @@ static int dw_probe(struct platform_device *pdev)
 	for (i = 0; i < hdata->nr_channels; i++) {
 		struct axi_dma_chan *chan = &dw->chan[i];
 
+		if (!(hdata->channels_mask & (1 << i)))
+			continue;
+
 		chan->chip = chip;
 		chan->id = i;
 		chan->chan_regs = chip->regs + COMMON_REG_LEN + i * CHAN_REG_LEN;
@@ -1593,6 +1610,8 @@ static int dw_remove(struct platform_device *pdev)
 	clk_prepare_enable(chip->core_clk);
 	axi_dma_irq_disable(chip);
 	for (i = 0; i < dw->hdata->nr_channels; i++) {
+		if (!(dw->hdata->channels_mask & (1 << i)))
+			continue;
 		axi_chan_disable(&chip->dw->chan[i]);
 		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
 	}
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 49210a248c27..1f9772e9be30 100644
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
2.40.0

