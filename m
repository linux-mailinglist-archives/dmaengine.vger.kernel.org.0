Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEA9611BC0
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 22:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJ1Usg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Oct 2022 16:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJ1Usa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Oct 2022 16:48:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68982475E0;
        Fri, 28 Oct 2022 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666990108; x=1698526108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DwAZgIO79UPglttMtSBhU1lsvyVEj9oh2vUqhHtM8XM=;
  b=EOjxAwcKb9nhZ2wqArps5mUYBzBNQK6Wyy96VbEPXWuIBd/9SefU2q2m
   3GZsR/HzjIAEi9BNh2ZMZMNsEslOZnrsM5E6P1XG347MEkGx37n0bI+yB
   sWbqDZ1ymeleppRAuhwjbvs6SVCWDdnXpcjoewsjY8t2os5HmVo0nIQSQ
   N6c7V+F9tq0GzxQM3JjOx5XUMcF4YdIjIf61kdjmfMdOP5/EJdcbwL1mU
   TEtgE5CYJcZtzpT3mZUBYjsvoUzNwkC/HyCQRgk9pbqIUe8g6Z+9UEooR
   EhFbKrF48dOFvC2WWCqe9uG8kQ+Z1AeeRTuqSqT+bNyRA2BZ5ieEbvO7X
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="291885104"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="291885104"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 13:48:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="962159823"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="962159823"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by fmsmga005.fm.intel.com with ESMTP; 28 Oct 2022 13:48:26 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v6 2/7] dmaengine: Move dma_set_tx_state to the provider API header
Date:   Fri, 28 Oct 2022 13:48:07 -0700
Message-Id: <20221028204812.1772736-3-benjamin.walker@intel.com>
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

This is only used by DMA providers, not DMA clients. Move it next
to the other cookie utility functions.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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
2.37.3

