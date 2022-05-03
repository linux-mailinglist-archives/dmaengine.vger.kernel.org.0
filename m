Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA89518DFE
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 22:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242171AbiECUMW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 16:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiECULp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 16:11:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466782656D
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 13:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651608474; x=1683144474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wbX9rSJYFNVr2rb8p0DUuXF7RyYcKdVkKTgYYqNvOKM=;
  b=fn5t3QU2Kq01UceDq1a/GliP9TjsIi+93KIvr4tmJYEzbla6zcSlOQdu
   m3SgYdfi22GyIs3u3NX32WPtHDSpveH7PI5c31hF8raz8twa1VbcKtIaK
   RDB0Futmo9VyLreeCGSjW43/Mg6rW+WyPXtYSTiCWFGUVf7DgygMEPK54
   LfiT4ab+FMK8Oqzl4i4qQxDD6t7S/s3Q1sG27+hMeLHXnbf/DVWeHnkuE
   vjnzzlPB4f5Bpkh+F48LFCUjEHjmbD74cvnPLmyix45yoJ7nTZOebcAva
   2o1HbcWMvnqCzxuHhyg51NvCvQcB798GYs+M+6IJZCITqmpukIsKisawP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="328116016"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="328116016"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 13:07:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="516705132"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2022 13:07:53 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, mchehab@kernel.org,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v2 02/15] dmaengine: Move dma_set_tx_state to the provider API header
Date:   Tue,  3 May 2022 13:07:15 -0700
Message-Id: <20220503200728.2321188-3-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200728.2321188-1-benjamin.walker@intel.com>
References: <20220503200728.2321188-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
index 194e334b33bbc..8c4934bc038ec 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1457,17 +1457,6 @@ static inline enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
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
2.35.1

