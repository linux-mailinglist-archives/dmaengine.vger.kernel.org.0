Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC9D805E1
	for <lists+dmaengine@lfdr.de>; Sat,  3 Aug 2019 12:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389176AbfHCKs1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 3 Aug 2019 06:48:27 -0400
Received: from mailout2.hostsharing.net ([83.223.78.233]:35109 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389162AbfHCKs1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 3 Aug 2019 06:48:27 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 4226D10189B21;
        Sat,  3 Aug 2019 12:48:22 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id F03C6618F189;
        Sat,  3 Aug 2019 12:48:21 +0200 (CEST)
X-Mailbox-Line: From fe12893a7521a162001a1f52d2a98f07592c811c Mon Sep 17 00:00:00 2001
Message-Id: <fe12893a7521a162001a1f52d2a98f07592c811c.1564825752.git.lukas@wunner.de>
In-Reply-To: <cover.1564825752.git.lukas@wunner.de>
References: <cover.1564825752.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 3 Aug 2019 12:10:00 +0200
Subject: [PATCH 10/10] spi: bcm2835: Speed up RX-only DMA transfers by
 zero-filling TX FIFO
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>, linux-spi@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Eric Anholt <eric@anholt.net>, Nuno Sa <nuno.sa@analog.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Noralf Tronnes <noralf@tronnes.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Kauer <florian.kauer@koalo.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The BCM2835 SPI driver currently sets the SPI_CONTROLLER_MUST_TX flag.
When performing an RX-only transfer, this flag causes the SPI core to
allocate and DMA-map a dummy buffer which is copied to the TX FIFO.
The dummy buffer is necessary because the chip is not capable of
automatically clocking out null bytes.

Avoid the overhead induced by the dummy buffer by preallocating a
reusable DMA transaction which fills the TX FIFO by cyclically copying
from the zero page.  The transaction requires very little CPU time to
submit and generates no interrupts while running.  Specifics are
provided in kerneldoc comments.

[Nathan Chancellor contributed a DMA mapping fixup for an early version
of this commit, hence his Signed-off-by.]

Tested-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: Noralf Trønnes <noralf@tronnes.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/spi/spi-bcm2835.c | 93 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 82 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 9630a25c0304..a57d72fca66e 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -109,6 +109,9 @@ MODULE_PARM_DESC(polling_limit_us,
  * @tx_dma_active: whether a TX DMA descriptor is in progress
  * @rx_dma_active: whether a RX DMA descriptor is in progress
  *	(used by bcm2835_spi_dma_tx_done() to handle a race)
+ * @fill_tx_desc: preallocated TX DMA descriptor used for RX-only transfers
+ *	(cyclically copies from zero page to TX FIFO)
+ * @fill_tx_addr: bus address of zero page
  * @clear_rx_desc: preallocated RX DMA descriptor used for TX-only transfers
  *	(cyclically clears RX FIFO by writing @clear_rx_cs to CS register)
  * @clear_rx_addr: bus address of @clear_rx_cs
@@ -138,6 +141,8 @@ struct bcm2835_spi {
 	u8 chip_select;
 	unsigned int tx_dma_active;
 	unsigned int rx_dma_active;
+	struct dma_async_tx_descriptor *fill_tx_desc;
+	dma_addr_t fill_tx_addr;
 	struct dma_async_tx_descriptor *clear_rx_desc[BCM2835_SPI_NUM_CS];
 	dma_addr_t clear_rx_addr;
 	u32 clear_rx_cs[BCM2835_SPI_NUM_CS] ____cacheline_aligned;
@@ -474,14 +479,14 @@ static void bcm2835_spi_transfer_prologue(struct spi_controller *ctlr,
 	bs->rx_prologue  = 0;
 	bs->tx_spillover = false;
 
-	if (!sg_is_last(&tfr->tx_sg.sgl[0]))
+	if (bs->tx_buf && !sg_is_last(&tfr->tx_sg.sgl[0]))
 		bs->tx_prologue = sg_dma_len(&tfr->tx_sg.sgl[0]) & 3;
 
 	if (bs->rx_buf && !sg_is_last(&tfr->rx_sg.sgl[0])) {
 		bs->rx_prologue = sg_dma_len(&tfr->rx_sg.sgl[0]) & 3;
 
 		if (bs->rx_prologue > bs->tx_prologue) {
-			if (sg_is_last(&tfr->tx_sg.sgl[0])) {
+			if (!bs->tx_buf || sg_is_last(&tfr->tx_sg.sgl[0])) {
 				bs->tx_prologue  = bs->rx_prologue;
 			} else {
 				bs->tx_prologue += 4;
@@ -515,6 +520,9 @@ static void bcm2835_spi_transfer_prologue(struct spi_controller *ctlr,
 		sg_dma_len(&tfr->rx_sg.sgl[0])     -= bs->rx_prologue;
 	}
 
+	if (!bs->tx_buf)
+		return;
+
 	/*
 	 * Write remaining TX prologue.  Adjust first entry in TX sglist.
 	 * Also adjust second entry if prologue spills over to it.
@@ -560,6 +568,9 @@ static void bcm2835_spi_undo_prologue(struct bcm2835_spi *bs)
 		sg_dma_len(&tfr->rx_sg.sgl[0])     += bs->rx_prologue;
 	}
 
+	if (!bs->tx_buf)
+		goto out;
+
 	if (likely(!bs->tx_spillover)) {
 		sg_dma_address(&tfr->tx_sg.sgl[0]) -= bs->tx_prologue;
 		sg_dma_len(&tfr->tx_sg.sgl[0])     += bs->tx_prologue;
@@ -568,7 +579,7 @@ static void bcm2835_spi_undo_prologue(struct bcm2835_spi *bs)
 		sg_dma_address(&tfr->tx_sg.sgl[1]) -= 4;
 		sg_dma_len(&tfr->tx_sg.sgl[1])     += 4;
 	}
-
+out:
 	bs->tx_prologue = 0;
 }
 
@@ -583,10 +594,7 @@ static void bcm2835_spi_dma_rx_done(void *data)
 	struct spi_controller *ctlr = data;
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 
-	/* reset fifo and HW */
-	bcm2835_spi_reset_hw(ctlr);
-
-	/* and terminate tx-dma as we do not have an irq for it
+	/* terminate tx-dma as we do not have an irq for it
 	 * because when the rx dma will terminate and this callback
 	 * is called the tx-dma must have finished - can't get to this
 	 * situation otherwise...
@@ -596,6 +604,9 @@ static void bcm2835_spi_dma_rx_done(void *data)
 	bs->rx_dma_active = false;
 	bcm2835_spi_undo_prologue(bs);
 
+	/* reset fifo and HW */
+	bcm2835_spi_reset_hw(ctlr);
+
 	/* and mark as completed */;
 	complete(&ctlr->xfer_completion);
 }
@@ -723,6 +734,24 @@ static int bcm2835_spi_prepare_sg(struct spi_controller *ctlr,
  * register.)  Reading 32 bytes from the RX FIFO would normally require 8 bus
  * accesses, whereas clearing it requires only 1 bus access.  So an 8-fold
  * reduction in bus traffic and thus energy consumption is achieved.
+ *
+ * For *RX-only* transfers (tx_buf is %NULL), fill the TX FIFO by cyclically
+ * copying from the zero page.  The DMA descriptor to do this is preallocated
+ * in bcm2835_dma_init().  It must be terminated once the RX DMA channel is
+ * done and can then be reused.
+ *
+ * The BCM2835 DMA driver autodetects when a transaction copies from the zero
+ * page and utilizes the DMA controller's ability to synthesize zeroes instead
+ * of copying them from memory.  This reduces traffic on the memory bus.  The
+ * feature is not available on so-called "lite" channels, but normally TX DMA
+ * is backed by a full-featured channel.
+ *
+ * Zero-filling the TX FIFO is paced by the DREQ signal.  Unfortunately the
+ * BCM2835 SPI controller continues to assert DREQ even after the DLEN register
+ * has been counted down to zero (hardware erratum).  Thus, when the transfer
+ * has finished, the DMA engine zero-fills the TX FIFO until it is half full.
+ * (Tuneable with the DC register.)  So up to 9 gratuitous bus accesses are
+ * performed at the end of an RX-only transfer.
  */
 static int bcm2835_spi_transfer_one_dma(struct spi_controller *ctlr,
 					struct spi_device *spi,
@@ -743,7 +772,12 @@ static int bcm2835_spi_transfer_one_dma(struct spi_controller *ctlr,
 	bcm2835_spi_transfer_prologue(ctlr, tfr, bs, cs);
 
 	/* setup tx-DMA */
-	ret = bcm2835_spi_prepare_sg(ctlr, spi, tfr, bs, true);
+	if (bs->tx_buf) {
+		ret = bcm2835_spi_prepare_sg(ctlr, spi, tfr, bs, true);
+	} else {
+		cookie = dmaengine_submit(bs->fill_tx_desc);
+		ret = dma_submit_error(cookie);
+	}
 	if (ret)
 		goto err_reset_hw;
 
@@ -820,6 +854,16 @@ static void bcm2835_dma_release(struct spi_controller *ctlr,
 
 	if (ctlr->dma_tx) {
 		dmaengine_terminate_sync(ctlr->dma_tx);
+
+		if (bs->fill_tx_desc)
+			dmaengine_desc_free(bs->fill_tx_desc);
+
+		if (bs->fill_tx_addr)
+			dma_unmap_page_attrs(ctlr->dma_tx->device->dev,
+					     bs->fill_tx_addr, sizeof(u32),
+					     DMA_TO_DEVICE,
+					     DMA_ATTR_SKIP_CPU_SYNC);
+
 		dma_release_channel(ctlr->dma_tx);
 		ctlr->dma_tx = NULL;
 	}
@@ -870,7 +914,11 @@ static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 		goto err_release;
 	}
 
-	/* configure DMAs */
+	/*
+	 * The TX DMA channel either copies a transfer's TX buffer to the FIFO
+	 * or, in case of an RX-only transfer, cyclically copies from the zero
+	 * page to the FIFO using a preallocated, reusable descriptor.
+	 */
 	slave_config.dst_addr = (u32)(dma_reg_base + BCM2835_SPI_FIFO);
 	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
@@ -878,6 +926,31 @@ static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 	if (ret)
 		goto err_config;
 
+	bs->fill_tx_addr = dma_map_page_attrs(ctlr->dma_tx->device->dev,
+					      ZERO_PAGE(0), 0, sizeof(u32),
+					      DMA_TO_DEVICE,
+					      DMA_ATTR_SKIP_CPU_SYNC);
+	if (dma_mapping_error(ctlr->dma_tx->device->dev, bs->fill_tx_addr)) {
+		dev_err(dev, "cannot map zero page - not using DMA mode\n");
+		bs->fill_tx_addr = 0;
+		goto err_release;
+	}
+
+	bs->fill_tx_desc = dmaengine_prep_dma_cyclic(ctlr->dma_tx,
+						     bs->fill_tx_addr,
+						     sizeof(u32), 0,
+						     DMA_MEM_TO_DEV, 0);
+	if (!bs->fill_tx_desc) {
+		dev_err(dev, "cannot prepare fill_tx_desc - not using DMA mode\n");
+		goto err_release;
+	}
+
+	ret = dmaengine_desc_set_reuse(bs->fill_tx_desc);
+	if (ret) {
+		dev_err(dev, "cannot reuse fill_tx_desc - not using DMA mode\n");
+		goto err_release;
+	}
+
 	/*
 	 * The RX DMA channel is used bidirectionally:  It either reads the
 	 * RX FIFO or, in case of a TX-only transfer, cyclically writes a
@@ -921,8 +994,6 @@ static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 
 	/* all went well, so set can_dma */
 	ctlr->can_dma = bcm2835_spi_can_dma;
-	/* need to do TX DMA, so we need a dummy buffer */
-	ctlr->flags = SPI_CONTROLLER_MUST_TX;
 
 	return;
 
-- 
2.20.1

