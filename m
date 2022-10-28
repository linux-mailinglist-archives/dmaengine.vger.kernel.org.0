Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E0B611BC4
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 22:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiJ1Usi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Oct 2022 16:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJ1Usd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Oct 2022 16:48:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1AE23B684;
        Fri, 28 Oct 2022 13:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666990112; x=1698526112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nk/K5i7j65qqOGXiPvtxT8raiuWpDxteaKLaAofkBog=;
  b=n4uHuGkJHi67yD7hYETT/XV1UebksWNNcQi1lU2fZbMz2xUarL4PwnhO
   UoOmafDOvFkyMfLeOYw0PJba4SJ/cFAxQreSNY1umLhdSQW12ZBr3LGgu
   B+6xbRFIanUTrttJqaSxyQVDoCeJE0z0ihKAyC9DaXCs3iwz7Y7e8BnNF
   Us2kIKe+5XHaHqZAAKpfiy+xNTWgUXyNkTEm0oAEmTOveigVU/0hiG6Wv
   qBy01PL67XKhO0N7/9batjF1uRiba5byq+yoB3l0q0XJGRFrpqftIRMdU
   chrKaG8nIc/1FSZ+bv6NVUeocX6a23RSS7wa/reRlYYjdd/isvpBXU3qi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="291885114"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="291885114"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 13:48:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="962159835"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="962159835"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by fmsmga005.fm.intel.com with ESMTP; 28 Oct 2022 13:48:30 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v6 3/7] dmaengine: Add dmaengine_is_tx_complete
Date:   Fri, 28 Oct 2022 13:48:08 -0700
Message-Id: <20221028204812.1772736-4-benjamin.walker@intel.com>
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

This is the replacement for dma_async_is_tx_complete with two changes:
1) The name prefix is 'dmaengine' as per convention
2) It no longer reports the 'last' or 'used' cookie

Drivers should convert to using dmaengine_is_tx_complete.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/driver-api/dmaengine/client.rst | 19 ++++---------------
 .../driver-api/dmaengine/provider.rst         |  6 +++---
 drivers/dma/dmaengine.c                       |  2 +-
 drivers/dma/dmatest.c                         |  3 +--
 include/linux/dmaengine.h                     | 16 ++++++++++++++++
 5 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index 85ecec2c40005..9e737041d65ea 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -259,8 +259,8 @@ The details of these operations are:
 
       dma_cookie_t dmaengine_submit(struct dma_async_tx_descriptor *desc)
 
-   This returns a cookie can be used to check the progress of DMA engine
-   activity via other DMA engine calls not covered in this document.
+   This returns a cookie that can be used to check the progress of a transaction
+   via dmaengine_is_tx_complete().
 
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
+      enum dma_status dmaengine_is_tx_complete(struct dma_chan *chan,
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
index ceac2a300e328..1d0da2777921d 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -539,10 +539,10 @@ where to put them)
 
 dma_cookie_t
 
-- it's a DMA transaction ID that will increment over time.
+- it's a DMA transaction ID.
 
-- Not really relevant any more since the introduction of ``virt-dma``
-  that abstracts it away.
+- The value can be chosen by the provider, or use the helper APIs
+  such as dma_cookie_assign() and dma_cookie_complete().
 
 DMA_CTRL_ACK
 
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c741b6431958c..74bc92e51a5a7 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -523,7 +523,7 @@ enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie)
 
 	dma_async_issue_pending(chan);
 	do {
-		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
+		status = dmaengine_is_tx_complete(chan, cookie);
 		if (time_after_eq(jiffies, dma_sync_wait_timeout)) {
 			dev_err(chan->device->dev, "%s: timeout!\n", __func__);
 			return DMA_ERROR;
diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index ffe621695e472..76a027e95d2aa 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -831,8 +831,7 @@ static int dmatest_func(void *data)
 					done->done,
 					msecs_to_jiffies(params->timeout));
 
-			status = dma_async_is_tx_complete(chan, cookie, NULL,
-							  NULL);
+			status = dmaengine_is_tx_complete(chan, cookie);
 		}
 
 		if (!done->done) {
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 5ae881729b620..72b7d51fe41de 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1426,6 +1426,8 @@ static inline void dma_async_issue_pending(struct dma_chan *chan)
  * @last: returns last completed cookie, can be NULL
  * @used: returns last issued cookie, can be NULL
  *
+ * Note: This is deprecated. Use dmaengine_is_tx_complete instead.
+ *
  * If @last and @used are passed in, upon return they reflect the most
  * recently submitted (used) cookie and the most recently completed
  * cookie.
@@ -1444,6 +1446,20 @@ static inline enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
 	return status;
 }
 
+/**
+ * dmaengine_is_tx_complete - poll for transaction completion
+ * @chan: DMA channel
+ * @cookie: transaction identifier to check status of
+ *
+ */
+static inline enum dma_status dmaengine_is_tx_complete(struct dma_chan *chan,
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
2.37.3

