Return-Path: <dmaengine+bounces-7150-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A694EC57616
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 13:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CC83BD4E2
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 12:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA22350A07;
	Thu, 13 Nov 2025 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EJ3jZoDq"
X-Original-To: dmaengine@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA80434F255;
	Thu, 13 Nov 2025 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036570; cv=none; b=sGYCZ60EunNXikLcpAfVrBevyHn+6Ni2c6aDqwTgWbcQLYFYAAk6oDhcQfH9kRGFt3GXa5LgnaEZMDpuj+8FSYXpI1A+JsZ4ZbrjOK2/D5ufCd7NBS0yfK2eWo3c1hi018ozyi9HnOXVpPfRwgvDd78Kwq1K1eew7AHxKq95Rek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036570; c=relaxed/simple;
	bh=f8YYs7Jtpjk+WCoX4FIuodOSedKrGO1EncRMDJxwpIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUuVAOUSkYTF5YWB40uP0UK6X9cj+yDgdwRcRZgJ6VB3ghntmuPyi9NxbVRG5DYW8J06+wDIVJiiou8+5ltF1n84/Hx85ortmTo4NwCHBwUYXZLTD7QAg8rYyrmjf0IjdiMSRHmcwwqLIXXCxy+D5T42nGqKKcMkWcU+q9mlubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EJ3jZoDq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763036561;
	bh=f8YYs7Jtpjk+WCoX4FIuodOSedKrGO1EncRMDJxwpIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EJ3jZoDq6ylhDglSq4WfGnX7ldDjDX1VjLcH77Zeh/aDi66YZZCRJhb3aRdWEoQLR
	 teJKN5eqIeNBX1yC2pIt5PPlnQFUGiL7gxNgkXQ//Bcsp5siRdHExMlTO86yzT5+ih
	 Nn9pAtloB3Sml3DdlNprkgYtf9aM9kdqEPkGjz40Yv9zruUZG1SAmwvDYMglxXEc7x
	 +jh2V4K81zoYiVFPTWZUXHyAzsRarLRWuhOpJ40vLOdweVMyFH2DLboPF9EZzCIdMt
	 sigq3NIk55kwo1bLmcwCuzSMzvxcmyVDrUzqwVGcPD86ZWD2SfnO/oeQ8fjlbbQbc6
	 E5tILBREiZgVg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4C56217E13DC;
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
Subject: [PATCH 5/8] dmaengine: mediatek: uart-apdma: Fix above 4G addressing TX/RX
Date: Thu, 13 Nov 2025 13:22:26 +0100
Message-ID: <20251113122229.23998-6-angelogioacchino.delregno@collabora.com>
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

The VFF_4G_SUPPORT register is named differently in datasheets,
and its name is "VFF_ADDR2"; was this named correctly from the
beginning it would've been clearer that there was a mistake in
the programming sequence.

This register is supposed to hold the high bits to support the
DMA addressing above 4G (so, more than 32 bits) and not a bit
to "enable" the support for VFF 4G.

Fix the name of this register, and also fix its usage by writing
the upper 32 bits of the dma_addr_t on it when the SoC supports
such feature.

Fixes: 9135408c3ace ("dmaengine: mediatek: Add MediaTek UART APDMA support")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/dma/mediatek/mtk-uart-apdma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index b906e59f4c6d..2398b440b12a 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -41,7 +41,7 @@
 #define VFF_STOP_CLR_B		0
 #define VFF_EN_CLR_B		0
 #define VFF_INT_EN_CLR_B	0
-#define VFF_4G_SUPPORT_CLR_B	0
+#define VFF_ADDR2_CLR_B		0
 
 /*
  * interrupt trigger level for tx
@@ -72,7 +72,7 @@
 /* TX: the buffer size SW can write. RX: the buffer size HW can write. */
 #define VFF_LEFT_SIZE		0x40
 #define VFF_DEBUG_STATUS	0x50
-#define VFF_4G_SUPPORT		0x54
+#define VFF_ADDR2		0x54
 
 struct mtk_uart_apdmadev {
 	struct dma_device ddev;
@@ -149,7 +149,7 @@ static void mtk_uart_apdma_start_tx(struct mtk_chan *c)
 		mtk_uart_apdma_write(c, VFF_INT_FLAG, VFF_TX_INT_CLR_B);
 
 		if (mtkd->support_33bits)
-			mtk_uart_apdma_write(c, VFF_4G_SUPPORT, VFF_4G_EN_B);
+			mtk_uart_apdma_write(c, VFF_ADDR2, upper_32_bits(d->addr));
 	}
 
 	mtk_uart_apdma_write(c, VFF_EN, VFF_EN_B);
@@ -192,7 +192,7 @@ static void mtk_uart_apdma_start_rx(struct mtk_chan *c)
 		mtk_uart_apdma_write(c, VFF_INT_FLAG, VFF_RX_INT_CLR_B);
 
 		if (mtkd->support_33bits)
-			mtk_uart_apdma_write(c, VFF_4G_SUPPORT, VFF_4G_EN_B);
+			mtk_uart_apdma_write(c, VFF_ADDR2, upper_32_bits(d->addr));
 	}
 
 	mtk_uart_apdma_write(c, VFF_INT_EN, VFF_RX_INT_EN_B);
@@ -298,7 +298,7 @@ static int mtk_uart_apdma_alloc_chan_resources(struct dma_chan *chan)
 	}
 
 	if (mtkd->support_33bits)
-		mtk_uart_apdma_write(c, VFF_4G_SUPPORT, VFF_4G_SUPPORT_CLR_B);
+		mtk_uart_apdma_write(c, VFF_ADDR2, VFF_ADDR2_CLR_B);
 
 err_pm:
 	pm_runtime_put_noidle(mtkd->ddev.dev);
-- 
2.51.1


