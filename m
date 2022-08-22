Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4488F59BC8B
	for <lists+dmaengine@lfdr.de>; Mon, 22 Aug 2022 11:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiHVJQ4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Aug 2022 05:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbiHVJPy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Aug 2022 05:15:54 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209E1286F2;
        Mon, 22 Aug 2022 02:15:41 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27M9FaUN121375;
        Mon, 22 Aug 2022 04:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661159736;
        bh=4RWmn9Vu1OlHjUmqPhU6tSBzfYbt3rOJpZXMAAaiX+w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NuVwIMSvZ6ZH0I95bUagB4dlPI77RKUHqPAqFr+E4PmjsS+sk3/0VQZdVKU6Sj+iS
         Qtb5tQbeJySFzu507Im1iLoq97l4H4YP2xetHw8xfgwsRgur2HSOH71UO73gCwqfG2
         izvGG9Vfg0ToVeaD+FLaR6QR/fVzv0vSbqcZW/zI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27M9Fa8q111278
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Aug 2022 04:15:36 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 22
 Aug 2022 04:15:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 22 Aug 2022 04:15:36 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27M9FZuh069753;
        Mon, 22 Aug 2022 04:15:36 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>,
        <broonie@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC:     <vigneshr@ti.com>, <kishon@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH 2/2] spi: spi-omap2-mcspi: Use EOW interrupt for completion when DMA enabled
Date:   Mon, 22 Aug 2022 14:45:31 +0530
Message-ID: <20220822091531.27827-3-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220822091531.27827-1-vaishnav.a@ti.com>
References: <20220822091531.27827-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In MCSPI controller EOW interrupt is triggered when the channel has
transmitted the set number of bytes in MCSPI_XFERLEVEL[31-16] WCNT,
this can be used to signal the completion of a TX/RX when the internal
FIFO is enabled, when DMA is enabled the internal FIFO is always enabled.
Waiting for the DMA completion adds unpredictable delays due to the
non-realtime completion calculation mechanism in k3-udma driver.

This commit removes the dma_tx_completion and dma_rx_completion and
relies on the MCSPI controller EOW interrupt to signal transaction
completion.This fixes the real-time performance issues in master and
slave mode when DMA was enabled which resulted from the DMA completion
calculation delays.

Since the MCSPI driver now uses internal mechanism to identify a transfer
completion we disable the TX and RX DMA completion callback and remove
DMA_PREP_INTERRUPT.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 drivers/spi/spi-omap2-mcspi.c | 141 +++++++++-------------------------
 1 file changed, 36 insertions(+), 105 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index c48d02bb7013..8680465533e0 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -91,10 +91,6 @@
 struct omap2_mcspi_dma {
 	struct dma_chan *dma_tx;
 	struct dma_chan *dma_rx;
-
-	struct completion dma_tx_completion;
-	struct completion dma_rx_completion;
-
 	char dma_rx_ch_name[14];
 	char dma_tx_ch_name[14];
 };
@@ -116,7 +112,7 @@ struct omap2_mcspi_regs {
 };
 
 struct omap2_mcspi {
-	struct completion	txdone;
+	struct completion	txrxdone;
 	struct spi_master	*master;
 	/* Virtual base address of the controller */
 	void __iomem		*base;
@@ -375,30 +371,6 @@ static int mcspi_wait_for_completion(struct  omap2_mcspi *mcspi,
 	return 0;
 }
 
-static void omap2_mcspi_rx_callback(void *data)
-{
-	struct spi_device *spi = data;
-	struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
-	struct omap2_mcspi_dma *mcspi_dma = &mcspi->dma_channels[spi->chip_select];
-
-	/* We must disable the DMA RX request */
-	omap2_mcspi_set_dma_req(spi, 1, 0);
-
-	complete(&mcspi_dma->dma_rx_completion);
-}
-
-static void omap2_mcspi_tx_callback(void *data)
-{
-	struct spi_device *spi = data;
-	struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
-	struct omap2_mcspi_dma *mcspi_dma = &mcspi->dma_channels[spi->chip_select];
-
-	/* We must disable the DMA TX request */
-	omap2_mcspi_set_dma_req(spi, 0, 0);
-
-	complete(&mcspi_dma->dma_tx_completion);
-}
-
 static void omap2_mcspi_tx_dma(struct spi_device *spi,
 				struct spi_transfer *xfer,
 				struct dma_slave_config cfg)
@@ -413,12 +385,9 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
 	dmaengine_slave_config(mcspi_dma->dma_tx, &cfg);
 
 	tx = dmaengine_prep_slave_sg(mcspi_dma->dma_tx, xfer->tx_sg.sgl,
-				     xfer->tx_sg.nents,
-				     DMA_MEM_TO_DEV,
-				     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+					xfer->tx_sg.nents, DMA_MEM_TO_DEV, DMA_CTRL_ACK);
+
 	if (tx) {
-		tx->callback = omap2_mcspi_tx_callback;
-		tx->callback_param = spi;
 		dmaengine_submit(tx);
 	} else {
 		/* FIXME: fall back to PIO? */
@@ -500,11 +469,9 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	}
 
 	tx = dmaengine_prep_slave_sg(mcspi_dma->dma_rx, sg_out[0],
-				     out_mapped_nents[0], DMA_DEV_TO_MEM,
-				     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+				     out_mapped_nents[0], DMA_DEV_TO_MEM, DMA_CTRL_ACK);
+
 	if (tx) {
-		tx->callback = omap2_mcspi_rx_callback;
-		tx->callback_param = spi;
 		dmaengine_submit(tx);
 	} else {
 		/* FIXME: fall back to PIO? */
@@ -513,10 +480,10 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	dma_async_issue_pending(mcspi_dma->dma_rx);
 	omap2_mcspi_set_dma_req(spi, 1, 1);
 
-	ret = mcspi_wait_for_completion(mcspi, &mcspi_dma->dma_rx_completion);
+	ret = mcspi_wait_for_completion(mcspi, &mcspi->txrxdone);
+	omap2_mcspi_set_dma_req(spi, 1, 0);
 	if (ret || mcspi->slave_aborted) {
 		dmaengine_terminate_sync(mcspi_dma->dma_rx);
-		omap2_mcspi_set_dma_req(spi, 1, 0);
 		return 0;
 	}
 
@@ -587,8 +554,8 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	enum dma_slave_buswidth width;
 	unsigned es;
 	void __iomem		*chstat_reg;
-	void __iomem            *irqstat_reg;
 	int			wait_res;
+	int ret;
 
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
@@ -618,68 +585,36 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	tx = xfer->tx_buf;
 
 	mcspi->slave_aborted = false;
-	reinit_completion(&mcspi_dma->dma_tx_completion);
-	reinit_completion(&mcspi_dma->dma_rx_completion);
-	reinit_completion(&mcspi->txdone);
-	if (tx) {
-		/* Enable EOW IRQ to know end of tx in slave mode */
-		if (spi_controller_is_slave(spi->master))
-			mcspi_write_reg(spi->master,
-					OMAP2_MCSPI_IRQENABLE,
-					OMAP2_MCSPI_IRQSTATUS_EOW);
+	reinit_completion(&mcspi->txrxdone);
+	mcspi_write_reg(spi->master, OMAP2_MCSPI_IRQENABLE,	OMAP2_MCSPI_IRQSTATUS_EOW);
+	if (tx)
 		omap2_mcspi_tx_dma(spi, xfer, cfg);
-	}
 
-	if (rx != NULL)
+	if (rx)
 		count = omap2_mcspi_rx_dma(spi, xfer, cfg, es);
 
-	if (tx != NULL) {
-		int ret;
-
-		ret = mcspi_wait_for_completion(mcspi, &mcspi_dma->dma_tx_completion);
-		if (ret || mcspi->slave_aborted) {
-			dmaengine_terminate_sync(mcspi_dma->dma_tx);
-			omap2_mcspi_set_dma_req(spi, 0, 0);
-			return 0;
-		}
-
-		if (spi_controller_is_slave(mcspi->master)) {
-			ret = mcspi_wait_for_completion(mcspi, &mcspi->txdone);
-			if (ret || mcspi->slave_aborted)
-				return 0;
-		}
+	ret = mcspi_wait_for_completion(mcspi, &mcspi->txrxdone);
+	omap2_mcspi_set_dma_req(spi, 0, 0);
+	if (ret || mcspi->slave_aborted)
+		return 0;
 
+	/* for TX_ONLY mode, be sure all words have shifted out */
+	if (tx && !rx) {
+		chstat_reg = cs->base + OMAP2_MCSPI_CHSTAT0;
 		if (mcspi->fifo_depth > 0) {
-			irqstat_reg = mcspi->base + OMAP2_MCSPI_IRQSTATUS;
-
-			if (mcspi_wait_for_reg_bit(irqstat_reg,
-						OMAP2_MCSPI_IRQSTATUS_EOW) < 0)
-				dev_err(&spi->dev, "EOW timed out\n");
-
-			mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQSTATUS,
-					OMAP2_MCSPI_IRQSTATUS_EOW);
-		}
-
-		/* for TX_ONLY mode, be sure all words have shifted out */
-		if (rx == NULL) {
-			chstat_reg = cs->base + OMAP2_MCSPI_CHSTAT0;
-			if (mcspi->fifo_depth > 0) {
-				wait_res = mcspi_wait_for_reg_bit(chstat_reg,
-						OMAP2_MCSPI_CHSTAT_TXFFE);
-				if (wait_res < 0)
-					dev_err(&spi->dev, "TXFFE timed out\n");
-			} else {
-				wait_res = mcspi_wait_for_reg_bit(chstat_reg,
-						OMAP2_MCSPI_CHSTAT_TXS);
-				if (wait_res < 0)
-					dev_err(&spi->dev, "TXS timed out\n");
-			}
-			if (wait_res >= 0 &&
-				(mcspi_wait_for_reg_bit(chstat_reg,
-					OMAP2_MCSPI_CHSTAT_EOT) < 0))
-				dev_err(&spi->dev, "EOT timed out\n");
+			wait_res = mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_TXFFE);
+			if (wait_res < 0)
+				dev_err(&spi->dev, "TXFFE timed out\n");
+		} else {
+			wait_res = mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_TXS);
+			if (wait_res < 0)
+				dev_err(&spi->dev, "TXS timed out\n");
 		}
+		if (wait_res >= 0 && (mcspi_wait_for_reg_bit(chstat_reg,
+							     OMAP2_MCSPI_CHSTAT_EOT) < 0))
+			dev_err(&spi->dev, "EOT timed out\n");
 	}
+
 	return count;
 }
 
@@ -1010,9 +945,6 @@ static int omap2_mcspi_request_dma(struct omap2_mcspi *mcspi,
 		mcspi_dma->dma_rx = NULL;
 	}
 
-	init_completion(&mcspi_dma->dma_rx_completion);
-	init_completion(&mcspi_dma->dma_tx_completion);
-
 no_dma:
 	return ret;
 }
@@ -1102,8 +1034,10 @@ static irqreturn_t omap2_mcspi_irq_handler(int irq, void *data)
 
 	/* Disable IRQ and wakeup slave xfer task */
 	mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQENABLE, 0);
-	if (irqstat & OMAP2_MCSPI_IRQSTATUS_EOW)
-		complete(&mcspi->txdone);
+	if (irqstat & OMAP2_MCSPI_IRQSTATUS_EOW) {
+		complete_all(&mcspi->txrxdone);
+		mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQSTATUS, OMAP2_MCSPI_IRQSTATUS_EOW);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1111,12 +1045,9 @@ static irqreturn_t omap2_mcspi_irq_handler(int irq, void *data)
 static int omap2_mcspi_slave_abort(struct spi_master *master)
 {
 	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
-	struct omap2_mcspi_dma *mcspi_dma = mcspi->dma_channels;
 
 	mcspi->slave_aborted = true;
-	complete(&mcspi_dma->dma_rx_completion);
-	complete(&mcspi_dma->dma_tx_completion);
-	complete(&mcspi->txdone);
+	complete_all(&mcspi->txrxdone);
 
 	return 0;
 }
@@ -1516,7 +1447,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "no irq resource found\n");
 		goto free_master;
 	}
-	init_completion(&mcspi->txdone);
+	init_completion(&mcspi->txrxdone);
 	status = devm_request_irq(&pdev->dev, status,
 				  omap2_mcspi_irq_handler, 0, pdev->name,
 				  mcspi);
-- 
2.17.1

