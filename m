Return-Path: <dmaengine+bounces-3379-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AFF9A0A86
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2024 14:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0511CB21AA7
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2024 12:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930CB20ADDE;
	Wed, 16 Oct 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="mXAy5qPF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DF341C69;
	Wed, 16 Oct 2024 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082596; cv=none; b=YXVUJ+bN58ghjPckIDdwZm/rlro+SS3bGj6uh2nCn+TXbLXI6wLWzM2Ni5n7DSLfGoK1ZTxc7PckhUoDjzU6MluoWN39iIUw1oUUqF2EDjPWtC5vqsNIOXxD82AL43R+d6dUAmhtzQU6u6rTQRn+Trgt0wWRvxRZzy9OUGK3mEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082596; c=relaxed/simple;
	bh=HgMME6IRDHpuIAaHCfRr6oI+t6HtahI4szIwGwlqa4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=W4bTwNcVdv2Kb6CBF9vSEvcJ9hh2q+5eGDXzrzlg0g1UWtS05ahMvzRkvY7DOrEZr3Nf/5oeQY7AG8DtwC9zzgvT+yfTBwj/uaLUJ81FhyfybDK7fBQlJ5QBE5HCXACHSEYKbzfQYPJUuxS77zdMPG2gbfrc3BZKI+xs0sCPQKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=mXAy5qPF; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GAbVYW018447;
	Wed, 16 Oct 2024 14:42:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	SpHHpfjWYDyEBkQxP7SYNJ+CCTu5C3HJbtAasNlzTiE=; b=mXAy5qPFBplwXvun
	UaoYDu7gmw4G4J0nBn7H5IVzicdjnbk5Kta4nUG8PmCPgJmdrEGZupndLbnKmIiX
	RuI2zS+PtEVpSuS8n4nkDOQCfGp4qUHBSlF8k/3bKci9NPqKbcKMzWNHecE2u4Ow
	Ku+C3fONJj5hHR9V6I3KhLn72ADVS2z9OcHtPkxt6eilvZx8UYVHA80q2QA0hf4p
	bGYfa4/J9RcVrqfkSvenNwgupmJFApx8iA8fsbh9I7HZ5MrgxyydM22CLG7ZOBhj
	2Rda7t0ROq37b4SVWCdP2IqVd2O/dgt7kEOfw/Ra5x+6krBFKUvBKbWx58c2dr+6
	37u8gQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42a8mv9uvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 14:42:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6A18040044;
	Wed, 16 Oct 2024 14:41:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9349123CB3E;
	Wed, 16 Oct 2024 14:40:22 +0200 (CEST)
Received: from localhost (10.252.17.239) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 16 Oct
 2024 14:40:22 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Wed, 16 Oct 2024 14:39:55 +0200
Subject: [PATCH v3 3/9] dmaengine: stm32-dma3: refactor HW linked-list to
 optimize memory accesses
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241016-dma3-mp25-updates-v3-3-8311fe6f228d@foss.st.com>
References: <20241016-dma3-mp25-updates-v3-0-8311fe6f228d@foss.st.com>
In-Reply-To: <20241016-dma3-mp25-updates-v3-0-8311fe6f228d@foss.st.com>
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

Current behavior splits the buffer/sg in n * STM32_DMA3_MAX_BLOCK_SIZE + 1
for the remainder without optimization.

New behavior splits the buffer/sg in n * STM32_DMA3_MAX_BLOCK_SIZE + 1 for
(x * chan->max_burst) + 1 for the remainder.
Depending on channel FIFO size, optimal double-word (word if only 8-byte
FIFO size) bursts can be programmed before managing the very last remainder
with lower data width.
In case of _prep_slave_sg, and depending on the channel Transfer Complete
event configuration, the user is warned about the refactored linked-list,
not having the same items count than the initial sg_list. This warning is
shown only if the configuration is successful.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-dma3.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index f793eecd2c27ca17cedd5cabbaa1b1beca202039..1d961f5935f935e3855467318cdcde6e6173e43c 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1126,6 +1126,25 @@ static void stm32_dma3_free_chan_resources(struct dma_chan *c)
 	chan->config_set = 0;
 }
 
+static u32 stm32_dma3_get_ll_count(struct stm32_dma3_chan *chan, size_t len)
+{
+	u32 count;
+
+	count = len / STM32_DMA3_MAX_BLOCK_SIZE;
+	len -= (len / STM32_DMA3_MAX_BLOCK_SIZE) * STM32_DMA3_MAX_BLOCK_SIZE;
+
+	if (len >= chan->max_burst) {
+		count += 1; /* len < STM32_DMA3_MAX_BLOCK_SIZE here, so it fits in one item */
+		len -= (len / chan->max_burst) * chan->max_burst;
+	}
+
+	/* Unaligned remainder fits in one extra item */
+	if (len > 0)
+		count += 1;
+
+	return count;
+}
+
 static void stm32_dma3_init_chan_config_for_memcpy(struct stm32_dma3_chan *chan,
 						   dma_addr_t dst, dma_addr_t src)
 {
@@ -1161,7 +1180,7 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_dma_memcpy(struct dma_cha
 	size_t next_size, offset;
 	u32 count, i, ctr1, ctr2;
 
-	count = DIV_ROUND_UP(len, STM32_DMA3_MAX_BLOCK_SIZE);
+	count = stm32_dma3_get_ll_count(chan, len);
 
 	swdesc = stm32_dma3_chan_desc_alloc(chan, count);
 	if (!swdesc)
@@ -1177,6 +1196,9 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_dma_memcpy(struct dma_cha
 		remaining = len - offset;
 		next_size = min_t(size_t, remaining, STM32_DMA3_MAX_BLOCK_SIZE);
 
+		if (next_size < STM32_DMA3_MAX_BLOCK_SIZE && next_size >= chan->max_burst)
+			next_size = chan->max_burst * (remaining / chan->max_burst);
+
 		ret = stm32_dma3_chan_prep_hw(chan, DMA_MEM_TO_MEM, &swdesc->ccr, &ctr1, &ctr2,
 					      src + offset, dst + offset, next_size);
 		if (ret)
@@ -1215,12 +1237,9 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_slave_sg(struct dma_chan
 	u32 i, j, count, ctr1, ctr2;
 	int ret;
 
-	count = sg_len;
-	for_each_sg(sgl, sg, sg_len, i) {
-		len = sg_dma_len(sg);
-		if (len > STM32_DMA3_MAX_BLOCK_SIZE)
-			count += DIV_ROUND_UP(len, STM32_DMA3_MAX_BLOCK_SIZE) - 1;
-	}
+	count = 0;
+	for_each_sg(sgl, sg, sg_len, i)
+		count += stm32_dma3_get_ll_count(chan, sg_dma_len(sg));
 
 	swdesc = stm32_dma3_chan_desc_alloc(chan, count);
 	if (!swdesc)
@@ -1237,6 +1256,9 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_slave_sg(struct dma_chan
 		do {
 			size_t chunk = min_t(size_t, len, STM32_DMA3_MAX_BLOCK_SIZE);
 
+			if (chunk < STM32_DMA3_MAX_BLOCK_SIZE && chunk >= chan->max_burst)
+				chunk = chan->max_burst * (len / chan->max_burst);
+
 			if (dir == DMA_MEM_TO_DEV) {
 				src = sg_addr;
 				dst = dev_addr;
@@ -1269,6 +1291,10 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_slave_sg(struct dma_chan
 		} while (len);
 	}
 
+	if (count != sg_len && chan->tcem != CTR2_TCEM_CHANNEL)
+		dev_warn(chan2dev(chan), "Linked-list refactored, %d items instead of %d\n",
+			 count, sg_len);
+
 	/* Enable Error interrupts */
 	swdesc->ccr |= CCR_USEIE | CCR_ULEIE | CCR_DTEIE;
 	/* Enable Transfer state interrupts */

-- 
2.25.1


