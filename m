Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D82D64D5
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 16:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbfJNONr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 10:13:47 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34903 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbfJNONr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Oct 2019 10:13:47 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iK16X-00045S-Gq; Mon, 14 Oct 2019 16:13:45 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1iK16W-0003OA-Hl; Mon, 14 Oct 2019 16:13:44 +0200
Date:   Mon, 14 Oct 2019 16:13:44 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-mtd@lists.infradead.org,
        vkoul@kernel.org, miquel.raynal@bootlin.com, bth@kamstrup.com,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: Regression: dmaengine: imx28 with emmc
Message-ID: <20191014141344.uwnzy3j3kxngzv7a@pengutronix.de>
References: <CAH+2xPB7rbeJnOPU10Ss9BhV_2DJV-ToQ3XNOy97+vrGx+ubcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+2xPB7rbeJnOPU10Ss9BhV_2DJV-ToQ3XNOy97+vrGx+ubcg@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 16:11:15 up 98 days, 20:21, 105 users,  load average: 0.18, 0.22,
 0.32
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Bruno,

On Tue, Oct 08, 2019 at 10:03:16AM +0200, Bruno Thomsen wrote:
> Hi
> 
> I am getting a kernel oops[1] during boot on imx28 with emmc flash right
> around rootfs mounting. Using git bisect I found the cause to be the
> following commit.
> 
> Regression: ceeeb99cd821 ("dmaengine: mxs: rename custom flag")
> 
> Reverting the 2 changes in drivers/dma/mxs-dma.c fixes the oops,
> but I am not sure that is the right solution as I don't have the full
> mxs-dma + mtd/mmc overview.
> 
> I did see that the patch isn't a simple rename but also a bit define
> change.
> From: DMA_CTRL_ACK = (1 << 1) = BIT(1)
> To: MXS_DMA_CTRL_WAIT4END = BIT(31)
> 

Damn, I wasn't aware the DMA driver has other users than the GPMI Nand.
Please try the attached patch, it should fix it for MMC/SD. It seems
however, that I2C and AUART and SPI are also affected. Are you able to
test any of these?

Sascha

---------------------------8<---------------------------

From 3f7a1097099c9e57e31a86503edc479f9964bc95 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 14 Oct 2019 16:07:31 +0200
Subject: [PATCH] mmc: mxs: fix flags passed to dmaengine_prep_slave_sg

Since ceeeb99cd821 we no longer abuse the DMA_CTRL_ACK flag for custom
driver use and introduced the MXS_DMA_CTRL_WAIT4END instead. We have not
changed all users to this flag though. This patch fixes it for the
mxs-mmc driver.

Fixes: ceeeb99cd821 ("dmaengine: mxs: rename custom flag")
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/host/mxs-mmc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 78e7e350655c..4031217d21c3 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/dma/mxs-dma.h>
 #include <linux/highmem.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -266,7 +267,7 @@ static void mxs_mmc_bc(struct mxs_mmc_host *host)
 	ssp->ssp_pio_words[2] = cmd1;
 	ssp->dma_dir = DMA_NONE;
 	ssp->slave_dirn = DMA_TRANS_NONE;
-	desc = mxs_mmc_prep_dma(host, DMA_CTRL_ACK);
+	desc = mxs_mmc_prep_dma(host, MXS_DMA_CTRL_WAIT4END);
 	if (!desc)
 		goto out;
 
@@ -311,7 +312,7 @@ static void mxs_mmc_ac(struct mxs_mmc_host *host)
 	ssp->ssp_pio_words[2] = cmd1;
 	ssp->dma_dir = DMA_NONE;
 	ssp->slave_dirn = DMA_TRANS_NONE;
-	desc = mxs_mmc_prep_dma(host, DMA_CTRL_ACK);
+	desc = mxs_mmc_prep_dma(host, MXS_DMA_CTRL_WAIT4END);
 	if (!desc)
 		goto out;
 
@@ -441,7 +442,7 @@ static void mxs_mmc_adtc(struct mxs_mmc_host *host)
 	host->data = data;
 	ssp->dma_dir = dma_data_dir;
 	ssp->slave_dirn = slave_dirn;
-	desc = mxs_mmc_prep_dma(host, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	desc = mxs_mmc_prep_dma(host, DMA_PREP_INTERRUPT | MXS_DMA_CTRL_WAIT4END);
 	if (!desc)
 		goto out;
 
-- 
2.23.0


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
