Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49BE611BBF
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 22:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJ1Use (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Oct 2022 16:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiJ1Us3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Oct 2022 16:48:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110BD23AB7E;
        Fri, 28 Oct 2022 13:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666990106; x=1698526106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TzcP1yHmtwweYfkjNw9hfdumqxigqt50I2pQJenZIcE=;
  b=JQdY02WqVe5V9/R02urTqbWtvGV7nIVuOIK1o6cbwy27YQm7Uh463V6H
   V+rLhZB78yf6yCfPDEFZZDxVbpkTQExdZO58Mzc3TNG4hpbbRfrP7yB6O
   f9TbVcQBX+bS3ktzPgixwAj6cxKKc4GNuocbv86XMI2O6xB7eEc0wcfdb
   wHwwaVwJIqbWIZGlQkgvD69o0JrJfMX51NxU/Nu2Pk/q/tgT6PMdOcJf1
   8senbWXVIx8QMarW7U3sHueCOhgYoiBUdDt+D8H5yZNiqnAhmGYs+7YuP
   AVBCFubdpdKmIqIWrKebfQsuc19/zK2vrZxwWLjc2+59Bfvq3hpS5cNmR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="291885090"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="291885090"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 13:48:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="962159798"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="962159798"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by fmsmga005.fm.intel.com with ESMTP; 28 Oct 2022 13:48:20 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v6 1/7] dmaengine: Remove dma_async_is_complete from client API
Date:   Fri, 28 Oct 2022 13:48:06 -0700
Message-Id: <20221028204812.1772736-2-benjamin.walker@intel.com>
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

This is never actually used by any existing DMA clients. It is only
used, via dma_cookie_status, by providers.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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
2.37.3

