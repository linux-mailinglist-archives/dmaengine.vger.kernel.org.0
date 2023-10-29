Return-Path: <dmaengine+bounces-6-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE09D7DAD61
	for <lists+dmaengine@lfdr.de>; Sun, 29 Oct 2023 18:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39001C2091A
	for <lists+dmaengine@lfdr.de>; Sun, 29 Oct 2023 17:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DE6CA7C;
	Sun, 29 Oct 2023 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org header.b="oy969q+1"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC2223DB
	for <dmaengine@vger.kernel.org>; Sun, 29 Oct 2023 17:01:18 +0000 (UTC)
Received: from hutie.ust.cz (hutie.ust.cz [IPv6:2a03:3b40:fe:f0::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60517F1;
	Sun, 29 Oct 2023 10:01:14 -0700 (PDT)
From: =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
	t=1698598869; bh=3obvFsIjM96yZObtxW8n9rYv9PO/4hd8o4iHKP3fPHU=;
	h=From:To:Cc:Subject:Date;
	b=oy969q+11rxbPH9cmRXxn2HzOTPuGmb0VMsz2ddR9KK/ynvf7bXNiYZ59vwv4s2By
	 i0bAABtuznqJQtxeSHwIhKUpL9GgtlZLi2tLJi4Es2OLo/FehsMGXHRSPmEROM6Cj2
	 9/C9VVpp43XUb2TQFXhnEdPFw/Geu2MCQp+l5uZE=
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Vinod Koul <vkoul@kernel.org>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20Povi=C5=A1er?= <povik@cutebit.org>
Subject: [PATCH] dmaengine: apple-admac: Keep upper bits of REG_BUS_WIDTH
Date: Sun, 29 Oct 2023 18:00:53 +0100
Message-Id: <20231029170053.82146-1-povik+lin@cutebit.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

For RX channels, REG_BUS_WIDTH seems to default to a value of 0xf00, and
macOS preserves the upper bits when setting the configuration in the
lower ones. If we reset the upper bits to 0, this causes framing errors
on suspend/resume (the data stream "tears" and channels get swapped
around). Keeping the upper bits untouched, like the macOS driver does,
fixes this issue.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Martin Povišer <povik@cutebit.org>
Signed-off-by: Martin Povišer <povik@cutebit.org>
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
2.38.3


