Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830885554C7
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 21:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358273AbiFVTiX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 15:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358570AbiFVTiW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 15:38:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A840167FD;
        Wed, 22 Jun 2022 12:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655926701; x=1687462701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4QSuaH5P1V9uS0dSZnBNZ39kjP3dH2P2AHz6kFEzfGs=;
  b=bUN2qYUmg4fm+obhzfm8gC5R5Z8LJDuWu+sObidG+l9J8GVxNN1h51GK
   ihpnNewWe/W97vdhpZQVP3UsegUy2TpvRsDJAN97+juxxGHf5f18oc1ZF
   H50BMz8csG7K6XeaxvnFHEdbGSigcsG9JqhgV5eSO8imxdcN/rUQQR+BH
   OInYb9qCpyDJiUPwYPo7T7T9V+iBqHPMKW/IvrZ3nhSAzIpY3TsPo3ity
   dwnBSQgev1ncHgHwcr1OpysaO2B/XuuGQjMfDeVGo4+Uru1OVye8F+w9C
   qHPFMITG3mOXioZf1blHG0rRq0XKlnlssRVi26Mx8VbeHt0+YvngWg9cR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="305983063"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="305983063"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 12:38:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="715542075"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2022 12:38:20 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/15] dmaengine: Add dmaengine_async_is_tx_complete
Date:   Wed, 22 Jun 2022 12:37:41 -0700
Message-Id: <20220622193753.3044206-4-benjamin.walker@intel.com>
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

This is the replacement for dma_async_is_tx_complete with two changes:
1) The name prefix is 'dmaengine' as per convention
2) It no longer reports the 'last' or 'used' cookie

Drivers should convert to using dmaengine_async_is_tx_complete.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 Documentation/driver-api/dmaengine/client.rst | 19 ++++---------------
 .../driver-api/dmaengine/provider.rst         |  6 +++---
 drivers/dma/dmaengine.c                       |  2 +-
 drivers/dma/dmatest.c                         |  3 +--
 include/linux/dmaengine.h                     | 16 ++++++++++++++++
 5 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index 85ecec2c40005..9ae489a4ca97f 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -259,8 +259,8 @@ The details of these operations are:
 
       dma_cookie_t dmaengine_submit(struct dma_async_tx_descriptor *desc)
 
-   This returns a cookie can be used to check the progress of DMA engine
-   activity via other DMA engine calls not covered in this document.
+   This returns a cookie that can be used to check the progress of a transaction
+   via dmaengine_async_is_tx_complete().
 
    dmaengine_submit() will not start the DMA operation, it merely adds
    it to the pending queue. For this, see step 5, dma_async_issue_pending.
@@ -339,23 +339,12 @@ Further APIs
 
    .. code-block:: c
 
-      enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
-		dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
-
-   This can be used to check the status of the channel. Please see
-   the documentation in include/linux/dmaengine.h for a more complete
-   description of this API.
+      enum dma_status dmaengine_async_is_tx_complete(struct dma_chan *chan,
+		dma_cookie_t cookie)
 
    This can be used with the cookie returned from dmaengine_submit()
    to check for completion of a specific DMA transaction.
 
-   .. note::
-
-      Not all DMA engine drivers can return reliable information for
-      a running DMA channel. It is recommended that DMA engine users
-      pause or stop (via dmaengine_terminate_all()) the channel before
-      using this API.
-
 5. Synchronize termination API
 
    .. code-block:: c
diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 1e0f1f85d10e5..610309276bc9c 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -549,10 +549,10 @@ where to put them)
 
 dma_cookie_t
 
-- it's a DMA transaction ID that will increment over time.
+- it's a DMA transaction ID.
 
-- Not really relevant any more since the introduction of ``virt-dma``
-  that abstracts it away.
+- The value can be chosen by the provider, or use the helper APIs
+  such as dma_cookie_assign() and dma_cookie_complete().
 
 DMA_CTRL_ACK
 
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index e80feeea0e018..f67a13c29d3f9 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -523,7 +523,7 @@ enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie)
 
 	dma_async_issue_pending(chan);
 	do {
-		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
+		status = dmaengine_async_is_tx_complete(chan, cookie);
 		if (time_after_eq(jiffies, dma_sync_wait_timeout)) {
 			dev_err(chan->device->dev, "%s: timeout!\n", __func__);
 			return DMA_ERROR;
diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 0a2168a4ccb0c..3ee47a72bf9d7 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -838,8 +838,7 @@ static int dmatest_func(void *data)
 					done->done,
 					msecs_to_jiffies(params->timeout));
 
-			status = dma_async_is_tx_complete(chan, cookie, NULL,
-							  NULL);
+			status = dmaengine_async_is_tx_complete(chan, cookie);
 		}
 
 		if (!done->done) {
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index f968f7671e22c..44eb1df433e61 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1446,6 +1446,8 @@ static inline void dma_async_issue_pending(struct dma_chan *chan)
  * @last: returns last completed cookie, can be NULL
  * @used: returns last issued cookie, can be NULL
  *
+ * Note: This is deprecated. Use dmaengine_async_is_tx_complete instead.
+ *
  * If @last and @used are passed in, upon return they reflect the most
  * recently submitted (used) cookie and the most recently completed
  * cookie.
@@ -1464,6 +1466,20 @@ static inline enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
 	return status;
 }
 
+/**
+ * dmaengine_async_is_tx_complete - poll for transaction completion
+ * @chan: DMA channel
+ * @cookie: transaction identifier to check status of
+ *
+ */
+static inline enum dma_status dmaengine_async_is_tx_complete(struct dma_chan *chan,
+	dma_cookie_t cookie)
+{
+	struct dma_tx_state state;
+
+	return chan->device->device_tx_status(chan, cookie, &state);
+}
+
 #ifdef CONFIG_DMA_ENGINE
 struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type);
 enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie);
-- 
2.35.1

