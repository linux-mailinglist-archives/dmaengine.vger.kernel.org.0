Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01C56F6E76
	for <lists+dmaengine@lfdr.de>; Thu,  4 May 2023 16:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjEDO7R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 May 2023 10:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjEDO7F (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 May 2023 10:59:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C8F2712
        for <dmaengine@vger.kernel.org>; Thu,  4 May 2023 07:58:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7c58ec19so756323276.2
        for <dmaengine@vger.kernel.org>; Thu, 04 May 2023 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683212304; x=1685804304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cmjaIRPyR5OKdf02GACB/fx4eJBLPx7/7rEGOj0i7h0=;
        b=Npa8tJhk/Rl57/4enBWz8lg2nvQDhdQTSnbVDFE2lgk2BLJxivKtPSY6hUFdn3wW6l
         v1REXZVoP5NsVUr0gD29PV9sRNxZnxP/CQptfuBxi+cjV+7YFDPjVBomfDNpvo1skWzP
         PtFEt9GOtleAd8qMiZmFL3/BnaGyZInLz7SjaJvEghEyiePkZYORM8TgpbRCru2WZVBB
         BpLgrQcZXXRuLhuylbktYv7D8qn/V79l2U6AZ4B+8k/XskfQ4zVdhSTblZ7/mNXS3qiu
         J0jwtX1DfmT6RtM9sTzA8GAO0zMmoXp75diF6r8cD0zh5KIAVC+F0Td4y/Cs3lFVqBFa
         qQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212304; x=1685804304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmjaIRPyR5OKdf02GACB/fx4eJBLPx7/7rEGOj0i7h0=;
        b=ErW0zpo3edbHriQnxZIEMeyoTuPmZ91BJcK6P2R07Zx7sfeIxktPQGNmUL9W2E7Ojf
         S0UgIjdDlv3hRsEYzQaVyX2lrZC3y56BmKPkIRuE5g0MrIa8nZXoNKMNiZS24euPRg43
         lVAbLIfF1ISI4EWWoJLju5UBDL70iAFeTdYs3u6/FQHV+3FD9pnv2TjZNGF6JgmwZxkB
         zZhpGsa3rJAEnXLNXzQAbCr0CTJklB5p1d+OcTO9bmxo0g3igO8qqefdn0IqlYATNk3n
         Fr0YWYpT79oo8gLibhg1wNuFnBD1FOjjeziAc0aFVAXlCQb/f7NAr6sk32ujoeLiM/wM
         J4TQ==
X-Gm-Message-State: AC+VfDyDYYz00MCG6RCxY2C831oM0RqLafDKq/X8aLSpdccL9FBfHu70
        iHg2PaY2RIXeSXZO/KWGiFW3y1C2Szqb1w==
X-Google-Smtp-Source: ACHHUZ7Acs9BuSbDMP0NpP2tEqzon7Bw5llOE81ZkAf+HSeEsxYgXZGDptBJ4txV0qxAzgJNOSM5sKTF0oJuzA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:993:b0:b9d:fe66:a424 with SMTP
 id bv19-20020a056902099300b00b9dfe66a424mr125691ybb.2.1683212304642; Thu, 04
 May 2023 07:58:24 -0700 (PDT)
Date:   Thu,  4 May 2023 14:57:35 +0000
In-Reply-To: <20230504145737.286444-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230504145737.286444-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230504145737.286444-6-joychakr@google.com>
Subject: [PATCH 5/7] dmaengine: pl330: Quirk to optimize AxSize for peripheral usecases
From:   Joy Chakraborty <joychakr@google.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, manugautam@google.com,
        danielmentz@google.com, sjadavani@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add quirk "arm,pl330-optimize-dev2mem-axsize" to choose maximum possible
AxSize for transactions towards memory during usecases which copy data
between memory and peripherals.

Currently PL330 driver chooses equal AxLen and AxSize for both loads and
stores to/from memory and peripherals which is inefficient towards
memory as the whole bus width is not used for transfers as a peripheral
might be limited to use only a narrow size of the buswidth available.

Example scenario:
    A peripheral might require data byte by byte which would  make AxSize
    = 1 byte and AxLen = 16 for both load from memory and store to
    Peripheral.
    This can be optimized for memory by using maximum AxSize (say
    16bytes) then load from memory can be done with AxSize = 16byte,
    AxLen = 1 and store to peripheral with AxSize = 1byte, AxLen =
    16 beats.

Instruction setup with quirk :
    512bytes copy from Memory(16bytes * 4beats) to Peripheral(4bytes *
    16 beats)
    ---
    DMAMOV CCR 0xbd0239
    DMAMOV SAR 0xffffe000
    DMAMOV DAR 0xffffc860
    DMALP_1 7
    DMAFLUSHP 0
    DMAWFPB 0
    DMALDB
    DMASTPB 0
    DMALPENDA_1 bjmpto_7
    DMASEV 3
    DMAEND
    ---

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/dma/pl330.c | 105 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 89 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index e5e610c91f18..b4933fab8a62 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -35,6 +35,7 @@
 
 #define PL330_QUIRK_BROKEN_NO_FLUSHP	BIT(0)
 #define PL330_QUIRK_PERIPH_BURST	BIT(1)
+#define PL330_QUIRK_OPTIMIZE_DEV2MEM_AXSIZE	BIT(2)
 
 enum pl330_cachectrl {
 	CCTRL0,		/* Noncacheable and nonbufferable */
@@ -519,6 +520,10 @@ static struct pl330_of_quirks {
 	{
 		.quirk = "arm,pl330-periph-burst",
 		.id = PL330_QUIRK_PERIPH_BURST,
+	},
+	{
+		.quirk = "arm,pl330-optimize-dev2mem-axsize",
+		.id = PL330_QUIRK_OPTIMIZE_DEV2MEM_AXSIZE,
 	}
 };
 
@@ -2677,6 +2682,56 @@ static inline int get_burst_len(struct dma_pl330_desc *desc, unsigned int brst_s
 	return burst_len;
 }
 
+/*
+ * Returns burst size to be used to copy data from/to memory during a
+ * peripheral transfer
+ */
+static unsigned int get_periph_mem_brst_sz(dma_addr_t addr, size_t len,
+					   struct dma_pl330_chan *pch, int quirks)
+{
+	unsigned int burst, burst_size = pch->burst_sz;
+
+	if (quirks & PL330_QUIRK_OPTIMIZE_DEV2MEM_AXSIZE) {
+		/* Select max possible burst size */
+		burst = pch->dmac->pcfg.data_bus_width / 8;
+
+		/*
+		 * Make sure we use a burst size that aligns with the memory and length.
+		 */
+		while ((addr | len) & (burst - 1))
+			burst /= 2;
+
+		burst_size = __ffs(burst);
+	}
+	return burst_size;
+}
+
+/*
+ * Returns burst length to be used to copy data from/to memory during a
+ * peripheral transfer
+ */
+static unsigned int get_periph_mem_brst_len(struct dma_pl330_desc *desc,
+					    struct dma_pl330_chan *pch,
+					    unsigned int burst_size, int quirks)
+{
+	unsigned int burst_len = pch->burst_len;
+
+	if (quirks & PL330_QUIRK_OPTIMIZE_DEV2MEM_AXSIZE &&
+	    burst_size != pch->burst_sz) {
+		/* Select max possible burst len */
+		burst_len = get_burst_len(desc, burst_size);
+
+		/*
+		 * Adjust AxLen to keep number of bytes same in Load/Store
+		 */
+		if (burst_size > pch->burst_sz)
+			burst_len = pch->burst_len >> (burst_size - pch->burst_sz);
+		else
+			pch->burst_len = burst_len >> (pch->burst_sz - burst_size);
+	}
+	return burst_len;
+}
+
 static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 		struct dma_chan *chan, dma_addr_t dma_addr, size_t len,
 		size_t period_len, enum dma_transfer_direction direction,
@@ -2684,8 +2739,8 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 {
 	struct dma_pl330_desc *desc = NULL, *first = NULL;
 	struct dma_pl330_chan *pch = to_pchan(chan);
+	unsigned int i, burst_size, burst_len;
 	struct pl330_dmac *pl330 = pch->dmac;
-	unsigned int i;
 	dma_addr_t dst;
 	dma_addr_t src;
 
@@ -2729,28 +2784,35 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 			return NULL;
 		}
 
+		burst_size = get_periph_mem_brst_sz(dma_addr, period_len, pch, pl330->quirks);
+		burst_len = get_periph_mem_brst_len(desc, pch, burst_size, pl330->quirks);
+
 		switch (direction) {
 		case DMA_MEM_TO_DEV:
 			desc->rqcfg.src_inc = 1;
 			desc->rqcfg.dst_inc = 0;
 			src = dma_addr;
 			dst = pch->fifo_dma;
+			desc->rqcfg.src_brst_size = burst_size;
+			desc->rqcfg.src_brst_len = burst_len;
+			desc->rqcfg.dst_brst_size = pch->burst_sz;
+			desc->rqcfg.dst_brst_len = pch->burst_len;
 			break;
 		case DMA_DEV_TO_MEM:
 			desc->rqcfg.src_inc = 0;
 			desc->rqcfg.dst_inc = 1;
 			src = pch->fifo_dma;
 			dst = dma_addr;
+			desc->rqcfg.src_brst_size = pch->burst_sz;
+			desc->rqcfg.src_brst_len = pch->burst_len;
+			desc->rqcfg.dst_brst_size = burst_size;
+			desc->rqcfg.dst_brst_len = burst_len;
 			break;
 		default:
 			break;
 		}
 
 		desc->rqtype = direction;
-		desc->rqcfg.src_brst_size = pch->burst_sz;
-		desc->rqcfg.src_brst_len = pch->burst_len;
-		desc->rqcfg.dst_brst_size = pch->burst_sz;
-		desc->rqcfg.dst_brst_len = pch->burst_len;
 		desc->bytes_requested = period_len;
 		fill_px(&desc->px, dst, src, period_len);
 
@@ -2850,7 +2912,11 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 {
 	struct dma_pl330_desc *first, *desc = NULL;
 	struct dma_pl330_chan *pch = to_pchan(chan);
+	unsigned int burst_size, burst_len;
+	struct pl330_dmac *pl330;
 	struct scatterlist *sg;
+	dma_addr_t mem_addr;
+	size_t len;
 	int i;
 
 	if (unlikely(!pch || !sgl || !sg_len))
@@ -2862,13 +2928,12 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		return NULL;
 
 	first = NULL;
+	pl330 = pch->dmac;
 
 	for_each_sg(sgl, sg, sg_len, i) {
 
 		desc = pl330_get_desc(pch);
 		if (!desc) {
-			struct pl330_dmac *pl330 = pch->dmac;
-
 			dev_err(pch->dmac->ddma.dev,
 				"%s:%d Unable to fetch desc\n",
 				__func__, __LINE__);
@@ -2882,29 +2947,37 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		else
 			list_add_tail(&desc->node, &first->node);
 
+		mem_addr = sg_dma_address(sg);
+		len = sg_dma_len(sg);
+
+		burst_size = get_periph_mem_brst_sz(mem_addr, len, pch, pl330->quirks);
+		burst_len = get_periph_mem_brst_len(desc, pch, burst_size, pl330->quirks);
+
 		switch (direction) {
 		case DMA_MEM_TO_DEV:
 			desc->rqcfg.src_inc = 1;
 			desc->rqcfg.dst_inc = 0;
-			fill_px(&desc->px, pch->fifo_dma, sg_dma_address(sg),
-				sg_dma_len(sg));
+			desc->rqcfg.src_brst_size = burst_size;
+			desc->rqcfg.src_brst_len = burst_len;
+			desc->rqcfg.dst_brst_size = pch->burst_sz;
+			desc->rqcfg.dst_brst_len = pch->burst_len;
+			fill_px(&desc->px, pch->fifo_dma, mem_addr, len);
 			break;
 		case DMA_DEV_TO_MEM:
 			desc->rqcfg.src_inc = 0;
 			desc->rqcfg.dst_inc = 1;
-			fill_px(&desc->px, sg_dma_address(sg), pch->fifo_dma,
-				sg_dma_len(sg));
+			desc->rqcfg.src_brst_size = pch->burst_sz;
+			desc->rqcfg.src_brst_len = pch->burst_len;
+			desc->rqcfg.dst_brst_size = burst_size;
+			desc->rqcfg.dst_brst_len = burst_len;
+			fill_px(&desc->px, mem_addr, pch->fifo_dma, len);
 			break;
 		default:
 			break;
 		}
 
-		desc->rqcfg.src_brst_size = pch->burst_sz;
-		desc->rqcfg.src_brst_len = pch->burst_len;
-		desc->rqcfg.dst_brst_size = pch->burst_sz;
-		desc->rqcfg.dst_brst_len = pch->burst_len;
 		desc->rqtype = direction;
-		desc->bytes_requested = sg_dma_len(sg);
+		desc->bytes_requested = len;
 	}
 
 	/* Return the last desc in the chain */
-- 
2.40.1.495.gc816e09b53d-goog

