Return-Path: <dmaengine+bounces-3676-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422009B9E4A
	for <lists+dmaengine@lfdr.de>; Sat,  2 Nov 2024 10:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018FA281666
	for <lists+dmaengine@lfdr.de>; Sat,  2 Nov 2024 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9309F166302;
	Sat,  2 Nov 2024 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Zmni2bUr"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D937F155336;
	Sat,  2 Nov 2024 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730540174; cv=none; b=oz6fAldfn/rxf/HGdZZ1cgZVtZ4pxpxVyjYTJF0PUWM1T3XdFZeMzE7teyjrZa52zpTbetw26okqJFjgbJiu5rkqi+lMyRRM5sVOoOsiMAhBej+i9diERgVOY394Ii1LZZ01CNOofWI0phOqj1gBP8gdYdaxrb5I+d4+QQawoKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730540174; c=relaxed/simple;
	bh=zeXAIEsFUMmuU1POixTf74LalJUYReBKcOOBpIxkTIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTs/i8sfFSLM7n08ZRpiTRmpv1oe9I7k21KhzFkY/h2znR6yqBDObWJMO7ssrgzGD3BQxUFy/Yp9BXNlU0/iSi0qr61Vbmwkc4FlK9i5sKUZYjrTK/YyQ35Axnz4/PzhLjPtgYjw1IJp5CVozs2paiRh9jnJSml27FcToHqv1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Zmni2bUr; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 5E4E8A0B13;
	Sat,  2 Nov 2024 10:36:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=R+s79tNU1qd1nw+H4G/Q
	NlTSgR+QCMq5J2qciEy4mHk=; b=Zmni2bUr6o3F2ZEUehyEYpcfRGqeiTVWHpEL
	YECTREMh0iY3uaujQwwpw64TDhcr1T9YUtJzwlangm1FbrFscFJuisrJRlQByePb
	5yrLvtyTtLkqM8By8kEFHRk3RLSfCXbT5+ph9Au0RiRhT8i4svqP3NEAWRUD54ML
	CX2TlKD4FtYC0CJuen2ggz5C8l4jYILepX0+cP2kxLutuxZ8fYhRrt51wfDuehRb
	w1+83xGIJ+PEeMHPuQIpY1SGYiUi/bBwvLL4JbL5WCmJOvI6WowT4UMPtu9J8Sg3
	kfC1H7UUAnudiQI9sevYQYojHkOsqJ0vuPzxZHi0fcmD+dyserR2/SkTThFnqOCD
	cfl1DawDGC2VzWHghiVQXQGgrbgKDmXLo5t8h0KtVcIOfkBpG9lAFFHHw8czFpnc
	BGIlK7lehDChDTotixTA1AMT4BEaHb7S1fWJKpVpEantHWQzokyocKeCi1YQHufU
	LUZPsxlhzKGLeT6lZ57+Jm1E/qVoiWTqM+iRDY+rgGnpVk18x1uhFZbFM0ZCGCwg
	voMg37SNZ1rBoQuJ8J55P0f66ouVTv404li8ELQQ1B+d7NJ1xZ0YmgMSfvL4k7FE
	hynFnaxok2H5Kr3ygvpy0N6WI+j3uB8xpRzGJ+JlBtcbeJhN988jEQEMoj2Xh4e7
	wNChgQ4=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Vinod Koul
	<vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 4/5] dma-engine: sun4i: Add support for Allwinner suniv F1C100s
Date: Sat, 2 Nov 2024 10:31:43 +0100
Message-ID: <20241102093140.2625230-5-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241102093140.2625230-1-csokas.bence@prolan.hu>
References: <20241102093140.2625230-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730540170;VERSION=7979;MC=1301189787;ID=220021;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667067

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
index 9d1e3c51342d..e8c656f0ac63 100644
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
@@ -1376,8 +1413,31 @@ static struct sun4i_dma_config sun4i_a10_dma_cfg = {
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



