Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E795F805D4
	for <lists+dmaengine@lfdr.de>; Sat,  3 Aug 2019 12:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388807AbfHCKkw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 3 Aug 2019 06:40:52 -0400
Received: from mailout3.hostsharing.net ([176.9.242.54]:41163 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfHCKkw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 3 Aug 2019 06:40:52 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 4EC491034071B;
        Sat,  3 Aug 2019 12:40:49 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id E146B618F189;
        Sat,  3 Aug 2019 12:40:48 +0200 (CEST)
X-Mailbox-Line: From edb004dff4af6106f6bfcb89e1a96391e96eb857 Mon Sep 17 00:00:00 2001
Message-Id: <edb004dff4af6106f6bfcb89e1a96391e96eb857.1564825752.git.lukas@wunner.de>
In-Reply-To: <cover.1564825752.git.lukas@wunner.de>
References: <cover.1564825752.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 3 Aug 2019 12:10:00 +0200
Subject: [PATCH 05/10] spi: bcm2835: Work around DONE bit erratum
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

Commit 3bd7f6589f67 ("spi: bcm2835: Overcome sglist entry length
limitation") amended the BCM2835 SPI driver with support for DMA
transfers whose buffers are not aligned to 4 bytes and require more than
one sglist entry.

When testing this feature with upcoming commits to speed up TX-only and
RX-only transfers, I noticed that SPI transmission sometimes breaks.
A function introduced by the commit, bcm2835_spi_transfer_prologue(),
performs one or two PIO transmissions as a prologue to the actual DMA
transmission.  It turns out that the breakage goes away if the DONE bit
in the CS register is set when ending such a PIO transmission.

The DONE bit signifies emptiness of the TX FIFO.  According to the spec,
the bit is of type RO, so writing it should never have any effect.
Perhaps the spec is wrong and the bit is actually of type RW1C.
E.g. the I2C controller on the BCM2835 does have an RW1C DONE bit which
needs to be cleared by the driver.  Another, possibly more likely
explanation is that it's a hardware erratum since the issue does not
occur consistently.

Either way, amend bcm2835_spi_transfer_prologue() to always write the
DONE bit.

Usually a transmission is ended by bcm2835_spi_reset_hw().  If the
transmission was successful, the TX FIFO is empty and thus the DONE bit
is set when bcm2835_spi_reset_hw() reads the CS register.  The bit is
then written back to the register, so we happen to do the right thing.

However if DONE is not set, e.g. because transmission is aborted with
a non-empty TX FIFO, the bit won't be written by bcm2835_spi_reset_hw()
and it seems possible that transmission might subsequently break.  To be
on the safe side, likewise amend bcm2835_spi_reset_hw() to always write
the bit.

Tested-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: Noralf Trønnes <noralf@tronnes.org>
---
 drivers/spi/spi-bcm2835.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 2bf725e909fd..f6391c302363 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -317,6 +317,13 @@ static void bcm2835_spi_reset_hw(struct spi_controller *ctlr)
 		BCM2835_SPI_CS_INTD |
 		BCM2835_SPI_CS_DMAEN |
 		BCM2835_SPI_CS_TA);
+	/*
+	 * Transmission sometimes breaks unless the DONE bit is written at the
+	 * end of every transfer.  The spec says it's a RO bit.  Either the
+	 * spec is wrong and the bit is actually of type RW1C, or it's a
+	 * hardware erratum.
+	 */
+	cs |= BCM2835_SPI_CS_DONE;
 	/* and reset RX/TX FIFOS */
 	cs |= BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX;
 
@@ -475,7 +482,9 @@ static void bcm2835_spi_transfer_prologue(struct spi_controller *ctlr,
 		bcm2835_wr_fifo_count(bs, bs->rx_prologue);
 		bcm2835_wait_tx_fifo_empty(bs);
 		bcm2835_rd_fifo_count(bs, bs->rx_prologue);
-		bcm2835_spi_reset_hw(ctlr);
+		bcm2835_wr(bs, BCM2835_SPI_CS, cs | BCM2835_SPI_CS_CLEAR_RX
+						  | BCM2835_SPI_CS_CLEAR_TX
+						  | BCM2835_SPI_CS_DONE);
 
 		dma_sync_single_for_device(ctlr->dma_rx->device->dev,
 					   sg_dma_address(&tfr->rx_sg.sgl[0]),
@@ -496,7 +505,8 @@ static void bcm2835_spi_transfer_prologue(struct spi_controller *ctlr,
 						  | BCM2835_SPI_CS_DMAEN);
 		bcm2835_wr_fifo_count(bs, tx_remaining);
 		bcm2835_wait_tx_fifo_empty(bs);
-		bcm2835_wr(bs, BCM2835_SPI_CS, cs | BCM2835_SPI_CS_CLEAR_TX);
+		bcm2835_wr(bs, BCM2835_SPI_CS, cs | BCM2835_SPI_CS_CLEAR_TX
+						  | BCM2835_SPI_CS_DONE);
 	}
 
 	if (likely(!bs->tx_spillover)) {
-- 
2.20.1

