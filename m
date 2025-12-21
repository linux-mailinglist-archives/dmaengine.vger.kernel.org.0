Return-Path: <dmaengine+bounces-7856-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D36ECD3CB5
	for <lists+dmaengine@lfdr.de>; Sun, 21 Dec 2025 09:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 016C9300A1F9
	for <lists+dmaengine@lfdr.de>; Sun, 21 Dec 2025 08:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3290722FDEA;
	Sun, 21 Dec 2025 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQTzRoWB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067A71EFF80;
	Sun, 21 Dec 2025 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766304310; cv=none; b=ctyTrM6/rKJl0ycr0hayiwAgQcToQFtrqctmzkKPZk1AY2Q3WDFYWB67l53T4x+CPY0C1fEmktXLjCIZUP3a3lAqTalWhFdJD1BZqyn2cMXgZKWhbxFIS05Vv9w60rvcByPI1sMyIwiH35POGGlrJ0GSZkHG2nim4WxxpaflY7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766304310; c=relaxed/simple;
	bh=SbdKgxUWVMsftMM+lwkv9tuPDzerkjuvqnV6ISat3wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gP232RqbwhyEfB3e5CH30nVJE4e9trGdRI5M5wQ4ECxjNjT3WG9isoeIW/ixejNYwI+z95eB/qLD+4Nj0jGAYO7mPo8wn/4Z4PtPzTQo7qrH5zNkCzbEz0DTya+EKOmQZzVNaVKjfNoGsEbGiw4rQi8NMDfrPNIhK4bS0gf7ae0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQTzRoWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B13BC4CEFB;
	Sun, 21 Dec 2025 08:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766304309;
	bh=SbdKgxUWVMsftMM+lwkv9tuPDzerkjuvqnV6ISat3wc=;
	h=From:To:Cc:Subject:Date:From;
	b=kQTzRoWBQmw4rkI+HqSFZbx9Klkb44/ZZ9Pv7hVbqBEPJqHBzBC5b6BuCAXPZVLpt
	 o5BDXSLHYraDMDs/Copk9WDx8IGwtqXbpYnDzWkSZGwDnv43q5yLg0Gc9pOHSW95hS
	 U8EH7d05JKj9+KBZnTyyEXJnjM8e3EUJKNNixRb8FkV0pFuDZGFrdlbqeTPVYVQ0h1
	 sTIIejqy2e5AugwZ5xNahlxUSI1LEnJbpdCIDsm2+ZxtCUE/xGLcXHlITkEaU2a0Zc
	 7hv2nqLZxxo9DJJo3sbAdXGVYAMH8CfULRH64fuywwDAe8sEKInw7MLdM1IzAzXL/M
	 ERtYWzB6Sy0Dw==
Received: by wens.tw (Postfix, from userid 1000)
	id 4053A5FDFB; Sun, 21 Dec 2025 16:05:07 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	dmaengine@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: sun6i: Choose appropriate burst length under maxburst
Date: Sun, 21 Dec 2025 16:04:48 +0800
Message-ID: <20251221080450.1813479-1-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maxburst, as provided by the client, specifies the largest amount of
data that is allowed to be transferred in one burst. This limit is
normally provided to avoid a data burst overflowing the target FIFO.
It does not mean that the DMA engine can only do bursts in that size.

Let the driver pick the largest supported burst length within the
given limit. This lets the driver work correctly with some clients that
give a large maxburst value. In particular, the 8250_dw driver will give
a quarter of the UART's FIFO size as maxburst. On some systems the FIFO
size is 256 bytes, giving a maxburst of 64 bytes, while the hardware
only supports bursts of up to 16 bytes.

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 drivers/dma/sun6i-dma.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 2215ff877bf7..f9d876deb1f0 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -583,6 +583,22 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 	return ret;
 }
 
+static u32 find_burst_size(const u32 burst_lengths, u32 maxburst)
+{
+	if (!maxburst)
+		return 1;
+
+	if (BIT(maxburst) & burst_lengths)
+		return maxburst;
+
+	/* Hardware only does power-of-two bursts. */
+	for (u32 burst = rounddown_pow_of_two(maxburst); burst > 0; burst /= 2)
+		if (BIT(burst) & burst_lengths)
+			return burst;
+
+	return 1;
+}
+
 static int set_config(struct sun6i_dma_dev *sdev,
 			struct dma_slave_config *sconfig,
 			enum dma_transfer_direction direction,
@@ -616,15 +632,13 @@ static int set_config(struct sun6i_dma_dev *sdev,
 		return -EINVAL;
 	if (!(BIT(dst_addr_width) & sdev->slave.dst_addr_widths))
 		return -EINVAL;
-	if (!(BIT(src_maxburst) & sdev->cfg->src_burst_lengths))
-		return -EINVAL;
-	if (!(BIT(dst_maxburst) & sdev->cfg->dst_burst_lengths))
-		return -EINVAL;
 
 	src_width = convert_buswidth(src_addr_width);
 	dst_width = convert_buswidth(dst_addr_width);
-	dst_burst = convert_burst(dst_maxburst);
-	src_burst = convert_burst(src_maxburst);
+	src_burst = find_burst_size(sdev->cfg->src_burst_lengths, src_maxburst);
+	dst_burst = find_burst_size(sdev->cfg->dst_burst_lengths, dst_maxburst);
+	dst_burst = convert_burst(dst_burst);
+	src_burst = convert_burst(src_burst);
 
 	*p_cfg = DMA_CHAN_CFG_SRC_WIDTH(src_width) |
 		DMA_CHAN_CFG_DST_WIDTH(dst_width);
-- 
2.47.3


