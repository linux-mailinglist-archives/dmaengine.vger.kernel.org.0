Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1500C5A55A1
	for <lists+dmaengine@lfdr.de>; Mon, 29 Aug 2022 22:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiH2Ufy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Aug 2022 16:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiH2Ufv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Aug 2022 16:35:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B0589CE8;
        Mon, 29 Aug 2022 13:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661805349; x=1693341349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AOMv2D9+eNmOX++emb4GyqenMsZwfkFPdGhI0iTjL7U=;
  b=ludMlkdE77C5fO4b7H3WtupCqVOHfnASJ+k3wowzg0un4vsP1m5AxzFr
   IPKncRqJ+CEWkFUBlUKer310K34T+zi1m8xIZrOzBDMBQuc9mLUj5tYDm
   xJqMG8DGJk4yLJ+KUeBCddjzHef2r7Mh5PvjbjLS9IWU13x82uTvWRGZn
   dTTDRVaXT8L0fS+xznDLobW1zxGGIglcfpsOeCFUkVmGI2+5KOui6vDH3
   deBvnwJ2WFdxOKT6QkAAJKNfjuGBtYZLVMr4g3y0YcqVxsBuw28y/dMnD
   WWW9IreNxeA8Y1VzpInJMryaVMR8hyGLkpR0snMJugvOVhQdfi1tZLQ1b
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="381291978"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="381291978"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 13:35:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="614344248"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2022 13:35:47 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/7] dmaengine: Remove dma_async_is_complete from client API
Date:   Mon, 29 Aug 2022 13:35:31 -0700
Message-Id: <20220829203537.30676-2-benjamin.walker@intel.com>
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

This is never actually used by any existing DMA clients. It is only
used, via dma_cookie_status, by providers.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 Documentation/driver-api/dmaengine/client.rst |  5 ++--
 drivers/dma/dmaengine.h                       | 10 ++++++-
 include/linux/dmaengine.h                     | 28 ++-----------------
 3 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index bfd057b21a000..85ecec2c40005 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -346,9 +346,8 @@ Further APIs
    the documentation in include/linux/dmaengine.h for a more complete
    description of this API.
 
-   This can be used in conjunction with dma_async_is_complete() and
-   the cookie returned from dmaengine_submit() to check for
-   completion of a specific DMA transaction.
+   This can be used with the cookie returned from dmaengine_submit()
+   to check for completion of a specific DMA transaction.
 
    .. note::
 
diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index 53f16d3f00294..a2ce377e9ed0f 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -79,7 +79,15 @@ static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
 		state->residue = 0;
 		state->in_flight_bytes = 0;
 	}
-	return dma_async_is_complete(cookie, complete, used);
+
+	if (complete <= used) {
+		if ((cookie <= complete) || (cookie > used))
+			return DMA_COMPLETE;
+	} else {
+		if ((cookie <= complete) && (cookie > used))
+			return DMA_COMPLETE;
+	}
+	return DMA_IN_PROGRESS;
 }
 
 static inline void dma_set_residue(struct dma_tx_state *state, u32 residue)
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c923f4e60f240..c55dcae7dc620 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1426,9 +1426,9 @@ static inline void dma_async_issue_pending(struct dma_chan *chan)
  * @last: returns last completed cookie, can be NULL
  * @used: returns last issued cookie, can be NULL
  *
- * If @last and @used are passed in, upon return they reflect the driver
- * internal state and can be used with dma_async_is_complete() to check
- * the status of multiple cookies without re-checking hardware state.
+ * If @last and @used are passed in, upon return they reflect the most
+ * recently submitted (used) cookie and the most recently completed
+ * cookie.
  */
 static inline enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
 	dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
@@ -1444,28 +1444,6 @@ static inline enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
 	return status;
 }
 
-/**
- * dma_async_is_complete - test a cookie against chan state
- * @cookie: transaction identifier to test status of
- * @last_complete: last know completed transaction
- * @last_used: last cookie value handed out
- *
- * dma_async_is_complete() is used in dma_async_is_tx_complete()
- * the test logic is separated for lightweight testing of multiple cookies
- */
-static inline enum dma_status dma_async_is_complete(dma_cookie_t cookie,
-			dma_cookie_t last_complete, dma_cookie_t last_used)
-{
-	if (last_complete <= last_used) {
-		if ((cookie <= last_complete) || (cookie > last_used))
-			return DMA_COMPLETE;
-	} else {
-		if ((cookie <= last_complete) && (cookie > last_used))
-			return DMA_COMPLETE;
-	}
-	return DMA_IN_PROGRESS;
-}
-
 static inline void
 dma_set_tx_state(struct dma_tx_state *st, dma_cookie_t last, dma_cookie_t used, u32 residue)
 {
-- 
2.37.1

