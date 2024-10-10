Return-Path: <dmaengine+bounces-3326-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0424C998A19
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 16:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229631C21535
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 14:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C131F942F;
	Thu, 10 Oct 2024 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Nh2OI18w"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032001F8EE2;
	Thu, 10 Oct 2024 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570711; cv=none; b=OeY/Off2JW4p117CecMULNFohlwH+uT0BRNyYKkJYPbxnX7uajxzKvjSmAjc25aB5xF+3nJLIii3Ykrqv+8qVp+uGBKt7fpQSV+GgD7KGr1SZOHXDfZ+pI+WFOHyVY130CxEtUBJDh4I/g4b10KB9zYgt1J5/qgm99eBeITInI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570711; c=relaxed/simple;
	bh=ziLr/jqssxHfBtXxCvrHUJOT1YFEuA8iq2VvAtTofxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BVySXR1zlVGpPSXohdvJefZPgyJQjchLxbFSpCXS6TKgXxepLSHssIQSPPDyCeN0jKvESNZElbknjj9G6gS7HAKmOioZOoM5rjBJ16POxLgwz9moiC0rhMT6XG9hFI1ay+Yv6xnqh3QqcJj6dxrXwxmNP4lbNkt2+LsosSM/rzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Nh2OI18w; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A930tE006178;
	Thu, 10 Oct 2024 16:31:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Ty8+muhODEf7J0IrMecw+ogQitNlh/rpZ3rOexp30rY=; b=Nh2OI18wLXAI8+Lt
	i30VVFCvEw3GvJLNR3FoRmi3WsdlQOLV+c7R4qXYrcrI3o92EJPpsl6vTilI++HR
	fm/XAPWcq0/EzdSk3m0yVUL/8yfzx7PDWw/YiNT3/ch/qtT5qGp8pfT62QzpQyzX
	p1O/sfUNekPki+XCILgsYHwgFXVP812Vo3zzmtHYENCHKwQjlE40JIPoWX6QptZW
	RxfgLaivCqdbK3PSDe8C35drSudv7iX6xVtEIp0JVN2KuDPtEf7MBekNGatZ8U5+
	Elxjdfp1oAbDGgNWlRab0bl2uj6kzel956C9RoWWloAxbE5TLHMLj7P4eTqu6e4+
	hbI3Tg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 425w7xmw5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 16:31:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 411534008C;
	Thu, 10 Oct 2024 16:30:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 50C85299278;
	Thu, 10 Oct 2024 16:28:10 +0200 (CEST)
Received: from localhost (10.252.31.182) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 10 Oct
 2024 16:28:10 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Thu, 10 Oct 2024 16:27:55 +0200
Subject: [PATCH 05/11] dmaengine: stm32-dma3: prevent LL refactoring thanks
 to DT configuration
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241010-dma3-mp25-updates-v1-5-adf0633981ea@foss.st.com>
References: <20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com>
In-Reply-To: <20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

stm32-dma3 driver refactors the linked-list in order to address the memory
with the highest possible data width.
It means that it can introduce up to 2 linked-list items. One with a
transfer length multiple of channel maximum burst length and so with the
highest possible data width. And an extra one with the latest bytes, with
lower data width.
Some devices (e.g. FMC ECC) don't support having several transfers instead
of only one.
So add the possibility to prevent linked-list refactoring, when bit 17 of
the 'DMA transfer requirements' bit mask is set in device tree.
When NOPACK feature is used (bit 16 pf the 'DMA transfer requirements' bit
mask in device tree), linked-list refactoring can be avoided, since the
memory data width and burst will be aligned with the device ones.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-dma3.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 8cb112dc5e057d4832ca7e8bb38c548ae7e269c3..1467308dd27c4674b13d2740c05087b1338fd91a 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -222,6 +222,7 @@ enum stm32_dma3_port_data_width {
 #define STM32_DMA3_DT_PFREQ		BIT(9) /* CTR2_PFREQ */
 #define STM32_DMA3_DT_TCEM		GENMASK(13, 12) /* CTR2_TCEM */
 #define STM32_DMA3_DT_NOPACK		BIT(16) /* CTR1_PAM */
+#define STM32_DMA3_DT_NOREFACT		BIT(17)
 
 /* struct stm32_dma3_chan .config_set bitfield */
 #define STM32_DMA3_CFG_SET_DT		BIT(0)
@@ -1126,10 +1127,13 @@ static void stm32_dma3_free_chan_resources(struct dma_chan *c)
 	chan->config_set = 0;
 }
 
-static u32 stm32_dma3_get_ll_count(struct stm32_dma3_chan *chan, size_t len)
+static u32 stm32_dma3_get_ll_count(struct stm32_dma3_chan *chan, size_t len, bool prevent_refactor)
 {
 	u32 count;
 
+	if (prevent_refactor)
+		return DIV_ROUND_UP(len, STM32_DMA3_MAX_BLOCK_SIZE);
+
 	count = len / STM32_DMA3_MAX_BLOCK_SIZE;
 	len -= (len / STM32_DMA3_MAX_BLOCK_SIZE) * STM32_DMA3_MAX_BLOCK_SIZE;
 
@@ -1179,8 +1183,10 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_dma_memcpy(struct dma_cha
 	struct stm32_dma3_swdesc *swdesc;
 	size_t next_size, offset;
 	u32 count, i, ctr1, ctr2;
+	bool prevent_refactor = !!FIELD_GET(STM32_DMA3_DT_NOPACK, chan->dt_config.tr_conf) ||
+				!!FIELD_GET(STM32_DMA3_DT_NOREFACT, chan->dt_config.tr_conf);
 
-	count = stm32_dma3_get_ll_count(chan, len);
+	count = stm32_dma3_get_ll_count(chan, len, prevent_refactor);
 
 	swdesc = stm32_dma3_chan_desc_alloc(chan, count);
 	if (!swdesc)
@@ -1196,7 +1202,8 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_dma_memcpy(struct dma_cha
 		remaining = len - offset;
 		next_size = min_t(size_t, remaining, STM32_DMA3_MAX_BLOCK_SIZE);
 
-		if (next_size < STM32_DMA3_MAX_BLOCK_SIZE && next_size >= chan->max_burst)
+		if (!prevent_refactor &&
+		    (next_size < STM32_DMA3_MAX_BLOCK_SIZE && next_size >= chan->max_burst))
 			next_size = chan->max_burst * (remaining / chan->max_burst);
 
 		ret = stm32_dma3_chan_prep_hw(chan, DMA_MEM_TO_MEM, &swdesc->ccr, &ctr1, &ctr2,
@@ -1235,11 +1242,13 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_slave_sg(struct dma_chan
 	size_t len;
 	dma_addr_t sg_addr, dev_addr, src, dst;
 	u32 i, j, count, ctr1, ctr2;
+	bool prevent_refactor = !!FIELD_GET(STM32_DMA3_DT_NOPACK, chan->dt_config.tr_conf) ||
+				!!FIELD_GET(STM32_DMA3_DT_NOREFACT, chan->dt_config.tr_conf);
 	int ret;
 
 	count = 0;
 	for_each_sg(sgl, sg, sg_len, i)
-		count += stm32_dma3_get_ll_count(chan, sg_dma_len(sg));
+		count += stm32_dma3_get_ll_count(chan, sg_dma_len(sg), prevent_refactor);
 
 	swdesc = stm32_dma3_chan_desc_alloc(chan, count);
 	if (!swdesc)
@@ -1256,7 +1265,8 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_slave_sg(struct dma_chan
 		do {
 			size_t chunk = min_t(size_t, len, STM32_DMA3_MAX_BLOCK_SIZE);
 
-			if (chunk < STM32_DMA3_MAX_BLOCK_SIZE && chunk >= chan->max_burst)
+			if (!prevent_refactor &&
+			    (chunk < STM32_DMA3_MAX_BLOCK_SIZE && chunk >= chan->max_burst))
 				chunk = chan->max_burst * (len / chan->max_burst);
 
 			if (dir == DMA_MEM_TO_DEV) {

-- 
2.25.1


