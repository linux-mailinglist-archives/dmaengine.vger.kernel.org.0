Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2878F751148
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jul 2023 21:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjGLTey (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 15:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjGLTew (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 15:34:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0321FC3;
        Wed, 12 Jul 2023 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689190492; x=1720726492;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LI93rXYaddJNOOadSd3NS7WZJhub/0fU7emp27bnnyU=;
  b=enYGmwEyk4b5oHbI2+FEx4wEUqJOiXi3lo/PAtpiz+9vNcsRmMg1ugsb
   NicuDjsMES8ArKNsLIhfObFxOgXkbCN5a/UhM2kFaceh8WKMgN1zo1UMh
   38PGrKsYgEJixySICBHyS7IGVhT+lOmrvNpoA2YWyKkcKpaAWByStQV8g
   B2jaK39bTA5Yd0za+6Rtq0C1a7yetyhPOsVte4/ALmTmmnXpxjoz4VbIM
   2MH8LRMk9/Kb1mOjdDEfOB27UdNtTKxuDkNPhk9+Ca8VrIjOOgvD8bD0T
   5DWViG0LLYI7R8JEKBANcgtbGOoDrC5mAH/0W1LNq1bgKyEqr26qmCQb5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428729178"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="428729178"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 12:34:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="791740274"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="791740274"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2023 12:34:50 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Zhu <tony.zhu@intel.com>
Subject: [PATCH v3] dmaengine: idxd: Clear PRS disable flag when disabling IDXD device
Date:   Wed, 12 Jul 2023 12:35:05 -0700
Message-Id: <20230712193505.3440752-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Disabling IDXD device doesn't reset Page Request Service (PRS)
disable flag to its initial value 0. This may cause user confusion
because once PRS is disabled user will see PRS still remains the
previous setting (i.e. disabled) via sysfs interface even after the
device is disabled.

To eliminate user confusion, reset PRS disable flag to ensure that
the PRS flag bit reflects correct state after the device is disabled.

Additionally, simplify the code by setting wq->flags to 0, which clears
all flag bits, including any future additions.

Fixes: f2dc327131b5 ("dmaengine: idxd: add per wq PRS disable")
Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
v3:
- Add "Fixes" tag.
- Set wq->flags to 0.

v2:
- Fix Tony's email typo

 drivers/dma/idxd/device.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5abbcc61c528..9a15f0d12c79 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -384,9 +384,7 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	wq->threshold = 0;
 	wq->priority = 0;
 	wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
-	clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
-	clear_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags);
-	clear_bit(WQ_FLAG_ATS_DISABLE, &wq->flags);
+	wq->flags = 0;
 	memset(wq->name, 0, WQ_NAME_SIZE);
 	wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
 	idxd_wq_set_max_batch_size(idxd->data->type, wq, WQ_DEFAULT_MAX_BATCH);
-- 
2.37.1

