Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6037224A1C
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jul 2020 11:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgGRJUQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Jul 2020 05:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgGRJUO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 18 Jul 2020 05:20:14 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FCCC0619D2;
        Sat, 18 Jul 2020 02:20:13 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w2so7842526pgg.10;
        Sat, 18 Jul 2020 02:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UaC1El4svTPWWv/qHlp1y2AKMj6GXHYb+T5pK1WKkD0=;
        b=L14smzfnFCwhYPdckJw1ERr9pnwQ1X2QgfyZtLnI/VU7uxipFLFAckYA2bH4ZCZE/5
         p1YbDjpy2xOaadfugYZ1tRbwkawRceI0zTQ0T+lAO2AtWVClbauh1mTDgJ2A+lBEbQAn
         qtkdCnMQTuItjL65slHTH30Zd/Xopow92YMZ1XnobFMU0rPw+R5Th3tfRMs6FxyBkWzr
         icOJQTuWtlTUsAXLX+NHRsyED6RcKEQb7OlQ4nYY/Sw4zc8KTiJH7MH3Bp1YWEOvwqXF
         HazJZELjrYZRzTvbxa7G8U0t4/VF0sYADR4COzuvdEyqbIegfK94THRidBbPt32iaM9b
         JSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UaC1El4svTPWWv/qHlp1y2AKMj6GXHYb+T5pK1WKkD0=;
        b=QBVkJQofE0OT5WWYlP8Wb41CDCLzNPkLpsqZvoh3cmYLI8NhYaqJv+1qRepr0F6GnW
         VDU0zP/CKzkD4Rnc0vJVJ5MsPS2ewdn9tHeMIo66MRhGe/Qkb8pSTKBne1mH6sjZCaNl
         z2TY0CC0kLiq8zQO06VZQMWEJHCe+f8SoJWGh3lZBDBH+QdtcsBmTtJbteB7kdtxxWEK
         KKKiUyyRmrBjI2C/oiLJ+vbhTYB7K0IlDoHg/1NKffOCgDHH9mCCK9mG1uqne+2eK1Y1
         CWjBI6y1ThK6eVxArDCtz1Ns2xIuescTrovLDZWvzCWq1AGomDQrwZI8f9ELxbdyWCPv
         bKsA==
X-Gm-Message-State: AOAM531FgF+YZtNvHHYNCLlQeqDsqcfwgni3xOlrC+2MV9DSCQ/Dgp5j
        OPiALZLzxaBBdV86W/9TUVGLtw+trP8n2g==
X-Google-Smtp-Source: ABdhPJz/W3yRXHPyauUdYC/FsxYDovzlozVs4hgnmAHQldZHD7l6yGzJSZVwRjvK/UY71mNBWKInww==
X-Received: by 2002:a63:3151:: with SMTP id x78mr12176358pgx.210.1595064013260;
        Sat, 18 Jul 2020 02:20:13 -0700 (PDT)
Received: from localhost.localdomain ([182.69.248.222])
        by smtp.gmail.com with ESMTPSA id nl5sm5217800pjb.36.2020.07.18.02.20.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 02:20:12 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, vkoul@kernel.org, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v6 02/10] dmaengine: Actions: get rid of bit fields from dma descriptor
Date:   Sat, 18 Jul 2020 14:49:26 +0530
Message-Id: <1595063974-24228-3-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595063974-24228-1-git-send-email-amittomer25@gmail.com>
References: <1595063974-24228-1-git-send-email-amittomer25@gmail.com>
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

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Suggested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v5:
	* Added Mani's Reviewed-by: tag.
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

