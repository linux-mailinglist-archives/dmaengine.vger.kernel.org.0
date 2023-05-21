Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D0C70ADCF
	for <lists+dmaengine@lfdr.de>; Sun, 21 May 2023 13:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjEULsL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 May 2023 07:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjEUK1w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 May 2023 06:27:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E0710E9;
        Sun, 21 May 2023 03:23:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D55060C94;
        Sun, 21 May 2023 10:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7164C4339B;
        Sun, 21 May 2023 10:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684664614;
        bh=yGoRDjvKLbCYkSOxnH9X59HxNfLXO+ROMNUsbfcZ4wM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vMcLc2lI+wQvbqyTaFbmRSdqRqkCkEaQ0bJ/5dlZRCdKtbi237kfH1e0PRZkbuK5A
         6Epfhd5w9eeJ57Tq9kIfLtbgTyhd5Q9LKxClSgqfsNorGNi7SPDXtTkWv6+W1UqF2C
         L7GSnjVmvg9itJ9/SYs9HGsU9aRWlgVifoD5o+N8C08Yq/GapJF6k/zNGPC9Fz1RyV
         Q+AgF4ASkUWs4EawSh4RdE8NlfNRdOXw/N8oGDRllrYJLyqXg3ChNXw1UdSNR54KJ/
         fsqgSjvNKp2Sue4So1+wY2iSkcaF7W7Nk25RD0jKSWl4oMS5+IuE/TtauQzzFVi0Au
         G6n69g2C3rXFA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/11] dmaengine: dw-axi-dmac: support per channel irq
Date:   Sun, 21 May 2023 18:12:12 +0800
Message-Id: <20230521101216.4084-8-jszhang@kernel.org>
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

Each channel can have its own irq, support this case.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 46 ++++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 +
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 24a93b0c1489..3f3db48822e3 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1148,6 +1148,21 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t dw_axi_dma_ch_interrupt(int irq, void *dev_id)
+{
+	struct axi_dma_chan *chan = dev_id;
+
+	/* Disable DMAC interrupts. We'll enable them after processing channels */
+	axi_chan_irq_sig_set(chan, DWAXIDMAC_IRQ_NONE);
+
+	dw_axi_dma_handle_ch(chan);
+
+	/* Re-enable interrupts */
+	axi_chan_irq_sig_set(chan, DWAXIDMAC_IRQ_DMA_TRF | DWAXIDMAC_IRQ_ALL_ERR);
+
+	return IRQ_HANDLED;
+}
+
 static int dma_chan_terminate_all(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
@@ -1382,6 +1397,8 @@ static int parse_device_properties(struct axi_dma_chip *chip)
 		chip->dw->hdata->axi_rw_burst_len = tmp;
 	}
 
+	chip->dw->hdata->perch_irq = device_property_read_bool(dev, "snps,perch_irq");
+
 	return 0;
 }
 
@@ -1451,14 +1468,29 @@ static int dw_probe(struct platform_device *pdev)
 	if (!dw->chan)
 		return -ENOMEM;
 
-	chip->irq = platform_get_irq(pdev, 0);
-	if (chip->irq < 0)
-		return chip->irq;
+	if (hdata->perch_irq) {
+		char irqname[8];
+		for (i = 0; i < hdata->nr_channels; i++) {
+			snprintf(irqname, sizeof(irqname), "ch%u", i);
+			dw->chan[i].irq = platform_get_irq_byname(pdev, irqname);
+			if (dw->chan[i].irq < 0)
+				return dw->chan[i].irq;
+			ret = devm_request_irq(chip->dev, dw->chan[i].irq,
+					       dw_axi_dma_ch_interrupt,
+					       0, KBUILD_MODNAME, &dw->chan[i]);
+			if (ret)
+				return ret;
+		}
+	} else {
+		chip->irq = platform_get_irq(pdev, 0);
+		if (chip->irq < 0)
+			return chip->irq;
 
-	ret = devm_request_irq(chip->dev, chip->irq, dw_axi_dma_interrupt,
-			       IRQF_SHARED, KBUILD_MODNAME, chip);
-	if (ret)
-		return ret;
+		ret = devm_request_irq(chip->dev, chip->irq, dw_axi_dma_interrupt,
+				       IRQF_SHARED, KBUILD_MODNAME, chip);
+		if (ret)
+			return ret;
+	}
 
 	INIT_LIST_HEAD(&dw->dma.channels);
 	for (i = 0; i < hdata->nr_channels; i++) {
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index eb267cb24f67..49210a248c27 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -34,6 +34,7 @@ struct dw_axi_dma_hcfg {
 	bool	reg_map_8_channels;
 	bool	restrict_axi_burst_len;
 	bool	use_cfg2;
+	bool	perch_irq;
 };
 
 struct axi_dma_chan {
@@ -49,6 +50,7 @@ struct axi_dma_chan {
 	struct axi_dma_desc		*desc;
 	struct dma_slave_config		config;
 	enum dma_transfer_direction	direction;
+	int				irq;
 	bool				cyclic;
 	/* these other elements are all protected by vc.lock */
 	bool				is_paused;
-- 
2.40.0

