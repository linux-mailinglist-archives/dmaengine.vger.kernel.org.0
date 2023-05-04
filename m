Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CF66F6E6C
	for <lists+dmaengine@lfdr.de>; Thu,  4 May 2023 16:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjEDO7E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 May 2023 10:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjEDO65 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 May 2023 10:58:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A07E524B
        for <dmaengine@vger.kernel.org>; Thu,  4 May 2023 07:58:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a776a5eb2so1353364276.0
        for <dmaengine@vger.kernel.org>; Thu, 04 May 2023 07:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683212285; x=1685804285;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IBBR9Gpj6AENx07xObOvliG6DKbsyP8bVAT3ugF7Lw0=;
        b=Bm+hotMwTf3HmxBmAE5daNhihvDIBR6hTHsQD13iwNaFOBjVaTI+AwbBzFTHxfmDjS
         L9qr0x7GtBiXlzRprJjL9lPbhKPiTNgZRNqAVzlpB69tXujMAmuL2ooGL0Hj58gUgTz9
         ttugCUEN/CMSwmfxNjycm7b0a74skHz4MJlFYORccprny/38mMSuE6kOOtEWSlhplbnw
         Yx/Wpq1rGI6do55XSfuyFmDVkH46p9+jpivruEX59DhlayUQ+ETdxyZAPrHT7lNmtAdI
         8O5K+AzEA0nkN5J9MKx7h6ppG10WYH+eKCKmEjDim0EZ9khO6JRCLtT3mRpVgAXFVeig
         EUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212285; x=1685804285;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IBBR9Gpj6AENx07xObOvliG6DKbsyP8bVAT3ugF7Lw0=;
        b=Pqkp3DE34UM4RBceDwyzRa8qz5IgYObbjfO9hSNF2iqPdkjH3UXpVLVTm/82zT1eOl
         llcie4XpQxUeAakrOcN5zvg3OY/ApOeTsesSJ/oCwqll5lPo1ATj+Dr85JYyBxruerm9
         XqWOIkWaMKwwLbV7QwsMwBtoq9QEAWHb6SU0pHLsPxr5T4EaKPVL9c+8GVGaxfO+Lkl4
         4ImjQWbCJyXgvcgfILQPD66002EPqeWuEoP0x6N7ofPbX1431QUe4Qe7KyQtQVk4zuYX
         MGG1YjRJgl+gNKBsEfDX0NOrzJ/z5j4FcYT9YIhXZIO/BoYdfv2h/vmcIG7KnaeIofVt
         aD4g==
X-Gm-Message-State: AC+VfDxy/hOdkesYBCNH+r+TDRr/niRAC/cwqCIy0ZpAlEobDV1qCu2i
        MXDG0nz7C8K2cm0A0QuE+j6Ep1pE0k0mjQ==
X-Google-Smtp-Source: ACHHUZ4uNifwGkkKP/nqQYBaOewLLqK9iJjqVQ8HGG4hUdtx7I0jL8ngEvrX54UF9uiST/kJXf2XlnA9v7M59Q==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:8490:0:b0:ba1:d0:7f7c with SMTP id
 v16-20020a258490000000b00ba100d07f7cmr76053ybk.2.1683212285420; Thu, 04 May
 2023 07:58:05 -0700 (PDT)
Date:   Thu,  4 May 2023 14:57:31 +0000
In-Reply-To: <20230504145737.286444-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230504145737.286444-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230504145737.286444-2-joychakr@google.com>
Subject: [PATCH 1/7] dmaengine: pl330: Separate SRC and DST burst size and len
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

Add new variables in request configuration to handle source and
destination AxSize and AxLen separately and allow them to have different
values.

This allows further patches to configure different AxSize and AxLen for
optimum bus utilisation.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/dma/pl330.c | 71 +++++++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 0d9257fbdfb0..c006e481b4c5 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -240,6 +240,12 @@ enum pl330_byteswap {
 #define BYTE_TO_BURST(b, ccr)	((b) / BRST_SIZE(ccr) / BRST_LEN(ccr))
 #define BURST_TO_BYTE(c, ccr)	((c) * BRST_SIZE(ccr) * BRST_LEN(ccr))
 
+#define SRC_BRST_SIZE(ccr)	BRST_SIZE(ccr)
+#define DST_BRST_SIZE(ccr)	(1 << (((ccr) >> CC_DSTBRSTSIZE_SHFT) & 0x7))
+
+#define SRC_BRST_LEN(ccr)	BRST_LEN(ccr)
+#define DST_BRST_LEN(ccr)	((((ccr) >> CC_DSTBRSTLEN_SHFT) & 0xf) + 1)
+
 /*
  * With 256 bytes, we can do more than 2.5MB and 5MB xfers per req
  * at 1byte/burst for P<->M and M<->M respectively.
@@ -305,8 +311,10 @@ struct pl330_reqcfg {
 	bool nonsecure;
 	bool privileged;
 	bool insnaccess;
-	unsigned brst_len:5;
-	unsigned brst_size:3; /* in power of 2 */
+	unsigned src_brst_size : 3; /* in power of 2 */
+	unsigned src_brst_len:5;
+	unsigned dst_brst_size : 3; /* in power of 2 */
+	unsigned dst_brst_len:5;
 
 	enum pl330_cachectrl dcctl;
 	enum pl330_cachectrl scctl;
@@ -1204,7 +1212,10 @@ static int _bursts(struct pl330_dmac *pl330, unsigned dry_run, u8 buf[],
 		const struct _xfer_spec *pxs, int cyc)
 {
 	int off = 0;
-	enum pl330_cond cond = BRST_LEN(pxs->ccr) > 1 ? BURST : SINGLE;
+	enum pl330_cond cond = SINGLE;
+
+	if (SRC_BRST_LEN(pxs->ccr) > 1 || DST_BRST_LEN(pxs->ccr) > 1)
+		cond = BURST;
 
 	if (pl330->quirks & PL330_QUIRK_PERIPH_BURST)
 		cond = BURST;
@@ -1235,12 +1246,12 @@ static int _bursts(struct pl330_dmac *pl330, unsigned dry_run, u8 buf[],
  * for mem-to-mem, mem-to-dev or dev-to-mem.
  */
 static int _dregs(struct pl330_dmac *pl330, unsigned int dry_run, u8 buf[],
-		const struct _xfer_spec *pxs, int transfer_length)
+		const struct _xfer_spec *pxs, int src_length, int dst_length)
 {
 	int off = 0;
 	int dregs_ccr;
 
-	if (transfer_length == 0)
+	if (src_length == 0 || dst_length == 0)
 		return off;
 
 	/*
@@ -1253,9 +1264,9 @@ static int _dregs(struct pl330_dmac *pl330, unsigned int dry_run, u8 buf[],
 	dregs_ccr = pxs->ccr;
 	dregs_ccr &= ~((0xf << CC_SRCBRSTLEN_SHFT) |
 		(0xf << CC_DSTBRSTLEN_SHFT));
-	dregs_ccr |= (((transfer_length - 1) & 0xf) <<
+	dregs_ccr |= (((src_length - 1) & 0xf) <<
 		CC_SRCBRSTLEN_SHFT);
-	dregs_ccr |= (((transfer_length - 1) & 0xf) <<
+	dregs_ccr |= (((dst_length - 1) & 0xf) <<
 		CC_DSTBRSTLEN_SHFT);
 
 	switch (pxs->desc->rqtype) {
@@ -1369,16 +1380,18 @@ static inline int _setup_loops(struct pl330_dmac *pl330,
 	struct pl330_xfer *x = &pxs->desc->px;
 	u32 ccr = pxs->ccr;
 	unsigned long c, bursts = BYTE_TO_BURST(x->bytes, ccr);
-	int num_dregs = (x->bytes - BURST_TO_BYTE(bursts, ccr)) /
-		BRST_SIZE(ccr);
-	int off = 0;
+	int num_dreg_bytes = x->bytes - BURST_TO_BYTE(bursts, ccr);
+	int num_src_dregs, num_dst_dregs, off = 0;
+
+	num_src_dregs = num_dreg_bytes / SRC_BRST_SIZE(ccr);
+	num_dst_dregs = num_dreg_bytes / DST_BRST_SIZE(ccr);
 
 	while (bursts) {
 		c = bursts;
 		off += _loop(pl330, dry_run, &buf[off], &c, pxs);
 		bursts -= c;
 	}
-	off += _dregs(pl330, dry_run, &buf[off], pxs, num_dregs);
+	off += _dregs(pl330, dry_run, &buf[off], pxs, num_src_dregs, num_dst_dregs);
 
 	return off;
 }
@@ -1446,11 +1459,11 @@ static inline u32 _prepare_ccr(const struct pl330_reqcfg *rqc)
 	if (rqc->insnaccess)
 		ccr |= CC_SRCIA | CC_DSTIA;
 
-	ccr |= (((rqc->brst_len - 1) & 0xf) << CC_SRCBRSTLEN_SHFT);
-	ccr |= (((rqc->brst_len - 1) & 0xf) << CC_DSTBRSTLEN_SHFT);
+	ccr |= (((rqc->src_brst_len - 1) & 0xf) << CC_SRCBRSTLEN_SHFT);
+	ccr |= (((rqc->dst_brst_len - 1) & 0xf) << CC_DSTBRSTLEN_SHFT);
 
-	ccr |= (rqc->brst_size << CC_SRCBRSTSIZE_SHFT);
-	ccr |= (rqc->brst_size << CC_DSTBRSTSIZE_SHFT);
+	ccr |= (rqc->src_brst_size << CC_SRCBRSTSIZE_SHFT);
+	ccr |= (rqc->dst_brst_size << CC_DSTBRSTSIZE_SHFT);
 
 	ccr |= (rqc->scctl << CC_SRCCCTRL_SHFT);
 	ccr |= (rqc->dcctl << CC_DSTCCTRL_SHFT);
@@ -2656,7 +2669,7 @@ static inline int get_burst_len(struct dma_pl330_desc *desc, size_t len)
 
 	burst_len = pl330->pcfg.data_bus_width / 8;
 	burst_len *= pl330->pcfg.data_buf_dep / pl330->pcfg.num_chan;
-	burst_len >>= desc->rqcfg.brst_size;
+	burst_len >>= desc->rqcfg.src_brst_size;
 
 	/* src/dst_burst_len can't be more than 16 */
 	if (burst_len > PL330_MAX_BURST)
@@ -2735,8 +2748,10 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 		}
 
 		desc->rqtype = direction;
-		desc->rqcfg.brst_size = pch->burst_sz;
-		desc->rqcfg.brst_len = pch->burst_len;
+		desc->rqcfg.src_brst_size = pch->burst_sz;
+		desc->rqcfg.src_brst_len = pch->burst_len;
+		desc->rqcfg.dst_brst_size = pch->burst_sz;
+		desc->rqcfg.dst_brst_len = pch->burst_len;
 		desc->bytes_requested = period_len;
 		fill_px(&desc->px, dst, src, period_len);
 
@@ -2789,17 +2804,21 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 	while ((src | dst | len) & (burst - 1))
 		burst /= 2;
 
-	desc->rqcfg.brst_size = 0;
-	while (burst != (1 << desc->rqcfg.brst_size))
-		desc->rqcfg.brst_size++;
+	desc->rqcfg.src_brst_size = 0;
+	while (burst != (1 << desc->rqcfg.src_brst_size))
+		desc->rqcfg.src_brst_size++;
 
-	desc->rqcfg.brst_len = get_burst_len(desc, len);
+	desc->rqcfg.src_brst_len = get_burst_len(desc, len);
 	/*
 	 * If burst size is smaller than bus width then make sure we only
 	 * transfer one at a time to avoid a burst stradling an MFIFO entry.
 	 */
 	if (burst * 8 < pl330->pcfg.data_bus_width)
-		desc->rqcfg.brst_len = 1;
+		desc->rqcfg.src_brst_len = 1;
+
+	/* For Mem2Mem, set destination AxSize and AxLen same as source*/
+	desc->rqcfg.dst_brst_len = desc->rqcfg.src_brst_len;
+	desc->rqcfg.dst_brst_size = desc->rqcfg.src_brst_size;
 
 	desc->bytes_requested = len;
 
@@ -2879,8 +2898,10 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 				sg_dma_len(sg));
 		}
 
-		desc->rqcfg.brst_size = pch->burst_sz;
-		desc->rqcfg.brst_len = pch->burst_len;
+		desc->rqcfg.src_brst_size = pch->burst_sz;
+		desc->rqcfg.src_brst_len = pch->burst_len;
+		desc->rqcfg.dst_brst_size = pch->burst_sz;
+		desc->rqcfg.dst_brst_len = pch->burst_len;
 		desc->rqtype = direction;
 		desc->bytes_requested = sg_dma_len(sg);
 	}
-- 
2.40.1.495.gc816e09b53d-goog

