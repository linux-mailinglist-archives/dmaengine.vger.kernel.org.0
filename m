Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BEF609CDD
	for <lists+dmaengine@lfdr.de>; Mon, 24 Oct 2022 10:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiJXIgk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Oct 2022 04:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJXIgj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Oct 2022 04:36:39 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211216049F;
        Mon, 24 Oct 2022 01:36:31 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29O6kuPT019014;
        Mon, 24 Oct 2022 10:36:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=hjE8e/e8vt5lFLFZZcNa3D98nO+5lJyHBO3xGTZhfLE=;
 b=VR9qan/lYTl1+Hk7VmjXfbdwaN/nhYrQpOHgBIX5QYJA1B1jVXJL8+8QXpuQPZH1D7UA
 2aBlA7Z3F5Uy0Fh8m5wOdDRSZXbftP779KBI2My9BgiHkp7UBN+EP3J3iVwyE+EaJGi+
 lTWXzxEz/wX1YtqN+xNbfL+vnVdh+NHp1KBC6Ui3ndO5akDEfH7O3ewx3Y0FBUMJqTva
 F0g5Im5FY//1g3InGIu0MOfZx9HoghUryBWRmnqM0dLTomLdXYaFdbixFlnYDm6wOrvU
 /PFRkwN2JRI3wknW80CS0HCi9JJH3MsyoEVeIT9/5tnR0xxZyk7BvtDFeNZGK81+DLMG Ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kc7v29fyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 10:36:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7D3D310002A;
        Mon, 24 Oct 2022 10:36:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 795E0216ECE;
        Mon, 24 Oct 2022 10:36:13 +0200 (CEST)
Received: from localhost (10.201.20.208) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 10:36:13 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dmaengine: stm32-dma: fix potential race between pause and resume
Date:   Mon, 24 Oct 2022 10:36:11 +0200
Message-ID: <20221024083611.132588-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.208]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_02,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When disabling dma channel, a TCF flag is set and as TCIE is enabled, an
interrupt is raised.
On a busy system, the interrupt may have latency and the user can ask for
dmaengine_resume while stm32-dma driver has not yet managed the complete
pause (backup of registers to restore state in resume).
To avoid such a case, instead of waiting the interrupt to backup the
registers, do it just after disabling the channel and discard Transfer
Complete interrupt in case the channel is paused.

Fixes: 099a9a94be0e ("dmaengine: stm32-dma: add device_pause/device_resume support")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-dma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 4891a1767e5a..37674029cb42 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -675,6 +675,8 @@ static void stm32_dma_handle_chan_paused(struct stm32_dma_chan *chan)
 
 	chan->chan_reg.dma_sndtr = stm32_dma_read(dmadev, STM32_DMA_SNDTR(chan->id));
 
+	chan->status = DMA_PAUSED;
+
 	dev_dbg(chan2dev(chan), "vchan %pK: paused\n", &chan->vchan);
 }
 
@@ -789,9 +791,7 @@ static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
 	if (status & STM32_DMA_TCI) {
 		stm32_dma_irq_clear(chan, STM32_DMA_TCI);
 		if (scr & STM32_DMA_SCR_TCIE) {
-			if (chan->status == DMA_PAUSED && !(scr & STM32_DMA_SCR_EN))
-				stm32_dma_handle_chan_paused(chan);
-			else
+			if (chan->status != DMA_PAUSED)
 				stm32_dma_handle_chan_done(chan, scr);
 		}
 		status &= ~STM32_DMA_TCI;
@@ -838,13 +838,11 @@ static int stm32_dma_pause(struct dma_chan *c)
 		return -EPERM;
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
+
 	ret = stm32_dma_disable_chan(chan);
-	/*
-	 * A transfer complete flag is set to indicate the end of transfer due to the stream
-	 * interruption, so wait for interrupt
-	 */
 	if (!ret)
-		chan->status = DMA_PAUSED;
+		stm32_dma_handle_chan_paused(chan);
+
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 
 	return ret;
-- 
2.25.1

