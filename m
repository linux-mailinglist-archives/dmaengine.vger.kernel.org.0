Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3539E51BD25
	for <lists+dmaengine@lfdr.de>; Thu,  5 May 2022 12:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355518AbiEEKax (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 May 2022 06:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240927AbiEEKav (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 May 2022 06:30:51 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2A6517F3;
        Thu,  5 May 2022 03:27:12 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2458U01o001536;
        Thu, 5 May 2022 12:26:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=vVNs20GHeQv8C1KNCWf/owN4D8dQJUtAlbOROVhSK7s=;
 b=iQG1ip0qqrP1rdEbmOo7sq9Ff8CNH0nyRCr6NRFJmYoExKiWYmwj+qhRRthhWvWlmv1i
 07s9xSGfq36kI/b/IbXRuzDXC5hd4HIXjHA21fAWcil5le8Ab0XG3rtR7y5w1jz3Fw8r
 ByUzC7pgW8SZXNiBftmmbRZAvlQ4QIgHsRtq5IMYtzZL6MhFZ/ZmBgN9KTpnVeY6dUJg
 k8J/VTUX7eY+86H0GzWRKHJBCuDSpuyAgOwAiLcjO5rojDGyhgQycqRf2GNDVG0w7k1C
 3AishfqbiUCQn2+txFk24+76FqV9ypVWNT8n7+tDe00+mMlO4CZ89t7gB2F/8qdFwNyB ZA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frv0gjx2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 12:26:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D518B100034;
        Thu,  5 May 2022 12:26:54 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CD84A2171CE;
        Thu,  5 May 2022 12:26:54 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 5 May 2022 12:26:54
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
Date:   Thu, 5 May 2022 12:26:33 +0200
Message-ID: <20220505102636.35506-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505102636.35506-1-amelie.delaunay@foss.st.com>
References: <20220505102636.35506-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
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

