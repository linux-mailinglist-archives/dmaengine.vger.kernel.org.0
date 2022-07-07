Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EE05698B0
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jul 2022 05:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiGGDPo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 23:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiGGDPn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 23:15:43 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503413057A;
        Wed,  6 Jul 2022 20:15:42 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F1DA6201055;
        Thu,  7 Jul 2022 05:15:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8AB95201056;
        Thu,  7 Jul 2022 05:15:40 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1F700180222C;
        Thu,  7 Jul 2022 11:15:39 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, shengjiu.wang@gmail.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3] dmaengine: imx-sdma: Add FIFO stride support for multi FIFO script
Date:   Thu,  7 Jul 2022 11:00:29 +0800
Message-Id: <1657162829-9273-1-git-send-email-shengjiu.wang@nxp.com>
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
may be selected. So add FIFO address stride support, 0 means all FIFOs
are continuous, 1 means 1 word stride between FIFOs. All stride between
FIFOs should be same.

Another option words_per_fifo means how many audio channel data copied
to one FIFO one time, 1 means one channel per FIFO, 2 means 2 channels
per FIFO.

If 'n_fifos_src =  4' and 'words_per_fifo = 2', it means the first two
words(channels) fetch from FIFO0 and then jump to FIFO1 for next two words,
and so on after the last FIFO3 fetched, roll back to FIFO0.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in RESEND v3
- It base on "01eafd4b2380 dmaengine: imx-sdma: Add missing struct documentation"
  rebase to latest dmaengine/next and resend

changes in v3
- fix issue with words_per_fifo = 0 case;

changes in v2
- change offset to stride for naming and description
- fix description for words_per_fifo
- update subsystem tag to be dmaengine

 drivers/dma/imx-sdma.c      | 27 +++++++++++++++++++++++++--
 include/linux/dma/imx-dma.h | 13 +++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 8a5d4d4a4dff..e302089784ed 100644
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
+ * @stride_fifos_src:	stride for source device FIFOs
+ * @stride_fifos_dst:	stride for destination device FIFOs
+ * @words_per_fifo:	copy number of words one time for one FIFO
  */
 struct sdma_channel {
 	struct virt_dma_chan		vc;
@@ -456,6 +461,9 @@ struct sdma_channel {
 	bool				is_ram_script;
 	unsigned int			n_fifos_src;
 	unsigned int			n_fifos_dst;
+	unsigned int			stride_fifos_src;
+	unsigned int			stride_fifos_dst;
+	unsigned int			words_per_fifo;
 	bool				sw_done;
 };
 
@@ -1245,17 +1253,29 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 static void sdma_set_watermarklevel_for_sais(struct sdma_channel *sdmac)
 {
 	unsigned int n_fifos;
+	unsigned int stride_fifos;
+	unsigned int words_per_fifo;
 
 	if (sdmac->sw_done)
 		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_SW_DONE;
 
-	if (sdmac->direction == DMA_DEV_TO_MEM)
+	if (sdmac->direction == DMA_DEV_TO_MEM) {
 		n_fifos = sdmac->n_fifos_src;
-	else
+		stride_fifos = sdmac->stride_fifos_src;
+	} else {
 		n_fifos = sdmac->n_fifos_dst;
+		stride_fifos = sdmac->stride_fifos_dst;
+	}
+
+	words_per_fifo = sdmac->words_per_fifo;
 
 	sdmac->watermark_level |=
 			FIELD_PREP(SDMA_WATERMARK_LEVEL_N_FIFOS, n_fifos);
+	sdmac->watermark_level |=
+			FIELD_PREP(SDMA_WATERMARK_LEVEL_OFF_FIFOS, stride_fifos);
+	if (words_per_fifo)
+		sdmac->watermark_level |=
+			FIELD_PREP(SDMA_WATERMARK_LEVEL_WORDS_PER_FIFO, (words_per_fifo - 1));
 }
 
 static int sdma_config_channel(struct dma_chan *chan)
@@ -1769,6 +1789,9 @@ static int sdma_config(struct dma_chan *chan,
 		}
 		sdmac->n_fifos_src = sdmacfg->n_fifos_src;
 		sdmac->n_fifos_dst = sdmacfg->n_fifos_dst;
+		sdmac->stride_fifos_src = sdmacfg->stride_fifos_src;
+		sdmac->stride_fifos_dst = sdmacfg->stride_fifos_dst;
+		sdmac->words_per_fifo = sdmacfg->words_per_fifo;
 		sdmac->sw_done = sdmacfg->sw_done;
 	}
 
diff --git a/include/linux/dma/imx-dma.h b/include/linux/dma/imx-dma.h
index 8887762360d4..f487a4fa103a 100644
--- a/include/linux/dma/imx-dma.h
+++ b/include/linux/dma/imx-dma.h
@@ -70,6 +70,16 @@ static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
  * struct sdma_peripheral_config - SDMA config for audio
  * @n_fifos_src: Number of FIFOs for recording
  * @n_fifos_dst: Number of FIFOs for playback
+ * @stride_fifos_src: FIFO address stride for recording, 0 means all FIFOs are
+ *                    continuous, 1 means 1 word stride between FIFOs. All stride
+ *                    between FIFOs should be same.
+ * @stride_fifos_dst: FIFO address stride for playback
+ * @words_per_fifo: numbers of words per FIFO fetch/fill, 1 means
+ *                  one channel per FIFO, 2 means 2 channels per FIFO..
+ *                  If 'n_fifos_src =  4' and 'words_per_fifo = 2', it
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
+	int stride_fifos_src;
+	int stride_fifos_dst;
+	int words_per_fifo;
 	bool sw_done;
 };
 
-- 
2.17.1

