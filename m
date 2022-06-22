Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1075553CC
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 20:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377444AbiFVSzF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 14:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377702AbiFVSy3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 14:54:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE5640A0D;
        Wed, 22 Jun 2022 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655924055; x=1687460055;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OOQALfgmATaUv4VRkx7rlx6lJnuZeTGNaW9g/kaaH/U=;
  b=a5FHQ1QV/mRaVuHTw16Xj7O6BvX5aXDnEqB4vd924gkXqaT3H/t8FF9y
   DoAz8aFaqBxcI8f3lwZyMA84F3KbXYfu+zu4JGrvwhtMRN3adnLXmCjeR
   kJyENfMDeHSvvwrFxo5HKqeBrtsl5cousPLjb90MRFEdXvfOCL87mubC3
   MKDuKEOAU/r1D/M2/OVbx0P3OKMJYdhEYeSbiYCwjUs0gmr/OFYi6ACPg
   cEdgDW/BhqOJpOKoeodLIGGhel7k1gY3++aCy/4JxjcQbjTQZhzk11eju
   YY9cBuAiDFziSJKwJUA6U3cf6SrzqH6rnePz5P8BgZh0eLY5Gs37IyOx4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="260949351"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="260949351"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 11:54:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="588316308"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2022 11:54:14 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/15] dmaengine: Revert "cookie bypass for out of order completion"
Date:   Wed, 22 Jun 2022 11:54:11 -0700
Message-Id: <20220622185411.3043654-1-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
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

This reverts commit 47ec7f09bc107720905c96bc37771e4ed1ff0aed.

This is no longer necessary now that all assumptions about the order of
completions have been removed from the dmaengine client API.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 .../driver-api/dmaengine/provider.rst         | 19 -------------------
 drivers/dma/dmatest.c                         | 11 +----------
 drivers/dma/idxd/dma.c                        |  1 -
 include/linux/dmaengine.h                     |  2 --
 4 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index db019ec492b58..8565241270a62 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -268,22 +268,6 @@ Currently, the types available are:
     want to transfer a portion of uncompressed data directly to the
     display to print it
 
-- DMA_COMPLETION_NO_ORDER
-
-  - The device does not support in order completion.
-
-  - The driver should return DMA_OUT_OF_ORDER for device_tx_status if
-    the device is setting this capability.
-
-  - All cookie tracking and checking API should be treated as invalid if
-    the device exports this capability.
-
-  - At this point, this is incompatible with polling option for dmatest.
-
-  - If this cap is set, the user is recommended to provide an unique
-    identifier for each descriptor sent to the DMA device in order to
-    properly track the completion.
-
 - DMA_REPEAT
 
   - The device supports repeated transfers. A repeated transfer, indicated by
@@ -467,9 +451,6 @@ supported.
   - In the case of a cyclic transfer, it should only take into
     account the total size of the cyclic buffer.
 
-  - Should return DMA_OUT_OF_ORDER if the device does not support in order
-    completion and is completing the operation out of order.
-
   - This function can be called in an interrupt context.
 
 - device_config
diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 3ee47a72bf9d7..d34e7a9b63d89 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -845,10 +845,7 @@ static int dmatest_func(void *data)
 			result("test timed out", total_tests, src->off, dst->off,
 			       len, 0);
 			goto error_unmap_continue;
-		} else if (status != DMA_COMPLETE &&
-			   !(dma_has_cap(DMA_COMPLETION_NO_ORDER,
-					 dev->cap_mask) &&
-			     status == DMA_OUT_OF_ORDER)) {
+		} else if (status != DMA_COMPLETE) {
 			result(status == DMA_ERROR ?
 			       "completion error status" :
 			       "completion busy status", total_tests, src->off,
@@ -1027,12 +1024,6 @@ static int dmatest_add_channel(struct dmatest_info *info,
 	dtc->chan = chan;
 	INIT_LIST_HEAD(&dtc->threads);
 
-	if (dma_has_cap(DMA_COMPLETION_NO_ORDER, dma_dev->cap_mask) &&
-	    info->params.polled) {
-		info->params.polled = false;
-		pr_warn("DMA_COMPLETION_NO_ORDER, polled disabled\n");
-	}
-
 	if (dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask)) {
 		if (dmatest == 0) {
 			cnt = dmatest_add_threads(info, dtc, DMA_MEMCPY);
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index dda5342d273f4..49e863abd50cd 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -297,7 +297,6 @@ int idxd_register_dma_device(struct idxd_device *idxd)
 
 	dma_cap_set(DMA_INTERRUPT, dma->cap_mask);
 	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
-	dma_cap_set(DMA_COMPLETION_NO_ORDER, dma->cap_mask);
 	dma->device_release = idxd_dma_release;
 
 	dma->device_prep_dma_interrupt = idxd_dma_prep_interrupt;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index e3e5311b6bb64..136c7afbcc385 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -39,7 +39,6 @@ enum dma_status {
 	DMA_IN_PROGRESS,
 	DMA_PAUSED,
 	DMA_ERROR,
-	DMA_OUT_OF_ORDER,
 };
 
 /**
@@ -63,7 +62,6 @@ enum dma_transaction_type {
 	DMA_SLAVE,
 	DMA_CYCLIC,
 	DMA_INTERLEAVE,
-	DMA_COMPLETION_NO_ORDER,
 	DMA_REPEAT,
 	DMA_LOAD_EOT,
 /* last transaction type for creation of the capabilities mask */
-- 
2.35.1

