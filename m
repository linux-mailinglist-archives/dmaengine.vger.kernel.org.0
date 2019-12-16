Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 252FD1202FE
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2019 11:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfLPKyG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 05:54:06 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43691 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfLPKyG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Dec 2019 05:54:06 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1igo0L-0001dd-9S; Mon, 16 Dec 2019 11:53:33 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1igo0I-0005tN-Ew; Mon, 16 Dec 2019 11:53:30 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Green Wan <green.wan@sifive.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Sean Wang <sean.wang@mediatek.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 7/9] dmaengine: imx-sdma: rename function
Date:   Mon, 16 Dec 2019 11:53:26 +0100
Message-Id: <20191216105328.15198-8-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191216105328.15198-1-s.hauer@pengutronix.de>
References: <20191216105328.15198-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Rename sdma_disable_channel_async() after the hook it implements, like
done for all other functions in the SDMA driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index c27e206a764c..527f8a81f50b 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1077,7 +1077,7 @@ static void sdma_channel_terminate_work(struct work_struct *work)
 	sdmac->context_loaded = false;
 }
 
-static int sdma_disable_channel_async(struct dma_chan *chan)
+static int sdma_terminate_all(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 
@@ -1324,7 +1324,7 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
 
-	sdma_disable_channel_async(chan);
+	sdma_terminate_all(chan);
 
 	sdma_channel_synchronize(chan);
 
@@ -2103,7 +2103,7 @@ static int sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.device_prep_slave_sg = sdma_prep_slave_sg;
 	sdma->dma_device.device_prep_dma_cyclic = sdma_prep_dma_cyclic;
 	sdma->dma_device.device_config = sdma_config;
-	sdma->dma_device.device_terminate_all = sdma_disable_channel_async;
+	sdma->dma_device.device_terminate_all = sdma_terminate_all;
 	sdma->dma_device.device_synchronize = sdma_channel_synchronize;
 	sdma->dma_device.src_addr_widths = SDMA_DMA_BUSWIDTHS;
 	sdma->dma_device.dst_addr_widths = SDMA_DMA_BUSWIDTHS;
-- 
2.24.0

