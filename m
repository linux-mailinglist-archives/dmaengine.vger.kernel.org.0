Return-Path: <dmaengine+bounces-3603-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF299B1CB0
	for <lists+dmaengine@lfdr.de>; Sun, 27 Oct 2024 10:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2261A1F215BE
	for <lists+dmaengine@lfdr.de>; Sun, 27 Oct 2024 09:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1AD762E0;
	Sun, 27 Oct 2024 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="peYzhbck"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA94433D0;
	Sun, 27 Oct 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730020863; cv=none; b=X4mGKj+ES6tcvbGsG7ow/KmzVW8q1BcYSl8mIy9YTpkGUKUeLLE9Uwg65sI/fJu20aI+EhKrpCQY9AniGD0hUyYEX4xRI+g6Tf5BaMQJlrCoky3xzy3AKnHSbGH0pjs1VLIFCGvgAF+PpInpqb0uToK2ZMmJLmoQPOMz1Y1AB2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730020863; c=relaxed/simple;
	bh=Udk2D3bPQa/VRBXaI/JkL47MYkVvJvr2ZMxMf3jtQss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNX8FkfgYmxJw0yzpuhBWSm0P67PdZI79eQFo1XoiLQvJ9tlmhRVnX9ITXJUNI2jtMat/9ePUW/cd9ql/FBMiCUsBtHzqo5p+LOugEc9/dkxS0iA46SI7X9wuPFAE/5esXFyD/Rw8nwQR97WFcivg6iJ5Apy9bgu2kX4A+uTMfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=peYzhbck; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 67977A064A;
	Sun, 27 Oct 2024 10:20:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ZDNKPYZEifl3ipQUUda/
	JljLACm3upo4aMWFTa7LXdA=; b=peYzhbckZTAnjTcS48bdzBak4B5XRxE7XR8M
	t2gnUOrZkNyk2sObNx5dXJiJCqfZWjOgl+TNYNgL2gFqQAAvztUDByt2RryQTXbt
	mHAatWI9YRGgcD7A2UMW/oelxh0sCR6fBkpuwRjuNN519BX4i4lbKyi+DqWeZBEv
	X/ewrogjOEROS3SlDH/bzJmJdNtEVZjAlG1zLco7+fyngPjLBv2DF9MQspypj78c
	SWnz/w7kVx2vDMUECr/FU76gLMQll4y+0ybGmJ5JKQrHR2v/gEyOcPphNFkwMJl9
	8H9c8oPBlsz4D4+uyYWoDVG/ocdqBN+yeRIWD2XT1G0Mt6+NxfYx1DGWOmy8SrGO
	kFMyc/i6xf4A5N1xJe5537SHVr7r9Tm3PFHY8kTQhqxr/LMS2ixcXqYGTbyhTH+b
	ThX7oc4pilQdGHFtQLZNlwtKNd3SYX4Sx60DtjGZZE/a/sZ+7houK9A9DRcXDvUJ
	dI4ACrnEIHEsJVaMZVOHYMMO/mRZcJTY02mVCnC+cBZi9zaHuzsAhzdVdXeBZvg3
	IShO0uMOAtEhOApzuQaFrU/xwyFwjkGUk8/zXhgzSHfXxr4NUcx1Do1rkBxJ6deu
	9vsnZS/BnJj6LTUI3xHUItBT5ag/IB5L4eaoRq2fos+5vaLvCKP1nVb2179n0r6s
	SOFEWPw=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Vinod Koul
	<vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 04/10] dma-engine: sun4i: Add support for Allwinner suniv F1C100s
Date: Sun, 27 Oct 2024 10:14:35 +0100
Message-ID: <20241027091440.1913863-4-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241027091440.1913863-1-csokas.bence@prolan.hu>
References: <20241027091440.1913863-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730020858;VERSION=7978;MC=1001936460;ID=156040;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855677D65

From: Mesih Kilinc <mesihkilinc@gmail.com>

DMA of Allwinner suniv F1C100s is similar to sun4i. It has 4 NDMA, 4
DDMA channels and endpoints are different. Also F1C100s has reset bit
for DMA in CCU. Add support for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
[ csokas.bence: Rebased on current master ]
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/dma/Kconfig     |  4 +--
 drivers/dma/sun4i-dma.c | 60 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d9ec1e69e428..fc25bfc356f3 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -162,8 +162,8 @@ config DMA_SA11X0
 
 config DMA_SUN4I
 	tristate "Allwinner A10 DMA SoCs support"
-	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I
-	default (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I)
+	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNIV
+	default (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNIV)
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index 0a45089461e1..cb52976b56aa 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -33,7 +33,11 @@
 #define SUN4I_DMA_CFG_SRC_ADDR_MODE(mode)	((mode) << 5)
 #define SUN4I_DMA_CFG_SRC_DRQ_TYPE(type)	(type)
 
+#define SUNIV_DMA_CFG_DST_DATA_WIDTH(width)	((width) << 24)
+#define SUNIV_DMA_CFG_SRC_DATA_WIDTH(width)	((width) << 8)
+
 #define SUN4I_MAX_BURST	8
+#define SUNIV_MAX_BURST	4
 
 /** Normal DMA register values **/
 
@@ -41,6 +45,9 @@
 #define SUN4I_NDMA_DRQ_TYPE_SDRAM		0x16
 #define SUN4I_NDMA_DRQ_TYPE_LIMIT		(0x1F + 1)
 
+#define SUNIV_NDMA_DRQ_TYPE_SDRAM		0x11
+#define SUNIV_NDMA_DRQ_TYPE_LIMIT		(0x17 + 1)
+
 /** Normal DMA register layout **/
 
 /* Dedicated DMA source/destination address mode values */
@@ -54,6 +61,9 @@
 #define SUN4I_NDMA_CFG_BYTE_COUNT_MODE_REMAIN	BIT(15)
 #define SUN4I_NDMA_CFG_SRC_NON_SECURE		BIT(6)
 
+#define SUNIV_NDMA_CFG_CONT_MODE		BIT(29)
+#define SUNIV_NDMA_CFG_WAIT_STATE(n)		((n) << 26)
+
 /** Dedicated DMA register values **/
 
 /* Dedicated DMA source/destination address mode values */
@@ -66,6 +76,9 @@
 #define SUN4I_DDMA_DRQ_TYPE_SDRAM		0x1
 #define SUN4I_DDMA_DRQ_TYPE_LIMIT		(0x1F + 1)
 
+#define SUNIV_DDMA_DRQ_TYPE_SDRAM		0x1
+#define SUNIV_DDMA_DRQ_TYPE_LIMIT		(0x9 + 1)
+
 /** Dedicated DMA register layout **/
 
 /* Dedicated DMA configuration register layout */
@@ -119,6 +132,11 @@
 #define SUN4I_DMA_NR_MAX_VCHANS						\
 	(SUN4I_NDMA_NR_MAX_VCHANS + SUN4I_DDMA_NR_MAX_VCHANS)
 
+#define SUNIV_NDMA_NR_MAX_CHANNELS	4
+#define SUNIV_DDMA_NR_MAX_CHANNELS	4
+#define SUNIV_NDMA_NR_MAX_VCHANS	(24 * 2 - 1)
+#define SUNIV_DDMA_NR_MAX_VCHANS	10
+
 /* This set of SUN4I_DDMA timing parameters were found experimentally while
  * working with the SPI driver and seem to make it behave correctly */
 #define SUN4I_DDMA_MAGIC_SPI_PARAMETERS \
@@ -243,6 +261,16 @@ static void set_src_data_width_a10(u32 *p_cfg, s8 data_width)
 	*p_cfg |= SUN4I_DMA_CFG_SRC_DATA_WIDTH(data_width);
 }
 
+static void set_dst_data_width_f1c100s(u32 *p_cfg, s8 data_width)
+{
+	*p_cfg |= SUNIV_DMA_CFG_DST_DATA_WIDTH(data_width);
+}
+
+static void set_src_data_width_f1c100s(u32 *p_cfg, s8 data_width)
+{
+	*p_cfg |= SUNIV_DMA_CFG_SRC_DATA_WIDTH(data_width);
+}
+
 static int convert_burst_a10(u32 maxburst)
 {
 	if (maxburst > 8)
@@ -252,6 +280,15 @@ static int convert_burst_a10(u32 maxburst)
 	return (maxburst >> 2);
 }
 
+static int convert_burst_f1c100s(u32 maxburst)
+{
+	if (maxburst > 4)
+		return -EINVAL;
+
+	/* 1 -> 0, 4 -> 1 */
+	return (maxburst >> 2);
+}
+
 static int convert_buswidth(enum dma_slave_buswidth addr_width)
 {
 	if (addr_width > DMA_SLAVE_BUSWIDTH_4_BYTES)
@@ -1379,8 +1416,31 @@ static struct sun4i_dma_config sun4i_a10_dma_cfg = {
 	.has_reset		= false,
 };
 
+static struct sun4i_dma_config suniv_f1c100s_dma_cfg = {
+	.ndma_nr_max_channels	= SUNIV_NDMA_NR_MAX_CHANNELS,
+	.ndma_nr_max_vchans	= SUNIV_NDMA_NR_MAX_VCHANS,
+
+	.ddma_nr_max_channels	= SUNIV_DDMA_NR_MAX_CHANNELS,
+	.ddma_nr_max_vchans	= SUNIV_DDMA_NR_MAX_VCHANS,
+
+	.dma_nr_max_channels	= SUNIV_NDMA_NR_MAX_CHANNELS +
+		SUNIV_DDMA_NR_MAX_CHANNELS,
+
+	.set_dst_data_width	= set_dst_data_width_f1c100s,
+	.set_src_data_width	= set_src_data_width_f1c100s,
+	.convert_burst		= convert_burst_f1c100s,
+
+	.ndma_drq_sdram		= SUNIV_NDMA_DRQ_TYPE_SDRAM,
+	.ddma_drq_sdram		= SUNIV_DDMA_DRQ_TYPE_SDRAM,
+
+	.max_burst		= SUNIV_MAX_BURST,
+	.has_reset		= true,
+};
+
 static const struct of_device_id sun4i_dma_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-dma", .data = &sun4i_a10_dma_cfg },
+	{ .compatible = "allwinner,suniv-f1c100s-dma",
+		.data = &suniv_f1c100s_dma_cfg },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun4i_dma_match);
-- 
2.34.1



