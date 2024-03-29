Return-Path: <dmaengine+bounces-1650-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823B7891226
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 04:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E4E1F22D1E
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 03:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5BD39FD9;
	Fri, 29 Mar 2024 03:45:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5208239FC3;
	Fri, 29 Mar 2024 03:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711683919; cv=none; b=J3kD4BBQvH7ur/+Z/tHgOqQibL0FhC9KsxZkzdcV3+0+dzlfBXZWA+Q5LBsf22rxafcllk7HiBk5OqBqtyu0dyj9D5ocqYWOQHxbbexoZk2x09LFQWJeFrCrzGcIU77Ra1VaZUPpa1DxTjb2PZ1ilajS0LKivOFqsx6KLS+VlA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711683919; c=relaxed/simple;
	bh=Lg8RQNfQWRVNjwDCPa0PeRNPU4BSAxRxHYfrnD7JNsk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=s7U27mI7qxV1k1iI195QQZlC6tizGcWQqkp/oO8gZNUCJFzbQXXyoS1El4Q8LL2entLTFSPZgwhyXBnxXXJEuv4NZ0JqymHBV2BmM378YwMwYU72y+6lBGeKA2XIxo1/EWNXQ4yLB/Q8Sm7Vp+2K+yflF+GT/K1kF7RgiqjCIkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E0945200820;
	Fri, 29 Mar 2024 04:45:10 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 964112011A8;
	Fri, 29 Mar 2024 04:45:10 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CB5DA180222F;
	Fri, 29 Mar 2024 11:45:08 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: vkoul@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shengjiu.wang@gmail.com,
	linux-imx@nxp.com,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] dmaengine: imx-sdma: support dual fifo for DEV_TO_DEV
Date: Fri, 29 Mar 2024 11:28:07 +0800
Message-Id: <1711682887-15676-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

SSI and SPDIF are dual fifo interface, when support ASRC P2P
with SSI and SPDIF, the src fifo or dst fifo number can be
two.

The p2p watermark level bit 13 and 14 are designed for
these use case. This patch is to complete this function
in driver.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Acked-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/dma/imx-sdma.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 9b42f5e96b1e..079e6e8f4f59 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -137,7 +137,11 @@
  *						0: Source on AIPS
  *	12		Destination Bit(DP)	1: Destination on SPBA
  *						0: Destination on AIPS
- *	13-15		---------		MUST BE 0
+ *	13		Source FIFO		1: Source is dual FIFO
+ *						0: Source is single FIFO
+ *	14		Destination FIFO	1: Destination is dual FIFO
+ *						0: Destination is single FIFO
+ *	15		---------		MUST BE 0
  *	16-23		Higher WML		HWML
  *	24-27		N			Total number of samples after
  *						which Pad adding/Swallowing
@@ -168,6 +172,8 @@
 #define SDMA_WATERMARK_LEVEL_SPDIF	BIT(10)
 #define SDMA_WATERMARK_LEVEL_SP		BIT(11)
 #define SDMA_WATERMARK_LEVEL_DP		BIT(12)
+#define SDMA_WATERMARK_LEVEL_SD		BIT(13)
+#define SDMA_WATERMARK_LEVEL_DD		BIT(14)
 #define SDMA_WATERMARK_LEVEL_HWML	(0xFF << 16)
 #define SDMA_WATERMARK_LEVEL_LWE	BIT(28)
 #define SDMA_WATERMARK_LEVEL_HWE	BIT(29)
@@ -1255,6 +1261,16 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_DP;
 
 	sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_CONT;
+
+	/*
+	 * Limitation: The p2p script support dual fifos in maximum,
+	 * So when fifo number is larger than 1, force enable dual
+	 * fifos.
+	 */
+	if (sdmac->n_fifos_src > 1)
+		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_SD;
+	if (sdmac->n_fifos_dst > 1)
+		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_DD;
 }
 
 static void sdma_set_watermarklevel_for_sais(struct sdma_channel *sdmac)
-- 
2.34.1


