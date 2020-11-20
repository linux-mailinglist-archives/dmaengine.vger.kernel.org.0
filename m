Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3369C2BABEE
	for <lists+dmaengine@lfdr.de>; Fri, 20 Nov 2020 15:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgKTOdq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Nov 2020 09:33:46 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:23988 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727647AbgKTOdo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Nov 2020 09:33:44 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AKEXHHY018448;
        Fri, 20 Nov 2020 15:33:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=UyfffjjSF2sBtAEAw+GB45f91+mpPpOOijeEiPcemhI=;
 b=pzBGyp5qQEGAXsC3kwiMmSW+wgjsAWVFruu4NOcL5OnW7TARU/fEjGX58bo8Sf4p7l64
 +ejsJL1gPnQBqAzdcprwFJnLL1JFnWIKFr4xtjvATB8VudwvGMsZYGCjcmeJh0muQQlN
 oZs/aPfC4sBZ/JLNS4OH6ZadQEvUR7si1sl3+CikEfutVU0yCRyLSrVDB+7s677l42Vb
 2jUYgn7u3Gg4jhUR38BSXnbxZnpsPlsP+NII+uDnHBzx64aCcvjiFGCPG28ezjBdrn8t
 OXXZEDcFOQfOsJ1oIrEcw1F1thk/wElgFtkmQMm3OvIdOC6zdouM1Jz+IccBJhGxAQjf 2A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t58d7uey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 15:33:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8B0EB100034;
        Fri, 20 Nov 2020 15:33:27 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7DD4D2777DE;
        Fri, 20 Nov 2020 15:33:27 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Nov 2020 15:33:27
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH 1/4] dmaengine: stm32-dma: rework irq handler to manage error before xfer events
Date:   Fri, 20 Nov 2020 15:33:17 +0100
Message-ID: <20201120143320.30367-2-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120143320.30367-1-amelie.delaunay@st.com>
References: <20201120143320.30367-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_07:2020-11-20,2020-11-20 signatures=0
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

To better understand error that can be detected by the DMA controller,
manage the error flags before the transfer flags.
This way, it is possible to know if the FIFO error flag is set for an
over/underrun condition or a FIFO level error.
When a FIFO over/underrun condition occurs, the data is not lost because
peripheral request is not acknowledged by the stream until the over/
underrun condition is cleared. If this acknowledge takes too much time,
the peripheral itself may detect an over/underrun condition of its internal
buffer and data might be lost.
That's why in case the FIFO error flag is set, we check if the channel is
disabled or not, and if a Transfer Complete flag is set, which means that
the channel is disabled because of the end of transfer.
Because channel is disabled by hardware either by a FIFO level error, or by
an end of transfer.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/dma/stm32-dma.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index d0055d2f0b9a..55a6bd381219 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -648,21 +648,12 @@ static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
 	scr = stm32_dma_read(dmadev, STM32_DMA_SCR(chan->id));
 	sfcr = stm32_dma_read(dmadev, STM32_DMA_SFCR(chan->id));
 
-	if (status & STM32_DMA_TCI) {
-		stm32_dma_irq_clear(chan, STM32_DMA_TCI);
-		if (scr & STM32_DMA_SCR_TCIE)
-			stm32_dma_handle_chan_done(chan);
-		status &= ~STM32_DMA_TCI;
-	}
-	if (status & STM32_DMA_HTI) {
-		stm32_dma_irq_clear(chan, STM32_DMA_HTI);
-		status &= ~STM32_DMA_HTI;
-	}
 	if (status & STM32_DMA_FEI) {
 		stm32_dma_irq_clear(chan, STM32_DMA_FEI);
 		status &= ~STM32_DMA_FEI;
 		if (sfcr & STM32_DMA_SFCR_FEIE) {
-			if (!(scr & STM32_DMA_SCR_EN))
+			if (!(scr & STM32_DMA_SCR_EN) &&
+			    !(status & STM32_DMA_TCI))
 				dev_err(chan2dev(chan), "FIFO Error\n");
 			else
 				dev_dbg(chan2dev(chan), "FIFO over/underrun\n");
@@ -674,6 +665,19 @@ static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
 		if (sfcr & STM32_DMA_SCR_DMEIE)
 			dev_dbg(chan2dev(chan), "Direct mode overrun\n");
 	}
+
+	if (status & STM32_DMA_TCI) {
+		stm32_dma_irq_clear(chan, STM32_DMA_TCI);
+		if (scr & STM32_DMA_SCR_TCIE)
+			stm32_dma_handle_chan_done(chan);
+		status &= ~STM32_DMA_TCI;
+	}
+
+	if (status & STM32_DMA_HTI) {
+		stm32_dma_irq_clear(chan, STM32_DMA_HTI);
+		status &= ~STM32_DMA_HTI;
+	}
+
 	if (status) {
 		stm32_dma_irq_clear(chan, status);
 		dev_err(chan2dev(chan), "DMA error: status=0x%08x\n", status);
-- 
2.17.1

