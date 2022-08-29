Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173E25A55B0
	for <lists+dmaengine@lfdr.de>; Mon, 29 Aug 2022 22:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiH2Ugt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Aug 2022 16:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiH2Ugk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Aug 2022 16:36:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B87C8C02B;
        Mon, 29 Aug 2022 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661805388; x=1693341388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jycDPCjkbeirrCGksiw9H7cDx+q6rA7Kgq23B7N3h/I=;
  b=dX7LkYRgVz8+Y93SArV+e/v+eBxTrCBrAJcOBJInC0mmJpDGcKVSH7XJ
   BSFNwiw2YOtOhR51N6DUj8uTrKmR7mUgB6rrr+9WFVrcIyaYwvB4m6sWq
   luvIReUwEX6Jngg7msi/cA7IZndTSZXICLQIyYjQ9aWOLv+yIyBepiICA
   zIQZpS8ffBLRigY2WIFO1A6roTIaKxrPQLXFEA7XWexBbnEfQOMp5o/+g
   2TB6A9900jZtrCC0i6qlxL44/gWvv2CtBJYJPmsZ5dx/rqMpZjgU3z+C5
   kNA/Yd7v3aTqoOMbYK0NUKHQ4PahVp7Xif+sBqflp1qfGGBIUZd4Kyovb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="381292062"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="381292062"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 13:36:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="614344387"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2022 13:36:26 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/7] dmaengine: Revert "cookie bypass for out of order completion"
Date:   Mon, 29 Aug 2022 13:35:37 -0700
Message-Id: <20220829203537.30676-8-benjamin.walker@intel.com>
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
index a5539f816d125..8d1510c8cb66f 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -258,22 +258,6 @@ Currently, the types available are:
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
@@ -457,9 +441,6 @@ supported.
   - In the case of a cyclic transfer, it should only take into
     account the total size of the cyclic buffer.
 
-  - Should return DMA_OUT_OF_ORDER if the device does not support in order
-    completion and is completing the operation out of order.
-
   - This function can be called in an interrupt context.
 
 - device_config
diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index dde7b9b626336..47db4748d3e51 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -838,10 +838,7 @@ static int dmatest_func(void *data)
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
@@ -1019,12 +1016,6 @@ static int dmatest_add_channel(struct dmatest_info *info,
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
index 0ee21887b3924..abaf24d953849 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -39,7 +39,6 @@ enum dma_status {
 	DMA_IN_PROGRESS,
 	DMA_PAUSED,
 	DMA_ERROR,
-	DMA_OUT_OF_ORDER,
 };
 
 /**
@@ -62,7 +61,6 @@ enum dma_transaction_type {
 	DMA_SLAVE,
 	DMA_CYCLIC,
 	DMA_INTERLEAVE,
-	DMA_COMPLETION_NO_ORDER,
 	DMA_REPEAT,
 	DMA_LOAD_EOT,
 /* last transaction type for creation of the capabilities mask */
-- 
2.37.1

