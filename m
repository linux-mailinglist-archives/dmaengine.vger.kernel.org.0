Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFF35553BE
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 20:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377704AbiFVSyK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 14:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377719AbiFVSx5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 14:53:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A5227FF1;
        Wed, 22 Jun 2022 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655924036; x=1687460036;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IWEAw0BMzgbgDY1rwfN7uYNpUJiLcW/iUQ1Hnk7la2k=;
  b=EG3ZJ/jSVQWiGPD+UZe+VttrEVrqoVFgc7m6igr1yURTR4xd6H++oIY/
   FfJ16+iN8m+E5/1P5i5bdu8Pi+Kwim4/wtDMPOuJgStI+Z896HDFAqSxv
   pnV/W9pBdtZnrMXnODM0AqKWPgjY/i4lh3WAW2XCnAuYjLewtDPVZSLyF
   ymw/1fgwKm5Dc2/C1xzLMzr1xvZU7e8KjZmzjcsYDCViIf8itr88zOh5F
   XXB8rnv30RO/3A66wpXWu+r+Lo2Y2ZGnlqUDQb4G0NBOwkvRyVcU5rzIz
   ROQZUMzWiGzbT1uFV5JmGTXX3+LXJdTbNTdyXbbGsYqJfg4VxZ9G+5/Ej
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="278063732"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="278063732"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 11:53:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="621030199"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2022 11:53:55 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/15] dmaengine: Remove last, used from dma_tx_state
Date:   Wed, 22 Jun 2022 11:53:54 -0700
Message-Id: <20220622185354.3043606-1-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Nothing uses these and they don't convey usable information.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/dma/dmaengine.h   | 4 ----
 include/linux/dmaengine.h | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index e72876a512a39..08c7bd7cfc229 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -74,8 +74,6 @@ static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
 	complete = chan->completed_cookie;
 	barrier();
 	if (state) {
-		state->last = complete;
-		state->used = used;
 		state->residue = 0;
 		state->in_flight_bytes = 0;
 	}
@@ -96,8 +94,6 @@ static inline void dma_set_tx_state(struct dma_tx_state *st,
 	if (!st)
 		return;
 
-	st->last = last;
-	st->used = used;
 	st->residue = residue;
 }
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c34f21d19c423..e3e5311b6bb64 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -716,16 +716,12 @@ static inline struct dma_async_tx_descriptor *txd_next(struct dma_async_tx_descr
 /**
  * struct dma_tx_state - filled in to report the status of
  * a transfer.
- * @last: last completed DMA cookie
- * @used: last issued DMA cookie (i.e. the one in progress)
  * @residue: the remaining number of bytes left to transmit
  *	on the selected transfer for states DMA_IN_PROGRESS and
  *	DMA_PAUSED if this is implemented in the driver, else 0
  * @in_flight_bytes: amount of data in bytes cached by the DMA.
  */
 struct dma_tx_state {
-	dma_cookie_t last;
-	dma_cookie_t used;
 	u32 residue;
 	u32 in_flight_bytes;
 };
-- 
2.35.1

