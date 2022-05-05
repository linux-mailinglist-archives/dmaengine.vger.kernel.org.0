Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F3B51BEA5
	for <lists+dmaengine@lfdr.de>; Thu,  5 May 2022 13:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358552AbiEEMAM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 May 2022 08:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358891AbiEEMAL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 May 2022 08:00:11 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A742CC94;
        Thu,  5 May 2022 04:56:31 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2458Pia1018222;
        Thu, 5 May 2022 13:56:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=vVNs20GHeQv8C1KNCWf/owN4D8dQJUtAlbOROVhSK7s=;
 b=P3XqQRTA1D5786TFzpTPVyAb3NRTd1mpjNy7pi8kChfU6Fop/CCZ1EAsodK7gTdl50cD
 h2OMm2VMY/7hvL6Ucqe/LoYtsYY5rcBIrfyOQVKoVmCxHMBzu8UoDQCHfT8r9hFhSrLl
 eD/00rHkCV0k4jTekiNLJmkb+DDstKCZfpibZEXxWF5q8p13jyWoz+wOieUvqqFja6mt
 Ob28djNI4r9xoeCDjXL6PiTHnYMxp4qsNBd3hkL7WmI46jnJymJZSdl46f0ghC0IS1KF
 BCGzF2dJQ15v4Tk3T+UDct43ImL1nsuC9ygjww8hddZEZXekeDJJJ/ir9HTANVmEYb0n hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frthk26tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 13:56:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 27EAB100034;
        Thu,  5 May 2022 13:56:21 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 20EFD21B50C;
        Thu,  5 May 2022 13:56:21 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 5 May 2022 13:56:20
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
Subject: [PATCH 1/4] dmaengine: stm32-dma: introduce stm32_dma_sg_inc to manage chan->next_sg
Date:   Thu, 5 May 2022 13:56:08 +0200
Message-ID: <20220505115611.38845-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505115611.38845-1-amelie.delaunay@foss.st.com>
References: <20220505115611.38845-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_05,2022-05-05_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

chan->next_sg is used to know which transfer will start after the ongoing
one. It is incremented for each new transfer, either on transfer start for
non-cyclic transfers, or on transfer complete interrupt for cyclic
transfers.
For cyclic transfer, when the last item is reached, chan->next_sg must be
reinitialized to the first item.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-dma.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index d2365fab1b7a..5afe4205f57b 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -535,6 +535,13 @@ static void stm32_dma_dump_reg(struct stm32_dma_chan *chan)
 	dev_dbg(chan2dev(chan), "SFCR:  0x%08x\n", sfcr);
 }
 
+static void stm32_dma_sg_inc(struct stm32_dma_chan *chan)
+{
+	chan->next_sg++;
+	if (chan->desc->cyclic && (chan->next_sg == chan->desc->num_sgs))
+		chan->next_sg = 0;
+}
+
 static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan);
 
 static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
@@ -575,7 +582,7 @@ static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
 	stm32_dma_write(dmadev, STM32_DMA_SM1AR(chan->id), reg->dma_sm1ar);
 	stm32_dma_write(dmadev, STM32_DMA_SNDTR(chan->id), reg->dma_sndtr);
 
-	chan->next_sg++;
+	stm32_dma_sg_inc(chan);
 
 	/* Clear interrupt status if it is there */
 	status = stm32_dma_irq_status(chan);
@@ -606,9 +613,6 @@ static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan)
 	dma_scr = stm32_dma_read(dmadev, STM32_DMA_SCR(id));
 
 	if (dma_scr & STM32_DMA_SCR_DBM) {
-		if (chan->next_sg == chan->desc->num_sgs)
-			chan->next_sg = 0;
-
 		sg_req = &chan->desc->sg_req[chan->next_sg];
 
 		if (dma_scr & STM32_DMA_SCR_CT) {
@@ -630,7 +634,7 @@ static void stm32_dma_handle_chan_done(struct stm32_dma_chan *chan)
 	if (chan->desc) {
 		if (chan->desc->cyclic) {
 			vchan_cyclic_callback(&chan->desc->vdesc);
-			chan->next_sg++;
+			stm32_dma_sg_inc(chan);
 			stm32_dma_configure_next_sg(chan);
 		} else {
 			chan->busy = false;
-- 
2.25.1

