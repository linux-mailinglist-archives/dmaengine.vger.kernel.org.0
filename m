Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA1E4A662D
	for <lists+dmaengine@lfdr.de>; Tue,  1 Feb 2022 21:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbiBAUlk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Feb 2022 15:41:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:16572 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242053AbiBAUki (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 1 Feb 2022 15:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643748038; x=1675284038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ISPUwZWPjdBErobFerrKjLBHA71gNTXPHTRpPudr9sw=;
  b=l21xi7iqE3PBCGA9tOwMvrDbSRkpHN7XJnDznlCAFGC85tEA+oVXEzna
   ZlVELttJkf/xiqAyLj9qohnqWnYpPtY2PoBvpOPa2LXvFDyyrBLNXweIl
   mXAJ0HdwiFGcIIVPI7aVY1RyYbPxptDBWzd7MF+pJib4LAz8EZijE1hdK
   JpRptdhQKMYgwlLFxuQ6u4pxOngBmkxmEyLxop1BGCWHTXjFK8gkPYFK9
   14J5+GkY4nuA4GluI5mVzIJqto0aeOYEhI/+aseqeL2rlkh8u+pdzcFlq
   zqjQcqFPz5Ch34FqPfl6lS7tC8mgBf8WEtiQMsdiS6TjNQwXwUUwhkfVK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="334143894"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="334143894"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 12:39:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="479820802"
Received: from bwalker-desk.ch.intel.com ([143.182.137.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Feb 2022 12:39:12 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [RESEND 07/10] dmaengine: Add provider documentation on cookie assignment
Date:   Tue,  1 Feb 2022 13:38:10 -0700
Message-Id: <20220201203813.3951461-8-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220201203813.3951461-1-benjamin.walker@intel.com>
References: <20220201203813.3951461-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.33.1

