Return-Path: <dmaengine+bounces-7152-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 888D7C57623
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 13:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E2E3BE18D
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 12:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD288350D77;
	Thu, 13 Nov 2025 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jdaT2YM1"
X-Original-To: dmaengine@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A4C34FF77;
	Thu, 13 Nov 2025 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036571; cv=none; b=KjWT4776F+Lh7shGw/WvyEL3q8WcWZCX+I2erWtTwFFJQHYYM7aRVP8t3+Z1+An+2sBA2bUY/zoc/5rqa6RNxFLpjkUEHO+EPFW7WokOv12XfHhfcFA5iAbWuvLFF9Myw9Ft4QnuOcymvPCc4ibcpuaM5DWr7xr9S48bUeyHzfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036571; c=relaxed/simple;
	bh=JFgZElGuW7huMLg5IeTiiaMe7V7hDDxmcenUv8VvhSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myEglwPeZCCf396vYhxdMeLOTnfdmT7Bkrw7b+Ez75FwvhgQ7woVRevc41MucETVm4he3kqvNKZfUMsZGxscXUs5jy8pKKJJh+MPAA5A8BZmmQDbnZ3DvbgUq1waGkagLrKXm46/JZWQsOF5LaS+TfeNPzpnXafx4O7G5oaQghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jdaT2YM1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763036563;
	bh=JFgZElGuW7huMLg5IeTiiaMe7V7hDDxmcenUv8VvhSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jdaT2YM10QNyrQb4uPfRepfG9a90LnHiYl+WClEpOpiN6E9jWAfbDQDLzds2Zi17p
	 yGHOxASDgHDbrC3kxt/4vD9Y64iTUUQIeQaWg19rUwUSob9YPgrzc+I3xYEf56lb8F
	 FpDFx1y6A7scsOWlNlSmePFPtFPj2iWln7E/BnHX3gZZZO5pydt4zPRviDs2BzmSGa
	 soHqTzBQ6388YsykB6RBOJND7kejaY2MLrxwoKiATdqb4bDgFNLDtc3WoCUX+K74GP
	 XZUNnfEiIW0K2fc512pBlEFtRfnAVBa0NAdFfRNR5zgCb6hkOhDKOCkqQEihBiAqpt
	 rqfylKbOkCWmQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4E40017E151F;
	Thu, 13 Nov 2025 13:22:43 +0100 (CET)
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
Subject: [PATCH 8/8] dmaengine: mediatek: mtk-uart-apdma: Add support for Dimensity 9200
Date: Thu, 13 Nov 2025 13:22:29 +0100
Message-ID: <20251113122229.23998-9-angelogioacchino.delregno@collabora.com>
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
found in the MediaTek Dimensity 9200 MT6985 SoC; this supports
extended addressing with up to 35 bits.

Other SoCs with this IP version also include the Dimensity 9400
MT6991 and Kompanio Ultra MT8196 (which don't need a specific
compatible in this driver and can reuse the mt6985 one).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/dma/mediatek/mtk-uart-apdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index dfcfc618bb8c..ead00636b048 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -471,6 +471,7 @@ static const struct of_device_id mtk_uart_apdma_match[] = {
 	{ .compatible = "mediatek,mt6577-uart-dma", .data = (void *)32 },
 	{ .compatible = "mediatek,mt6795-uart-dma", .data = (void *)33 },
 	{ .compatible = "mediatek,mt6835-uart-dma", .data = (void *)34 },
+	{ .compatible = "mediatek,mt6985-uart-dma", .data = (void *)35 },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, mtk_uart_apdma_match);
-- 
2.51.1


