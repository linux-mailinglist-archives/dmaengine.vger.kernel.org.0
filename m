Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 617B93B071
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jun 2019 10:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbfFJIQi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jun 2019 04:16:38 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37652 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388393AbfFJIQi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 Jun 2019 04:16:38 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 74134200747;
        Mon, 10 Jun 2019 10:16:35 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 39628200748;
        Mon, 10 Jun 2019 10:16:27 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9829D40326;
        Mon, 10 Jun 2019 16:16:17 +0800 (SGT)
From:   yibin.gong@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, broonie@kernel.org,
        festevam@gmail.com, vkoul@kernel.org, dan.j.williams@intel.com,
        u.kleine-koenig@pengutronix.de, catalin.marinas@arm.com,
        l.stach@pengutronix.de, will.deacon@arm.com
Cc:     linux-spi@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 09/15] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
Date:   Mon, 10 Jun 2019 16:17:47 +0800
Message-Id: <20190610081753.11422-10-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610081753.11422-1-yibin.gong@nxp.com>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

ECSPI issue fixed from i.mx6ul at hardware level, no need
ERR009165 anymore on those chips such as i.mx8mq. Add i.mx6sx
from where i.mx6ul source.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 61af656..525ca89 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -419,6 +419,13 @@ struct sdma_driver_data {
 	int num_events;
 	struct sdma_script_start_addrs	*script_addrs;
 	bool check_ratio;
+	/*
+	 * ecspi ERR009165 fixed should be done in sdma script
+	 * and it has been fixed in soc from i.mx6ul.
+	 * please get more information from the below link:
+	 * https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf
+	 */
+	bool ecspi_fixed;
 };
 
 struct sdma_engine {
@@ -539,6 +546,31 @@ static struct sdma_driver_data sdma_imx6q = {
 	.script_addrs = &sdma_script_imx6q,
 };
 
+static struct sdma_script_start_addrs sdma_script_imx6sx = {
+	.ap_2_ap_addr = 642,
+	.uart_2_mcu_addr = 817,
+	.mcu_2_app_addr = 747,
+	.uartsh_2_mcu_addr = 1032,
+	.mcu_2_shp_addr = 960,
+	.app_2_mcu_addr = 683,
+	.shp_2_mcu_addr = 891,
+	.spdif_2_mcu_addr = 1100,
+	.mcu_2_spdif_addr = 1134,
+};
+
+static struct sdma_driver_data sdma_imx6sx = {
+	.chnenbl0 = SDMA_CHNENBL0_IMX35,
+	.num_events = 48,
+	.script_addrs = &sdma_script_imx6sx,
+};
+
+static struct sdma_driver_data sdma_imx6ul = {
+	.chnenbl0 = SDMA_CHNENBL0_IMX35,
+	.num_events = 48,
+	.script_addrs = &sdma_script_imx6sx,
+	.ecspi_fixed = true,
+};
+
 static struct sdma_script_start_addrs sdma_script_imx7d = {
 	.ap_2_ap_addr = 644,
 	.uart_2_mcu_addr = 819,
@@ -584,9 +616,15 @@ static const struct platform_device_id sdma_devtypes[] = {
 		.name = "imx6q-sdma",
 		.driver_data = (unsigned long)&sdma_imx6q,
 	}, {
+		.name = "imx6sx-sdma",
+		.driver_data = (unsigned long)&sdma_imx6sx,
+	}, {
 		.name = "imx7d-sdma",
 		.driver_data = (unsigned long)&sdma_imx7d,
 	}, {
+		.name = "imx6ul-sdma",
+		.driver_data = (unsigned long)&sdma_imx6ul,
+	}, {
 		.name = "imx8mq-sdma",
 		.driver_data = (unsigned long)&sdma_imx8mq,
 	}, {
@@ -602,7 +640,9 @@ static const struct of_device_id sdma_dt_ids[] = {
 	{ .compatible = "fsl,imx35-sdma", .data = &sdma_imx35, },
 	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
 	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
+	{ .compatible = "fsl,imx6sx-sdma", .data = &sdma_imx6sx, },
 	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
+	{ .compatible = "fsl,imx6ul-sdma", .data = &sdma_imx6ul, },
 	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx8mq, },
 	{ /* sentinel */ }
 };
@@ -1166,8 +1206,17 @@ static int sdma_config_channel(struct dma_chan *chan)
 			if (sdmac->peripheral_type == IMX_DMATYPE_ASRC_SP ||
 			    sdmac->peripheral_type == IMX_DMATYPE_ASRC)
 				sdma_set_watermarklevel_for_p2p(sdmac);
-		} else
+		} else {
+			/*
+			 * ERR009165 fixed from i.mx6ul, no errata need,
+			 * set bit31 to let sdma script skip the errata.
+			 */
+			if (sdmac->peripheral_type == IMX_DMATYPE_CSPI &&
+			    sdmac->direction == DMA_MEM_TO_DEV &&
+			    sdmac->sdma->drvdata->ecspi_fixed)
+				__set_bit(31, &sdmac->watermark_level);
 			__set_bit(sdmac->event_id0, sdmac->event_mask);
+		}
 
 		/* Address */
 		sdmac->shp_addr = sdmac->per_address;
-- 
2.7.4

