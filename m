Return-Path: <dmaengine+bounces-2232-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2C08D654F
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 17:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D291F25D18
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 15:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5087A172793;
	Fri, 31 May 2024 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="PyVfCwuN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834D9155C8E;
	Fri, 31 May 2024 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168170; cv=none; b=XnPzCnFQFY+AUPRSwl1Y+Ggs4e6XRTJjymzYz1qHHOpVRT4RCN6ZGDuyFQchB2MkPgSPlfseDGJRB2ApA6Jlm392CESN/HlPnu0dVLOeatJx6zcsrX2AnBmjMo9dP0Ge9zMQ2ZvKJEYRpTxbTXRKx87V3iPjo4Kw8fVnPG9Z28E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168170; c=relaxed/simple;
	bh=X8bCZb+LGq9IT/jtth4sfFIXiMuBh/uesUgk+HfKE+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPBTs7teqNdMI+UnITackyBvB9yjTsCuPB4YEg6M+0Rs8n1SJx24piKvrsuynlkZ1CdzCKMEJnQwwS/5v1Rxw3axGfcI5f1inyovGjSSNL1GV6VbSirH2hzFWHEQm0KtP2jYIYwPmNOSe6r2BkvyCA7p0iePuNsfMoOKevHpfsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=PyVfCwuN; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VDTij6015827;
	Fri, 31 May 2024 17:09:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	wSZcG54oF23vBwdSURBd9dvwNaKAExh6VPZQR9eqddI=; b=PyVfCwuNVkv6slZR
	GYIfzu0qq+FW4xYRQfuXwGPPOuCdtJJw/EYyxFmRZ1xXiZH26RxP7Y88sWOU0HfV
	hYzPmC6S4qEYVJ2jlPjh8jcXT/Cf6SGh+DRRlPu3WDDmc3jN3+QWS8USoJeisZu6
	PF2Wdi6rBDWpIg65mzvg2qxXbUgXc6h0eipNgDh9QINYnQPiVuK7HTXPSRBmaYAH
	z7GYCPc5pIAzmGgjeR5j3RcGbz9IaUF4da+RZ0JA8n65P1KoKO6k1+apZ6rz5WkA
	Q8qxxpInCNsv8I0+rStZwJRaQXPJyF1yT5RkgdowWS+ZD2IZ7y1Pcy8P08i0C4Nh
	YVUwdw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yba52cem7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 17:09:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C154A40048;
	Fri, 31 May 2024 17:09:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 08C5B2207D2;
	Fri, 31 May 2024 17:08:21 +0200 (CEST)
Received: from localhost (10.252.27.179) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 17:08:20 +0200
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
Subject: [PATCH v4 06/12] dmaengine: stm32-dma3: add DMA_CYCLIC capability
Date: Fri, 31 May 2024 17:07:06 +0200
Message-ID: <20240531150712.2503554-7-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240531150712.2503554-1-amelie.delaunay@foss.st.com>
References: <20240531150712.2503554-1-amelie.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_11,2024-05-30_01,2024-05-17_01

Add DMA_CYCLIC capability and relative device_prep_dma_cyclic ops with
stm32_dma3_prep_dma_cyclic(). It reuses stm32_dma3_chan_prep_hw() and
stm32_dma3_chan_prep_hwdesc() helpers.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
v4:
- remove MEM_TO_MEM comment: only DEV_TO_MEM and MEM_TO_DEV are supported
  in cyclic mode. 
---
 drivers/dma/stm32/stm32-dma3.c | 77 ++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 49886117d29b..fc131c758d7c 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1021,6 +1021,81 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_slave_sg(struct dma_chan
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
+		} else { /* (dir == DMA_DEV_TO_MEM) */
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
@@ -1255,6 +1330,7 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
 	dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
+	dma_cap_set(DMA_CYCLIC, dma_dev->cap_mask);
 	dma_dev->dev = &pdev->dev;
 	/*
 	 * This controller supports up to 8-byte buswidth depending on the port used and the
@@ -1277,6 +1353,7 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	dma_dev->device_alloc_chan_resources = stm32_dma3_alloc_chan_resources;
 	dma_dev->device_free_chan_resources = stm32_dma3_free_chan_resources;
 	dma_dev->device_prep_slave_sg = stm32_dma3_prep_slave_sg;
+	dma_dev->device_prep_dma_cyclic = stm32_dma3_prep_dma_cyclic;
 	dma_dev->device_caps = stm32_dma3_caps;
 	dma_dev->device_config = stm32_dma3_config;
 	dma_dev->device_terminate_all = stm32_dma3_terminate_all;
-- 
2.25.1


