Return-Path: <dmaengine+bounces-5669-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DC3AEBAE3
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 17:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153A21C22EA9
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5450F2E888A;
	Fri, 27 Jun 2025 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVXhzY7H"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6852D3EF2
	for <dmaengine@vger.kernel.org>; Fri, 27 Jun 2025 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751036421; cv=none; b=s/CHUYb0lhID+MTd6QltJqTOrj2mPFVfdCjWvryAxE5oom9GnjU7M9iAUp1KabL21b1Ur55XIFxZ1SY4rPbtAhTwV3UaTuG1YdHCpJdhCz4hgS9VMEx55pJhA5Ad5YLvxaXdZuje2h62JPRtiMVOzoDVVsaD8Z3c0DucvGEspMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751036421; c=relaxed/simple;
	bh=S7kC617fabBtf6MIBMBTxBjL8hB4hHAfOzWK1VEF5VU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T9nGcZJcdnd9i0Tso4W84FITkjAtXtBC4/cWbXbWKRAjayc+RHO64ym+jSIt5HWJixssvcmaU6FNrgb/PeFhoU0qTm/qFHMC73wUukJLTnULhX876SEy4n+gtY66aIkTlQrhM1hswSxEaiFofMYvShOfVSttFetRV8J1D0bjo9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVXhzY7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E688EC4CEF4;
	Fri, 27 Jun 2025 15:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751036420;
	bh=S7kC617fabBtf6MIBMBTxBjL8hB4hHAfOzWK1VEF5VU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aVXhzY7Hoit1Jbqe4O0nSyVYWcbHc7S+QiUn8PgBrNUSBHqZ1Pn28y1LvTAji2vmk
	 mXTwQ/lhLkMzSzn6yAr4MS0lGzO4G6bdnTyI96bX8RyjICwCaKqgW3nF+KmctUJY7i
	 hXmSxDdowY/FegEHxkIgGcZKAgUv2jb3goFOR7oBb2rrgdxuKLE9uTzwYsZn7wU6v/
	 K5cK5NpManXL7LwKhup9z4CoUkAkdgC9sY51f4GIqC279iv8Cc+HeaiIkqbbPFq/aL
	 NrelgkHzYF/1DBOWrPYHQf5d+RTzf9BrpEyeXh1yhjpjcBQ3Qq5Qgof/BKeq88TXna
	 LWbdk9P2S3sBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEACC83013;
	Fri, 27 Jun 2025 15:00:20 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 27 Jun 2025 16:00:21 +0100
Subject: [PATCH RESEND 3/4] dma: dma-axi-dmac: support bigger than 32bits
 addresses
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250627-dev-axi-dmac-fixes-v1-3-2453674c5b78@analog.com>
References: <20250627-dev-axi-dmac-fixes-v1-0-2453674c5b78@analog.com>
In-Reply-To: <20250627-dev-axi-dmac-fixes-v1-0-2453674c5b78@analog.com>
To: dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751036430; l=3179;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ZGxrN1xnwf4y1YWWtMB/bP7zKhMataEa5fI5QDXT05s=;
 b=VCO40+pEBcCqagdrr52vjfC5mhqstIrgUdX/czpGMMKbbuGZK14N6X4iCSrjBHvp5iKeGA7E4
 wgeITcQnhWJDRUcRXD4RNBEgLxSkO16+EYw1J6LDaXKnbh4007mP7Yl
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

In some supported platforms as ARCH_ZYNQMP, part of the memory is mapped
above 32bit addresses and since the DMA mask, by default, is set to 32bits,
we would need to rely on swiotlb (which incurs a performance penalty)
for the DMA mappings. Thus, we can write either the SRC or DEST high
addresses with 1's and read them back. The last bit set on the return
value will reflect the IP address bus width and so we can update the
device DMA mask accordingly.

While at it, support bigger that 32 bits transfers in IP without HW
scatter gather support.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 47d95d2d743b1b939ed0ec79ee29763843bcdc09..25717a6ea9848b6c591a3ab6adb27c6f21f002b9 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -69,7 +69,9 @@
 #define AXI_DMAC_REG_START_TRANSFER	0x408
 #define AXI_DMAC_REG_FLAGS		0x40c
 #define AXI_DMAC_REG_DEST_ADDRESS	0x410
+#define AXI_DMAC_REG_DEST_ADDRESS_HIGH	0x490
 #define AXI_DMAC_REG_SRC_ADDRESS	0x414
+#define AXI_DMAC_REG_SRC_ADDRESS_HIGH	0x494
 #define AXI_DMAC_REG_X_LENGTH		0x418
 #define AXI_DMAC_REG_Y_LENGTH		0x41c
 #define AXI_DMAC_REG_DEST_STRIDE	0x420
@@ -271,11 +273,14 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 	if (!chan->hw_sg) {
 		if (axi_dmac_dest_is_mem(chan)) {
 			axi_dmac_write(dmac, AXI_DMAC_REG_DEST_ADDRESS, sg->hw->dest_addr);
+			axi_dmac_write(dmac, AXI_DMAC_REG_DEST_ADDRESS_HIGH,
+				       sg->hw->dest_addr >> 32);
 			axi_dmac_write(dmac, AXI_DMAC_REG_DEST_STRIDE, sg->hw->dst_stride);
 		}
 
 		if (axi_dmac_src_is_mem(chan)) {
 			axi_dmac_write(dmac, AXI_DMAC_REG_SRC_ADDRESS, sg->hw->src_addr);
+			axi_dmac_write(dmac, AXI_DMAC_REG_SRC_ADDRESS_HIGH, sg->hw->src_addr >> 32);
 			axi_dmac_write(dmac, AXI_DMAC_REG_SRC_STRIDE, sg->hw->src_stride);
 		}
 	}
@@ -990,6 +995,9 @@ static int axi_dmac_read_chan_config(struct device *dev, struct axi_dmac *dmac)
 static int axi_dmac_detect_caps(struct axi_dmac *dmac, unsigned int version)
 {
 	struct axi_dmac_chan *chan = &dmac->chan;
+	struct device *dev = dmac->dma_dev.dev;
+	u32 mask;
+	int ret;
 
 	axi_dmac_write(dmac, AXI_DMAC_REG_FLAGS, AXI_DMAC_FLAG_CYCLIC);
 	if (axi_dmac_read(dmac, AXI_DMAC_REG_FLAGS) == AXI_DMAC_FLAG_CYCLIC)
@@ -1024,6 +1032,22 @@ static int axi_dmac_detect_caps(struct axi_dmac *dmac, unsigned int version)
 		return -ENODEV;
 	}
 
+	if (axi_dmac_dest_is_mem(chan)) {
+		axi_dmac_write(dmac, AXI_DMAC_REG_DEST_ADDRESS_HIGH, 0xffffffff);
+		mask = axi_dmac_read(dmac, AXI_DMAC_REG_DEST_ADDRESS_HIGH);
+	} else {
+		axi_dmac_write(dmac, AXI_DMAC_REG_SRC_ADDRESS_HIGH, 0xffffffff);
+		mask = axi_dmac_read(dmac, AXI_DMAC_REG_SRC_ADDRESS_HIGH);
+	}
+
+	mask = 32 + fls(mask);
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(mask));
+	if (ret) {
+		dev_err(dev, "DMA mask set error %d\n", ret);
+		return ret;
+	}
+
 	if (version >= ADI_AXI_PCORE_VER(4, 2, 'a'))
 		chan->hw_partial_xfer = true;
 

-- 
2.49.0



