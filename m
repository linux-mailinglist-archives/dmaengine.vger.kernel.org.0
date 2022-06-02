Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F44E53B693
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jun 2022 12:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbiFBKHa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jun 2022 06:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiFBKH3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Jun 2022 06:07:29 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96391D05B9;
        Thu,  2 Jun 2022 03:07:26 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 873F92014FE;
        Thu,  2 Jun 2022 12:07:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 266212014FA;
        Thu,  2 Jun 2022 12:07:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A7531180031F;
        Thu,  2 Jun 2022 18:07:23 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, shengjiu.wang@gmail.com,
        joy.zou@nxp.com, linux-imx@nxp.com, dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma: imx-sdma: Add FIFO offset support for multi FIFO script
Date:   Thu,  2 Jun 2022 17:53:47 +0800
Message-Id: <1654163627-30836-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The peripheral may have several FIFOs, but some case just select
some FIFOs from them for data transfer, which means FIFO0 and FIFO2
may be selected. So add FIFO address offset support, 0 means all FIFOs
are continuous, 1 means 1 word offset between FIFOs. All offset between
FIFOs should be same.

Another option words_per_fifo means how many audio channel data copied
to one FIFO one time, 0 means one channel per FIFO, 1 means 2 channels
per FIFO.

If 'n_fifos_src =  4' and 'words_per_fifo = 1', it means the first two
words(channels) fetch from FIFO0 and then jump to FIFO1 for next two words,
and so on after the last FIFO3 fetched, roll back to FIFO0.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/dma/imx-sdma.c      | 26 ++++++++++++++++++++++++--
 include/linux/dma/imx-dma.h | 13 +++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 111beb7138e0..3c95719286bc 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -183,6 +183,8 @@
 				 BIT(DMA_DEV_TO_DEV))
 
 #define SDMA_WATERMARK_LEVEL_N_FIFOS	GENMASK(15, 12)
+#define SDMA_WATERMARK_LEVEL_OFF_FIFOS  GENMASK(19, 16)
+#define SDMA_WATERMARK_LEVEL_WORDS_PER_FIFO   GENMASK(31, 28)
 #define SDMA_WATERMARK_LEVEL_SW_DONE	BIT(23)
 
 #define SDMA_DONE0_CONFIG_DONE_SEL	BIT(7)
@@ -429,6 +431,9 @@ struct sdma_desc {
  * @n_fifos_src:	number of source device fifos
  * @n_fifos_dst:	number of destination device fifos
  * @sw_done:		software done flag
+ * @off_fifos_src:	offset for source device FIFOs
+ * @off_fifos_dst:	offset for destination device FIFOs
+ * @words_per_fifo:	copy number of words one time for one FIFO
  */
 struct sdma_channel {
 	struct virt_dma_chan		vc;
@@ -456,6 +461,9 @@ struct sdma_channel {
 	bool				is_ram_script;
 	unsigned int			n_fifos_src;
 	unsigned int			n_fifos_dst;
+	unsigned int			off_fifos_src;
+	unsigned int			off_fifos_dst;
+	unsigned int			words_per_fifo;
 	bool				sw_done;
 };
 
@@ -1245,17 +1253,28 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 static void sdma_set_watermarklevel_for_sais(struct sdma_channel *sdmac)
 {
 	unsigned int n_fifos;
+	unsigned int off_fifos;
+	unsigned int words_per_fifo;
 
 	if (sdmac->sw_done)
 		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_SW_DONE;
 
-	if (sdmac->direction == DMA_DEV_TO_MEM)
+	if (sdmac->direction == DMA_DEV_TO_MEM) {
 		n_fifos = sdmac->n_fifos_src;
-	else
+		off_fifos = sdmac->off_fifos_src;
+	} else {
 		n_fifos = sdmac->n_fifos_dst;
+		off_fifos = sdmac->off_fifos_dst;
+	}
+
+	words_per_fifo = sdmac->words_per_fifo;
 
 	sdmac->watermark_level |=
 			FIELD_PREP(SDMA_WATERMARK_LEVEL_N_FIFOS, n_fifos);
+	sdmac->watermark_level |=
+			FIELD_PREP(SDMA_WATERMARK_LEVEL_OFF_FIFOS, off_fifos);
+	sdmac->watermark_level |=
+			FIELD_PREP(SDMA_WATERMARK_LEVEL_WORDS_PER_FIFO, (words_per_fifo - 1));
 }
 
 static int sdma_config_channel(struct dma_chan *chan)
@@ -1769,6 +1788,9 @@ static int sdma_config(struct dma_chan *chan,
 		}
 		sdmac->n_fifos_src = sdmacfg->n_fifos_src;
 		sdmac->n_fifos_dst = sdmacfg->n_fifos_dst;
+		sdmac->off_fifos_src = sdmacfg->off_fifos_src;
+		sdmac->off_fifos_dst = sdmacfg->off_fifos_dst;
+		sdmac->words_per_fifo = sdmacfg->words_per_fifo;
 		sdmac->sw_done = sdmacfg->sw_done;
 	}
 
diff --git a/include/linux/dma/imx-dma.h b/include/linux/dma/imx-dma.h
index 8887762360d4..0c739d571956 100644
--- a/include/linux/dma/imx-dma.h
+++ b/include/linux/dma/imx-dma.h
@@ -70,6 +70,16 @@ static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
  * struct sdma_peripheral_config - SDMA config for audio
  * @n_fifos_src: Number of FIFOs for recording
  * @n_fifos_dst: Number of FIFOs for playback
+ * @off_fifos_src: FIFO address offset for recording, 0 means all FIFOs are
+ *                 continuous, 1 means 1 word offset between FIFOs. All offset
+ *                 between FIFOs should be same.
+ * @off_fifos_dst: FIFO address offset for playback
+ * @words_per_fifo: numbers of words per FIFO fetch/fill, 0 means
+ *                  one channel per FIFO, 1 means 2 channels per FIFO..
+ *                  If 'n_fifos_src =  4' and 'words_per_fifo = 1', it
+ *                  means the first two words(channels) fetch from FIFO0
+ *                  and then jump to FIFO1 for next two words, and so on
+ *                  after the last FIFO3 fetched, roll back to FIFO0.
  * @sw_done: Use software done. Needed for PDM (micfil)
  *
  * Some i.MX Audio devices (SAI, micfil) have multiple successive FIFO
@@ -82,6 +92,9 @@ static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
 struct sdma_peripheral_config {
 	int n_fifos_src;
 	int n_fifos_dst;
+	int off_fifos_src;
+	int off_fifos_dst;
+	int words_per_fifo;
 	bool sw_done;
 };
 
-- 
2.17.1

