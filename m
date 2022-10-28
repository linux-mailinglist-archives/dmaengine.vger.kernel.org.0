Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974E9611BC6
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 22:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJ1Uso (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Oct 2022 16:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJ1Usk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Oct 2022 16:48:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9111023AB74;
        Fri, 28 Oct 2022 13:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666990119; x=1698526119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=evvx+nDuoiHJQ8Cz/68x5eQqcsBuh3i6RV3xt1h3Odo=;
  b=nc0j8zWGnP5uG3mRMkB+3xGJQTQB9e88eXXJm4Nm8MKTB2paGgQG7GD7
   l7mSQQD0+kKAOoerg5qvLBcT7D0JqdENvWnhm9U73sBVR49ZwJB8SBfes
   g5VjBmmXx2jDROmUch+OgqjC+FhMZuCz6F1CgKqvHSNacVKbY0c2IGBte
   dMFJg1geWO2+qH59xGVy5tpVsPFV/ZNBEq+8B9cbB/hWLt3rssc8W8EjF
   u/Sb+sjqO9xAGVVh+9BTV5CcmBZL3m+RkclE4XvAY1F17QKxbrx1ENKUc
   BF/9sG+2fA9oPgT9Fzz5wBszt3/NnBop9+H/voVr5/6eDuLlbU6SRiUrh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="291885126"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="291885126"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 13:48:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="962159886"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="962159886"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by fmsmga005.fm.intel.com with ESMTP; 28 Oct 2022 13:48:39 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v6 6/7] dmaengine: idxd: Support device_tx_status
Date:   Fri, 28 Oct 2022 13:48:11 -0700
Message-Id: <20221028204812.1772736-7-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028204812.1772736-1-benjamin.walker@intel.com>
References: <20220829203537.30676-1-benjamin.walker@intel.com>
 <20221028204812.1772736-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This can now be supported even for devices that complete operations out
of order. Add support for directly polling transactions.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |  1 +
 drivers/dma/idxd/dma.c    | 84 ++++++++++++++++++++++++++++++++++++++-
 drivers/dma/idxd/idxd.h   |  1 +
 3 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 2c1e6f6daa628..870e7adfdd240 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -148,6 +148,7 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
 			desc->iax_completion = &wq->iax_compls[i];
 		desc->compl_dma = wq->compls_addr + idxd->data->compl_size * i;
 		desc->id = i;
+		desc->gen = 1;
 		desc->wq = wq;
 		desc->cpu = -1;
 	}
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index e0874cb4721c8..87749efec311b 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -12,6 +12,23 @@
 #include "registers.h"
 #include "idxd.h"
 
+
+#define DMA_COOKIE_BITS (sizeof(dma_cookie_t) * 8)
+/*
+ * The descriptor id takes the lower 16 bits of the cookie.
+ */
+#define DESC_ID_BITS 16
+#define DESC_ID_MASK ((1 << DESC_ID_BITS) - 1)
+/*
+ * The 'generation' is in the upper half of the cookie. But dma_cookie_t
+ * is signed, so we leave the upper-most bit for the sign. Further, we
+ * need to flag whether a cookie corresponds to an operation that is
+ * being completed via interrupt to avoid polling it, which takes
+ * the second most upper bit. So we subtract two bits from the upper half.
+ */
+#define DESC_GEN_MAX ((1 << (DMA_COOKIE_BITS - DESC_ID_BITS - 2)) - 1)
+#define DESC_INTERRUPT_FLAG (1 << (DMA_COOKIE_BITS - 2))
+
 static inline struct idxd_wq *to_idxd_wq(struct dma_chan *c)
 {
 	struct idxd_dma_chan *idxd_chan;
@@ -162,9 +179,62 @@ static enum dma_status idxd_dma_tx_status(struct dma_chan *dma_chan,
 					  dma_cookie_t cookie,
 					  struct dma_tx_state *txstate)
 {
-	return DMA_OUT_OF_ORDER;
+	u8 status;
+	struct idxd_wq *wq;
+	struct idxd_desc *desc;
+	u32 idx;
+
+	memset(txstate, 0, sizeof(*txstate));
+
+	if (dma_submit_error(cookie))
+		return DMA_ERROR;
+
+	wq = to_idxd_wq(dma_chan);
+
+	idx = cookie & DESC_ID_MASK;
+	if (idx >= wq->num_descs)
+		return DMA_ERROR;
+
+	desc = wq->descs[idx];
+
+	if (desc->txd.cookie != cookie) {
+		/*
+		 * The user asked about an old transaction
+		 */
+		return DMA_COMPLETE;
+	}
+
+	/*
+	 * For descriptors completed via interrupt, we can't go
+	 * look at the completion status directly because it races
+	 * with the IRQ handler recyling the descriptor. However,
+	 * since in this case we can rely on the interrupt handler
+	 * to invalidate the cookie when the command completes we
+	 * know that if we get here, the command is still in
+	 * progress.
+	 */
+	if ((cookie & DESC_INTERRUPT_FLAG) != 0)
+		return DMA_IN_PROGRESS;
+
+	status = desc->completion->status & DSA_COMP_STATUS_MASK;
+
+	if (status) {
+		/*
+		 * Check against the original status as ABORT is software defined
+		 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.
+		 */
+		if (unlikely(desc->completion->status == IDXD_COMP_DESC_ABORT))
+			idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT, true);
+		else
+			idxd_dma_complete_txd(desc, IDXD_COMPLETE_NORMAL, true);
+
+		return DMA_COMPLETE;
+	}
+
+	return DMA_IN_PROGRESS;
 }
 
+
 /*
  * issue_pending() does not need to do anything since tx_submit() does the job
  * already.
@@ -181,7 +251,17 @@ static dma_cookie_t idxd_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	int rc;
 	struct idxd_desc *desc = container_of(tx, struct idxd_desc, txd);
 
-	cookie = dma_cookie_assign(tx);
+	cookie = (desc->gen << DESC_ID_BITS) | (desc->id & DESC_ID_MASK);
+
+	if ((desc->hw->flags & IDXD_OP_FLAG_RCI) != 0)
+		cookie |= DESC_INTERRUPT_FLAG;
+
+	if (desc->gen == DESC_GEN_MAX)
+		desc->gen = 1;
+	else
+		desc->gen++;
+
+	tx->cookie = cookie;
 
 	rc = idxd_submit_desc(wq, desc);
 	if (rc < 0) {
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index d9096dfb27422..739c55e56502c 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -334,6 +334,7 @@ struct idxd_desc {
 	struct llist_node llnode;
 	struct list_head list;
 	u16 id;
+	u16 gen;
 	int cpu;
 	struct idxd_wq *wq;
 };
-- 
2.37.3

