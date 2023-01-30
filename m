Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42A16814A7
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jan 2023 16:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbjA3PS7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Jan 2023 10:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238127AbjA3PSq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Jan 2023 10:18:46 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619193D92C;
        Mon, 30 Jan 2023 07:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675091899; x=1706627899;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=92LbvsRwBB+FsQXF+k+MJ2NaG025JyCEXU4mtLMGezM=;
  b=In+dspDEH5iRsY8r8V8JDntwbrpVenyxNDBSydO2WPOGu8RPgYTVxRLm
   6vCYin9z6rynMkf00SiQ6eXnf7pJqIgOpZbnlc+C6p1lV+fmlZyKGGelE
   G8K1nBj+Y2JPyZThzyo0Xd0LtDX53hsG1NxPBstbWfZeSNHNmkoLgBipj
   98ztUZPsIM+wQ67ykMgninBPZS9AmSKI7B4yS1+4xOwfsZmCCFx3nxFUv
   YhVbgkgAN2Pr6vUwTMR8jQC9Snx9x4Cx/WpzjDVe9wiON17ALoIu4wjIB
   QtCfzSVBzvv/kz9sdhMisv27FxQEgjS200NGqKv8O+TJsPFtNwK1wJ8Yn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="307233097"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="307233097"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 07:17:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="837994822"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="837994822"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 30 Jan 2023 07:17:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2DECF152; Mon, 30 Jan 2023 17:17:50 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 1/1] dmaengine: dw: Move check for paused channel to dwc_get_residue()
Date:   Mon, 30 Jan 2023 17:17:47 +0200
Message-Id: <20230130151747.20704-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move check for paused channel to dwc_get_residue() and rename the latter
to dwc_get_residue_and_status().

This improves data integrity as residue and DMA channel status are set
in the same function under the same conditions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 97ba3bfc10b1..5f7d690e3dba 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -889,7 +889,8 @@ static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 	return NULL;
 }
 
-static u32 dwc_get_residue(struct dw_dma_chan *dwc, dma_cookie_t cookie)
+static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cookie,
+				      enum dma_status *status)
 {
 	struct dw_desc *desc;
 	unsigned long flags;
@@ -903,6 +904,8 @@ static u32 dwc_get_residue(struct dw_dma_chan *dwc, dma_cookie_t cookie)
 			residue = desc->residue;
 			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags) && residue)
 				residue -= dwc_get_sent(dwc);
+			if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
+				*status = DMA_PAUSED;
 		} else {
 			residue = desc->total_len;
 		}
@@ -932,11 +935,7 @@ dwc_tx_status(struct dma_chan *chan,
 	if (ret == DMA_COMPLETE)
 		return ret;
 
-	dma_set_residue(txstate, dwc_get_residue(dwc, cookie));
-
-	if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags) && ret == DMA_IN_PROGRESS)
-		return DMA_PAUSED;
-
+	dma_set_residue(txstate, dwc_get_residue_and_status(dwc, cookie, &ret));
 	return ret;
 }
 
-- 
2.39.0

