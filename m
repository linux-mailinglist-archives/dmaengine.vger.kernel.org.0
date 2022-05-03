Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B086A518E05
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 22:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbiECUM1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 16:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242219AbiECUMV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 16:12:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1FB40E41
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 13:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651608518; x=1683144518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=svOEFZ0iM4zTNd+iiLiugoQxXLlbWcFdAikX4WDfSss=;
  b=lI1iR5K8YKEsVn64B1+U4C0UKXVLJyE9OplX2gdt3u0JxNZ69P/0quks
   Nj23O0YlevBZ7nJCS6JRoXcFSNiuojKOkpOvTkfgc6wqSh8INwkf8ufOj
   JMHYjZpb/P7mEpX+DXQOtIhy6v1OWVEJ3lmXK+6MixzJjpFxWaDERtVf+
   p7/HVChjqTWP7PAlUZqF6Syjg9Sh9P/ya9RFhEIAS/67uMBdB3pvjsdnQ
   xuR6ewRJFYUIxpvPLG5lWnXbAoGdBO/g6TQtgyWR5H8AfLwl2v9OV8Qez
   MWEmiOePMKQu8fXR2V8/TMoQEyyaCr7g8qydDPFv1eLfmaMlx2JkFF9Ly
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248118284"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="248118284"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 13:08:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="516705424"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2022 13:08:38 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, mchehab@kernel.org,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v2 15/15] dmaengine: Revert "cookie bypass for out of order completion"
Date:   Tue,  3 May 2022 13:07:28 -0700
Message-Id: <20220503200728.2321188-16-benjamin.walker@intel.com>
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
index 7c8ace703c96f..5bb4738ece0c2 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -262,22 +262,6 @@ Currently, the types available are:
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
@@ -461,9 +445,6 @@ supported.
   - In the case of a cyclic transfer, it should only take into
     account the current period.
 
-  - Should return DMA_OUT_OF_ORDER if the device does not support in order
-    completion and is completing the operation out of order.
-
   - This function can be called in an interrupt context.
 
 - device_config
diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index aa36359883242..e78b315d31f83 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -839,10 +839,7 @@ static int dmatest_func(void *data)
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
@@ -1020,12 +1017,6 @@ static int dmatest_add_channel(struct dmatest_info *info,
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
index 7bb9ecad43ec5..4d35597cf5315 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -289,7 +289,6 @@ int idxd_register_dma_device(struct idxd_device *idxd)
 	dma->dev = dev;
 
 	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
-	dma_cap_set(DMA_COMPLETION_NO_ORDER, dma->cap_mask);
 	dma->device_release = idxd_dma_release;
 
 	if (idxd->hw.opcap.bits[0] & IDXD_OPCAP_MEMMOVE) {
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 827007146eb94..ba568d0373dec 100644
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

