Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCEF5553B6
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 20:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377725AbiFVSyo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 14:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377736AbiFVSyQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 14:54:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64AF4092B;
        Wed, 22 Jun 2022 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655924047; x=1687460047;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0WsFvoGYgiGnVS8P+Hg1gGwngMRIqqhXjP5myyi7RDo=;
  b=E/QhVCtSiWRwksrumdYUvUMkMlxAjWtSEKVVVjipaAgyfojmLmkCvWP6
   emOxNCb3NL9FB/yER9Z6Mezb+GCk5Cpd8k0PABV0f45FNJ86aaeTHXLwU
   hiIHVAWnUErud89fLa7lLZ2D9AL1s3tujhOPnfiagiKjqz3JGVU3uACGR
   mR2fselybitnr0CofY4iF94lKIkam1kUATuLYB688GqRWNg7Mp6R2F53l
   fSsfBU7erlGqzhJtWkc5SJWU8txfL9zdhZ7FtgODcqQgEoJpqcsNGJMtO
   oTGUmGAY6UNOjhjvO/nwDyP89/TprUr28GA9daeO/hDtXdhuAQyy89hmP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="305971702"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="305971702"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 11:54:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="730495502"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jun 2022 11:54:06 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/15] dmaengine: Add provider documentation on cookie assignment
Date:   Wed, 22 Jun 2022 11:54:02 -0700
Message-Id: <20220622185402.3043630-1-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
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

Clarify the rules on assigning cookies to DMA transactions.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 .../driver-api/dmaengine/provider.rst         | 45 +++++++++++++++----
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 610309276bc9c..db019ec492b58 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -427,7 +427,9 @@ supported.
 
     - tx_submit: A pointer to a function you have to implement,
       that is supposed to push the current transaction descriptor to a
-      pending queue, waiting for issue_pending to be called.
+      pending queue, waiting for issue_pending to be called. Each
+      descriptor is given a cookie to identify it. See the section
+      "Cookie Management" below.
 
   - In this structure the function pointer callback_result can be
     initialized in order for the submitter to be notified that a
@@ -532,6 +534,40 @@ supported.
 
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
@@ -547,13 +583,6 @@ where to put them)
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

