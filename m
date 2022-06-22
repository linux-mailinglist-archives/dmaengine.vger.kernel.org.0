Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B605554CB
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 21:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359105AbiFVTjA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 15:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359565AbiFVTie (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 15:38:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7733FBF9;
        Wed, 22 Jun 2022 12:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655926708; x=1687462708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=22nHq2RPTYBl+xCBcNB+uv2lzSC2PKfcu0Pva/vEmZc=;
  b=GQSw9aP6MDjJXW5KxwpLTNo/p1lL6J3To/XcPL3RNHjhLmnKKnXP3U2u
   gcFmPSnBW5vUvInDo6XwETgeqQIqUeJGADJlmqvyocjRSiauYH2qxv94H
   BwGiQ7YIvx3HNnaJvCw1V8eOzPSfxEV44OF8Y2PvwMxFl/esMfyMdfuzL
   wrTTxIdy0P5TbjPzD03BBfH8lxZNbfSsjJYLUmLlCCKgONoZV976L/mBJ
   PWwrr+qLXNHKt9wmzEfvtpAfwkIA8V7fpzlFu4ReAdeosh0iYzmXsfEhr
   940SWRkBDM3NYDERjQ8vwBtty+E7TRWiL9AVL7R2LPBZ0YxQMtXGJ5905
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="305983099"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="305983099"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 12:38:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="715542095"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2022 12:38:28 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/15] dmaengine: Remove dma_async_is_tx_complete
Date:   Wed, 22 Jun 2022 12:37:46 -0700
Message-Id: <20220622193753.3044206-9-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220622193753.3044206-1-benjamin.walker@intel.com>
References: <20220503200728.2321188-1-benjamin.walker@intel.com>
 <20220622193753.3044206-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Everything has now been converted over to
dmaengine_async_is_tx_complete, so this can be removed.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 include/linux/dmaengine.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 44eb1df433e61..c34f21d19c423 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1439,33 +1439,6 @@ static inline void dma_async_issue_pending(struct dma_chan *chan)
 	chan->device->device_issue_pending(chan);
 }
 
-/**
- * dma_async_is_tx_complete - poll for transaction completion
- * @chan: DMA channel
- * @cookie: transaction identifier to check status of
- * @last: returns last completed cookie, can be NULL
- * @used: returns last issued cookie, can be NULL
- *
- * Note: This is deprecated. Use dmaengine_async_is_tx_complete instead.
- *
- * If @last and @used are passed in, upon return they reflect the most
- * recently submitted (used) cookie and the most recently completed
- * cookie.
- */
-static inline enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
-	dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
-{
-	struct dma_tx_state state;
-	enum dma_status status;
-
-	status = chan->device->device_tx_status(chan, cookie, &state);
-	if (last)
-		*last = state.last;
-	if (used)
-		*used = state.used;
-	return status;
-}
-
 /**
  * dmaengine_async_is_tx_complete - poll for transaction completion
  * @chan: DMA channel
-- 
2.35.1

