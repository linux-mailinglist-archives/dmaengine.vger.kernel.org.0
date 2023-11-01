Return-Path: <dmaengine+bounces-38-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF9A7DDDB4
	for <lists+dmaengine@lfdr.de>; Wed,  1 Nov 2023 09:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE098B20E63
	for <lists+dmaengine@lfdr.de>; Wed,  1 Nov 2023 08:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A35C6FAE;
	Wed,  1 Nov 2023 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A45C96
	for <dmaengine@vger.kernel.org>; Wed,  1 Nov 2023 08:25:04 +0000 (UTC)
X-Greylist: delayed 345 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Nov 2023 01:25:03 PDT
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16533103
	for <dmaengine@vger.kernel.org>; Wed,  1 Nov 2023 01:25:02 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6FC4C1A117F;
	Wed,  1 Nov 2023 09:19:16 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1FBF31A05BE;
	Wed,  1 Nov 2023 09:19:16 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5AA21180031E;
	Wed,  1 Nov 2023 16:19:14 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: vkoul@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shengjiu.wang@gmail.com,
	linux-imx@nxp.com,
	dmaengine@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: imx-sdma: support dual fifo for DEV_TO_DEV
Date: Wed,  1 Nov 2023 15:40:26 +0800
Message-Id: <1698824426-16111-1-git-send-email-shengjiu.wang@nxp.com>
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
---
 drivers/dma/imx-sdma.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index f81ecf5863e8..892e23cc0ce8 100644
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
@@ -1259,6 +1265,16 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
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


