Return-Path: <dmaengine+bounces-867-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D824841217
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 19:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5028E1C2091F
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 18:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD64241EC;
	Mon, 29 Jan 2024 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2k0G+JP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD8C12E47;
	Mon, 29 Jan 2024 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553283; cv=none; b=HQkqdaTI6o341x/LzgFT7UU16DyRyG3ACVpELCKLRZRSqZaqAWKwZOQ35iYRwkaMUEbjZvckqoWlivx5KELyRlxelY//GId04HZ4ETcJUzFe22dLpBuS24vANAKtos3x4JaXL3yD+zLsBHb8+43WHzc314HR/+XbCKgwXTYaf/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553283; c=relaxed/simple;
	bh=Wfk4yPeASuxwl48Oyf/iy94v6/Ove6zw/HOC6KbRDiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bZUL3q3WVKlcnnz1n0TwmEQD7fMIwOFf03V6bKajL0CAsUUdtFZw8vK8/BjCT8kz5abk9PAsgGAy3AuQQnUPP1kBq7RnTE1bMm6Z6e2dwt9DCMPl5tVuRVRAR+VYtqG1tlSYODFfP6+SKJol3pT8QfZBJVcgrIBB/tu/GC7n/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2k0G+JP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477ACC433F1;
	Mon, 29 Jan 2024 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553283;
	bh=Wfk4yPeASuxwl48Oyf/iy94v6/Ove6zw/HOC6KbRDiE=;
	h=From:To:Cc:Subject:Date:From;
	b=F2k0G+JPOks06KgR3j6gUbiPLuWkGZX9w+VHdYe6NRSMDEl9Hbd4DpubRu8sdKsRU
	 fek81S/M1xvYMm/ZJGH9iQOu2glPNqK5F9qyOVek5ptYvckHXoGz3Nz0WTe1iVMzE9
	 7iy6OOAc1LQWFC+FBSL46K6851kRJ3b1uc7dxPxCEXcpNUQ/Pz9r4WGXdi0Ep2UVy+
	 KHmhQKG8jepPGXgVSPsPTlSH4Reh87MaC0d9t7AoewqZl2XtIUFmOnHaQpAwoJvRXe
	 fayJGNnIu838VlL78u3vocEPh/37NuYUuw/YUwbmV0cBMxMHoXZpUKUW/hz9VP0MrU
	 7cJzZs8eqwA0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hector Martin <marcan@marcan.st>,
	=?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sven@svenpeter.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 01/12] dmaengine: apple-admac: Keep upper bits of REG_BUS_WIDTH
Date: Mon, 29 Jan 2024 13:34:10 -0500
Message-ID: <20240129183440.463998-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

[ Upstream commit 306f5df81fcc89b462fbeb9dbe26d9a8ad7c7582 ]

For RX channels, REG_BUS_WIDTH seems to default to a value of 0xf00, and
macOS preserves the upper bits when setting the configuration in the
lower ones. If we reset the upper bits to 0, this causes framing errors
on suspend/resume (the data stream "tears" and channels get swapped
around). Keeping the upper bits untouched, like the macOS driver does,
fixes this issue.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Link: https://lore.kernel.org/r/20231029170704.82238-1-povik+lin@cutebit.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/apple-admac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
index 5b63996640d9..9588773dd2eb 100644
--- a/drivers/dma/apple-admac.c
+++ b/drivers/dma/apple-admac.c
@@ -57,6 +57,8 @@
 
 #define REG_BUS_WIDTH(ch)	(0x8040 + (ch) * 0x200)
 
+#define BUS_WIDTH_WORD_SIZE	GENMASK(3, 0)
+#define BUS_WIDTH_FRAME_SIZE	GENMASK(7, 4)
 #define BUS_WIDTH_8BIT		0x00
 #define BUS_WIDTH_16BIT		0x01
 #define BUS_WIDTH_32BIT		0x02
@@ -740,7 +742,8 @@ static int admac_device_config(struct dma_chan *chan,
 	struct admac_data *ad = adchan->host;
 	bool is_tx = admac_chan_direction(adchan->no) == DMA_MEM_TO_DEV;
 	int wordsize = 0;
-	u32 bus_width = 0;
+	u32 bus_width = readl_relaxed(ad->base + REG_BUS_WIDTH(adchan->no)) &
+		~(BUS_WIDTH_WORD_SIZE | BUS_WIDTH_FRAME_SIZE);
 
 	switch (is_tx ? config->dst_addr_width : config->src_addr_width) {
 	case DMA_SLAVE_BUSWIDTH_1_BYTE:
-- 
2.43.0


