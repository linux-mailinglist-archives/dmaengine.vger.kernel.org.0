Return-Path: <dmaengine+bounces-7149-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BACC57649
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 13:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 260D04E82DF
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 12:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08DD3502B7;
	Thu, 13 Nov 2025 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mhFkFB8w"
X-Original-To: dmaengine@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA75734F24A;
	Thu, 13 Nov 2025 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036570; cv=none; b=REBL5K4VBRmOj/wdFRXMwIwUQF8/MMiAAlHHhnkSg39U14TWbKPkMwSVJ4uXCIVIpmoGCv6Nl5TAQgxs6glv257lNSEeDRJNyBH2elxmx2PXnRWc3pKZkQxEtx+ul+PWKM8mIOQzdI2vx/3wizpaHghyP56yAvZiZtA27KmQPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036570; c=relaxed/simple;
	bh=k8+meZJQprbtExrsSpzTiYBLLVkN3FNkJSPN8CJTMSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODPSS91x/+cOdVM614i96zONN6S6XlIXv/n0Toj27TwbTDfsEOYCCIWEjIsY4qLZ2AwzQyrTv+99FX7PlkyJhwFCEwMaHDGZw6u8Hht8sQwRDQdlXF2P1WbpXVsXdg4Uso2U4YGFbzna8MdPNVoUhvu1bOK0szsyr5LzVed2kQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mhFkFB8w; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763036561;
	bh=k8+meZJQprbtExrsSpzTiYBLLVkN3FNkJSPN8CJTMSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mhFkFB8wHB0rVMhJiyD/PKAF0WTYTQ2PpYbUPHeHsSQ6hsRDn1hKUfkQhNaICED86
	 kdrdumJVSvl5q5BTsGFBbcQUh3+n7rAWJPnLzzKM4FD3mo/khOdcb3DMOrysHEXsWv
	 9srCkHScQcbq1ho9N2DeMQJnZT03t/rZwmetD30tKYeqtTfgGwFeHNL9OJW7ET91bz
	 fOszy+WD7QZNcCcwJIJ/1xfZV56tYdgl5/A+oP3bYzRGdRRAKu8kni1hvPBog2Aguc
	 1NHCFZXHxgqbJMwq69bMZjtlOH7alMxX0YxzoHbT/+yDShWxwCIcYjPek5q7StqrIb
	 jTW2hhWFQsWyQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9D20D17E13C1;
	Thu, 13 Nov 2025 13:22:40 +0100 (CET)
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
Subject: [PATCH 4/8] dmaengine: mediatek: uart-apdma: Get addressing bits from match data
Date: Thu, 13 Nov 2025 13:22:25 +0100
Message-ID: <20251113122229.23998-5-angelogioacchino.delregno@collabora.com>
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

The only SoC that declares mediatek,dma-33bits in its devicetree
currently is MT6795, which obviously also declares a SoC-specific
compatible string: in preparation for adding new SoCs with 34 bits
addressing, replace the parsing of said vendor property with logic
to get the number of addressing bits from platform data associated
to compatible strings.

While at it, also make the bit_mask variable unsigned and move the
`int rc` declaration as last to beautify the code.

Thanks to the correct declaration of the APDMA node is in all of
the MediaTek device trees that are currently upstream, this commit
brings no functional differences.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/dma/mediatek/mtk-uart-apdma.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index 08e15177427b..b906e59f4c6d 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -468,7 +468,8 @@ static void mtk_uart_apdma_free(struct mtk_uart_apdmadev *mtkd)
 }
 
 static const struct of_device_id mtk_uart_apdma_match[] = {
-	{ .compatible = "mediatek,mt6577-uart-dma", },
+	{ .compatible = "mediatek,mt6577-uart-dma", .data = (void *)32 },
+	{ .compatible = "mediatek,mt6795-uart-dma", .data = (void *)33 },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, mtk_uart_apdma_match);
@@ -477,9 +478,9 @@ static int mtk_uart_apdma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct mtk_uart_apdmadev *mtkd;
-	int bit_mask = 32, rc;
 	struct mtk_chan *c;
-	unsigned int i;
+	unsigned int bit_mask, i;
+	int rc;
 
 	mtkd = devm_kzalloc(&pdev->dev, sizeof(*mtkd), GFP_KERNEL);
 	if (!mtkd)
@@ -492,12 +493,10 @@ static int mtk_uart_apdma_probe(struct platform_device *pdev)
 		return rc;
 	}
 
-	if (of_property_read_bool(np, "mediatek,dma-33bits"))
+	bit_mask = (unsigned int)(uintptr_t)of_device_get_match_data(&pdev->dev);
+	if (bit_mask > 32)
 		mtkd->support_33bits = true;
 
-	if (mtkd->support_33bits)
-		bit_mask = 33;
-
 	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(bit_mask));
 	if (rc)
 		return rc;
-- 
2.51.1


