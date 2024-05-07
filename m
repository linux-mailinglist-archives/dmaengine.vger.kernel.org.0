Return-Path: <dmaengine+bounces-1996-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B208D8BE2C4
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2024 14:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D13C1F21BE6
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2024 12:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC7015E5B1;
	Tue,  7 May 2024 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="JrQ2ydYP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A27215D5BE;
	Tue,  7 May 2024 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086636; cv=none; b=aEUNB7XWLzYqedvgmkGJ6PF2w0vLpwrGXIrO2iXkbYu1yofwfAmMQL+wNKE1daDcRYOFAfL9BCQlIb8e4GppBiK018snC+dbTuR7rDJlEd1yi/Nj+ISfGiuScP6eQrxg2CSbafcWhLXjvaqvnUMiRBnqeGzGLnHA9uJjIcQ6bq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086636; c=relaxed/simple;
	bh=iGtDexBMs6kBbQvS9oNqp69Ii6eLc0yLIeWHLtdOEhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dN/feuAehDKesipNWsvhcSNJ3wra2Cc4jUxiyJW/Fr/qmYVC0QhByUKghgTrsyUE/EIWAfFoWacPRNP2LgLCACWPBkr87pfbIRcncf51DjsXZ+Hfoy2E1+Cz7UwdVj2p0bUlF7yJ/vp+I6H4GgWEWimUpg7PLRMfCYHtYx8N1FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=JrQ2ydYP; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447BkrIK016848;
	Tue, 7 May 2024 14:56:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=b7SUStuGYGLMrw27XS+u2fyLUrbgKF89blpfA1Jaw58=; b=Jr
	Q2ydYPed2b0ybF6PS7OfEhX/XU34mMC1kjUn7u4aunbSo6kTZr7tcXVep13ISeJx
	1Azthc7kn2g+20193tMbx5zbx7y7egl6Lz0G8npCR/y4YT1M542IRQi+wWNHLllo
	ipROzOqrOU/C1KuLWkQ+DZ5ibk4nw6546czh2eagYdrouaceSVzkodKx/U17cllG
	vcfHLE6PWVd0WXwpEyKqPWjTh4NbdYeNKsZUx95WhAp2h6POEYa5331Z/TPYXSYM
	yQjrxzgDJFvrCICWgQncXXi0lFE+/nKRZloty+Q9s3POSF7a9zE0xNzLZ2Ax98g9
	dfHU3pVMwSBV5hLdv0dQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xwaegc60n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 14:56:57 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3BD4D40044;
	Tue,  7 May 2024 14:56:53 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5936B212FCF;
	Tue,  7 May 2024 14:56:06 +0200 (CEST)
Received: from localhost (10.48.86.143) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 7 May
 2024 14:56:06 +0200
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
Subject: [PATCH v2 06/12] dmaengine: stm32-dma3: add DMA_CYCLIC capability
Date: Tue, 7 May 2024 14:54:36 +0200
Message-ID: <20240507125442.3989284-7-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507125442.3989284-1-amelie.delaunay@foss.st.com>
References: <20240507125442.3989284-1-amelie.delaunay@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_06,2024-05-06_02,2023-05-22_02

Add DMA_CYCLIC capability and relative device_prep_dma_cyclic ops with
stm32_dma3_prep_dma_cyclic(). It reuses stm32_dma3_chan_prep_hw() and
stm32_dma3_chan_prep_hwdesc() helpers.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-dma3.c | 77 ++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 15dc45703168..d49cc461abff 100644
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


