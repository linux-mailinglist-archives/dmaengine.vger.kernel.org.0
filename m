Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994BA518E11
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 22:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbiECUMa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 16:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242253AbiECUMV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 16:12:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9AD40938
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 13:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651608508; x=1683144508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AbCtiizXn7mtWsj4iItd1wCayDjqPN6a2w8lSyAntQQ=;
  b=UEZhKjTc+cHeiXLbqLJuDjglv+SxAzMQOaIw7mIQedVc2MGLPjE+nI13
   WQEOQcP4QLQI9+1K7THMM9LZX6vq9uIx5C766+wy27uMCNl+HIqy7ckb4
   /joWbXzLBEKAJmLxgIAqpNtLmmRD4rhm8isZD+Fmu9KQ+6yDrv4UfTq95
   1YY8Syg/xTkPCxr2GkxDbEoP2bHT1Xf32kmGPtU0GL3SQgmBp7tBQzXUM
   jtcFIC17ORcvuUC4YvmZUGDqECQzfWiyVaBZcBPTtaqQhaNgt7ziKMSvO
   8vDINbVMKQMX++NdDM5q1iI9h9GrklGAh4MsZKclcJivplUeEPTDJklq2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248118258"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="248118258"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 13:08:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="516705376"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2022 13:08:27 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, mchehab@kernel.org,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v2 12/15] dmaengine: Add provider documentation on cookie assignment
Date:   Tue,  3 May 2022 13:07:25 -0700
Message-Id: <20220503200728.2321188-13-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200728.2321188-1-benjamin.walker@intel.com>
References: <20220503200728.2321188-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Clarify the rules on assigning cookies to DMA transactions.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 .../driver-api/dmaengine/provider.rst         | 45 +++++++++++++++----
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index e9e9de18d6b02..7c8ace703c96f 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -421,7 +421,9 @@ supported.
 
     - tx_submit: A pointer to a function you have to implement,
       that is supposed to push the current transaction descriptor to a
-      pending queue, waiting for issue_pending to be called.
+      pending queue, waiting for issue_pending to be called. Each
+      descriptor is given a cookie to identify it. See the section
+      "Cookie Management" below.
 
   - In this structure the function pointer callback_result can be
     initialized in order for the submitter to be notified that a
@@ -526,6 +528,40 @@ supported.
 
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
@@ -541,13 +577,6 @@ where to put them)
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
2.35.1

