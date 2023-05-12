Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B311700A0A
	for <lists+dmaengine@lfdr.de>; Fri, 12 May 2023 16:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241483AbjELOPN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 May 2023 10:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240831AbjELOPI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 May 2023 10:15:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E4012480
        for <dmaengine@vger.kernel.org>; Fri, 12 May 2023 07:15:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba6f530c9c7so2036474276.3
        for <dmaengine@vger.kernel.org>; Fri, 12 May 2023 07:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683900906; x=1686492906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9fd/5tDM33mlBKRPz7g7eHWJD79X5yTFlYNSGMw+woI=;
        b=ZtsTNy2PVfhlpb/JuCfk1p8ZXlnYWWxWxMEu1Lva2/0XLeNRSoREIJqChnS3XuVtdr
         BE5huxYM2URNE4X1IxhxOTZISn4KuZI2Yqn/u6yGjFFj+RInj169E8ItPuxQQGs9QzoV
         4Dvr7N/r//TmFUqT233y4l29SSmOpi3WqZsSVqkrH4NscGes5SFDHTVJ8TrYzYpED4Kf
         7d23qfy07kmel36g5Qh/hO+vjVplrl5L+5RmkW/RECjDn8VO6EMQ3QulL97z7jfNOtKq
         e5+3GV/laP5C/Cao4Jsxp0p52Tp/DJuee8K0eFFT0VPDhl/QxO6pMNVlT4e39qP0nYlw
         329w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683900906; x=1686492906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9fd/5tDM33mlBKRPz7g7eHWJD79X5yTFlYNSGMw+woI=;
        b=d8bCiBc82FpjR3ppCisdCTYwcSPmOKMGlKBq6rP0Hc+JA8KdLme2tHLZjMrR+ZOYKm
         RHg/S/FdHsnsY2jozgBXEVPHBQ6pgLsJbeFIRfR/ruWNroZ28P0UES4ywUJ9E2eExKJ6
         N9N6LZxhZMpcL0FfhDwNhOAyUvh/C7JRpv3YfKbaq4EbO3EFoOd/3xZMWSk/oB4cuRPs
         1Khvi0CM8IMMyJvM92BEl3rgzsmNVOpEGS/i6ykPWcYENLGaJqvSBJZlziA+uGRMiq6Y
         0FaOupshBFoHW7LWj7nS7q7eW8MeKjI5b+JqvEuE0QOFAWBcdYOjBcJG80yVZUcqXlc1
         geJw==
X-Gm-Message-State: AC+VfDzp0cPS7GiZ4i4wQrD2ME5zw1Mre3Fi9P4q2Hj808W5inn/vkDf
        4BBRnWIAaW47rwBsktQwW0HFBA8zxODB8g==
X-Google-Smtp-Source: ACHHUZ606I3ZcTGrIAGj3KmtJiebDv5RhcP3DxRfkMrJL64OO+mRwOKUmnmEexp2/X66k3JxQdAsUEMcSict+w==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:114e:b0:b4a:3896:bc17 with SMTP
 id p14-20020a056902114e00b00b4a3896bc17mr11151964ybu.0.1683900906639; Fri, 12
 May 2023 07:15:06 -0700 (PDT)
Date:   Fri, 12 May 2023 14:14:40 +0000
In-Reply-To: <20230512141445.2026660-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230512141445.2026660-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512141445.2026660-2-joychakr@google.com>
Subject: [PATCH v2 1/6] dmaengine: pl330: Separate SRC and DST burst size and len
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
2.40.1.606.ga4b1b128d6-goog

