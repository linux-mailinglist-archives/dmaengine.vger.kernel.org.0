Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319735554C9
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 21:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358172AbiFVTiT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 15:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiFVTiS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 15:38:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22BC13FAD;
        Wed, 22 Jun 2022 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655926697; x=1687462697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P3iUa2XT/oNSfJJ/tR2VBOAYNb3cfyuFHSgoct+V9vU=;
  b=iYpWY5gmcjdC2wYZpXapk+75ZhNPyBeB4hHeTwLSm/IBg4xooVH+Oria
   h3mTLXJrNn3ly6QPcZuvFtuK6wzMxEz9g4V6Gprxab72zUyzehIcSG3bJ
   BwtpvUxxMfo/DI/pizEx4v9kIGHUsI7fQdGKNkvqxnHzsv79spNSfr/YO
   ewErk7MKhypqo3m/yduHcXXCpspSGkv7Ojd4jQPp0Tsp9M71y8BEPx0hx
   cwXRIR+RLJbT/12l1YLQHw/uLTmRjUOqF7ErxhAA2+Hwm4MDM0hUUsmef
   QL5wraBwWhvtCBqRVc13bKynDB36jv62KhcO4IB/N7+LMki8WqtsMps3o
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="305983053"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="305983053"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 12:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="715542069"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2022 12:38:17 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/15] dmaengine: Remove dma_async_is_complete from client API
Date:   Wed, 22 Jun 2022 12:37:39 -0700
Message-Id: <20220622193753.3044206-2-benjamin.walker@intel.com>
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

This is never actually used by any existing DMA clients. It is only
used, via dma_cookie_status, by providers.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 Documentation/driver-api/dmaengine/client.rst |  5 ++--
 drivers/dma/amba-pl08x.c                      |  1 -
 drivers/dma/at_hdmac.c                        |  3 +-
 drivers/dma/dmaengine.h                       | 10 ++++++-
 include/linux/dmaengine.h                     | 28 ++-----------------
 5 files changed, 15 insertions(+), 32 deletions(-)

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
 
diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index a4a794e62ac26..bd361aee07db8 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1536,7 +1536,6 @@ static void pl08x_free_chan_resources(struct dma_chan *chan)
 }
 
 /*
- * Code accessing dma_async_is_complete() in a tight loop may give problems.
  * If slaves are relying on interrupts to signal completion this function
  * must not be called with interrupts disabled.
  */
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 5a50423b7378e..5ec9a36074771 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1491,8 +1491,7 @@ static int atc_terminate_all(struct dma_chan *chan)
  * @txstate: if not %NULL updated with transaction state
  *
  * If @txstate is passed in, upon return it reflect the driver
- * internal state and can be used with dma_async_is_complete() to check
- * the status of multiple cookies without re-checking hardware state.
+ * internal state.
  */
 static enum dma_status
 atc_tx_status(struct dma_chan *chan,
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
index b46b88e6aa0d1..ea6ec2666eb15 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1446,9 +1446,9 @@ static inline void dma_async_issue_pending(struct dma_chan *chan)
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
@@ -1464,28 +1464,6 @@ static inline enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
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
2.35.1

