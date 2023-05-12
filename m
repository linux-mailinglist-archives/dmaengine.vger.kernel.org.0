Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938C4700A19
	for <lists+dmaengine@lfdr.de>; Fri, 12 May 2023 16:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241531AbjELOPw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 May 2023 10:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241508AbjELOPk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 May 2023 10:15:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1379F150C2
        for <dmaengine@vger.kernel.org>; Fri, 12 May 2023 07:15:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-55a40d32a6bso110428767b3.2
        for <dmaengine@vger.kernel.org>; Fri, 12 May 2023 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683900926; x=1686492926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DBrF5DHnKIcDo8+7KXBxIWAhYs0e5wcmWXF/2mvOoX0=;
        b=EONdOzyG1A039q9TIagzHY6fFI1rVU8j8RfaY005zsbMET+fIElC7gxK8sx0Vsbb+s
         pSTTsT66jPni2V+txz15o1bHYwb+q3i1Ro2WMm9WcWd6Wb15w8vYK+acVehdrA2TGnkQ
         rMM8mVUCubXv1/aIYEsmdbP3RS71eBBvPTgxZO9ZFY9MbiKaGrI09akfU/7GUPivWGAv
         ncwdUmZTbtP9/bSGq7Sc8MgGVVEjADk2Xls/KOw8jR6SftsyaPO0RSsn0UMNBpaaaQaR
         EOoTQ+i5XopPmCMoVmtL7yfxALXdH4BcwshdmcXjv/sWuRx6ztWLCphAchPsjNNjuc5C
         kdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683900926; x=1686492926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DBrF5DHnKIcDo8+7KXBxIWAhYs0e5wcmWXF/2mvOoX0=;
        b=JwmrgqarJH66nGvguxUAqixjhVgob5BW5Jhpn1O4fmVYGdrDf1iTIjvvgDpI81pNfX
         S1SJEVRoQFHEsx8OYIjCPTncSUq78jtGwEJXyanHPwWsbEe55pFVEHwKecMZf9j5/jIT
         mrYlP2J0pb125uP2V4+V7gvSM1x5/+2o/hXPxtIfT2Y5H2vIg+X06OaffInWdzcEvB65
         URSmJ9sOuvJsiWLF9/JzOaIHvDemFw1ZVhF6tFWQhLqFmKQyoKgbZ8eDkVa0vZ9Ut80S
         SB2J51qij8z5DefRtv/rNHBqg0gsRKe+hf7JE0zol4Iqtcd66WV1tZvYORnLAuJDsRYW
         wEsg==
X-Gm-Message-State: AC+VfDwI7hSsFOzv4ijMQUZGgq2RwNt34mXFbAa2KVcbEhCs1b3/09cj
        PQ6iRPzuy8VHQRHz6yB+8ymQQHORDzr4KQ==
X-Google-Smtp-Source: ACHHUZ74NTF891q+rha9vQxX0ztAqHF8xmg+06mHuF47o0U+NFSy8mVkCqG5vTx05WHIlOepTiBReOAqZ/CQNA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:bd52:0:b0:54f:b986:9c60 with SMTP id
 n18-20020a81bd52000000b0054fb9869c60mr16276082ywk.7.1683900926764; Fri, 12
 May 2023 07:15:26 -0700 (PDT)
Date:   Fri, 12 May 2023 14:14:44 +0000
In-Reply-To: <20230512141445.2026660-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230512141445.2026660-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512141445.2026660-6-joychakr@google.com>
Subject: [PATCH v2 5/6] dmaengine: pl330: Optimize AxSize for peripheral usecases
From:   Joy Chakraborty <joychakr@google.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, manugautam@google.com,
        danielmentz@google.com, sjadavani@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add logic to choose the maximum possible AxSize for transactions towards
memory during usecases which copy data between memory and peripherals.

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

Instruction setup post changes :
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
 drivers/dma/pl330.c | 92 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 78 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index e5e610c91f18..46e254fd4007 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2677,6 +2677,52 @@ static inline int get_burst_len(struct dma_pl330_desc *desc, unsigned int brst_s
 	return burst_len;
 }
 
+/*
+ * Returns burst size to be used to copy data from/to memory during a
+ * peripheral transfer
+ */
+static unsigned int get_periph_mem_brst_sz(dma_addr_t addr, size_t len,
+					   struct dma_pl330_chan *pch)
+{
+	unsigned int burst;
+
+	/* Select max possible burst size */
+	burst = pch->dmac->pcfg.data_bus_width / 8;
+
+	/*
+	 * Make sure we use a burst size that aligns with the memory and length.
+	 */
+	while ((addr | len) & (burst - 1))
+		burst /= 2;
+
+	return __ffs(burst);
+}
+
+/*
+ * Returns burst length to be used to copy data from/to memory during a
+ * peripheral transfer
+ */
+static unsigned int get_periph_mem_brst_len(struct dma_pl330_desc *desc,
+					    struct dma_pl330_chan *pch,
+					    unsigned int burst_size)
+{
+	unsigned int burst_len = pch->burst_len;
+
+	if (burst_size != pch->burst_sz) {
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
@@ -2684,8 +2730,8 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 {
 	struct dma_pl330_desc *desc = NULL, *first = NULL;
 	struct dma_pl330_chan *pch = to_pchan(chan);
+	unsigned int i, burst_size, burst_len;
 	struct pl330_dmac *pl330 = pch->dmac;
-	unsigned int i;
 	dma_addr_t dst;
 	dma_addr_t src;
 
@@ -2729,28 +2775,35 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 			return NULL;
 		}
 
+		burst_size = get_periph_mem_brst_sz(dma_addr, period_len, pch);
+		burst_len = get_periph_mem_brst_len(desc, pch, burst_size);
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
 
@@ -2850,7 +2903,10 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 {
 	struct dma_pl330_desc *first, *desc = NULL;
 	struct dma_pl330_chan *pch = to_pchan(chan);
+	unsigned int burst_size, burst_len;
 	struct scatterlist *sg;
+	dma_addr_t mem_addr;
+	size_t len;
 	int i;
 
 	if (unlikely(!pch || !sgl || !sg_len))
@@ -2882,29 +2938,37 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		else
 			list_add_tail(&desc->node, &first->node);
 
+		mem_addr = sg_dma_address(sg);
+		len = sg_dma_len(sg);
+
+		burst_size = get_periph_mem_brst_sz(mem_addr, len, pch);
+		burst_len = get_periph_mem_brst_len(desc, pch, burst_size);
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
2.40.1.606.ga4b1b128d6-goog

