Return-Path: <dmaengine+bounces-1925-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DC88AE632
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 14:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFA5283C2B
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 12:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A2712A14D;
	Tue, 23 Apr 2024 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="k4O4mtLy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5BA86AC2;
	Tue, 23 Apr 2024 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875732; cv=none; b=JZKFmBxuY+APoz8q6jIH70y52fiDokrRBbXAMDOnb15oJeyoMtWOmNvSYmyYby02UdO2lFSwnbnrmIjFU5PxX8/iyzF+eJWFO1LkY3osJxF3nId9xozn9MZfRpjmGKjZ7DPk9EaDgqhcXxWu8l0uV+Po6Vh/lNCf9KGDYHed8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875732; c=relaxed/simple;
	bh=aPc6gVs0kBaBmL9Ra+XbHTVFMnPXQs30Dcc6L88xpSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=laNkYVjW2SyiyBsRp8lLOL+xDhywQ/DNfJ+2oqdAeh4tVJQIZb14FlW+/kynzevmlU2JGdiqxs/IFRc7Srty5kFFj9AbJ/TEsxIPabGnvx1Mp1PyPqIhXfEC2+EDDozZeofufzlUKAdU+Ojq4Dm4DlOGgcNuEl3oTnMGdsEC9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=k4O4mtLy; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NBtpIx020959;
	Tue, 23 Apr 2024 14:35:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=U2DMOOWjs2kwqjijCXilt3juOAuuOj0K9jWHNDrDvmE=; b=k4
	O4mtLyhhWUm6A9d1V1A7b9xHi8qOOHvaX8aFIjOUJ0bkM7wOifA00Hb5IjkDnom2
	nfNai/4S73lY5zv4K5ct7Tz9S9kx824fF9lxzK2pRtUxk8zapAYL6CahMyDs2niI
	ufCK3ptholaXZfDXcKTLsqEBksOUGhBNS/9TmdAPrnnQCK5CTbjUgE7pzCDZI8In
	MFYTQuWZAqqEjXDGr3NgcQB4vJNrCMWWm3I9pLPsbfRGaF4cVz0oTf1yO92bLUfq
	XWw7Kf9IZ8Bb15R0oVblOzbiqmvHSnIXmqMeTN6Iw7fQnyoPkJ2h+xlPxTt+N9HX
	4r9dBh+vwpAdKwzHme8A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xmrnj14tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 14:35:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6566C40044;
	Tue, 23 Apr 2024 14:35:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8E23D21A23A;
	Tue, 23 Apr 2024 14:34:28 +0200 (CEST)
Received: from localhost (10.48.86.143) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 14:34:28 +0200
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
Subject: [PATCH 06/12] dmaengine: stm32-dma3: add DMA_CYCLIC capability
Date: Tue, 23 Apr 2024 14:32:56 +0200
Message-ID: <20240423123302.1550592-7-amelie.delaunay@foss.st.com>
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

Add DMA_CYCLIC capability and relative device_prep_dma_cyclic ops with
stm32_dma3_prep_dma_cyclic(). It reuses stm32_dma3_chan_prep_hw() and
stm32_dma3_chan_prep_hwdesc() helpers.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-dma3.c | 77 ++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index b5493f497d06..3afd9f8da2b6 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1012,6 +1012,81 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_slave_sg(struct dma_chan
 	return NULL;
 }
 
+static struct dma_async_tx_descriptor *stm32_dma3_prep_dma_cyclic(struct dma_chan *c,
+								  dma_addr_t buf_addr,
+								  size_t buf_len, size_t period_len,
+								  enum dma_transfer_direction dir,
+								  unsigned long flags)
+{
+	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
+	struct stm32_dma3_swdesc *swdesc;
+	dma_addr_t src, dst;
+	u32 count, i, ctr1, ctr2;
+	int ret;
+
+	if (!buf_len || !period_len || period_len > STM32_DMA3_MAX_BLOCK_SIZE) {
+		dev_err(chan2dev(chan), "Invalid buffer/period length\n");
+		return NULL;
+	}
+
+	if (buf_len % period_len) {
+		dev_err(chan2dev(chan), "Buffer length not multiple of period length\n");
+		return NULL;
+	}
+
+	count = buf_len / period_len;
+	swdesc = stm32_dma3_chan_desc_alloc(chan, count);
+	if (!swdesc)
+		return NULL;
+
+	if (dir == DMA_MEM_TO_DEV) {
+		src = buf_addr;
+		dst = chan->dma_config.dst_addr;
+
+		ret = stm32_dma3_chan_prep_hw(chan, DMA_MEM_TO_DEV, &swdesc->ccr, &ctr1, &ctr2,
+					      src, dst, period_len);
+	} else if (dir == DMA_DEV_TO_MEM) {
+		src = chan->dma_config.src_addr;
+		dst = buf_addr;
+
+		ret = stm32_dma3_chan_prep_hw(chan, DMA_DEV_TO_MEM, &swdesc->ccr, &ctr1, &ctr2,
+					      src, dst, period_len);
+	} else {
+		dev_err(chan2dev(chan), "Invalid direction\n");
+		ret = -EINVAL;
+	}
+
+	if (ret)
+		goto err_desc_free;
+
+	for (i = 0; i < count; i++) {
+		if (dir == DMA_MEM_TO_DEV) {
+			src = buf_addr + i * period_len;
+			dst = chan->dma_config.dst_addr;
+		} else { /* (dir == DMA_DEV_TO_MEM || dir == DMA_MEM_TO_MEM) */
+			src = chan->dma_config.src_addr;
+			dst = buf_addr + i * period_len;
+		}
+
+		stm32_dma3_chan_prep_hwdesc(chan, swdesc, i, src, dst, period_len,
+					    ctr1, ctr2, i == (count - 1), true);
+	}
+
+	/* Enable Error interrupts */
+	swdesc->ccr |= CCR_USEIE | CCR_ULEIE | CCR_DTEIE;
+	/* Enable Transfer state interrupts */
+	swdesc->ccr |= CCR_TCIE;
+
+	swdesc->cyclic = true;
+
+	return vchan_tx_prep(&chan->vchan, &swdesc->vdesc, flags);
+
+err_desc_free:
+	stm32_dma3_chan_desc_free(chan, swdesc);
+
+	return NULL;
+}
+
 static void stm32_dma3_caps(struct dma_chan *c, struct dma_slave_caps *caps)
 {
 	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
@@ -1246,6 +1321,7 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
 	dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
+	dma_cap_set(DMA_CYCLIC, dma_dev->cap_mask);
 	dma_dev->dev = &pdev->dev;
 	/*
 	 * This controller supports up to 8-byte buswidth depending on the port used and the
@@ -1268,6 +1344,7 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	dma_dev->device_alloc_chan_resources = stm32_dma3_alloc_chan_resources;
 	dma_dev->device_free_chan_resources = stm32_dma3_free_chan_resources;
 	dma_dev->device_prep_slave_sg = stm32_dma3_prep_slave_sg;
+	dma_dev->device_prep_dma_cyclic = stm32_dma3_prep_dma_cyclic;
 	dma_dev->device_caps = stm32_dma3_caps;
 	dma_dev->device_config = stm32_dma3_config;
 	dma_dev->device_terminate_all = stm32_dma3_terminate_all;
-- 
2.25.1


