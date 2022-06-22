Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7DC5553CE
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 20:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377195AbiFVSzC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 14:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377692AbiFVSy1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 14:54:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902FB40A14;
        Wed, 22 Jun 2022 11:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655924052; x=1687460052;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=heNZ3ldVGFsCnCJbujwBHGTHwI0k3/obOMtrSos/hpM=;
  b=FFjRlito3RUXhJrkpHSAfj04RlNnQufBzS2AQdo33Ejy75QVY9iwc/yN
   D4jdyuMm14lOO4KXDUEtEnL0AwPUZZJtLtjHK+KQJX73YGx7O34JNDsKz
   2vPvhgRFMrKZi6iT4im30/RcWyYbQlBlzlGuVpcMu/xjrwd05X8nUMFTL
   7xywM6wEpbSELzGkiNv34+hPqf74lTtFYE7wW4JY4P3vcjkoi+LC+kIjA
   YaYK/WRKT4zRaQmX8c8CdYmjdC3E6CuiMgwQDbrjWV7lqRqBVXdWWz7y2
   aioL7KHt5RaR73KEGNVm++kl3HYTeu8YhdbCJaJUSXey034kShC5beXnv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="342200306"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="342200306"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 11:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="677700974"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2022 11:54:11 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/15] dmaengine: idxd: Support device_tx_status
Date:   Wed, 22 Jun 2022 11:54:09 -0700
Message-Id: <20220622185409.3043646-1-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This can now be supported even for devices that complete operations out
of order. Add support for directly polling transactions.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/dma/idxd/device.c |  1 +
 drivers/dma/idxd/dma.c    | 85 ++++++++++++++++++++++++++++++++++++++-
 drivers/dma/idxd/idxd.h   |  1 +
 3 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index ff0ea60051f0c..3c61eac0b05c7 100644
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
index e0874cb4721c8..dda5342d273f4 100644
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
@@ -158,13 +175,67 @@ static void idxd_dma_free_chan_resources(struct dma_chan *chan)
 		idxd_wq_refcount(wq));
 }
 
+
 static enum dma_status idxd_dma_tx_status(struct dma_chan *dma_chan,
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
@@ -181,7 +252,17 @@ static dma_cookie_t idxd_dma_tx_submit(struct dma_async_tx_descriptor *tx)
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
index bd93ada32c89d..d4f0227895075 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -326,6 +326,7 @@ struct idxd_desc {
 	struct llist_node llnode;
 	struct list_head list;
 	u16 id;
+	u16 gen;
 	int cpu;
 	struct idxd_wq *wq;
 };
-- 
2.35.1

