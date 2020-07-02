Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4619C212709
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 16:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgGBOx3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 10:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbgGBOx2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Jul 2020 10:53:28 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD97C08C5C1;
        Thu,  2 Jul 2020 07:53:28 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so10618861pgf.0;
        Thu, 02 Jul 2020 07:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kVZnqKKOXbcyeeSV2XaFAZh0+U3CQbPxjKebaZ+ZWI8=;
        b=Xl6osqX2CGrnKf0D3DcIlq6Z9wiG0HfnMZjouhxqMEmt7UvH3+q1K1HadqzYLbWZyR
         ct0i0pwEJi9E9mIhqwgoZQeXl5dBeoKMyW64Dz6Kkz2QjN6+1w8yjSJYZ70DRrx5teOA
         ymgzts0rv6G//i3JFJNEdhSJ0ftOOWBW955Ik06isJh3g1VmG0c34d6Fcd08NaeNcel8
         9g1jJHH+NMWldjd0bwpb1J/OnVeQRGaDlGcqEwJHXVLKAo3Sxn3mYohgecPEI7NZSFTD
         tuGoTo5I2mTvS+d8J3eL8UaPEwYJA+k0iss4oMdX2t2o9HYIEWfR/UuwjiXBlaEQEz6P
         /OzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kVZnqKKOXbcyeeSV2XaFAZh0+U3CQbPxjKebaZ+ZWI8=;
        b=qKapLoWgtsB4kB5I2YefP6XRs6/R8bImXis9sWHc9gUJvQ7sTxijQMfcA5yLCYCPgr
         BsXHAIcFnoooFh3HgnTZNaW6n40AWgoiAke7CzR9f2NFibfJUg8CQBJQcdtw8URCpjRw
         rj4dEYIdnbxjiEd3HwkHC5kUPb/eYPyy3jU8+mg7ZuSejzpgzycKzA6vgLS+H83StWGU
         0N52r2m2D0nsTC/EeMQz9JjzAC47yZc+dypn9+j1Mo5LCS0c/GJQFyIi9cAHDgAeniqg
         xK9QimYJEvQz1HEK3BKnFI3iV+79Rcj3tcS49stsZf+EWLtjE8X/RdjSHxMXzOqQuOmh
         WJ4A==
X-Gm-Message-State: AOAM532vEEwmxmSuBE3Jw5IFlZv2u/4q4Nmptxzv9MT70S5MyI1Fu5mk
        CUjs1V5wggQr3ZhRNHesx0k=
X-Google-Smtp-Source: ABdhPJw70vRFyOqPs8AyqXAjegeW0hKGSWTjbsLGPGbZM2xxKNkRJZ8DfAUDYh0rgqR7R+xtlJd1bQ==
X-Received: by 2002:a63:3c09:: with SMTP id j9mr22899994pga.206.1593701608087;
        Thu, 02 Jul 2020 07:53:28 -0700 (PDT)
Received: from localhost.localdomain ([223.190.0.253])
        by smtp.gmail.com with ESMTPSA id 204sm9487891pfc.18.2020.07.02.07.53.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 07:53:27 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, vkoul@kernel.org, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v5 02/10] dmaengine: Actions: get rid of bit fields from dma descriptor
Date:   Thu,  2 Jul 2020 20:22:48 +0530
Message-Id: <1593701576-28580-3-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
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
Changes since v4:
	* Reordered it from 01/10 to 02/10.
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

