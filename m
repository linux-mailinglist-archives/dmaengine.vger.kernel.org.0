Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B9C5A507B
	for <lists+dmaengine@lfdr.de>; Mon, 29 Aug 2022 17:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiH2PrX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Aug 2022 11:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiH2PrV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Aug 2022 11:47:21 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C8C88DF0;
        Mon, 29 Aug 2022 08:47:19 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TCiOtS016605;
        Mon, 29 Aug 2022 17:46:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=v8wc07A8hSAxt7WcUKG6F00J8yif2Tg5BD46hVVaF8s=;
 b=H2cyF8RCsdyqoBryi4wE8RhhuDofembeSjSmrZfv2sVn1BNlhwji6KvB97A+iu1gZ6lM
 ILfKpQTfaaTVXCJ5yd8XvW/YeoBDuc5aMQ8yLSWF13796WjOgxULMBM1kz7NN7Y5SAuV
 QvF5yZXSFNPg0ROE2tRXh/L3fbInCGwtSLZFbqGjLGuKlJf8QzL5K2FK0lvqhCCza8G2
 Wha0eB0CafvpPQ22PtmYiyYqJ1ec9cw9WnS7GIAxTUwvyhkc4NzNxcWyQujDQ9kL9kHR
 dalMC/qjZprByF051srw73lD+BVUTXuJ8dFmm6CL1RZE6bLYKANh1wBJ2Xci8iQ0RzY5 9w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3j7a5htmx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 17:46:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1350910003E;
        Mon, 29 Aug 2022 17:46:59 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0E686236928;
        Mon, 29 Aug 2022 17:46:59 +0200 (CEST)
Received: from localhost (10.75.127.116) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.7; Mon, 29 Aug
 2022 17:46:58 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Jonathan Corbet <corbet@lwn.net>, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-doc@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [RESEND PATCH v3 2/6] dmaengine: stm32-dma: use bitfield helpers
Date:   Mon, 29 Aug 2022 17:46:42 +0200
Message-ID: <20220829154646.29867-3-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829154646.29867-1-amelie.delaunay@foss.st.com>
References: <20220829154646.29867-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.116]
X-ClientProxiedBy: GPXDAG2NODE5.st.com (10.75.127.69) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_07,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use the FIELD_{GET,PREP}() helpers, instead of defining custom macros
implementing the same operations.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-dma.c | 60 +++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 35 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 5d67e168aaee..6aa281561f38 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -9,6 +9,7 @@
  *         Pierre-Yves Mordret <pierre-yves.mordret@st.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
@@ -54,20 +55,13 @@
 
 /* DMA Stream x Configuration Register */
 #define STM32_DMA_SCR(x)		(0x0010 + 0x18 * (x)) /* x = 0..7 */
-#define STM32_DMA_SCR_REQ(n)		((n & 0x7) << 25)
+#define STM32_DMA_SCR_REQ_MASK		GENMASK(27, 25)
 #define STM32_DMA_SCR_MBURST_MASK	GENMASK(24, 23)
-#define STM32_DMA_SCR_MBURST(n)	        ((n & 0x3) << 23)
 #define STM32_DMA_SCR_PBURST_MASK	GENMASK(22, 21)
-#define STM32_DMA_SCR_PBURST(n)	        ((n & 0x3) << 21)
 #define STM32_DMA_SCR_PL_MASK		GENMASK(17, 16)
-#define STM32_DMA_SCR_PL(n)		((n & 0x3) << 16)
 #define STM32_DMA_SCR_MSIZE_MASK	GENMASK(14, 13)
-#define STM32_DMA_SCR_MSIZE(n)		((n & 0x3) << 13)
 #define STM32_DMA_SCR_PSIZE_MASK	GENMASK(12, 11)
-#define STM32_DMA_SCR_PSIZE(n)		((n & 0x3) << 11)
-#define STM32_DMA_SCR_PSIZE_GET(n)	((n & STM32_DMA_SCR_PSIZE_MASK) >> 11)
 #define STM32_DMA_SCR_DIR_MASK		GENMASK(7, 6)
-#define STM32_DMA_SCR_DIR(n)		((n & 0x3) << 6)
 #define STM32_DMA_SCR_TRBUFF		BIT(20) /* Bufferable transfer for USART/UART */
 #define STM32_DMA_SCR_CT		BIT(19) /* Target in double buffer */
 #define STM32_DMA_SCR_DBM		BIT(18) /* Double Buffer Mode */
@@ -104,7 +98,6 @@
 /* DMA stream x FIFO control register */
 #define STM32_DMA_SFCR(x)		(0x0024 + 0x18 * (x))
 #define STM32_DMA_SFCR_FTH_MASK		GENMASK(1, 0)
-#define STM32_DMA_SFCR_FTH(n)		(n & STM32_DMA_SFCR_FTH_MASK)
 #define STM32_DMA_SFCR_FEIE		BIT(7) /* FIFO error interrupt enable */
 #define STM32_DMA_SFCR_DMDIS		BIT(2) /* Direct mode disable */
 #define STM32_DMA_SFCR_MASK		(STM32_DMA_SFCR_FEIE \
@@ -145,11 +138,8 @@
 
 /* DMA Features */
 #define STM32_DMA_THRESHOLD_FTR_MASK	GENMASK(1, 0)
-#define STM32_DMA_THRESHOLD_FTR_GET(n)	((n) & STM32_DMA_THRESHOLD_FTR_MASK)
 #define STM32_DMA_DIRECT_MODE_MASK	BIT(2)
-#define STM32_DMA_DIRECT_MODE_GET(n)	(((n) & STM32_DMA_DIRECT_MODE_MASK) >> 2)
 #define STM32_DMA_ALT_ACK_MODE_MASK	BIT(4)
-#define STM32_DMA_ALT_ACK_MODE_GET(n)	(((n) & STM32_DMA_ALT_ACK_MODE_MASK) >> 4)
 
 enum stm32_dma_width {
 	STM32_DMA_BYTE,
@@ -856,7 +846,8 @@ static int stm32_dma_resume(struct dma_chan *c)
 		sg_req = &chan->desc->sg_req[chan->next_sg - 1];
 
 	ndtr = sg_req->chan_reg.dma_sndtr;
-	offset = (ndtr - chan_reg.dma_sndtr) << STM32_DMA_SCR_PSIZE_GET(chan_reg.dma_scr);
+	offset = (ndtr - chan_reg.dma_sndtr);
+	offset <<= FIELD_GET(STM32_DMA_SCR_PSIZE_MASK, chan_reg.dma_scr);
 	spar = sg_req->chan_reg.dma_spar;
 	sm0ar = sg_req->chan_reg.dma_sm0ar;
 	sm1ar = sg_req->chan_reg.dma_sm1ar;
@@ -968,16 +959,16 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 		if (src_burst_size < 0)
 			return src_burst_size;
 
-		dma_scr = STM32_DMA_SCR_DIR(STM32_DMA_MEM_TO_DEV) |
-			STM32_DMA_SCR_PSIZE(dst_bus_width) |
-			STM32_DMA_SCR_MSIZE(src_bus_width) |
-			STM32_DMA_SCR_PBURST(dst_burst_size) |
-			STM32_DMA_SCR_MBURST(src_burst_size);
+		dma_scr = FIELD_PREP(STM32_DMA_SCR_DIR_MASK, STM32_DMA_MEM_TO_DEV) |
+			FIELD_PREP(STM32_DMA_SCR_PSIZE_MASK, dst_bus_width) |
+			FIELD_PREP(STM32_DMA_SCR_MSIZE_MASK, src_bus_width) |
+			FIELD_PREP(STM32_DMA_SCR_PBURST_MASK, dst_burst_size) |
+			FIELD_PREP(STM32_DMA_SCR_MBURST_MASK, src_burst_size);
 
 		/* Set FIFO threshold */
 		chan->chan_reg.dma_sfcr &= ~STM32_DMA_SFCR_FTH_MASK;
 		if (fifoth != STM32_DMA_FIFO_THRESHOLD_NONE)
-			chan->chan_reg.dma_sfcr |= STM32_DMA_SFCR_FTH(fifoth);
+			chan->chan_reg.dma_sfcr |= FIELD_PREP(STM32_DMA_SFCR_FTH_MASK, fifoth);
 
 		/* Set peripheral address */
 		chan->chan_reg.dma_spar = chan->dma_sconfig.dst_addr;
@@ -1025,16 +1016,16 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 		if (dst_burst_size < 0)
 			return dst_burst_size;
 
-		dma_scr = STM32_DMA_SCR_DIR(STM32_DMA_DEV_TO_MEM) |
-			STM32_DMA_SCR_PSIZE(src_bus_width) |
-			STM32_DMA_SCR_MSIZE(dst_bus_width) |
-			STM32_DMA_SCR_PBURST(src_burst_size) |
-			STM32_DMA_SCR_MBURST(dst_burst_size);
+		dma_scr = FIELD_PREP(STM32_DMA_SCR_DIR_MASK, STM32_DMA_DEV_TO_MEM) |
+			FIELD_PREP(STM32_DMA_SCR_PSIZE_MASK, src_bus_width) |
+			FIELD_PREP(STM32_DMA_SCR_MSIZE_MASK, dst_bus_width) |
+			FIELD_PREP(STM32_DMA_SCR_PBURST_MASK, src_burst_size) |
+			FIELD_PREP(STM32_DMA_SCR_MBURST_MASK, dst_burst_size);
 
 		/* Set FIFO threshold */
 		chan->chan_reg.dma_sfcr &= ~STM32_DMA_SFCR_FTH_MASK;
 		if (fifoth != STM32_DMA_FIFO_THRESHOLD_NONE)
-			chan->chan_reg.dma_sfcr |= STM32_DMA_SFCR_FTH(fifoth);
+			chan->chan_reg.dma_sfcr |= FIELD_PREP(STM32_DMA_SFCR_FTH_MASK, fifoth);
 
 		/* Set peripheral address */
 		chan->chan_reg.dma_spar = chan->dma_sconfig.src_addr;
@@ -1242,16 +1233,15 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
 
 		stm32_dma_clear_reg(&desc->sg_req[i].chan_reg);
 		desc->sg_req[i].chan_reg.dma_scr =
-			STM32_DMA_SCR_DIR(STM32_DMA_MEM_TO_MEM) |
-			STM32_DMA_SCR_PBURST(dma_burst) |
-			STM32_DMA_SCR_MBURST(dma_burst) |
+			FIELD_PREP(STM32_DMA_SCR_DIR_MASK, STM32_DMA_MEM_TO_MEM) |
+			FIELD_PREP(STM32_DMA_SCR_PBURST_MASK, dma_burst) |
+			FIELD_PREP(STM32_DMA_SCR_MBURST_MASK, dma_burst) |
 			STM32_DMA_SCR_MINC |
 			STM32_DMA_SCR_PINC |
 			STM32_DMA_SCR_TCIE |
 			STM32_DMA_SCR_TEIE;
 		desc->sg_req[i].chan_reg.dma_sfcr |= STM32_DMA_SFCR_MASK;
-		desc->sg_req[i].chan_reg.dma_sfcr |=
-			STM32_DMA_SFCR_FTH(threshold);
+		desc->sg_req[i].chan_reg.dma_sfcr |= FIELD_PREP(STM32_DMA_SFCR_FTH_MASK, threshold);
 		desc->sg_req[i].chan_reg.dma_spar = src + offset;
 		desc->sg_req[i].chan_reg.dma_sm0ar = dest + offset;
 		desc->sg_req[i].chan_reg.dma_sndtr = xfer_count;
@@ -1270,7 +1260,7 @@ static u32 stm32_dma_get_remaining_bytes(struct stm32_dma_chan *chan)
 	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
 
 	dma_scr = stm32_dma_read(dmadev, STM32_DMA_SCR(chan->id));
-	width = STM32_DMA_SCR_PSIZE_GET(dma_scr);
+	width = FIELD_GET(STM32_DMA_SCR_PSIZE_MASK, dma_scr);
 	ndtr = stm32_dma_read(dmadev, STM32_DMA_SNDTR(chan->id));
 
 	return ndtr << width;
@@ -1476,15 +1466,15 @@ static void stm32_dma_set_config(struct stm32_dma_chan *chan,
 	stm32_dma_clear_reg(&chan->chan_reg);
 
 	chan->chan_reg.dma_scr = cfg->stream_config & STM32_DMA_SCR_CFG_MASK;
-	chan->chan_reg.dma_scr |= STM32_DMA_SCR_REQ(cfg->request_line);
+	chan->chan_reg.dma_scr |= FIELD_PREP(STM32_DMA_SCR_REQ_MASK, cfg->request_line);
 
 	/* Enable Interrupts  */
 	chan->chan_reg.dma_scr |= STM32_DMA_SCR_TEIE | STM32_DMA_SCR_TCIE;
 
-	chan->threshold = STM32_DMA_THRESHOLD_FTR_GET(cfg->features);
-	if (STM32_DMA_DIRECT_MODE_GET(cfg->features))
+	chan->threshold = FIELD_GET(STM32_DMA_THRESHOLD_FTR_MASK, cfg->features);
+	if (FIELD_GET(STM32_DMA_DIRECT_MODE_MASK, cfg->features))
 		chan->threshold = STM32_DMA_FIFO_THRESHOLD_NONE;
-	if (STM32_DMA_ALT_ACK_MODE_GET(cfg->features))
+	if (FIELD_GET(STM32_DMA_ALT_ACK_MODE_MASK, cfg->features))
 		chan->chan_reg.dma_scr |= STM32_DMA_SCR_TRBUFF;
 }
 
-- 
2.25.1

