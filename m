Return-Path: <dmaengine+bounces-3367-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6497199E978
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2024 14:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2BF282835
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2024 12:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643021F7091;
	Tue, 15 Oct 2024 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="vTMuzf//"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546191EC009;
	Tue, 15 Oct 2024 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994603; cv=none; b=h8QH3vdGh96+0VmKa7tfUKa1XoQ9p/+7VO1gbH/+SphyMFdYvR9c6MPj23NRHfxMUdyXDU+sA6xuPBl7aHKeRQtj05NHR0KCPxYb2+4m3PoWwzNZxG6Yuzdelu61SrwBBc59R1Gd2idKVnakctJToPG6soFeMWQouFW9gYkGKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994603; c=relaxed/simple;
	bh=0wMZjBiKbeWlkn1SVGWn4ELdfYW09IWr4QPh1pal+X8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZM1BCSR+JMJUt+/Rc8p6dqGhBBTeHICql/gatC1yo+uhai1gISCSTbDqBs3GAY5PvY+133KljxBqgpzM6I2HrNrjytqHc8qyjXJueJDZBkwCgImlrF582MoqEb7fV7+yDxn1vMetTglWLpp7HipV0yi7N/1lfP8K+S+ZUcDXZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=vTMuzf//; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FCDNIr007311;
	Tue, 15 Oct 2024 14:16:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	UZRhPTOG/vhlw4ceqD6czRH3HdQz/01xNzvZSqz2geU=; b=vTMuzf//+0bk1NhS
	N37pewjvwaYsJleKvwDYhYu/5QR8RwFxfzquExbgt2w9WXteGCE1o3OCrCias4VB
	Dbq4guOsaA+U7eLjszqoKsVgLbiGYEHNSP5+Gndabq6xkeqMEqJGDhlX1MhBMtKj
	nCahYVVMIggsxcl05DIcG8EzZ1R7nvKQA6mBQHq3u6nn2cBrHQCYVipvnWwLEcWL
	14OZzjDGycRW5qX1aHclklWnHMxV9Pw7voCNZiIoIjflou9HfdeuO8/utlsz1ZDH
	sm1sjXZ8ec9LrRRshhqS8MM8LBahf2og7Jz8WfVIStp+BIQH/4I9U7xZsRQcpHwi
	lNdjHQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4282p12r96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:16:31 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 08E4040052;
	Tue, 15 Oct 2024 14:15:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 25FBF222C93;
	Tue, 15 Oct 2024 14:14:50 +0200 (CEST)
Received: from localhost (10.48.87.35) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 15 Oct
 2024 14:14:49 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Tue, 15 Oct 2024 14:14:41 +0200
Subject: [PATCH v2 5/9] dmaengine: stm32-dma3: prevent LL refactoring
 thanks to DT configuration
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241015-dma3-mp25-updates-v2-5-b63e21556ec8@foss.st.com>
References: <20241015-dma3-mp25-updates-v2-0-b63e21556ec8@foss.st.com>
In-Reply-To: <20241015-dma3-mp25-updates-v2-0-b63e21556ec8@foss.st.com>
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
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
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
index 1d961f5935f935e3855467318cdcde6e6173e43c..fc874fec729df733fd8a6b4362fe1a937e9443c7 100644
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


