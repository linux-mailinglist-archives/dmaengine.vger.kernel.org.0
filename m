Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1991B3EBA
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2020 12:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgDVKa4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Apr 2020 06:30:56 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56208 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730716AbgDVK32 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Apr 2020 06:29:28 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MASQZh005973;
        Wed, 22 Apr 2020 12:29:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=pPakesbqMo9f4f4O8z3p59FXSEQ2p5KiMoyTUXhVLRw=;
 b=AzOCimmihZLvoNlrJ1X13eePRNNu/IQNwX3v1f/NMAPJT+fHwCDPC3LtSxw3O+sbd4pW
 7nkDmJPIEclKreURFJfD00PFMnWj7FSuOB8uUOK3q2lkYnUSjlwCwvEh7JWjt2fRqTWN
 irYKPiVjPcuwu3jxfX6kIMvqewaIHNmVwkP7DpOguaRkk4OOnupQPDsFOgEHLP2as6Xz
 JD1/GqixWbmkK5d0d1oh8105RBZmxGhIR+CEKsxBZ+lm2XH2LT0yms/KsEGqBkuD/5xS
 jDOtcj1XXz7X7AkodG7lKDSuQltjXaUxgxt20ycZFTJ5DxWiXowSMtnkMh70PGXOal4Y 9w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fregnraa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 12:29:16 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E1E3910002A;
        Wed, 22 Apr 2020 12:29:15 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D33842A9560;
        Wed, 22 Apr 2020 12:29:15 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 22 Apr 2020 12:29:15
 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Pierre-Yves Mordret <pierre-yves.mordret@st.com>
Subject: [PATCH 2/2] dmaengine: stm32-dma: direct mode support through device tree
Date:   Wed, 22 Apr 2020 12:29:04 +0200
Message-ID: <20200422102904.1448-3-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422102904.1448-1-amelie.delaunay@st.com>
References: <20200422102904.1448-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_03:2020-04-22,2020-04-22 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Direct mode or FIFO mode is computed by stm32-dma driver. Add a way for
the user to force direct mode, by setting bit 2 in the bitfield value
specifying DMA features in the device tree.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/dma/stm32-dma.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 0ddbaa4b4f0b..96ad1b3d24c6 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -117,6 +117,7 @@
 #define STM32_DMA_FIFO_THRESHOLD_HALFFULL		0x01
 #define STM32_DMA_FIFO_THRESHOLD_3QUARTERSFULL		0x02
 #define STM32_DMA_FIFO_THRESHOLD_FULL			0x03
+#define STM32_DMA_FIFO_THRESHOLD_NONE			0x04
 
 #define STM32_DMA_MAX_DATA_ITEMS	0xffff
 /*
@@ -136,6 +137,9 @@
 /* DMA Features */
 #define STM32_DMA_THRESHOLD_FTR_MASK	GENMASK(1, 0)
 #define STM32_DMA_THRESHOLD_FTR_GET(n)	((n) & STM32_DMA_THRESHOLD_FTR_MASK)
+#define STM32_DMA_DIRECT_MODE_MASK	BIT(2)
+#define STM32_DMA_DIRECT_MODE_GET(n)	(((n) & STM32_DMA_DIRECT_MODE_MASK) \
+					 >> 2)
 
 enum stm32_dma_width {
 	STM32_DMA_BYTE,
@@ -281,6 +285,9 @@ static bool stm32_dma_fifo_threshold_is_allowed(u32 burst, u32 threshold,
 {
 	u32 remaining;
 
+	if (threshold == STM32_DMA_FIFO_THRESHOLD_NONE)
+		return false;
+
 	if (width != DMA_SLAVE_BUSWIDTH_UNDEFINED) {
 		if (burst != 0) {
 			/*
@@ -302,6 +309,10 @@ static bool stm32_dma_fifo_threshold_is_allowed(u32 burst, u32 threshold,
 
 static bool stm32_dma_is_burst_possible(u32 buf_len, u32 threshold)
 {
+	/* If FIFO direct mode, burst is not possible */
+	if (threshold == STM32_DMA_FIFO_THRESHOLD_NONE)
+		return false;
+
 	/*
 	 * Buffer or period length has to be aligned on FIFO depth.
 	 * Otherwise bytes may be stuck within FIFO at buffer or period
@@ -657,6 +668,12 @@ static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
 				dev_dbg(chan2dev(chan), "FIFO over/underrun\n");
 		}
 	}
+	if (status & STM32_DMA_DMEI) {
+		stm32_dma_irq_clear(chan, STM32_DMA_DMEI);
+		status &= ~STM32_DMA_DMEI;
+		if (sfcr & STM32_DMA_SCR_DMEIE)
+			dev_dbg(chan2dev(chan), "Direct mode overrun\n");
+	}
 	if (status) {
 		stm32_dma_irq_clear(chan, status);
 		dev_err(chan2dev(chan), "DMA error: status=0x%08x\n", status);
@@ -692,13 +709,13 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 	int src_bus_width, dst_bus_width;
 	int src_burst_size, dst_burst_size;
 	u32 src_maxburst, dst_maxburst, src_best_burst, dst_best_burst;
-	u32 dma_scr, threshold;
+	u32 dma_scr, fifoth;
 
 	src_addr_width = chan->dma_sconfig.src_addr_width;
 	dst_addr_width = chan->dma_sconfig.dst_addr_width;
 	src_maxburst = chan->dma_sconfig.src_maxburst;
 	dst_maxburst = chan->dma_sconfig.dst_maxburst;
-	threshold = chan->threshold;
+	fifoth = chan->threshold;
 
 	switch (direction) {
 	case DMA_MEM_TO_DEV:
@@ -710,7 +727,7 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 		/* Set device burst size */
 		dst_best_burst = stm32_dma_get_best_burst(buf_len,
 							  dst_maxburst,
-							  threshold,
+							  fifoth,
 							  dst_addr_width);
 
 		dst_burst_size = stm32_dma_get_burst(chan, dst_best_burst);
@@ -718,7 +735,7 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 			return dst_burst_size;
 
 		/* Set memory data size */
-		src_addr_width = stm32_dma_get_max_width(buf_len, threshold);
+		src_addr_width = stm32_dma_get_max_width(buf_len, fifoth);
 		chan->mem_width = src_addr_width;
 		src_bus_width = stm32_dma_get_width(chan, src_addr_width);
 		if (src_bus_width < 0)
@@ -728,7 +745,7 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 		src_maxburst = STM32_DMA_MAX_BURST;
 		src_best_burst = stm32_dma_get_best_burst(buf_len,
 							  src_maxburst,
-							  threshold,
+							  fifoth,
 							  src_addr_width);
 		src_burst_size = stm32_dma_get_burst(chan, src_best_burst);
 		if (src_burst_size < 0)
@@ -742,7 +759,8 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 
 		/* Set FIFO threshold */
 		chan->chan_reg.dma_sfcr &= ~STM32_DMA_SFCR_FTH_MASK;
-		chan->chan_reg.dma_sfcr |= STM32_DMA_SFCR_FTH(threshold);
+		if (fifoth != STM32_DMA_FIFO_THRESHOLD_NONE)
+			chan->chan_reg.dma_sfcr |= STM32_DMA_SFCR_FTH(fifoth);
 
 		/* Set peripheral address */
 		chan->chan_reg.dma_spar = chan->dma_sconfig.dst_addr;
@@ -758,7 +776,7 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 		/* Set device burst size */
 		src_best_burst = stm32_dma_get_best_burst(buf_len,
 							  src_maxburst,
-							  threshold,
+							  fifoth,
 							  src_addr_width);
 		chan->mem_burst = src_best_burst;
 		src_burst_size = stm32_dma_get_burst(chan, src_best_burst);
@@ -766,7 +784,7 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 			return src_burst_size;
 
 		/* Set memory data size */
-		dst_addr_width = stm32_dma_get_max_width(buf_len, threshold);
+		dst_addr_width = stm32_dma_get_max_width(buf_len, fifoth);
 		chan->mem_width = dst_addr_width;
 		dst_bus_width = stm32_dma_get_width(chan, dst_addr_width);
 		if (dst_bus_width < 0)
@@ -776,7 +794,7 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 		dst_maxburst = STM32_DMA_MAX_BURST;
 		dst_best_burst = stm32_dma_get_best_burst(buf_len,
 							  dst_maxburst,
-							  threshold,
+							  fifoth,
 							  dst_addr_width);
 		chan->mem_burst = dst_best_burst;
 		dst_burst_size = stm32_dma_get_burst(chan, dst_best_burst);
@@ -791,7 +809,8 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 
 		/* Set FIFO threshold */
 		chan->chan_reg.dma_sfcr &= ~STM32_DMA_SFCR_FTH_MASK;
-		chan->chan_reg.dma_sfcr |= STM32_DMA_SFCR_FTH(threshold);
+		if (fifoth != STM32_DMA_FIFO_THRESHOLD_NONE)
+			chan->chan_reg.dma_sfcr |= STM32_DMA_SFCR_FTH(fifoth);
 
 		/* Set peripheral address */
 		chan->chan_reg.dma_spar = chan->dma_sconfig.src_addr;
@@ -1216,6 +1235,8 @@ static void stm32_dma_set_config(struct stm32_dma_chan *chan,
 	chan->chan_reg.dma_scr |= STM32_DMA_SCR_TEIE | STM32_DMA_SCR_TCIE;
 
 	chan->threshold = STM32_DMA_THRESHOLD_FTR_GET(cfg->features);
+	if (STM32_DMA_DIRECT_MODE_GET(cfg->features))
+		chan->threshold = STM32_DMA_FIFO_THRESHOLD_NONE;
 }
 
 static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
-- 
2.17.1

