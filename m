Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0DD50191B
	for <lists+dmaengine@lfdr.de>; Thu, 14 Apr 2022 18:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbiDNQyM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 12:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239716AbiDNQyD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 12:54:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6F213CCE2
        for <dmaengine@vger.kernel.org>; Thu, 14 Apr 2022 09:22:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nf2FC-0007P6-C9; Thu, 14 Apr 2022 18:22:54 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nf2FC-00312c-UX; Thu, 14 Apr 2022 18:22:53 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nf2F9-00GuAJ-E8; Thu, 14 Apr 2022 18:22:51 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     alsa-devel@alsa-project.org
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v6 10/21] dmaengine: imx-sdma: error out on unsupported transfer types
Date:   Thu, 14 Apr 2022 18:22:38 +0200
Message-Id: <20220414162249.3934543-11-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220414162249.3934543-1-s.hauer@pengutronix.de>
References: <20220414162249.3934543-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The i.MX SDMA driver currently silently ignores unsupported transfer
types. These transfer types are specified in the dma channel description
in the device tree, so they should really be checked.
Issue a message and error out when we hit unsupported transfer types.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-By: Vinod Koul <vkoul@kernel.org>
---

Notes:
    Changes since v2:
    - Use prefix dmaengine:

 drivers/dma/imx-sdma.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 80261a905eb5b..0e70843567cef 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -940,7 +940,7 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
 /*
  * sets the pc of SDMA script according to the peripheral type
  */
-static void sdma_get_pc(struct sdma_channel *sdmac,
+static int sdma_get_pc(struct sdma_channel *sdmac,
 		enum sdma_peripheral_type peripheral_type)
 {
 	struct sdma_engine *sdma = sdmac->sdma;
@@ -1039,13 +1039,17 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 		emi_2_per = sdma->script_addrs->ext_mem_2_ipu_addr;
 		break;
 	default:
-		break;
+		dev_err(sdma->dev, "Unsupported transfer type %d\n",
+			peripheral_type);
+		return -EINVAL;
 	}
 
 	sdmac->pc_from_device = per_2_emi;
 	sdmac->pc_to_device = emi_2_per;
 	sdmac->device_to_device = per_2_per;
 	sdmac->pc_to_pc = emi_2_emi;
+
+	return 0;
 }
 
 static int sdma_load_context(struct sdma_channel *sdmac)
@@ -1213,6 +1217,7 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 static int sdma_config_channel(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	int ret;
 
 	sdma_disable_channel(chan);
 
@@ -1233,7 +1238,9 @@ static int sdma_config_channel(struct dma_chan *chan)
 		break;
 	}
 
-	sdma_get_pc(sdmac, sdmac->peripheral_type);
+	ret = sdma_get_pc(sdmac, sdmac->peripheral_type);
+	if (ret)
+		return ret;
 
 	if ((sdmac->peripheral_type != IMX_DMATYPE_MEMORY) &&
 			(sdmac->peripheral_type != IMX_DMATYPE_DSP)) {
@@ -1349,7 +1356,9 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 		mem_data.dma_request2 = 0;
 		data = &mem_data;
 
-		sdma_get_pc(sdmac, IMX_DMATYPE_MEMORY);
+		ret = sdma_get_pc(sdmac, IMX_DMATYPE_MEMORY);
+		if (ret)
+			return ret;
 	}
 
 	switch (data->priority) {
-- 
2.30.2

