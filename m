Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47001F37BA
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2020 12:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgFIKRj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Jun 2020 06:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgFIKRg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 Jun 2020 06:17:36 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20054C05BD1E;
        Tue,  9 Jun 2020 03:17:36 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jz3so1212731pjb.0;
        Tue, 09 Jun 2020 03:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OaQ7+auRM9Q1yLKBuV5VyQHz4qYUBbJ7B40lNF33USM=;
        b=Ku32MxuAaf7eN9eEOJTcQfS7+B561Jo1jSnNdzP4XO+v+GxlPub6PWRxbOIRXAxCay
         g5jNspd9MBTQctWNEQMX8YcDqUzb/+KiCaEGHJo9xvLGNbodOasSinTK3omWIMjx8deQ
         LzLhn1TPTXYFw4SYBcC6dA/sM6DJGVEnAZJG2KisflS8SRl+5xApRvminGbQYpxuHRpc
         40tH5tMiU1TPZzjLnGjbLQ43JnSbAVbZLdSVpzRdCMoLGMHhXNB3bWHsVBx48CDW2kRX
         2a4cPf/zX9VYp70Dr+ECvj2LmW+5tqFSjl82TJWvm1Z3UW5EcIYBY3hxI896hRQCw5Iv
         HUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OaQ7+auRM9Q1yLKBuV5VyQHz4qYUBbJ7B40lNF33USM=;
        b=tyiA6pEolARtICrs8rW89rtfkWU/29/0Ced5iy7gIL3RmU6dFYEms8DITgdOiaEane
         68zOe8e7Dlta9T9S6oASCapUaf002T3SJjuioQF2rCGnkSgBF3NNRxW4JOeu5ilSbHVA
         Qh1OynHhC2YU9aMKpA/wcbw+DXv2+0WaQc8zfZPnbs7269WJIiWyJC+0tM/htT/j3S3I
         JIHDyHBd6sqB5TVteRQwWWMGpV5FLeWqWv8Foiu/A+NwJtjxDUQ8f8wqZI6PLFFkZz17
         D5cnH5s/l3mBvnNEBaShX2CuFGjj38HVVjR7gkbS4O4bDSdDpGPl5/w9kY6yyN+SZf+h
         2kEg==
X-Gm-Message-State: AOAM5309gsTyS5uz/DG0AlgSMXZvaI1iGZAcxDTrrEi7hkglN9cFRN08
        7Fzmwe/eSE03wpIMYyVtaHQ=
X-Google-Smtp-Source: ABdhPJw3kW2M43xVqqQRBt9O8taxkJlAxVuvWJZ+mj2Ra2oAOk+9XlH16UvUH2wMPAqhKXHKFGIu0g==
X-Received: by 2002:a17:90a:65c9:: with SMTP id i9mr4008012pjs.201.1591697855603;
        Tue, 09 Jun 2020 03:17:35 -0700 (PDT)
Received: from localhost.localdomain ([223.190.87.90])
        by smtp.gmail.com with ESMTPSA id d189sm9637253pfc.51.2020.06.09.03.17.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 03:17:34 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, vkoul@kernel.org, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v4 01/10] dmaengine: Actions: get rid of bit fields from dma descriptor
Date:   Tue,  9 Jun 2020 15:47:01 +0530
Message-Id: <1591697830-16311-2-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

At the moment, Driver uses bit fields to describe registers of the DMA
descriptor structure that makes it less portable and maintainable, and
Andre suugested(and even sketched important bits for it) to make use of
array to describe this DMA descriptors instead. It gives the flexibility
while extending support for other platform such as Actions S700.

This commit removes the "owl_dma_lli_hw" (that includes bit-fields) and
uses array to describe DMA descriptor.

Suggested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v3:
	* Added description for enum fields.
	* Restored the old comment.
	* Added detailed comment about, the way FLEN
	  and FCNT values are filled.
Changes since v2:
	* No change.
Changes since v1:
	* Defined macro for frame count value.
	* Introduced llc_hw_flen() from patch 2/9.
	* Removed the unnecessary line break.
Changes since rfc:
	* No change.
---
 drivers/dma/owl-dma.c | 98 +++++++++++++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 66ef70b00ec0..948d1bead860 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -120,30 +120,33 @@
 #define BIT_FIELD(val, width, shift, newshift)	\
 		((((val) >> (shift)) & ((BIT(width)) - 1)) << (newshift))
 
+/* Frame count value is fixed as 1 */
+#define FCNT_VAL				0x1
+
 /**
- * struct owl_dma_lli_hw - Hardware link list for dma transfer
- * @next_lli: physical address of the next link list
- * @saddr: source physical address
- * @daddr: destination physical address
- * @flen: frame length
- * @fcnt: frame count
- * @src_stride: source stride
- * @dst_stride: destination stride
- * @ctrla: dma_mode and linklist ctrl config
- * @ctrlb: interrupt config
- * @const_num: data for constant fill
+ * owl_dmadesc_offsets - Describe DMA descriptor, hardware link
+ * list for dma transfer
+ * @OWL_DMADESC_NEXT_LLI: physical address of the next link list
+ * @OWL_DMADESC_SADDR: source physical address
+ * @OWL_DMADESC_DADDR: destination physical address
+ * @OWL_DMADESC_FLEN: frame length
+ * @OWL_DMADESC_SRC_STRIDE: source stride
+ * @OWL_DMADESC_DST_STRIDE: destination stride
+ * @OWL_DMADESC_CTRLA: dma_mode and linklist ctrl config
+ * @OWL_DMADESC_CTRLB: interrupt config
+ * @OWL_DMADESC_CONST_NUM: data for constant fill
  */
-struct owl_dma_lli_hw {
-	u32	next_lli;
-	u32	saddr;
-	u32	daddr;
-	u32	flen:20;
-	u32	fcnt:12;
-	u32	src_stride;
-	u32	dst_stride;
-	u32	ctrla;
-	u32	ctrlb;
-	u32	const_num;
+enum owl_dmadesc_offsets {
+	OWL_DMADESC_NEXT_LLI = 0,
+	OWL_DMADESC_SADDR,
+	OWL_DMADESC_DADDR,
+	OWL_DMADESC_FLEN,
+	OWL_DMADESC_SRC_STRIDE,
+	OWL_DMADESC_DST_STRIDE,
+	OWL_DMADESC_CTRLA,
+	OWL_DMADESC_CTRLB,
+	OWL_DMADESC_CONST_NUM,
+	OWL_DMADESC_SIZE
 };
 
 /**
@@ -153,7 +156,7 @@ struct owl_dma_lli_hw {
  * @node: node for txd's lli_list
  */
 struct owl_dma_lli {
-	struct  owl_dma_lli_hw	hw;
+	u32			hw[OWL_DMADESC_SIZE];
 	dma_addr_t		phys;
 	struct list_head	node;
 };
@@ -318,6 +321,11 @@ static inline u32 llc_hw_ctrlb(u32 int_ctl)
 	return ctl;
 }
 
+static u32 llc_hw_flen(struct owl_dma_lli *lli)
+{
+	return lli->hw[OWL_DMADESC_FLEN] & GENMASK(19, 0);
+}
+
 static void owl_dma_free_lli(struct owl_dma *od,
 			     struct owl_dma_lli *lli)
 {
@@ -349,8 +357,9 @@ static struct owl_dma_lli *owl_dma_add_lli(struct owl_dma_txd *txd,
 		list_add_tail(&next->node, &txd->lli_list);
 
 	if (prev) {
-		prev->hw.next_lli = next->phys;
-		prev->hw.ctrla |= llc_hw_ctrla(OWL_DMA_MODE_LME, 0);
+		prev->hw[OWL_DMADESC_NEXT_LLI] = next->phys;
+		prev->hw[OWL_DMADESC_CTRLA] |=
+					llc_hw_ctrla(OWL_DMA_MODE_LME, 0);
 	}
 
 	return next;
@@ -363,8 +372,7 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
 				  struct dma_slave_config *sconfig,
 				  bool is_cyclic)
 {
-	struct owl_dma_lli_hw *hw = &lli->hw;
-	u32 mode;
+	u32 mode, ctrlb;
 
 	mode = OWL_DMA_MODE_PW(0);
 
@@ -405,22 +413,28 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
 		return -EINVAL;
 	}
 
-	hw->next_lli = 0; /* One link list by default */
-	hw->saddr = src;
-	hw->daddr = dst;
-
-	hw->fcnt = 1; /* Frame count fixed as 1 */
-	hw->flen = len; /* Max frame length is 1MB */
-	hw->src_stride = 0;
-	hw->dst_stride = 0;
-	hw->ctrla = llc_hw_ctrla(mode,
-				 OWL_DMA_LLC_SAV_LOAD_NEXT |
-				 OWL_DMA_LLC_DAV_LOAD_NEXT);
+	lli->hw[OWL_DMADESC_CTRLA] = llc_hw_ctrla(mode,
+						  OWL_DMA_LLC_SAV_LOAD_NEXT |
+						  OWL_DMA_LLC_DAV_LOAD_NEXT);
 
 	if (is_cyclic)
-		hw->ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_BLOCK);
+		ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_BLOCK);
 	else
-		hw->ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_SUPER_BLOCK);
+		ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_SUPER_BLOCK);
+
+	lli->hw[OWL_DMADESC_NEXT_LLI] = 0; /* One link list by default */
+	lli->hw[OWL_DMADESC_SADDR] = src;
+	lli->hw[OWL_DMADESC_DADDR] = dst;
+	lli->hw[OWL_DMADESC_SRC_STRIDE] = 0;
+	lli->hw[OWL_DMADESC_DST_STRIDE] = 0;
+	/*
+	 * Word starts from offset 0xC is shared between frame length
+	 * (max frame length is 1MB) and frame count, where first 20
+	 * bits are for frame length and rest of 12 bits are for frame
+	 * count.
+	 */
+	lli->hw[OWL_DMADESC_FLEN] = len | FCNT_VAL << 20;
+	lli->hw[OWL_DMADESC_CTRLB] = ctrlb;
 
 	return 0;
 }
@@ -752,7 +766,7 @@ static u32 owl_dma_getbytes_chan(struct owl_dma_vchan *vchan)
 			/* Start from the next active node */
 			if (lli->phys == next_lli_phy) {
 				list_for_each_entry(lli, &txd->lli_list, node)
-					bytes += lli->hw.flen;
+					bytes += llc_hw_flen(lli);
 				break;
 			}
 		}
@@ -783,7 +797,7 @@ static enum dma_status owl_dma_tx_status(struct dma_chan *chan,
 	if (vd) {
 		txd = to_owl_txd(&vd->tx);
 		list_for_each_entry(lli, &txd->lli_list, node)
-			bytes += lli->hw.flen;
+			bytes += llc_hw_flen(lli);
 	} else {
 		bytes = owl_dma_getbytes_chan(vchan);
 	}
-- 
2.7.4

