Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5759F1C6E78
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2020 12:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgEFKge (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 May 2020 06:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728338AbgEFKgd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 May 2020 06:36:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE243C061A0F
        for <dmaengine@vger.kernel.org>; Wed,  6 May 2020 03:36:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w65so762796pfc.12
        for <dmaengine@vger.kernel.org>; Wed, 06 May 2020 03:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HFpcgU1nGmiRP0+54g0zuPXHEdqiV8xYolaZNPO82Ng=;
        b=gdwOuImmAqQhFu+Ap1qpg9CgRhvTdqd/DKQasuVCGHpKGQL2agS9/BljsLhHgAFAW6
         F04PfPExlmMsiBbA2JW+Wc1HgXj6fcaNfzZGe81Fu81wo9162cIo7V/tmRaPx9+GNhZ0
         3qAysfD5vtYLU5+txOoFM/J9nhdjyurnXooFJmt4aixnOF7ErpL73hcm2lV7w0u5WZVu
         Nxv+iR4aNwesRYz6VO2poZJQ8g/Qt+h2XfLsnhYuNqC6IbbbdfC1wZRT9pNHvGibtA0B
         /4yBJe5NRDBC5zCo5NiN7KlvUK0nTYI8WbQWlWhAUaDVLG4MDJOVeMviJcVSXhdeD2oP
         kmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HFpcgU1nGmiRP0+54g0zuPXHEdqiV8xYolaZNPO82Ng=;
        b=rYXzSpkzelOGqyT3HAqE5JvJkanB/QvH/5FescrBQJMQCDu0ScocHnyQ7yjHBMhhM9
         8KagcQCMFc9tS+0vQk80WNgOYbecC9RVC/XVna9AC9pEsIQ3KAbXkMnVX0dsrJtGPY0/
         wbP7eTp5gk6oPD9kTbGXbB+1FaZXGMgH8x3x4/t73HYxdPpC9U4rsdaB6TdrgYmvhkpa
         ZE7BXk7OADblNC2P0DrDZoNNDPfa1ltZa7yte77ghXaXflV6xGZ4fZMJmt2WiNUVNPFm
         86V5be7fchzNcIO3Urfa4qiTWZwW4cyXAV1l5mFO/9cSS6+wHVJ4xttH4ibMm6cGjKmO
         UtgQ==
X-Gm-Message-State: AGi0PuZgG6LFUJ9TauOYtJvCWzjBSMuKVD9u18+VR07iaBFvkJAvDhP3
        QDfh6KGpWdHgluq5pWLQzv8=
X-Google-Smtp-Source: APiQypKSMIfjxq6/2Pq+wXux9SSxrE+CSejlhakPh5O4JUlKSdHhyEdkmr4DKcGweqHN2a3ACFaCDg==
X-Received: by 2002:a63:1d54:: with SMTP id d20mr6576617pgm.286.1588761393159;
        Wed, 06 May 2020 03:36:33 -0700 (PDT)
Received: from localhost.localdomain ([106.215.43.48])
        by smtp.gmail.com with ESMTPSA id i72sm1601582pfe.104.2020.05.06.03.36.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 03:36:32 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, vkoul@kernel.org, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH RFC 1/8] dmaengine: Actions: get rid of bit fields from dma descriptor
Date:   Wed,  6 May 2020 16:06:03 +0530
Message-Id: <1588761371-9078-2-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588761371-9078-1-git-send-email-amittomer25@gmail.com>
References: <1588761371-9078-1-git-send-email-amittomer25@gmail.com>
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
 drivers/dma/owl-dma.c | 77 ++++++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 44 deletions(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index c683051257fd..b0d80a2fa383 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -120,30 +120,18 @@
 #define BIT_FIELD(val, width, shift, newshift)	\
 		((((val) >> (shift)) & ((BIT(width)) - 1)) << (newshift))
 
-/**
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
- */
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
+/* Describe DMA descriptor, hardware link list for dma transfer */
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
@@ -153,7 +141,7 @@ struct owl_dma_lli_hw {
  * @node: node for txd's lli_list
  */
 struct owl_dma_lli {
-	struct  owl_dma_lli_hw	hw;
+	u32			hw[OWL_DMADESC_SIZE];
 	dma_addr_t		phys;
 	struct list_head	node;
 };
@@ -351,8 +339,9 @@ static struct owl_dma_lli *owl_dma_add_lli(struct owl_dma_txd *txd,
 		list_add_tail(&next->node, &txd->lli_list);
 
 	if (prev) {
-		prev->hw.next_lli = next->phys;
-		prev->hw.ctrla |= llc_hw_ctrla(OWL_DMA_MODE_LME, 0);
+		prev->hw[OWL_DMADESC_NEXT_LLI] = next->phys;
+		prev->hw[OWL_DMADESC_CTRLA] |=
+					llc_hw_ctrla(OWL_DMA_MODE_LME, 0);
 	}
 
 	return next;
@@ -365,8 +354,7 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
 				  struct dma_slave_config *sconfig,
 				  bool is_cyclic)
 {
-	struct owl_dma_lli_hw *hw = &lli->hw;
-	u32 mode;
+	u32 mode, ctrlb;
 
 	mode = OWL_DMA_MODE_PW(0);
 
@@ -407,22 +395,22 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
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
+	lli->hw[OWL_DMADESC_NEXT_LLI] = 0;
+	lli->hw[OWL_DMADESC_SADDR] = src;
+	lli->hw[OWL_DMADESC_DADDR] = dst;
+	lli->hw[OWL_DMADESC_SRC_STRIDE] = 0;
+	lli->hw[OWL_DMADESC_DST_STRIDE] = 0;
+	lli->hw[OWL_DMADESC_FLEN] = len | 1 << 20;
+	lli->hw[OWL_DMADESC_CTRLB] = ctrlb;
 
 	return 0;
 }
@@ -754,7 +742,8 @@ static u32 owl_dma_getbytes_chan(struct owl_dma_vchan *vchan)
 			/* Start from the next active node */
 			if (lli->phys == next_lli_phy) {
 				list_for_each_entry(lli, &txd->lli_list, node)
-					bytes += lli->hw.flen;
+					bytes += lli->hw[OWL_DMADESC_FLEN] &
+						 GENMASK(19, 0);
 				break;
 			}
 		}
@@ -785,7 +774,7 @@ static enum dma_status owl_dma_tx_status(struct dma_chan *chan,
 	if (vd) {
 		txd = to_owl_txd(&vd->tx);
 		list_for_each_entry(lli, &txd->lli_list, node)
-			bytes += lli->hw.flen;
+			bytes += lli->hw[OWL_DMADESC_FLEN] & GENMASK(19, 0);
 	} else {
 		bytes = owl_dma_getbytes_chan(vchan);
 	}
-- 
2.7.4

