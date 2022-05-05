Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7BD51BD29
	for <lists+dmaengine@lfdr.de>; Thu,  5 May 2022 12:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355512AbiEEKaz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 May 2022 06:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355552AbiEEKay (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 May 2022 06:30:54 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB7E4B1EF;
        Thu,  5 May 2022 03:27:14 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2458Q0NQ015536;
        Thu, 5 May 2022 12:26:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=uItryK/B8ZXSaeQAnfJVbT07KupO9tgEkT2nTq7fmd4=;
 b=Jef8xU9zwpvaB9M9kXvNxg4CB4qaLtMQUandmvyfSTe8m7jzSPc4s3aKJzdfpN0E2zT+
 dq9x2smRPngGLYZ4UZQwptsM1dkWgoRY5NF2B9HIF17rAfsmP6AtkSiO5pETRoC9P/Vy
 OXCh6nvQZNPuy1T0LRvOe5vuUWAkBYegfqRxACc/KKHaBH2KbLmf51Y5lSwE9KQFKWUc
 z5TIW6vBHmjE8gMQpDYR/HY3hjMpMHCS+oBx5CVSWhD9+CDT3L32XWj09UqLFBTmSrjl
 Z6hINN0aW8/OBzLf2KqxDhrIt7qv+chTt/Iy6tr/9pUSZh+jCqwAKZ+tXB45pPiKV9Ps +g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frvf0sfgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 12:26:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 11E6710002A;
        Thu,  5 May 2022 12:26:56 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0B1902171CE;
        Thu,  5 May 2022 12:26:56 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 5 May 2022 12:26:55
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 2/4] dmaengine: stm32-dma: pass DMA_SxSCR value to stm32_dma_handle_chan_done()
Date:   Thu, 5 May 2022 12:26:34 +0200
Message-ID: <20220505102636.35506-3-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505102636.35506-1-amelie.delaunay@foss.st.com>
References: <20220505102636.35506-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_04,2022-05-05_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

stm32_dma_handle_chan_done() is called on Transfer Complete interrupt.
As DMA_SxSCR register is read in interrupt handler, pass the value as
parameter of stm32_dma_handle_chan_done(). Also return directly if
chan->desc is null to remove one ident level.
Then, stm32_dma_configure_next_sg() is doing something only if
Double-Buffer Mode (DBM) is enabled, so, check it is enabled prior calling
stm32_dma_configure_next_sg(), to remove one ident level in
stm32_dma_configure_next_sg().

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-dma.c | 54 ++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 5afe4205f57b..eecd13795943 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -612,38 +612,38 @@ static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan)
 	id = chan->id;
 	dma_scr = stm32_dma_read(dmadev, STM32_DMA_SCR(id));
 
-	if (dma_scr & STM32_DMA_SCR_DBM) {
-		sg_req = &chan->desc->sg_req[chan->next_sg];
-
-		if (dma_scr & STM32_DMA_SCR_CT) {
-			dma_sm0ar = sg_req->chan_reg.dma_sm0ar;
-			stm32_dma_write(dmadev, STM32_DMA_SM0AR(id), dma_sm0ar);
-			dev_dbg(chan2dev(chan), "CT=1 <=> SM0AR: 0x%08x\n",
-				stm32_dma_read(dmadev, STM32_DMA_SM0AR(id)));
-		} else {
-			dma_sm1ar = sg_req->chan_reg.dma_sm1ar;
-			stm32_dma_write(dmadev, STM32_DMA_SM1AR(id), dma_sm1ar);
-			dev_dbg(chan2dev(chan), "CT=0 <=> SM1AR: 0x%08x\n",
-				stm32_dma_read(dmadev, STM32_DMA_SM1AR(id)));
-		}
+	sg_req = &chan->desc->sg_req[chan->next_sg];
+
+	if (dma_scr & STM32_DMA_SCR_CT) {
+		dma_sm0ar = sg_req->chan_reg.dma_sm0ar;
+		stm32_dma_write(dmadev, STM32_DMA_SM0AR(id), dma_sm0ar);
+		dev_dbg(chan2dev(chan), "CT=1 <=> SM0AR: 0x%08x\n",
+			stm32_dma_read(dmadev, STM32_DMA_SM0AR(id)));
+	} else {
+		dma_sm1ar = sg_req->chan_reg.dma_sm1ar;
+		stm32_dma_write(dmadev, STM32_DMA_SM1AR(id), dma_sm1ar);
+		dev_dbg(chan2dev(chan), "CT=0 <=> SM1AR: 0x%08x\n",
+			stm32_dma_read(dmadev, STM32_DMA_SM1AR(id)));
 	}
 }
 
-static void stm32_dma_handle_chan_done(struct stm32_dma_chan *chan)
+static void stm32_dma_handle_chan_done(struct stm32_dma_chan *chan, u32 scr)
 {
-	if (chan->desc) {
-		if (chan->desc->cyclic) {
-			vchan_cyclic_callback(&chan->desc->vdesc);
-			stm32_dma_sg_inc(chan);
+	if (!chan->desc)
+		return;
+
+	if (chan->desc->cyclic) {
+		vchan_cyclic_callback(&chan->desc->vdesc);
+		stm32_dma_sg_inc(chan);
+		if (scr & STM32_DMA_SCR_DBM)
 			stm32_dma_configure_next_sg(chan);
-		} else {
-			chan->busy = false;
-			if (chan->next_sg == chan->desc->num_sgs) {
-				vchan_cookie_complete(&chan->desc->vdesc);
-				chan->desc = NULL;
-			}
-			stm32_dma_start_transfer(chan);
+	} else {
+		chan->busy = false;
+		if (chan->next_sg == chan->desc->num_sgs) {
+			vchan_cookie_complete(&chan->desc->vdesc);
+			chan->desc = NULL;
 		}
+		stm32_dma_start_transfer(chan);
 	}
 }
 
@@ -680,7 +680,7 @@ static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
 	if (status & STM32_DMA_TCI) {
 		stm32_dma_irq_clear(chan, STM32_DMA_TCI);
 		if (scr & STM32_DMA_SCR_TCIE)
-			stm32_dma_handle_chan_done(chan);
+			stm32_dma_handle_chan_done(chan, scr);
 		status &= ~STM32_DMA_TCI;
 	}
 
-- 
2.25.1

