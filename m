Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2189C6E30F0
	for <lists+dmaengine@lfdr.de>; Sat, 15 Apr 2023 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjDOKto (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 15 Apr 2023 06:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjDOKtY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 15 Apr 2023 06:49:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74F2B45A;
        Sat, 15 Apr 2023 03:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD95B617CB;
        Sat, 15 Apr 2023 10:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C93C4339E;
        Sat, 15 Apr 2023 10:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681555626;
        bh=BENT+Gyh2C5823xlOfoa81398QX+6CAqsChvkHIBGOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G9Z09GtImEFma9YsVLp8pqsVAXgSSZeb7PK9XDKvDsX/8TNFRMF64iQ7FuSF7C4B/
         /EVWJi9OkaXJ+s2avyrsGmbV1c1jHD48WR4+HdyXnCwlhdbun3IVXtUT1FpF8/u6Qu
         8RMPfSEk7vWmejNwXe2i0+oowX5qAxIHllQ7TI9/Ejd1DlMqTRSaskehElLrlW8htx
         teYYhZ0HjNcuadIzAuackkhVZYhgYlmF/vsdrAejSlZQUesc0E1vqQ+M+XQXMX7Hf8
         oIqQdxNB4c9PnvF3Ur182weJ+zJg5TyriBlMIrVEL3on5rYytMqJDppcntFO2E94iu
         B0H/mCqV1IC+g==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/11] dmaengine: dw-axi-dmac: support per channel irq
Date:   Sat, 15 Apr 2023 18:35:57 +0800
Message-Id: <20230415103601.2979-8-jszhang@kernel.org>
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

Each channel can have its own irq, support this case.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 48 +++++++++++++++----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 +
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 796fd0136781..edb1c089a8eb 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1141,6 +1141,21 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
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
@@ -1375,6 +1390,8 @@ static int parse_device_properties(struct axi_dma_chip *chip)
 		chip->dw->hdata->axi_rw_burst_len = tmp;
 	}
 
+	chip->dw->hdata->perch_irq = device_property_read_bool(dev, "snps,perch_irq");
+
 	return 0;
 }
 
@@ -1430,14 +1447,29 @@ static int dw_probe(struct platform_device *pdev)
 	if (!dw->chan)
 		return -ENOMEM;
 
-	chip->irq = platform_get_irq(pdev, 0);
-	if (chip->irq < 0)
-		return chip->irq;
-
-	ret = devm_request_irq(chip->dev, chip->irq, dw_axi_dma_interrupt,
-			       IRQF_SHARED, KBUILD_MODNAME, chip);
-	if (ret)
-		return ret;
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
+
+		ret = devm_request_irq(chip->dev, chip->irq, dw_axi_dma_interrupt,
+				       IRQF_SHARED, KBUILD_MODNAME, chip);
+		if (ret)
+			return ret;
+	}
 
 	INIT_LIST_HEAD(&dw->dma.channels);
 	for (i = 0; i < hdata->nr_channels; i++) {
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index e9d5eb0fd594..83ac839b4394 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -33,6 +33,7 @@ struct dw_axi_dma_hcfg {
 	/* Register map for DMAX_NUM_CHANNELS <= 8 */
 	bool	reg_map_8_channels;
 	bool	restrict_axi_burst_len;
+	bool	perch_irq;
 };
 
 struct axi_dma_chan {
@@ -48,6 +49,7 @@ struct axi_dma_chan {
 	struct axi_dma_desc		*desc;
 	struct dma_slave_config		config;
 	enum dma_transfer_direction	direction;
+	int				irq;
 	bool				cyclic;
 	/* these other elements are all protected by vc.lock */
 	bool				is_paused;
-- 
2.39.2

