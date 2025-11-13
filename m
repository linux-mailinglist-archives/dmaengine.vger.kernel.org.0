Return-Path: <dmaengine+bounces-7151-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7E8C5761F
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 13:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F933BE02B
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 12:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDD3350D58;
	Thu, 13 Nov 2025 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AqzCZw7C"
X-Original-To: dmaengine@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AD234FF79;
	Thu, 13 Nov 2025 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036571; cv=none; b=Zt8yZN/AzXcCkPXDxnRus2XSlnPGksU7GstRO1+huV/B50/T3olj6DD7fxHKvCianqFpZFAHRzD7LmVYOeMXbGFsQ6j0X0KB/1DEPfqEvQalpHg88po2DrJAkpf8VHgabztB1PzGvejjP4roEaa67BXN1pHzv4HbGrima9mVzGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036571; c=relaxed/simple;
	bh=Q2b+AjuDHevZT4A1PbKOjLTq44s3ZXzwctElSef5DkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZpiGMd5wxMLbBWOQGE+4TzW3hwbgJATBIEsofHoumtBC8siarGulzoWcxHC3Q8IpsZD4gbKvLzZVBATzPp9F6rlleLJTPo1GMNRpC2kxRXIc10qiGe/PyA+iwpjS2rN4w53ynpJpVUDsRJjVmvdA0v7+TToEnSZn0dnzFSEjPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AqzCZw7C; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763036563;
	bh=Q2b+AjuDHevZT4A1PbKOjLTq44s3ZXzwctElSef5DkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AqzCZw7CIvF8nNsn4zNOR9TlsnXWZ5jX3pRJd70nu119E0AdTHT2xQW8OOkl6wqIR
	 t+YZK1XXycaY0f4eCQo0B/LMbK0HjZlLfBAGmIjUnjBHyV46pfmVeDvhNYY4M8ZBOr
	 fK8hckHYvYh1a2NLlLz3fHymL6qBjAtKaH23XJ2jl+CIo3oxnrqntl7bidTNvIb1ZL
	 OHbUgrSER0cP87qIzweuaUBAhxeqA1M7Sr3IdTnc2xTRPE3n2F1bUY8KNYiSnPVAMc
	 PgPtaBMlUQ839RGdlM2p0e/AQ7Vj3XT1cS8h6FNV99WrNW3aaKpokBOT44uPWMHyhY
	 vrDihRTf5iZPA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9E41817E1416;
	Thu, 13 Nov 2025 13:22:42 +0100 (CET)
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
Subject: [PATCH 7/8] dmaengine: mediatek: mtk-uart-apdma: Add support for Dimensity 6300
Date: Thu, 13 Nov 2025 13:22:28 +0100
Message-ID: <20251113122229.23998-8-angelogioacchino.delregno@collabora.com>
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

Add a compatible string and match data for the APDMA IP version
found in the MediaTek Dimensity 6300 MT6835 SoC; this supports
extended addressing with up to 34 bits.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/dma/mediatek/mtk-uart-apdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index 802a4d6c11fa..dfcfc618bb8c 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -470,6 +470,7 @@ static void mtk_uart_apdma_free(struct mtk_uart_apdmadev *mtkd)
 static const struct of_device_id mtk_uart_apdma_match[] = {
 	{ .compatible = "mediatek,mt6577-uart-dma", .data = (void *)32 },
 	{ .compatible = "mediatek,mt6795-uart-dma", .data = (void *)33 },
+	{ .compatible = "mediatek,mt6835-uart-dma", .data = (void *)34 },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, mtk_uart_apdma_match);
-- 
2.51.1


