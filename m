Return-Path: <dmaengine+bounces-7153-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4AFC57637
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 13:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739833BEB2A
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 12:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2907A351FC6;
	Thu, 13 Nov 2025 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z5N3z00g"
X-Original-To: dmaengine@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8F534F261;
	Thu, 13 Nov 2025 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036572; cv=none; b=amKufdECWL11ty/5jkgGXF7p7nw+LXJhw2xrPcmlfl3cLvCF9FLhKt00WgbLjgE4JsrAIoyZBq/6y95fqCiPJFC7MelqDwlbPA3+q/COw8gMksX8ZMZauK4E57Gsv3bMwPMWu3aCK9YCedHQ2ZQWLPRpt7IFNfp9DwcgR7uQXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036572; c=relaxed/simple;
	bh=DGRoafYf75LyiDgJC7aeQ1lFqtCY6dpeDmoD5LwAHNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctT5m69wRo48vHr9zWp4XfIP4xbX9sGN2AYrgzwiEZFDTW/Y7SE1cUe+iIcL6PfUf776ZYnV6jyprqi5qU12cpG09K5sdTfrmZTqtJC7qqXhJW+qBBN+PFGNuSTdv6FTFqRy+rhqfX+QioCUVAmwYXPJwtnGzeFSihGDWn1cF8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z5N3z00g; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763036562;
	bh=DGRoafYf75LyiDgJC7aeQ1lFqtCY6dpeDmoD5LwAHNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z5N3z00gKxPzdfpINYTnKSo4FKp3DoJEr8ZFxLiwVrTrRwB8YOV1wClPNwTJnXJzR
	 HVTQIOPAokq+lgFhKwJxOqtYQemv6A9r2V15H1fHY2DWRLeb+SjxRdXNNO7E6iGSfk
	 j3fRVMdZ3cTk5VF06aJEfCnlsVkCrTTTQphCHbnICa+IiEe/bFI1MsWAzjaq24deX2
	 ZozRybKH97Culkmvt/baAsENSENu9PMOOyFuHRd7MZH3GvnrsseLachfdsNjp+ePSD
	 zY23S/dWBLqd8A7Sx7QvR8SW42JFkAWcZSeBF9ChYSl+LlXiDvke5TPQVoexpA2OxW
	 2hf8+ftYP+zJw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F153D17E1401;
	Thu, 13 Nov 2025 13:22:41 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: dmaengine@vger.kernel.org
Cc: sean.wang@mediatek.com,
	vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	long.cheng@mediatek.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 6/8] dmaengine: mediatek: mtk-uart-apdma: Rename support_33bits to support_ext_addr
Date: Thu, 13 Nov 2025 13:22:27 +0100
Message-ID: <20251113122229.23998-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113122229.23998-1-angelogioacchino.delregno@collabora.com>
References: <20251113122229.23998-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding support for SoCs with APDMA IP versions
supporting more than 33 bits addressing, rename the support_33bits
variable to support_ext_addr to signal support for extended, above
4GB, addressing.

This change is cosmetic only, and brings no functional differences.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/dma/mediatek/mtk-uart-apdma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index 2398b440b12a..802a4d6c11fa 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -77,7 +77,7 @@
 struct mtk_uart_apdmadev {
 	struct dma_device ddev;
 	struct clk *clk;
-	bool support_33bits;
+	bool support_ext_addr;
 	unsigned int dma_requests;
 };
 
@@ -148,7 +148,7 @@ static void mtk_uart_apdma_start_tx(struct mtk_chan *c)
 		mtk_uart_apdma_write(c, VFF_WPT, 0);
 		mtk_uart_apdma_write(c, VFF_INT_FLAG, VFF_TX_INT_CLR_B);
 
-		if (mtkd->support_33bits)
+		if (mtkd->support_ext_addr)
 			mtk_uart_apdma_write(c, VFF_ADDR2, upper_32_bits(d->addr));
 	}
 
@@ -191,7 +191,7 @@ static void mtk_uart_apdma_start_rx(struct mtk_chan *c)
 		mtk_uart_apdma_write(c, VFF_RPT, 0);
 		mtk_uart_apdma_write(c, VFF_INT_FLAG, VFF_RX_INT_CLR_B);
 
-		if (mtkd->support_33bits)
+		if (mtkd->support_ext_addr)
 			mtk_uart_apdma_write(c, VFF_ADDR2, upper_32_bits(d->addr));
 	}
 
@@ -297,7 +297,7 @@ static int mtk_uart_apdma_alloc_chan_resources(struct dma_chan *chan)
 		goto err_pm;
 	}
 
-	if (mtkd->support_33bits)
+	if (mtkd->support_ext_addr)
 		mtk_uart_apdma_write(c, VFF_ADDR2, VFF_ADDR2_CLR_B);
 
 err_pm:
@@ -495,7 +495,7 @@ static int mtk_uart_apdma_probe(struct platform_device *pdev)
 
 	bit_mask = (unsigned int)(uintptr_t)of_device_get_match_data(&pdev->dev);
 	if (bit_mask > 32)
-		mtkd->support_33bits = true;
+		mtkd->support_ext_addr = true;
 
 	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(bit_mask));
 	if (rc)
-- 
2.51.1


