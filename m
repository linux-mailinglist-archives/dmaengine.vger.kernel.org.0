Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66ABB4F4F83
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 04:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbiDFAwY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Apr 2022 20:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579953AbiDEXd1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Apr 2022 19:33:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D670C1081B6
        for <dmaengine@vger.kernel.org>; Tue,  5 Apr 2022 14:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649195619; x=1680731619;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SN7XYbG7HQgv/a75FIgQW3YvGavpk4iSVd80uDvCrGo=;
  b=gq8n1YF4UVBqNoJpqB7wq8XcqaTewV9pJ+ymFXCKcmNkXChpe6ewtEhP
   pN/nM35CAeGvUQaVunh2feGGjFHeq/1RJifmF8Ngfn5tsDxsvjD1Chf0x
   56ZFprgxnTFSaDDzEBGu3sg/mCvH1Q7AAyO9D65JiXLp7uthOJpHgjhK2
   0sXCb22vFxn68WRrkOoRbh6v4/wNTmFIOqDI3X8jMJnXVhg/7dPDpPoyg
   HTfap/ttrbmq3YgDiSm1OnNuf9E8i1nQVYTf60j3nV1q55ks83N4sCPMt
   Zl9dSr+1edHe13ayi2lJiqcqlv1bF/6tB90rssUcf6+LMDvAxzzPvZjTr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="243012466"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="243012466"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 14:53:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="524177026"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 14:53:39 -0700
Subject: [PATCH] dmaengine: idxd: fix device cleanup on disable
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Tony Zhu <tony.zhu@intel.com>, Tony Zhu <tony.zhu@intel.com>,
        dmaengine@vger.kernel.org
Date:   Tue, 05 Apr 2022 14:53:39 -0700
Message-ID: <164919561905.1455025.13542366389944678346.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There are certain parts of WQ that needs to be cleaned up even after WQ is
disabled during the device disable. Those are the unchangeable parts for a
WQ when the device is still enabled. Move the cleanup outside of WQ state
check. Remove idxd_wq_disable_cleanup() inside idxd_wq_device_reset_cleanup()
since only the unchangeable parts need to be cleared.

Fixes: 0f225705cf65 ("dmaengine: idxd: fix wq settings post wq disable")
Reported-by: Tony Zhu <tony.zhu@intel.com>
Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 3061fe857d69..5a0535a0f850 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -373,7 +373,6 @@ static void idxd_wq_device_reset_cleanup(struct idxd_wq *wq)
 {
 	lockdep_assert_held(&wq->wq_lock);
 
-	idxd_wq_disable_cleanup(wq);
 	wq->size = 0;
 	wq->group = NULL;
 }
@@ -701,9 +700,9 @@ static void idxd_device_wqs_clear_state(struct idxd_device *idxd)
 
 		if (wq->state == IDXD_WQ_ENABLED) {
 			idxd_wq_disable_cleanup(wq);
-			idxd_wq_device_reset_cleanup(wq);
 			wq->state = IDXD_WQ_DISABLED;
 		}
+		idxd_wq_device_reset_cleanup(wq);
 	}
 }
 


