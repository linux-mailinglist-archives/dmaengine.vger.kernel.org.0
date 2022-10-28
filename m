Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74670611BC2
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 22:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJ1Usj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Oct 2022 16:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJ1Usf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Oct 2022 16:48:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D854523AB61;
        Fri, 28 Oct 2022 13:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666990114; x=1698526114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3SWIcRGRt8kh18AXJXrL3bsHSZdCuMtCu2X+SbLmmGE=;
  b=GTOlf4FQdHDGdMITgG+cU06B1jnQQL5xwMXSWnW5tZwkGT2RZX2HyXpY
   UP+Gxgai/JekWDqTxD2r0nrAyx0M6zCMO7op8zSTVPvnDRp4WdGIW01Pb
   Lm30PRxlEzVdcdt/d58rCWYVsUcvMpZXuXgiYx0J88zIMZBtLOxHu5Ca+
   IrAi2QTg+8oV4rq+U84+9iZZxT/NITdTVA79iqcGx9LmEN6HijOgXM7BF
   JX8Yv56kDtnAPYiP2Ow89MgLnvaVJ+t/bi0Qx0HjURANfSsXz2z9sQh6T
   elU9Dcu9oNpVHOokSqYv58sgUZzXq89W1mIAcwQtmarCfOWZN3jUPk4wG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="291885119"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="291885119"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 13:48:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="962159863"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="962159863"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by fmsmga005.fm.intel.com with ESMTP; 28 Oct 2022 13:48:34 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v6 4/7] dmaengine: Add provider documentation on cookie assignment
Date:   Fri, 28 Oct 2022 13:48:09 -0700
Message-Id: <20221028204812.1772736-5-benjamin.walker@intel.com>
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

Clarify the rules on assigning cookies to DMA transactions.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 .../driver-api/dmaengine/provider.rst         | 45 +++++++++++++++----
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 1d0da2777921d..a5539f816d125 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -417,7 +417,9 @@ supported.
 
     - tx_submit: A pointer to a function you have to implement,
       that is supposed to push the current transaction descriptor to a
-      pending queue, waiting for issue_pending to be called.
+      pending queue, waiting for issue_pending to be called. Each
+      descriptor is given a cookie to identify it. See the section
+      "Cookie Management" below.
 
   - In this structure the function pointer callback_result can be
     initialized in order for the submitter to be notified that a
@@ -522,6 +524,40 @@ supported.
 
   - May sleep.
 
+Cookie Management
+------------------
+
+When a transaction is queued for submission via tx_submit(), the provider
+must assign that transaction a cookie (dma_cookie_t) to uniquely identify it.
+The provider is allowed to perform this assignment however it wants, but for
+convenience the following utility functions are available to create
+monotonically increasing cookies
+
+  .. code-block:: c
+
+    void dma_cookie_init(struct dma_chan *chan);
+
+  Called once at channel creation
+
+  .. code-block:: c
+
+    dma_cookie_t dma_cookie_assign(struct dma_async_tx_descriptor *tx);
+
+  Assign a cookie to the given descriptor
+
+  .. code-block:: c
+
+    void dma_cookie_complete(struct dma_async_tx_descriptor *tx);
+
+  Mark the descriptor as complete and invalidate the cookie
+
+  .. code-block:: c
+
+    enum dma_status dma_cookie_status(struct dma_chan *chan,
+      dma_cookie_t cookie, struct dma_tx_state *state);
+
+  Report the status of the cookie and filling in state, if not NULL.
+
 
 Misc notes
 ==========
@@ -537,13 +573,6 @@ where to put them)
 - Makes sure that dependent operations are run before marking it
   as complete.
 
-dma_cookie_t
-
-- it's a DMA transaction ID.
-
-- The value can be chosen by the provider, or use the helper APIs
-  such as dma_cookie_assign() and dma_cookie_complete().
-
 DMA_CTRL_ACK
 
 - If clear, the descriptor cannot be reused by provider until the
-- 
2.37.3

