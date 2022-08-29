Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF845A5081
	for <lists+dmaengine@lfdr.de>; Mon, 29 Aug 2022 17:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiH2Pr0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Aug 2022 11:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiH2PrZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Aug 2022 11:47:25 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C708990A;
        Mon, 29 Aug 2022 08:47:24 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TConQO019097;
        Mon, 29 Aug 2022 17:46:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=mk+HbX0tXEH4jLFUIcwhs7ti4fgYpEiZOT9i+s5ZYmY=;
 b=6HIDqMGrbYSbinRD5IfC7zxkMuBRkoOsYYmuLQ6VCW7CVam9U19GMW+1W7KpJQiWoXEn
 yThgSB/zu/tLVeWmrePMIBzyYOMC6TeXb978JqvclddgdqnFhoTvUd3XE9oWm3RwJRGi
 4P/OvTXculGAuieTOTlf9PkbyFPeKzpXUVYHI5L011c8eviqlBfOw0DozMz/v/Gp50ou
 amWN3jVUKNW50GZb5b9ciACIVUVgHtwoxHzmwonyuZwxOHEWOZjMndkqm3sK4PssS7+Z
 6658npOHi90rNCU3F4YdPSo7M82SCJDsgYjp6gp6GsUtvB+knGRLLVEszL18Lnex83Xz DA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3j78pk2r7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 17:46:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E121A100034;
        Mon, 29 Aug 2022 17:46:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D96BE236928;
        Mon, 29 Aug 2022 17:46:57 +0200 (CEST)
Received: from localhost (10.75.127.46) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.7; Mon, 29 Aug
 2022 17:46:57 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Jonathan Corbet <corbet@lwn.net>, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-doc@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [RESEND PATCH v3 1/6] dmaengine: stm32-dma: introduce 3 helpers to address channel flags
Date:   Mon, 29 Aug 2022 17:46:41 +0200
Message-ID: <20220829154646.29867-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829154646.29867-1-amelie.delaunay@foss.st.com>
References: <20220829154646.29867-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
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

Channels 0 to 3 flags are described in DMA_LISR and DMA_LIFCR (L as Low).
Channels 4 to 7 flags are described in DMA_HISR and DMA_HIFCR (H as High).
Macro STM32_DMA_ISR(n) returns the interrupt status register offset for the
channel id (n).
Macro STM32_DMA_IFCR(n) returns the interrupt flag clear register offset
for the channel id (n).

If chan->id % 4 = 2 or 3, then its flags are left-shifted by 16 bits.
If chan->id % 4 = 1 or 3, then its flags are additionally left-shifted by 6
bits.
If chan->id % 4 = 0, then its flags are not shifted.
Macro STM32_DMA_FLAGS_SHIFT(n) returns the required shift to get or set the
channel flags mask.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-dma.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index adb25a11c70f..5d67e168aaee 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -32,8 +32,10 @@
 
 #define STM32_DMA_LISR			0x0000 /* DMA Low Int Status Reg */
 #define STM32_DMA_HISR			0x0004 /* DMA High Int Status Reg */
+#define STM32_DMA_ISR(n)		(((n) & 4) ? STM32_DMA_HISR : STM32_DMA_LISR)
 #define STM32_DMA_LIFCR			0x0008 /* DMA Low Int Flag Clear Reg */
 #define STM32_DMA_HIFCR			0x000c /* DMA High Int Flag Clear Reg */
+#define STM32_DMA_IFCR(n)		(((n) & 4) ? STM32_DMA_HIFCR : STM32_DMA_LIFCR)
 #define STM32_DMA_TCI			BIT(5) /* Transfer Complete Interrupt */
 #define STM32_DMA_HTI			BIT(4) /* Half Transfer Interrupt */
 #define STM32_DMA_TEI			BIT(3) /* Transfer Error Interrupt */
@@ -43,6 +45,12 @@
 					 | STM32_DMA_TEI \
 					 | STM32_DMA_DMEI \
 					 | STM32_DMA_FEI)
+/*
+ * If (chan->id % 4) is 2 or 3, left shift the mask by 16 bits;
+ * if (ch % 4) is 1 or 3, additionally left shift the mask by 6 bits.
+ */
+#define STM32_DMA_FLAGS_SHIFT(n)	({ typeof(n) (_n) = (n); \
+					   (((_n) & 2) << 3) | (((_n) & 1) * 6); })
 
 /* DMA Stream x Configuration Register */
 #define STM32_DMA_SCR(x)		(0x0010 + 0x18 * (x)) /* x = 0..7 */
@@ -401,17 +409,10 @@ static u32 stm32_dma_irq_status(struct stm32_dma_chan *chan)
 	/*
 	 * Read "flags" from DMA_xISR register corresponding to the selected
 	 * DMA channel at the correct bit offset inside that register.
-	 *
-	 * If (ch % 4) is 2 or 3, left shift the mask by 16 bits.
-	 * If (ch % 4) is 1 or 3, additionally left shift the mask by 6 bits.
 	 */
 
-	if (chan->id & 4)
-		dma_isr = stm32_dma_read(dmadev, STM32_DMA_HISR);
-	else
-		dma_isr = stm32_dma_read(dmadev, STM32_DMA_LISR);
-
-	flags = dma_isr >> (((chan->id & 2) << 3) | ((chan->id & 1) * 6));
+	dma_isr = stm32_dma_read(dmadev, STM32_DMA_ISR(chan->id));
+	flags = dma_isr >> STM32_DMA_FLAGS_SHIFT(chan->id);
 
 	return flags & STM32_DMA_MASKI;
 }
@@ -424,17 +425,11 @@ static void stm32_dma_irq_clear(struct stm32_dma_chan *chan, u32 flags)
 	/*
 	 * Write "flags" to the DMA_xIFCR register corresponding to the selected
 	 * DMA channel at the correct bit offset inside that register.
-	 *
-	 * If (ch % 4) is 2 or 3, left shift the mask by 16 bits.
-	 * If (ch % 4) is 1 or 3, additionally left shift the mask by 6 bits.
 	 */
 	flags &= STM32_DMA_MASKI;
-	dma_ifcr = flags << (((chan->id & 2) << 3) | ((chan->id & 1) * 6));
+	dma_ifcr = flags << STM32_DMA_FLAGS_SHIFT(chan->id);
 
-	if (chan->id & 4)
-		stm32_dma_write(dmadev, STM32_DMA_HIFCR, dma_ifcr);
-	else
-		stm32_dma_write(dmadev, STM32_DMA_LIFCR, dma_ifcr);
+	stm32_dma_write(dmadev, STM32_DMA_IFCR(chan->id), dma_ifcr);
 }
 
 static int stm32_dma_disable_chan(struct stm32_dma_chan *chan)
-- 
2.25.1

