Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B68D805D7
	for <lists+dmaengine@lfdr.de>; Sat,  3 Aug 2019 12:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388852AbfHCKnc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 3 Aug 2019 06:43:32 -0400
Received: from mailout2.hostsharing.net ([83.223.78.233]:47897 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388809AbfHCKnb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 3 Aug 2019 06:43:31 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 6F34E10189B9A;
        Sat,  3 Aug 2019 12:43:26 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 200C1618F189;
        Sat,  3 Aug 2019 12:43:26 +0200 (CEST)
X-Mailbox-Line: From e264f405f6fd528f860f028d0e16e6d8f9d004be Mon Sep 17 00:00:00 2001
Message-Id: <e264f405f6fd528f860f028d0e16e6d8f9d004be.1564825752.git.lukas@wunner.de>
In-Reply-To: <cover.1564825752.git.lukas@wunner.de>
References: <cover.1564825752.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 3 Aug 2019 12:10:00 +0200
Subject: [PATCH 07/10] spi: bcm2835: Speed up TX-only DMA transfers by
 clearing RX FIFO
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

The BCM2835 SPI driver currently sets the SPI_CONTROLLER_MUST_RX flag.
When performing a TX-only transfer, this flag causes the SPI core to
allocate and DMA-map a dummy buffer into which the RX FIFO contents are
copied.  The dummy buffer is necessary because the chip is not capable
of disabling the receiver or automatically throwing away received data.
Not reading the RX FIFO isn't an option either since transmission is
halted once it's full.

Avoid the overhead induced by the dummy buffer by preallocating a
reusable DMA transaction which cyclically clears the RX FIFO.  The
transaction requires very little CPU time to submit and generates no
interrupts while running.  Specifics are provided in kerneldoc comments.

With a ks8851 Ethernet chip attached to the SPI controller, I am seeing
a 30 us reduction in ping time with this commit (1.819 ms vs. 1.849 ms,
average of 100,000 packets) as well as a 2% reduction in CPU time
(75:08 vs. 76:39 for transmission of 5 GByte over the SPI bus).

The commit uses the TX DMA interrupt to signal completion of a transfer.
This interrupt is raised once all bytes have been written to the
TX FIFO and it is then necessary to busy-wait for the TX FIFO to become
empty before the transfer can be finalized.  As an alternative approach,
I have explored using the SPI controller's DONE interrupt to detect
completion.  This interrupt is signaled when the TX FIFO becomes empty,
avoiding the need to busy-wait.  However latency deteriorates compared
to the present commit and surprisingly, CPU time is slightly higher as
well:

It turns out that in 45% of the cases, no busy-waiting is needed at all
and in 76% of the cases, less than 10 busy-wait iterations are
sufficient for the TX FIFO to drain.  This was measured on an RT kernel.
On a vanilla kernel, wakeup latency is worse and thus fewer iterations
are needed.  The measurements were made with an SPI clock of 20 MHz,
they may differ slightly for slower or faster clock speeds.

Previously we always used the RX DMA interrupt to signal completion of a
transfer.  Using the TX DMA interrupt now introduces a race condition:
TX DMA is always started before RX DMA so that bytes are already clocked
out while RX DMA is still being set up.  But if a TX-only transfer is
very short, then the TX DMA interrupt may occur before RX DMA is set up.
If the interrupt happens to occur on the same CPU, setup of RX DMA may
even be delayed until after the interrupt was handled.

I've solved this by having the TX DMA callback clear the RX FIFO while
busy-waiting for the TX FIFO to drain, thus avoiding a dependency on
setup of RX DMA.  Additionally, I am using a lock-free mechanism with
two flags, tx_dma_active and rx_dma_active plus memory barriers to
terminate RX DMA either by the TX DMA callback or immediately after
setting it up, whichever wins the race.  I've explored an alternative
approach which temporarily disables the TX DMA callback until RX DMA
has been set up (using tasklet_disable(), local_bh_disable() or
local_irq_save()), but the performance was minimally worse.

[Nathan Chancellor contributed a DMA mapping fixup for an early version
of this commit, hence his Signed-off-by.]

Tested-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: Noralf Trønnes <noralf@tronnes.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/spi/spi-bcm2835.c | 241 ++++++++++++++++++++++++++++++++++----
 1 file changed, 218 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index fcf203c30455..9630a25c0304 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -104,6 +104,16 @@ MODULE_PARM_DESC(polling_limit_us,
  *      These are counted as well in @count_transfer_polling and
  *      @count_transfer_irq
  * @count_transfer_dma: count how often dma mode is used
+ * @chip_select: SPI slave currently selected
+ *	(used by bcm2835_spi_dma_tx_done() to write @clear_rx_cs)
+ * @tx_dma_active: whether a TX DMA descriptor is in progress
+ * @rx_dma_active: whether a RX DMA descriptor is in progress
+ *	(used by bcm2835_spi_dma_tx_done() to handle a race)
+ * @clear_rx_desc: preallocated RX DMA descriptor used for TX-only transfers
+ *	(cyclically clears RX FIFO by writing @clear_rx_cs to CS register)
+ * @clear_rx_addr: bus address of @clear_rx_cs
+ * @clear_rx_cs: precalculated CS register value to clear RX FIFO
+ *	(uses slave-specific clock polarity and phase settings)
  */
 struct bcm2835_spi {
 	void __iomem *regs;
@@ -124,6 +134,13 @@ struct bcm2835_spi {
 	u64 count_transfer_irq;
 	u64 count_transfer_irq_after_polling;
 	u64 count_transfer_dma;
+
+	u8 chip_select;
+	unsigned int tx_dma_active;
+	unsigned int rx_dma_active;
+	struct dma_async_tx_descriptor *clear_rx_desc[BCM2835_SPI_NUM_CS];
+	dma_addr_t clear_rx_addr;
+	u32 clear_rx_cs[BCM2835_SPI_NUM_CS] ____cacheline_aligned;
 };
 
 #if defined(CONFIG_DEBUG_FS)
@@ -460,7 +477,7 @@ static void bcm2835_spi_transfer_prologue(struct spi_controller *ctlr,
 	if (!sg_is_last(&tfr->tx_sg.sgl[0]))
 		bs->tx_prologue = sg_dma_len(&tfr->tx_sg.sgl[0]) & 3;
 
-	if (!sg_is_last(&tfr->rx_sg.sgl[0])) {
+	if (bs->rx_buf && !sg_is_last(&tfr->rx_sg.sgl[0])) {
 		bs->rx_prologue = sg_dma_len(&tfr->rx_sg.sgl[0]) & 3;
 
 		if (bs->rx_prologue > bs->tx_prologue) {
@@ -555,7 +572,13 @@ static void bcm2835_spi_undo_prologue(struct bcm2835_spi *bs)
 	bs->tx_prologue = 0;
 }
 
-static void bcm2835_spi_dma_done(void *data)
+/**
+ * bcm2835_spi_dma_rx_done() - callback for DMA RX channel
+ * @data: SPI master controller
+ *
+ * Used for bidirectional and RX-only transfers.
+ */
+static void bcm2835_spi_dma_rx_done(void *data)
 {
 	struct spi_controller *ctlr = data;
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
@@ -569,14 +592,61 @@ static void bcm2835_spi_dma_done(void *data)
 	 * situation otherwise...
 	 */
 	dmaengine_terminate_async(ctlr->dma_tx);
+	bs->tx_dma_active = false;
+	bs->rx_dma_active = false;
 	bcm2835_spi_undo_prologue(bs);
 
 	/* and mark as completed */;
 	complete(&ctlr->xfer_completion);
 }
 
+/**
+ * bcm2835_spi_dma_tx_done() - callback for DMA TX channel
+ * @data: SPI master controller
+ *
+ * Used for TX-only transfers.
+ */
+static void bcm2835_spi_dma_tx_done(void *data)
+{
+	struct spi_controller *ctlr = data;
+	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
+
+	/* busy-wait for TX FIFO to empty */
+	while (!(bcm2835_rd(bs, BCM2835_SPI_CS) & BCM2835_SPI_CS_DONE))
+		bcm2835_wr(bs, BCM2835_SPI_CS,
+			   bs->clear_rx_cs[bs->chip_select]);
+
+	bs->tx_dma_active = false;
+	smp_wmb();
+
+	/*
+	 * In case of a very short transfer, RX DMA may not have been
+	 * issued yet.  The onus is then on bcm2835_spi_transfer_one_dma()
+	 * to terminate it immediately after issuing.
+	 */
+	if (cmpxchg(&bs->rx_dma_active, true, false))
+		dmaengine_terminate_async(ctlr->dma_rx);
+
+	bcm2835_spi_undo_prologue(bs);
+	bcm2835_spi_reset_hw(ctlr);
+	complete(&ctlr->xfer_completion);
+}
+
+/**
+ * bcm2835_spi_prepare_sg() - prepare and submit DMA descriptor for sglist
+ * @ctlr: SPI master controller
+ * @spi: SPI slave
+ * @tfr: SPI transfer
+ * @bs: BCM2835 SPI controller
+ * @is_tx: whether to submit DMA descriptor for TX or RX sglist
+ *
+ * Prepare and submit a DMA descriptor for the TX or RX sglist of @tfr.
+ * Return 0 on success or a negative error number.
+ */
 static int bcm2835_spi_prepare_sg(struct spi_controller *ctlr,
+				  struct spi_device *spi,
 				  struct spi_transfer *tfr,
+				  struct bcm2835_spi *bs,
 				  bool is_tx)
 {
 	struct dma_chan *chan;
@@ -593,8 +663,7 @@ static int bcm2835_spi_prepare_sg(struct spi_controller *ctlr,
 		chan  = ctlr->dma_tx;
 		nents = tfr->tx_sg.nents;
 		sgl   = tfr->tx_sg.sgl;
-		flags = 0 /* no  tx interrupt */;
-
+		flags = tfr->rx_buf ? 0 : DMA_PREP_INTERRUPT;
 	} else {
 		dir   = DMA_DEV_TO_MEM;
 		chan  = ctlr->dma_rx;
@@ -607,10 +676,17 @@ static int bcm2835_spi_prepare_sg(struct spi_controller *ctlr,
 	if (!desc)
 		return -EINVAL;
 
-	/* set callback for rx */
+	/*
+	 * Completion is signaled by the RX channel for bidirectional and
+	 * RX-only transfers; else by the TX channel for TX-only transfers.
+	 */
 	if (!is_tx) {
-		desc->callback = bcm2835_spi_dma_done;
+		desc->callback = bcm2835_spi_dma_rx_done;
+		desc->callback_param = ctlr;
+	} else if (!tfr->rx_buf) {
+		desc->callback = bcm2835_spi_dma_tx_done;
 		desc->callback_param = ctlr;
+		bs->chip_select = spi->chip_select;
 	}
 
 	/* submit it to DMA-engine */
@@ -619,12 +695,42 @@ static int bcm2835_spi_prepare_sg(struct spi_controller *ctlr,
 	return dma_submit_error(cookie);
 }
 
+/**
+ * bcm2835_spi_transfer_one_dma() - perform SPI transfer using DMA engine
+ * @ctlr: SPI master controller
+ * @spi: SPI slave
+ * @tfr: SPI transfer
+ * @cs: CS register
+ *
+ * For *bidirectional* transfers (both tx_buf and rx_buf are non-%NULL), set up
+ * the TX and RX DMA channel to copy between memory and FIFO register.
+ *
+ * For *TX-only* transfers (rx_buf is %NULL), copying the RX FIFO's contents to
+ * memory is pointless.  However not reading the RX FIFO isn't an option either
+ * because transmission is halted once it's full.  As a workaround, cyclically
+ * clear the RX FIFO by setting the CLEAR_RX bit in the CS register.
+ *
+ * The CS register value is precalculated in bcm2835_spi_setup().  Normally
+ * this is called only once, on slave registration.  A DMA descriptor to write
+ * this value is preallocated in bcm2835_dma_init().  All that's left to do
+ * when performing a TX-only transfer is to submit this descriptor to the RX
+ * DMA channel.  Latency is thereby minimized.  The descriptor does not
+ * generate any interrupts while running.  It must be terminated once the
+ * TX DMA channel is done.
+ *
+ * Clearing the RX FIFO is paced by the DREQ signal.  The signal is asserted
+ * when the RX FIFO becomes half full, i.e. 32 bytes.  (Tuneable with the DC
+ * register.)  Reading 32 bytes from the RX FIFO would normally require 8 bus
+ * accesses, whereas clearing it requires only 1 bus access.  So an 8-fold
+ * reduction in bus traffic and thus energy consumption is achieved.
+ */
 static int bcm2835_spi_transfer_one_dma(struct spi_controller *ctlr,
 					struct spi_device *spi,
 					struct spi_transfer *tfr,
 					u32 cs)
 {
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
+	dma_cookie_t cookie;
 	int ret;
 
 	/* update usage statistics */
@@ -637,13 +743,10 @@ static int bcm2835_spi_transfer_one_dma(struct spi_controller *ctlr,
 	bcm2835_spi_transfer_prologue(ctlr, tfr, bs, cs);
 
 	/* setup tx-DMA */
-	ret = bcm2835_spi_prepare_sg(ctlr, tfr, true);
+	ret = bcm2835_spi_prepare_sg(ctlr, spi, tfr, bs, true);
 	if (ret)
 		goto err_reset_hw;
 
-	/* start TX early */
-	dma_async_issue_pending(ctlr->dma_tx);
-
 	/* set the DMA length */
 	bcm2835_wr(bs, BCM2835_SPI_DLEN, bs->tx_len);
 
@@ -651,19 +754,43 @@ static int bcm2835_spi_transfer_one_dma(struct spi_controller *ctlr,
 	bcm2835_wr(bs, BCM2835_SPI_CS,
 		   cs | BCM2835_SPI_CS_TA | BCM2835_SPI_CS_DMAEN);
 
+	bs->tx_dma_active = true;
+	smp_wmb();
+
+	/* start TX early */
+	dma_async_issue_pending(ctlr->dma_tx);
+
 	/* setup rx-DMA late - to run transfers while
 	 * mapping of the rx buffers still takes place
 	 * this saves 10us or more.
 	 */
-	ret = bcm2835_spi_prepare_sg(ctlr, tfr, false);
+	if (bs->rx_buf) {
+		ret = bcm2835_spi_prepare_sg(ctlr, spi, tfr, bs, false);
+	} else {
+		cookie = dmaengine_submit(bs->clear_rx_desc[spi->chip_select]);
+		ret = dma_submit_error(cookie);
+	}
 	if (ret) {
 		/* need to reset on errors */
 		dmaengine_terminate_sync(ctlr->dma_tx);
+		bs->tx_dma_active = false;
 		goto err_reset_hw;
 	}
 
 	/* start rx dma late */
 	dma_async_issue_pending(ctlr->dma_rx);
+	bs->rx_dma_active = true;
+	smp_mb();
+
+	/*
+	 * In case of a very short TX-only transfer, bcm2835_spi_dma_tx_done()
+	 * may run before RX DMA is issued.  Terminate RX DMA if so.
+	 */
+	if (!bs->rx_buf && !bs->tx_dma_active &&
+	    cmpxchg(&bs->rx_dma_active, true, false)) {
+		dmaengine_terminate_async(ctlr->dma_rx);
+		bcm2835_spi_reset_hw(ctlr);
+	}
 
 	/* wait for wakeup in framework */
 	return 1;
@@ -686,26 +813,42 @@ static bool bcm2835_spi_can_dma(struct spi_controller *ctlr,
 	return true;
 }
 
-static void bcm2835_dma_release(struct spi_controller *ctlr)
+static void bcm2835_dma_release(struct spi_controller *ctlr,
+				struct bcm2835_spi *bs)
 {
+	int i;
+
 	if (ctlr->dma_tx) {
 		dmaengine_terminate_sync(ctlr->dma_tx);
 		dma_release_channel(ctlr->dma_tx);
 		ctlr->dma_tx = NULL;
 	}
+
 	if (ctlr->dma_rx) {
 		dmaengine_terminate_sync(ctlr->dma_rx);
+
+		for (i = 0; i < BCM2835_SPI_NUM_CS; i++)
+			if (bs->clear_rx_desc[i])
+				dmaengine_desc_free(bs->clear_rx_desc[i]);
+
+		if (bs->clear_rx_addr)
+			dma_unmap_single(ctlr->dma_rx->device->dev,
+					 bs->clear_rx_addr,
+					 sizeof(bs->clear_rx_cs),
+					 DMA_TO_DEVICE);
+
 		dma_release_channel(ctlr->dma_rx);
 		ctlr->dma_rx = NULL;
 	}
 }
 
-static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev)
+static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
+			     struct bcm2835_spi *bs)
 {
 	struct dma_slave_config slave_config;
 	const __be32 *addr;
 	dma_addr_t dma_reg_base;
-	int ret;
+	int ret, i;
 
 	/* base address in dma-space */
 	addr = of_get_address(ctlr->dev.of_node, 0, NULL, NULL);
@@ -735,17 +878,51 @@ static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev)
 	if (ret)
 		goto err_config;
 
+	/*
+	 * The RX DMA channel is used bidirectionally:  It either reads the
+	 * RX FIFO or, in case of a TX-only transfer, cyclically writes a
+	 * precalculated value to the CS register to clear the RX FIFO.
+	 */
 	slave_config.src_addr = (u32)(dma_reg_base + BCM2835_SPI_FIFO);
 	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	slave_config.dst_addr = (u32)(dma_reg_base + BCM2835_SPI_CS);
+	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
 	ret = dmaengine_slave_config(ctlr->dma_rx, &slave_config);
 	if (ret)
 		goto err_config;
 
+	bs->clear_rx_addr = dma_map_single(ctlr->dma_rx->device->dev,
+					   bs->clear_rx_cs,
+					   sizeof(bs->clear_rx_cs),
+					   DMA_TO_DEVICE);
+	if (dma_mapping_error(ctlr->dma_rx->device->dev, bs->clear_rx_addr)) {
+		dev_err(dev, "cannot map clear_rx_cs - not using DMA mode\n");
+		bs->clear_rx_addr = 0;
+		goto err_release;
+	}
+
+	for (i = 0; i < BCM2835_SPI_NUM_CS; i++) {
+		bs->clear_rx_desc[i] = dmaengine_prep_dma_cyclic(ctlr->dma_rx,
+					   bs->clear_rx_addr + i * sizeof(u32),
+					   sizeof(u32), 0,
+					   DMA_MEM_TO_DEV, 0);
+		if (!bs->clear_rx_desc[i]) {
+			dev_err(dev, "cannot prepare clear_rx_desc - not using DMA mode\n");
+			goto err_release;
+		}
+
+		ret = dmaengine_desc_set_reuse(bs->clear_rx_desc[i]);
+		if (ret) {
+			dev_err(dev, "cannot reuse clear_rx_desc - not using DMA mode\n");
+			goto err_release;
+		}
+	}
+
 	/* all went well, so set can_dma */
 	ctlr->can_dma = bcm2835_spi_can_dma;
-	/* need to do TX AND RX DMA, so we need dummy buffers */
-	ctlr->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
+	/* need to do TX DMA, so we need a dummy buffer */
+	ctlr->flags = SPI_CONTROLLER_MUST_TX;
 
 	return;
 
@@ -753,7 +930,7 @@ static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev)
 	dev_err(dev, "issue configuring dma: %d - not using DMA mode\n",
 		ret);
 err_release:
-	bcm2835_dma_release(ctlr);
+	bcm2835_dma_release(ctlr, bs);
 err:
 	return;
 }
@@ -842,8 +1019,7 @@ static int bcm2835_spi_transfer_one(struct spi_controller *ctlr,
 	bcm2835_wr(bs, BCM2835_SPI_CLK, cdiv);
 
 	/* handle all the 3-wire mode */
-	if (spi->mode & SPI_3WIRE && tfr->rx_buf &&
-	    tfr->rx_buf != ctlr->dummy_rx)
+	if (spi->mode & SPI_3WIRE && tfr->rx_buf)
 		cs |= BCM2835_SPI_CS_REN;
 
 	/* set transmit buffers and length */
@@ -911,7 +1087,9 @@ static void bcm2835_spi_handle_err(struct spi_controller *ctlr,
 
 	/* if an error occurred and we have an active dma, then terminate */
 	dmaengine_terminate_sync(ctlr->dma_tx);
+	bs->tx_dma_active = false;
 	dmaengine_terminate_sync(ctlr->dma_rx);
+	bs->rx_dma_active = false;
 	bcm2835_spi_undo_prologue(bs);
 
 	/* and reset */
@@ -925,7 +1103,8 @@ static int chip_match_name(struct gpio_chip *chip, void *data)
 
 static int bcm2835_spi_setup(struct spi_device *spi)
 {
-	struct bcm2835_spi *bs = spi_controller_get_devdata(spi->controller);
+	struct spi_controller *ctlr = spi->controller;
+	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	int err;
 	struct gpio_chip *chip;
 	u32 cs;
@@ -943,6 +1122,21 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 		cs |= BCM2835_SPI_CS_CPHA;
 	bs->prepare_cs[spi->chip_select] = cs;
 
+	/*
+	 * Precalculate SPI slave's CS register value to clear RX FIFO
+	 * in case of a TX-only DMA transfer.
+	 */
+	if (ctlr->dma_rx) {
+		bs->clear_rx_cs[spi->chip_select] = cs |
+						    BCM2835_SPI_CS_TA |
+						    BCM2835_SPI_CS_DMAEN |
+						    BCM2835_SPI_CS_CLEAR_RX;
+		dma_sync_single_for_device(ctlr->dma_rx->device->dev,
+					   bs->clear_rx_addr,
+					   sizeof(bs->clear_rx_cs),
+					   DMA_TO_DEVICE);
+	}
+
 	/*
 	 * sanity checking the native-chipselects
 	 */
@@ -993,7 +1187,8 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	struct resource *res;
 	int err;
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(*bs));
+	ctlr = spi_alloc_master(&pdev->dev, ALIGN(sizeof(*bs),
+						  dma_get_cache_alignment()));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -1032,7 +1227,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 
 	clk_prepare_enable(bs->clk);
 
-	bcm2835_dma_init(ctlr, &pdev->dev);
+	bcm2835_dma_init(ctlr, &pdev->dev, bs);
 
 	/* initialise the hardware with the default polarities */
 	bcm2835_wr(bs, BCM2835_SPI_CS,
@@ -1076,7 +1271,7 @@ static int bcm2835_spi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(bs->clk);
 
-	bcm2835_dma_release(ctlr);
+	bcm2835_dma_release(ctlr, bs);
 
 	return 0;
 }
-- 
2.20.1

