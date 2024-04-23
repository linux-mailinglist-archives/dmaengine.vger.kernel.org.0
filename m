Return-Path: <dmaengine+bounces-1927-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 071C98AE63D
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 14:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FD81F2575A
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 12:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F874130A6C;
	Tue, 23 Apr 2024 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="061bhe1p"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A212C813;
	Tue, 23 Apr 2024 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875735; cv=none; b=Xs/OUyzhUE1rvF9BhMraV+VvV9VaAgrSZRCxX8PB+QsbreI9Fb/PLkJ0WJ+SvF0xZvEtMCbq6REN6e5mQXjaJlbwTespeX9njs9vtia7kYMCB+o9jm/I4YP9NpbsKRwp81F/ysHG+xPBueGs1X5i4xr0W0MLytStHEJQ4v34ihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875735; c=relaxed/simple;
	bh=9U30dymWfubYw6TwVSZju35PXB6rdi5d3RC3lAAkio0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPNpxaOoIh5GKzrRyTmyds3Bx1l9zvctni4JSPRYU2QCiYFThZS9HCjPzxpoAD27pEVZMrAWN4qqlrUaDlbYnZ1HQWjh2FuE3r3Ap0ns/iuqXywPoZ+Ra7sMX5CB+Da33Gk0ENDO5yfzzM2tEMbk1uF0w9G6yC821aQniliGQaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=061bhe1p; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N884UD010265;
	Tue, 23 Apr 2024 14:35:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=fmcmPZBeTffpR8TX6qV5UHoj0bousNt9SCHAbfePCUk=; b=06
	1bhe1pvyZewMAxtDyQaUXMaj0My1GlpWjLhG7QML5z5AfWuBgIoWGMj6Uy3HBcQ2
	Uk5QuGQBO2K/R7wWUxjuyHG32m9SybQJzDrjMzfgtoDsO+AfQudZAAhfk1FTrhU+
	fXSq77zpSoGQjRMd9kfZOuYNen2QmTaWMazBMclOeuvlxjJA8z0B4FV55P5zte88
	e14HW1wR2Hy3BFSuxXPLIY4ipekOW/06U59YndOT09a/O6hwlLRxKc1ly/hJ4KU5
	Tk713gHuxBNgYNIcVNMicjpbg69aDrxv1QaTUGteQIGy/ioyeYw4dGXDJ9NQzlFP
	agc6axpM3fbz2kAQIRHA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4kb3dc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 14:35:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0EA7240046;
	Tue, 23 Apr 2024 14:35:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E133221A23E;
	Tue, 23 Apr 2024 14:34:30 +0200 (CEST)
Received: from localhost (10.48.86.143) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 14:34:30 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        Amelie Delaunay
	<amelie.delaunay@foss.st.com>
Subject: [PATCH 09/12] dmaengine: stm32-dma3: improve residue granularity
Date: Tue, 23 Apr 2024 14:32:59 +0200
Message-ID: <20240423123302.1550592-10-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
References: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_11,2024-04-23_01,2023-05-22_02

Implement own device_tx_status ops to compute the residue with a finer
granularity, up to bytes.
STM32 DMA3 has a bitfield, BNDT, in CxTR1 register which reflects the
number of bytes read from the source.
It also has a bitfield, FIFOL, in CxSR register which reflects the FIFO
level in units of programmed destination data width.
The channel is briefly suspended to get a coherent snapshot of registers.
It is possible to correct the fifo level when packing/unpacking is enabled
with destination increment.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-dma3.c | 165 ++++++++++++++++++++++++++++++++-
 1 file changed, 163 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 3d827c33150e..f15cc0129fc7 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -799,6 +799,134 @@ static void stm32_dma3_chan_reset(struct stm32_dma3_chan *chan)
 	writel_relaxed(ccr |= CCR_RESET, ddata->base + STM32_DMA3_CCR(chan->id));
 }
 
+static int stm32_dma3_chan_get_curr_hwdesc(struct stm32_dma3_swdesc *swdesc, u32 cllr, u32 *residue)
+{
+	u32 i, lli_offset, next_lli_offset = cllr & CLLR_LA;
+
+	/* If cllr is null, it means it is either the last or single item */
+	if (!cllr)
+		return swdesc->lli_size - 1;
+
+	/* In cyclic mode, go fast and first check we are not on the last item */
+	if (swdesc->cyclic && next_lli_offset == (swdesc->lli[0].hwdesc_addr & CLLR_LA))
+		return swdesc->lli_size - 1;
+
+	/* As transfer is in progress, look backward from the last item */
+	for (i = swdesc->lli_size - 1; i > 0; i--) {
+		*residue += FIELD_GET(CBR1_BNDT, swdesc->lli[i].hwdesc->cbr1);
+		lli_offset = swdesc->lli[i].hwdesc_addr & CLLR_LA;
+		if (lli_offset == next_lli_offset)
+			return i - 1;
+	}
+
+	return -EINVAL;
+}
+
+static void stm32_dma3_chan_set_residue(struct stm32_dma3_chan *chan,
+					struct stm32_dma3_swdesc *swdesc,
+					struct dma_tx_state *txstate)
+{
+	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
+	struct device *dev = chan2dev(chan);
+	struct stm32_dma3_hwdesc *hwdesc;
+	u32 residue, curr_lli, csr, cdar, cbr1, cllr, bndt, fifol;
+	bool pack_unpack;
+	int ret;
+
+	csr = readl_relaxed(ddata->base + STM32_DMA3_CSR(chan->id));
+	if (!((csr & CSR_TCF) && (csr & CSR_IDLEF)) && chan->dma_status != DMA_PAUSED) {
+		/* Suspend current transfer to read registers for a snapshot */
+		writel_relaxed(swdesc->ccr | CCR_SUSP, ddata->base + STM32_DMA3_CCR(chan->id));
+		ret = readl_relaxed_poll_timeout_atomic(ddata->base + STM32_DMA3_CSR(chan->id), csr,
+							csr & (CSR_SUSPF | CSR_TCF), 1, 10);
+
+		if (ret || ((csr & CSR_TCF) && (csr & CSR_IDLEF))) {
+			writel_relaxed(CFCR_SUSPF, ddata->base + STM32_DMA3_CFCR(chan->id));
+			writel_relaxed(swdesc->ccr, ddata->base + STM32_DMA3_CCR(chan->id));
+			if (ret)
+				dev_err(dev, "Channel suspension timeout, csr=%08x\n", csr);
+		}
+	}
+
+	/* If channel is still active (CSR_IDLEF is not set), can't get a reliable residue */
+	if (!(csr & CSR_IDLEF)) {
+		dev_err(dev, "Can't get residue: channel still active, csr=%08x\n", csr);
+		return;
+	}
+
+	/*
+	 * If channel is not suspended, but Idle and Transfer Complete are set,
+	 * linked-list is over, no residue
+	 */
+	if (!(csr & CSR_SUSPF) && (csr & CSR_TCF) && (csr & CSR_IDLEF))
+		return;
+
+	/* Read registers to have a snapshot */
+	cllr = readl_relaxed(ddata->base + STM32_DMA3_CLLR(chan->id));
+	cbr1 = readl_relaxed(ddata->base + STM32_DMA3_CBR1(chan->id));
+	cdar = readl_relaxed(ddata->base + STM32_DMA3_CDAR(chan->id));
+
+	/* Resume current transfer */
+	writel_relaxed(CFCR_SUSPF, ddata->base + STM32_DMA3_CFCR(chan->id));
+	writel_relaxed(swdesc->ccr, ddata->base + STM32_DMA3_CCR(chan->id));
+
+	/* Add current BNDT */
+	bndt = FIELD_GET(CBR1_BNDT, cbr1);
+	residue = bndt;
+
+	/* Get current hwdesc and cumulate residue of pending hwdesc BNDT */
+	ret = stm32_dma3_chan_get_curr_hwdesc(swdesc, cllr, &residue);
+	if (ret < 0) {
+		dev_err(chan2dev(chan), "Can't get residue: current hwdesc not found\n");
+		return;
+	}
+	curr_lli = ret;
+
+	/* Read current FIFO level - in units of programmed destination data width */
+	hwdesc = swdesc->lli[curr_lli].hwdesc;
+	fifol = FIELD_GET(CSR_FIFOL, csr) * (1 << FIELD_GET(CTR1_DDW_LOG2, hwdesc->ctr1));
+	/* If the FIFO contains as many bytes as its size, it can't contain more */
+	if (fifol == (1 << (chan->fifo_size + 1)))
+		goto skip_fifol_update;
+
+	/*
+	 * In case of PACKING (Destination burst length > Source burst length) or UNPACKING
+	 * (Source burst length > Destination burst length), bytes could be pending in the FIFO
+	 * (to be packed up to Destination burst length or unpacked into Destination burst length
+	 * chunks).
+	 * BNDT is not reliable, as it reflects the number of bytes read from the source but not the
+	 * number of bytes written to the destination.
+	 * FIFOL is also not sufficient, because it reflects the number of available write beats in
+	 * units of Destination data width but not the bytes not yet packed or unpacked.
+	 * In case of Destination increment DINC, it is possible to compute the number of bytes in
+	 * the FIFO:
+	 * fifol_in_bytes = bytes_read - bytes_written.
+	 */
+	pack_unpack = !!(FIELD_GET(CTR1_PAM, hwdesc->ctr1) == CTR1_PAM_PACK_UNPACK);
+	if (pack_unpack && (hwdesc->ctr1 & CTR1_DINC)) {
+		int bytes_read = FIELD_GET(CBR1_BNDT, hwdesc->cbr1) - bndt;
+		int bytes_written = cdar - hwdesc->cdar;
+
+		if (bytes_read > 0)
+			fifol = bytes_read - bytes_written;
+	}
+
+skip_fifol_update:
+	if (fifol) {
+		dev_dbg(chan2dev(chan), "%u byte(s) in the FIFO\n", fifol);
+		dma_set_in_flight_bytes(txstate, fifol);
+		/*
+		 * Residue is already accurate for DMA_MEM_TO_DEV as BNDT reflects data read from
+		 * the source memory buffer, so just need to add fifol to residue in case of
+		 * DMA_DEV_TO_MEM transfer because these bytes are not yet written in destination
+		 * memory buffer.
+		 */
+		if (chan->dma_config.direction == DMA_DEV_TO_MEM)
+			residue += fifol;
+	}
+	dma_set_residue(txstate, residue);
+}
+
 static int stm32_dma3_chan_stop(struct stm32_dma3_chan *chan)
 {
 	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
@@ -1301,6 +1429,39 @@ static void stm32_dma3_synchronize(struct dma_chan *c)
 	vchan_synchronize(&chan->vchan);
 }
 
+static enum dma_status stm32_dma3_tx_status(struct dma_chan *c, dma_cookie_t cookie,
+					    struct dma_tx_state *txstate)
+{
+	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
+	struct stm32_dma3_swdesc *swdesc = NULL;
+	enum dma_status status;
+	unsigned long flags;
+	struct virt_dma_desc *vd;
+
+	status = dma_cookie_status(c, cookie, txstate);
+	if (status == DMA_COMPLETE)
+		return status;
+
+	if (!txstate)
+		return chan->dma_status;
+
+	spin_lock_irqsave(&chan->vchan.lock, flags);
+
+	vd = vchan_find_desc(&chan->vchan, cookie);
+	if (vd)
+		swdesc = to_stm32_dma3_swdesc(vd);
+	else if (chan->swdesc && chan->swdesc->vdesc.tx.cookie == cookie)
+		swdesc = chan->swdesc;
+
+	/* Get residue/in_flight_bytes only if a transfer is currently running (swdesc != NULL) */
+	if (swdesc)
+		stm32_dma3_chan_set_residue(chan, swdesc, txstate);
+
+	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+
+	return chan->dma_status;
+}
+
 static void stm32_dma3_issue_pending(struct dma_chan *c)
 {
 	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
@@ -1497,7 +1658,7 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 
 	dma_dev->descriptor_reuse = true;
 	dma_dev->max_sg_burst = STM32_DMA3_MAX_SEG_SIZE;
-	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	dma_dev->device_alloc_chan_resources = stm32_dma3_alloc_chan_resources;
 	dma_dev->device_free_chan_resources = stm32_dma3_free_chan_resources;
 	dma_dev->device_prep_dma_memcpy = stm32_dma3_prep_dma_memcpy;
@@ -1509,7 +1670,7 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	dma_dev->device_resume = stm32_dma3_resume;
 	dma_dev->device_terminate_all = stm32_dma3_terminate_all;
 	dma_dev->device_synchronize = stm32_dma3_synchronize;
-	dma_dev->device_tx_status = dma_cookie_status;
+	dma_dev->device_tx_status = stm32_dma3_tx_status;
 	dma_dev->device_issue_pending = stm32_dma3_issue_pending;
 
 	/* if dma_channels is not modified, get it from hwcfgr1 */
-- 
2.25.1


