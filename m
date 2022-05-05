Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E71551BEAA
	for <lists+dmaengine@lfdr.de>; Thu,  5 May 2022 13:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359169AbiEEMAS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 May 2022 08:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiEEMAP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 May 2022 08:00:15 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E1C54F82;
        Thu,  5 May 2022 04:56:35 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24599UoN001423;
        Thu, 5 May 2022 13:56:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=1Ogb9fzJH2RRPqHqv5XBkYLmdMiwYt9r27x+Zvdcf7U=;
 b=0xlrdLnoRVgLJ7iaBEVY133xL1mJhBMOkkk7O/Dj5aifT/MiXwruteifOQ8/iUMAudSz
 RMt2gWkmGmU53iNutvQ+1Q9mGK73OI8iDfzirJTtHA9c4P5pFhqDrj//ILPLoNpbnCxr
 7m/dD+wAcTSQmzO4CEooMT9WmLE2b2ZHhn85AsSvvtfQ/LwFM9vPxFM++JNo7iYOX4gC
 x1+GJWUd4q93uCQAekLM1ObTd1McJIclYH8V1ksByfyPnZpPGzqNwiLHmldi9SZTFIIt
 RrfqHQ47cWcBXuwkuAZVoH7ZVzX/JCpQLJjupk6by1FsubTCz3nDbN3vkloF5ctX/8Pp lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frv0gkbdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 13:56:25 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C267110002A;
        Thu,  5 May 2022 13:56:24 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BB7D021B50C;
        Thu,  5 May 2022 13:56:24 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 5 May 2022 13:56:23
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
Subject: [PATCH 4/4] dmaengine: stm32-dma: add device_pause/device_resume support
Date:   Thu, 5 May 2022 13:56:11 +0200
Message-ID: <20220505115611.38845-5-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505115611.38845-1-amelie.delaunay@foss.st.com>
References: <20220505115611.38845-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
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

At any time, a DMA transfer can be suspended to be restarted later before
the end of the DMA transfer.

In order to restart from the point where the transfer was stopped,
DMA_SxNDTR has to be read after disabling the channel by clearing the EN
bit in DMA_SxCR register, to know the number of data items already
collected.
Peripheral and/or memory addresses have to be updated in order to adjust
the address pointers.
SxNDTR register has to be updated with the remaining number of data items
to be transferred (the value read when the channel was disabled).
Then the channel can be re-enabled to resume the transfer from the point
it was suspended.
If the channel was configured in circular or double-buffer mode, the
circular or double-buffer mode must be disabled before re-enabling the
channel to be able to reconfigure SxNDTR register and re-activate circular
or double-buffer mode on next Transfer Complete interrupt where channel
will be disabled by HW. This is due to the fact that on resume, re-writing
SxNDTR register value updates internal HW auto-reload data counter, and
then it truncates all next transfers after a pause/resume sequence.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-dma.c | 247 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 234 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 0b35c5178501..adb25a11c70f 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -208,6 +208,7 @@ struct stm32_dma_chan {
 	u32 threshold;
 	u32 mem_burst;
 	u32 mem_width;
+	enum dma_status status;
 };
 
 struct stm32_dma_device {
@@ -485,6 +486,7 @@ static void stm32_dma_stop(struct stm32_dma_chan *chan)
 	}
 
 	chan->busy = false;
+	chan->status = DMA_COMPLETE;
 }
 
 static int stm32_dma_terminate_all(struct dma_chan *c)
@@ -595,11 +597,11 @@ static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
 	stm32_dma_dump_reg(chan);
 
 	/* Start DMA */
+	chan->busy = true;
+	chan->status = DMA_IN_PROGRESS;
 	reg->dma_scr |= STM32_DMA_SCR_EN;
 	stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), reg->dma_scr);
 
-	chan->busy = true;
-
 	dev_dbg(chan2dev(chan), "vchan %pK: started\n", &chan->vchan);
 }
 
@@ -627,6 +629,95 @@ static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan)
 	}
 }
 
+static void stm32_dma_handle_chan_paused(struct stm32_dma_chan *chan)
+{
+	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
+	u32 dma_scr;
+
+	/*
+	 * Read and store current remaining data items and peripheral/memory addresses to be
+	 * updated on resume
+	 */
+	dma_scr = stm32_dma_read(dmadev, STM32_DMA_SCR(chan->id));
+	/*
+	 * Transfer can be paused while between a previous resume and reconfiguration on transfer
+	 * complete. If transfer is cyclic and CIRC and DBM have been deactivated for resume, need
+	 * to set it here in SCR backup to ensure a good reconfiguration on transfer complete.
+	 */
+	if (chan->desc && chan->desc->cyclic) {
+		if (chan->desc->num_sgs == 1)
+			dma_scr |= STM32_DMA_SCR_CIRC;
+		else
+			dma_scr |= STM32_DMA_SCR_DBM;
+	}
+	chan->chan_reg.dma_scr = dma_scr;
+
+	/*
+	 * Need to temporarily deactivate CIRC/DBM until next Transfer Complete interrupt, otherwise
+	 * on resume NDTR autoreload value will be wrong (lower than the initial period length)
+	 */
+	if (chan->desc && chan->desc->cyclic) {
+		dma_scr &= ~(STM32_DMA_SCR_DBM | STM32_DMA_SCR_CIRC);
+		stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), dma_scr);
+	}
+
+	chan->chan_reg.dma_sndtr = stm32_dma_read(dmadev, STM32_DMA_SNDTR(chan->id));
+
+	dev_dbg(chan2dev(chan), "vchan %pK: paused\n", &chan->vchan);
+}
+
+static void stm32_dma_post_resume_reconfigure(struct stm32_dma_chan *chan)
+{
+	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
+	struct stm32_dma_sg_req *sg_req;
+	u32 dma_scr, status, id;
+
+	id = chan->id;
+	dma_scr = stm32_dma_read(dmadev, STM32_DMA_SCR(id));
+
+	/* Clear interrupt status if it is there */
+	status = stm32_dma_irq_status(chan);
+	if (status)
+		stm32_dma_irq_clear(chan, status);
+
+	if (!chan->next_sg)
+		sg_req = &chan->desc->sg_req[chan->desc->num_sgs - 1];
+	else
+		sg_req = &chan->desc->sg_req[chan->next_sg - 1];
+
+	/* Reconfigure NDTR with the initial value */
+	stm32_dma_write(dmadev, STM32_DMA_SNDTR(chan->id), sg_req->chan_reg.dma_sndtr);
+
+	/* Restore SPAR */
+	stm32_dma_write(dmadev, STM32_DMA_SPAR(id), sg_req->chan_reg.dma_spar);
+
+	/* Restore SM0AR/SM1AR whatever DBM/CT as they may have been modified */
+	stm32_dma_write(dmadev, STM32_DMA_SM0AR(id), sg_req->chan_reg.dma_sm0ar);
+	stm32_dma_write(dmadev, STM32_DMA_SM1AR(id), sg_req->chan_reg.dma_sm1ar);
+
+	/* Reactivate CIRC/DBM if needed */
+	if (chan->chan_reg.dma_scr & STM32_DMA_SCR_DBM) {
+		dma_scr |= STM32_DMA_SCR_DBM;
+		/* Restore CT */
+		if (chan->chan_reg.dma_scr & STM32_DMA_SCR_CT)
+			dma_scr &= ~STM32_DMA_SCR_CT;
+		else
+			dma_scr |= STM32_DMA_SCR_CT;
+	} else if (chan->chan_reg.dma_scr & STM32_DMA_SCR_CIRC) {
+		dma_scr |= STM32_DMA_SCR_CIRC;
+	}
+	stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), dma_scr);
+
+	stm32_dma_configure_next_sg(chan);
+
+	stm32_dma_dump_reg(chan);
+
+	dma_scr |= STM32_DMA_SCR_EN;
+	stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), dma_scr);
+
+	dev_dbg(chan2dev(chan), "vchan %pK: reconfigured after pause/resume\n", &chan->vchan);
+}
+
 static void stm32_dma_handle_chan_done(struct stm32_dma_chan *chan, u32 scr)
 {
 	if (!chan->desc)
@@ -635,10 +726,14 @@ static void stm32_dma_handle_chan_done(struct stm32_dma_chan *chan, u32 scr)
 	if (chan->desc->cyclic) {
 		vchan_cyclic_callback(&chan->desc->vdesc);
 		stm32_dma_sg_inc(chan);
-		if (scr & STM32_DMA_SCR_DBM)
+		/* cyclic while CIRC/DBM disable => post resume reconfiguration needed */
+		if (!(scr & (STM32_DMA_SCR_CIRC | STM32_DMA_SCR_DBM)))
+			stm32_dma_post_resume_reconfigure(chan);
+		else if (scr & STM32_DMA_SCR_DBM)
 			stm32_dma_configure_next_sg(chan);
 	} else {
 		chan->busy = false;
+		chan->status = DMA_COMPLETE;
 		if (chan->next_sg == chan->desc->num_sgs) {
 			vchan_cookie_complete(&chan->desc->vdesc);
 			chan->desc = NULL;
@@ -679,8 +774,12 @@ static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
 
 	if (status & STM32_DMA_TCI) {
 		stm32_dma_irq_clear(chan, STM32_DMA_TCI);
-		if (scr & STM32_DMA_SCR_TCIE)
-			stm32_dma_handle_chan_done(chan, scr);
+		if (scr & STM32_DMA_SCR_TCIE) {
+			if (chan->status == DMA_PAUSED && !(scr & STM32_DMA_SCR_EN))
+				stm32_dma_handle_chan_paused(chan);
+			else
+				stm32_dma_handle_chan_done(chan, scr);
+		}
 		status &= ~STM32_DMA_TCI;
 	}
 
@@ -715,6 +814,107 @@ static void stm32_dma_issue_pending(struct dma_chan *c)
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 }
 
+static int stm32_dma_pause(struct dma_chan *c)
+{
+	struct stm32_dma_chan *chan = to_stm32_dma_chan(c);
+	unsigned long flags;
+	int ret;
+
+	if (chan->status != DMA_IN_PROGRESS)
+		return -EPERM;
+
+	spin_lock_irqsave(&chan->vchan.lock, flags);
+	ret = stm32_dma_disable_chan(chan);
+	/*
+	 * A transfer complete flag is set to indicate the end of transfer due to the stream
+	 * interruption, so wait for interrupt
+	 */
+	if (!ret)
+		chan->status = DMA_PAUSED;
+	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+
+	return ret;
+}
+
+static int stm32_dma_resume(struct dma_chan *c)
+{
+	struct stm32_dma_chan *chan = to_stm32_dma_chan(c);
+	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
+	struct stm32_dma_chan_reg chan_reg = chan->chan_reg;
+	u32 id = chan->id, scr, ndtr, offset, spar, sm0ar, sm1ar;
+	struct stm32_dma_sg_req *sg_req;
+	unsigned long flags;
+
+	if (chan->status != DMA_PAUSED)
+		return -EPERM;
+
+	scr = stm32_dma_read(dmadev, STM32_DMA_SCR(id));
+	if (WARN_ON(scr & STM32_DMA_SCR_EN))
+		return -EPERM;
+
+	spin_lock_irqsave(&chan->vchan.lock, flags);
+
+	/* sg_reg[prev_sg] contains original ndtr, sm0ar and sm1ar before pausing the transfer */
+	if (!chan->next_sg)
+		sg_req = &chan->desc->sg_req[chan->desc->num_sgs - 1];
+	else
+		sg_req = &chan->desc->sg_req[chan->next_sg - 1];
+
+	ndtr = sg_req->chan_reg.dma_sndtr;
+	offset = (ndtr - chan_reg.dma_sndtr) << STM32_DMA_SCR_PSIZE_GET(chan_reg.dma_scr);
+	spar = sg_req->chan_reg.dma_spar;
+	sm0ar = sg_req->chan_reg.dma_sm0ar;
+	sm1ar = sg_req->chan_reg.dma_sm1ar;
+
+	/*
+	 * The peripheral and/or memory addresses have to be updated in order to adjust the
+	 * address pointers. Need to check increment.
+	 */
+	if (chan_reg.dma_scr & STM32_DMA_SCR_PINC)
+		stm32_dma_write(dmadev, STM32_DMA_SPAR(id), spar + offset);
+	else
+		stm32_dma_write(dmadev, STM32_DMA_SPAR(id), spar);
+
+	if (!(chan_reg.dma_scr & STM32_DMA_SCR_MINC))
+		offset = 0;
+
+	/*
+	 * In case of DBM, the current target could be SM1AR.
+	 * Need to temporarily deactivate CIRC/DBM to finish the current transfer, so
+	 * SM0AR becomes the current target and must be updated with SM1AR + offset if CT=1.
+	 */
+	if ((chan_reg.dma_scr & STM32_DMA_SCR_DBM) && (chan_reg.dma_scr & STM32_DMA_SCR_CT))
+		stm32_dma_write(dmadev, STM32_DMA_SM1AR(id), sm1ar + offset);
+	else
+		stm32_dma_write(dmadev, STM32_DMA_SM0AR(id), sm0ar + offset);
+
+	/* NDTR must be restored otherwise internal HW counter won't be correctly reset */
+	stm32_dma_write(dmadev, STM32_DMA_SNDTR(id), chan_reg.dma_sndtr);
+
+	/*
+	 * Need to temporarily deactivate CIRC/DBM until next Transfer Complete interrupt,
+	 * otherwise NDTR autoreload value will be wrong (lower than the initial period length)
+	 */
+	if (chan_reg.dma_scr & (STM32_DMA_SCR_CIRC | STM32_DMA_SCR_DBM))
+		chan_reg.dma_scr &= ~(STM32_DMA_SCR_CIRC | STM32_DMA_SCR_DBM);
+
+	if (chan_reg.dma_scr & STM32_DMA_SCR_DBM)
+		stm32_dma_configure_next_sg(chan);
+
+	stm32_dma_dump_reg(chan);
+
+	/* The stream may then be re-enabled to restart transfer from the point it was stopped */
+	chan->status = DMA_IN_PROGRESS;
+	chan_reg.dma_scr |= STM32_DMA_SCR_EN;
+	stm32_dma_write(dmadev, STM32_DMA_SCR(id), chan_reg.dma_scr);
+
+	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+
+	dev_dbg(chan2dev(chan), "vchan %pK: resumed\n", &chan->vchan);
+
+	return 0;
+}
+
 static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 				    enum dma_transfer_direction direction,
 				    enum dma_slave_buswidth *buswidth,
@@ -982,10 +1182,12 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
 	}
 
 	/*  Enable Circular mode or double buffer mode */
-	if (buf_len == period_len)
+	if (buf_len == period_len) {
 		chan->chan_reg.dma_scr |= STM32_DMA_SCR_CIRC;
-	else
+	} else {
 		chan->chan_reg.dma_scr |= STM32_DMA_SCR_DBM;
+		chan->chan_reg.dma_scr &= ~STM32_DMA_SCR_CT;
+	}
 
 	/* Clear periph ctrl if client set it */
 	chan->chan_reg.dma_scr &= ~STM32_DMA_SCR_PFCTRL;
@@ -1095,24 +1297,36 @@ static bool stm32_dma_is_current_sg(struct stm32_dma_chan *chan)
 {
 	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
 	struct stm32_dma_sg_req *sg_req;
-	u32 dma_scr, dma_smar, id;
+	u32 dma_scr, dma_smar, id, period_len;
 
 	id = chan->id;
 	dma_scr = stm32_dma_read(dmadev, STM32_DMA_SCR(id));
 
+	/* In cyclic CIRC but not DBM, CT is not used */
 	if (!(dma_scr & STM32_DMA_SCR_DBM))
 		return true;
 
 	sg_req = &chan->desc->sg_req[chan->next_sg];
+	period_len = sg_req->len;
 
+	/* DBM - take care of a previous pause/resume not yet post reconfigured */
 	if (dma_scr & STM32_DMA_SCR_CT) {
 		dma_smar = stm32_dma_read(dmadev, STM32_DMA_SM0AR(id));
-		return (dma_smar == sg_req->chan_reg.dma_sm0ar);
+		/*
+		 * If transfer has been pause/resumed,
+		 * SM0AR is in the range of [SM0AR:SM0AR+period_len]
+		 */
+		return (dma_smar >= sg_req->chan_reg.dma_sm0ar &&
+			dma_smar < sg_req->chan_reg.dma_sm0ar + period_len);
 	}
 
 	dma_smar = stm32_dma_read(dmadev, STM32_DMA_SM1AR(id));
-
-	return (dma_smar == sg_req->chan_reg.dma_sm1ar);
+	/*
+	 * If transfer has been pause/resumed,
+	 * SM1AR is in the range of [SM1AR:SM1AR+period_len]
+	 */
+	return (dma_smar >= sg_req->chan_reg.dma_sm1ar &&
+		dma_smar < sg_req->chan_reg.dma_sm1ar + period_len);
 }
 
 static size_t stm32_dma_desc_residue(struct stm32_dma_chan *chan,
@@ -1152,7 +1366,7 @@ static size_t stm32_dma_desc_residue(struct stm32_dma_chan *chan,
 
 	residue = stm32_dma_get_remaining_bytes(chan);
 
-	if (!stm32_dma_is_current_sg(chan)) {
+	if (chan->desc->cyclic && !stm32_dma_is_current_sg(chan)) {
 		n_sg++;
 		if (n_sg == chan->desc->num_sgs)
 			n_sg = 0;
@@ -1192,7 +1406,12 @@ static enum dma_status stm32_dma_tx_status(struct dma_chan *c,
 	u32 residue = 0;
 
 	status = dma_cookie_status(c, cookie, state);
-	if (status == DMA_COMPLETE || !state)
+	if (status == DMA_COMPLETE)
+		return status;
+
+	status = chan->status;
+
+	if (!state)
 		return status;
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
@@ -1381,6 +1600,8 @@ static int stm32_dma_probe(struct platform_device *pdev)
 	dd->device_prep_slave_sg = stm32_dma_prep_slave_sg;
 	dd->device_prep_dma_cyclic = stm32_dma_prep_dma_cyclic;
 	dd->device_config = stm32_dma_slave_config;
+	dd->device_pause = stm32_dma_pause;
+	dd->device_resume = stm32_dma_resume;
 	dd->device_terminate_all = stm32_dma_terminate_all;
 	dd->device_synchronize = stm32_dma_synchronize;
 	dd->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-- 
2.25.1

