Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D284E955A
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 13:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241388AbiC1Ll1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 07:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243563AbiC1Lgi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 07:36:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB45DF97
        for <dmaengine@vger.kernel.org>; Mon, 28 Mar 2022 04:28:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nYnXj-0003Tb-5d; Mon, 28 Mar 2022 13:28:15 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nYnXf-003Zlt-Bt; Mon, 28 Mar 2022 13:28:14 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nYnXd-006byi-Ib; Mon, 28 Mar 2022 13:28:09 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     alsa-devel@alsa-project.org
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 10/19] dma: imx-sdma: Add multi fifo support
Date:   Mon, 28 Mar 2022 13:27:35 +0200
Message-Id: <20220328112744.1575631-11-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220328112744.1575631-1-s.hauer@pengutronix.de>
References: <20220328112744.1575631-1-s.hauer@pengutronix.de>
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

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

Notes:
    Changes since v1:
    - Drop unused variable sw_done_sel
    - Evaluate sdmac->direction directly instead of storing value in n_fifos

 drivers/dma/imx-sdma.c                | 57 +++++++++++++++++++++++++++
 include/linux/platform_data/dma-imx.h |  7 ++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 1038f6bc7f846..f08c409231b7b 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -14,6 +14,7 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
@@ -73,6 +74,7 @@
 #define SDMA_CHNENBL0_IMX35	0x200
 #define SDMA_CHNENBL0_IMX31	0x080
 #define SDMA_CHNPRI_0		0x100
+#define SDMA_DONE0_CONFIG	0x1000
 
 /*
  * Buffer descriptor status values.
@@ -180,6 +182,12 @@
 				 BIT(DMA_MEM_TO_DEV) | \
 				 BIT(DMA_DEV_TO_DEV))
 
+#define SDMA_WATERMARK_LEVEL_N_FIFOS	GENMASK(15, 12)
+#define SDMA_WATERMARK_LEVEL_SW_DONE	BIT(23)
+
+#define SDMA_DONE0_CONFIG_DONE_SEL	BIT(7)
+#define SDMA_DONE0_CONFIG_DONE_DIS	BIT(6)
+
 /**
  * struct sdma_script_start_addrs - SDMA script start pointers
  *
@@ -441,6 +449,9 @@ struct sdma_channel {
 	struct work_struct		terminate_worker;
 	struct list_head                terminated;
 	bool				is_ram_script;
+	unsigned int			n_fifos_src;
+	unsigned int			n_fifos_dst;
+	bool				sw_done;
 };
 
 #define IMX_DMA_SG_LOOP		BIT(0)
@@ -773,6 +784,14 @@ static void sdma_event_enable(struct sdma_channel *sdmac, unsigned int event)
 	val = readl_relaxed(sdma->regs + chnenbl);
 	__set_bit(channel, &val);
 	writel_relaxed(val, sdma->regs + chnenbl);
+
+	/* Set SDMA_DONEx_CONFIG is sw_done enabled */
+	if (sdmac->sw_done) {
+		val = readl_relaxed(sdma->regs + SDMA_DONE0_CONFIG);
+		val |= SDMA_DONE0_CONFIG_DONE_SEL;
+		val &= ~SDMA_DONE0_CONFIG_DONE_DIS;
+		writel_relaxed(val, sdma->regs + SDMA_DONE0_CONFIG);
+	}
 }
 
 static void sdma_event_disable(struct sdma_channel *sdmac, unsigned int event)
@@ -1022,6 +1041,10 @@ static int sdma_get_pc(struct sdma_channel *sdmac,
 	case IMX_DMATYPE_IPU_MEMORY:
 		emi_2_per = sdma->script_addrs->ext_mem_2_ipu_addr;
 		break;
+	case IMX_DMATYPE_MULTI_SAI:
+		per_2_emi = sdma->script_addrs->sai_2_mcu_addr;
+		emi_2_per = sdma->script_addrs->mcu_2_sai_addr;
+		break;
 	default:
 		dev_err(sdma->dev, "Unsupported transfer type %d\n",
 			peripheral_type);
@@ -1198,6 +1221,22 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 	sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_CONT;
 }
 
+static void sdma_set_watermarklevel_for_sais(struct sdma_channel *sdmac)
+{
+	unsigned int n_fifos;
+
+	if (sdmac->sw_done)
+		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_SW_DONE;
+
+	if (sdmac->direction == DMA_DEV_TO_MEM)
+		n_fifos = sdmac->n_fifos_src;
+	else
+		n_fifos = sdmac->n_fifos_dst;
+
+	sdmac->watermark_level |=
+			FIELD_PREP(SDMA_WATERMARK_LEVEL_N_FIFOS, n_fifos);
+}
+
 static int sdma_config_channel(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
@@ -1234,6 +1273,10 @@ static int sdma_config_channel(struct dma_chan *chan)
 			    sdmac->peripheral_type == IMX_DMATYPE_ASRC)
 				sdma_set_watermarklevel_for_p2p(sdmac);
 		} else {
+			if (sdmac->peripheral_type ==
+					IMX_DMATYPE_MULTI_SAI)
+				sdma_set_watermarklevel_for_sais(sdmac);
+
 			__set_bit(sdmac->event_id0, sdmac->event_mask);
 		}
 
@@ -1691,9 +1734,23 @@ static int sdma_config(struct dma_chan *chan,
 		       struct dma_slave_config *dmaengine_cfg)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	struct sdma_engine *sdma = sdmac->sdma;
 
 	memcpy(&sdmac->slave_config, dmaengine_cfg, sizeof(*dmaengine_cfg));
 
+	if (dmaengine_cfg->peripheral_config) {
+		struct sdma_peripheral_config *sdmacfg = dmaengine_cfg->peripheral_config;
+		if (dmaengine_cfg->peripheral_size != sizeof(struct sdma_peripheral_config)) {
+			dev_err(sdma->dev, "Invalid peripheral size %zu, expected %zu\n",
+				dmaengine_cfg->peripheral_size,
+				sizeof(struct sdma_peripheral_config));
+			return -EINVAL;
+		}
+		sdmac->n_fifos_src = sdmacfg->n_fifos_src;
+		sdmac->n_fifos_dst = sdmacfg->n_fifos_dst;
+		sdmac->sw_done = sdmacfg->sw_done;
+	}
+
 	/* Set ENBLn earlier to make sure dma request triggered after that */
 	if (sdmac->event_id0 >= sdmac->sdma->drvdata->num_events)
 		return -EINVAL;
diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
index 281adbb26e6bd..4a43a048e1b4d 100644
--- a/include/linux/platform_data/dma-imx.h
+++ b/include/linux/platform_data/dma-imx.h
@@ -39,6 +39,7 @@ enum sdma_peripheral_type {
 	IMX_DMATYPE_SSI_DUAL,	/* SSI Dual FIFO */
 	IMX_DMATYPE_ASRC_SP,	/* Shared ASRC */
 	IMX_DMATYPE_SAI,	/* SAI */
+	IMX_DMATYPE_MULTI_SAI,	/* MULTI FIFOs For Audio */
 };
 
 enum imx_dma_prio {
@@ -65,4 +66,10 @@ static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
 		!strcmp(chan->device->dev->driver->name, "imx-dma");
 }
 
+struct sdma_peripheral_config {
+	int n_fifos_src;
+	int n_fifos_dst;
+	bool sw_done;
+};
+
 #endif
-- 
2.30.2

