Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A1C5A55A9
	for <lists+dmaengine@lfdr.de>; Mon, 29 Aug 2022 22:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiH2UgM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Aug 2022 16:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiH2UgJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Aug 2022 16:36:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598B98B99E;
        Mon, 29 Aug 2022 13:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661805368; x=1693341368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t4PZeQmey/yHZcSqbdkm0gA9lwZhJ+ucFrG4fh62X8o=;
  b=BKgEgl4bTbVW1ctzkzMhht+ZAryv6kb/3MVZMyAksyic7kxLN1otyQ0M
   d/I8WOJMIrTF4noCZ0NpfTzeI+fJOqrvtwgiz9tAM6NwgdHqExR+4w5lc
   4as60YPi8WRqSszUOgoYzBprSye8ofcVNB3WrYopM3aS+CHSu/kGmN34H
   uPTZ6+Vfmsn0MgUrk/rED7eRJtYjFMsCQQ3Dwhqn4Jdtxs76wcI0nRPTq
   KoACW1psIcsRa8enUth1fwNBx3R/7wc1uXfjvJmPBl9JOD2qwU249Tfp0
   sdh2Sigx4tIAatWifX2ninShWtmIipZPlj8ZIaJf6hfuKoM3ODCHO+14d
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="358958403"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="358958403"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 13:36:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="614344320"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2022 13:36:04 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/7] dmaengine: Move dma_set_tx_state to the provider API header
Date:   Mon, 29 Aug 2022 13:35:32 -0700
Message-Id: <20220829203537.30676-3-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220829203537.30676-1-benjamin.walker@intel.com>
References: <20220622193753.3044206-1-benjamin.walker@intel.com>
 <20220829203537.30676-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This is only used by DMA providers, not DMA clients. Move it next
to the other cookie utility functions.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/dma/dmaengine.h   | 11 +++++++++++
 include/linux/dmaengine.h | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index a2ce377e9ed0f..e72876a512a39 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -90,6 +90,17 @@ static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
 	return DMA_IN_PROGRESS;
 }
 
+static inline void dma_set_tx_state(struct dma_tx_state *st,
+	dma_cookie_t last, dma_cookie_t used, u32 residue)
+{
+	if (!st)
+		return;
+
+	st->last = last;
+	st->used = used;
+	st->residue = residue;
+}
+
 static inline void dma_set_residue(struct dma_tx_state *state, u32 residue)
 {
 	if (state)
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c55dcae7dc620..5ae881729b620 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1444,17 +1444,6 @@ static inline enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
 	return status;
 }
 
-static inline void
-dma_set_tx_state(struct dma_tx_state *st, dma_cookie_t last, dma_cookie_t used, u32 residue)
-{
-	if (!st)
-		return;
-
-	st->last = last;
-	st->used = used;
-	st->residue = residue;
-}
-
 #ifdef CONFIG_DMA_ENGINE
 struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type);
 enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie);
-- 
2.37.1

