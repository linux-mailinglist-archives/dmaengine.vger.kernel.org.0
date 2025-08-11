Return-Path: <dmaengine+bounces-5985-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71386B2111E
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 18:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADC41882BE7
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 16:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225562D47ED;
	Mon, 11 Aug 2025 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHupAYGb"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF542D47EB
	for <dmaengine@vger.kernel.org>; Mon, 11 Aug 2025 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927797; cv=none; b=pimEWSKFS1tTnifeSsuy50mo8lxHhMgyfdhalWcblcHn71pTIUOelfCQgFnNcxOzjYhjd/qUPGSOhoI7TgpwjZQ/R4GHLEwfPCvuQ4x0ZrfpFL4YbfJR6BfW0ZE4qb76U0xvTgCHqdcsdC9x45K6yFXIq0nq9lStwkN6Md9GAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927797; c=relaxed/simple;
	bh=L8nn5AwUxK6fblpo+QPmWNM1XobElLybeiHdI3Xezdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jLbAF13VWWxL926yRu9LqkuW3PwLDkVjcHhBKApe4LFWthPcrZHaGca13hgTjJs0mySXrkevy0fiV/Yj10XzW1B0tguEjY2kaj4tz4ZvZQTk2s5TlTuwjpLlNHyf/a0qDtbZv/EVO7mXAb7u8683F6lJDvEEAUTSb/3nLYOWeeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHupAYGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C90F7C4CEF8;
	Mon, 11 Aug 2025 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754927796;
	bh=L8nn5AwUxK6fblpo+QPmWNM1XobElLybeiHdI3Xezdw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IHupAYGbR48ZsvRWP9ujsQWnp7YP9SBjIeHkiB/1tmJFnLqR4QML0Q69NO5dkO8zK
	 C/wIw3IvBWnJR61RhNZiRPhJb3n1Vhvryf1yL/KObA8z7SBANQAgKAcJM6XE6PEFd0
	 ffz3SW8ub0TGSCKGU/czvEeOczW8xtprTFj2areEnMmcadmhVJtTu6UVi7EtmI1sZI
	 cg5Zl/9liK3BEGMCLHiPicV8/NDr6oI9BeX0mkbW6l5iMX0bwe8E7PmmHDokxUr3hc
	 iW2GTnpaiFLOPba8TJce/I7NFnQvwbyoPTt9Ka/xDCwaj1sH5hc2CzkA3yd7cZC7ma
	 Elra4Zloq8gRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9697CA0ED1;
	Mon, 11 Aug 2025 15:56:36 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 11 Aug 2025 16:56:38 +0100
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
Message-Id: <20250811-dev-axi-dmac-fixes-v1-3-8d9895f6003f@analog.com>
References: <20250811-dev-axi-dmac-fixes-v1-0-8d9895f6003f@analog.com>
In-Reply-To: <20250811-dev-axi-dmac-fixes-v1-0-8d9895f6003f@analog.com>
To: dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754927814; l=3179;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ZsikNgN4By3w8azbKVO4HqwHd6u+j+7UKUaZJJOjNQY=;
 b=dwEqxeJmqh/2UG2oO8/3DP6fexh6pBsofuKLON+KJ2i4CEvY8pohuc0bqXJvhSM/Hut05CZj0
 8X6x5RgSzV3D7hC1AeX9mgRj/IQBj7BsZf+PX8WsSTE2cxZMjmqlkVS
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
2.50.1



