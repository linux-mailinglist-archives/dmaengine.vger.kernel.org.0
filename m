Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6E37AC5FF
	for <lists+dmaengine@lfdr.de>; Sun, 24 Sep 2023 02:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjIXAYD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 23 Sep 2023 20:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXAYD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 23 Sep 2023 20:24:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8219E136;
        Sat, 23 Sep 2023 17:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695515037; x=1727051037;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e+IP2YTTfPQNfC51BuRVQ3FS282THHINwCwNMeWcoVM=;
  b=Wts1pFYFwC2R/EcT0g9M9QnLRBVrY8HOEuU7vb6Xr++0RH6PDDGiWjs7
   bebC8YAJWTioUujvp1YgI42TD7pKsKkMwoZGPT93J+hJCmdsSDdbaWihC
   iIQ7CQfgTSQd5vSPpWn+FfTdne+qmPQ7zsF+w85PXJkLvvzj/f6QggUQj
   rKUe98SC96gCG/D2ux7g9pzRajlyJdp9YQJFnfIFPzal6fuSvfLl02nnb
   6heh9ckcVMGesW/ZoOmr7Kq/4czJYLXjaiVawfYVouKhavBgvb0AcEjJX
   kWCHtGUfzfJY5sVoln/gxwRHsVKHmDwcSIhaQcn2ZOcyRFmh0bSYJcYg+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="378338267"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="378338267"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 17:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="1078798374"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="1078798374"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga005.fm.intel.com with ESMTP; 23 Sep 2023 17:23:56 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] dmaengine: idxd: rate limit printk in misc interrupt thread
Date:   Sat, 23 Sep 2023 17:23:47 -0700
Message-Id: <20230924002347.1117757-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

Add rate limit to the dev_warn() call in the misc interrupt thread. This
limits dmesg getting spammed if a descriptor submitter is spamming bad
descriptors with invalid completion records and resulting the errors being
continuously reported by the misc interrupt handling thread.

Reported-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
---

This patch was sent to dmaengine mailing list before:
https://lore.kernel.org/all/165125377735.312075.15715853788802098990.stgit@djiang5-desk3.ch.intel.com/
But it hasn't be merged into upstream yet. Add my Reviewed-by tag
and re-send it. No code or commit message change.

 drivers/dma/idxd/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 041be6a4dec4..8e895a1e1881 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -430,8 +430,8 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 		val |= IDXD_INTC_ERR;
 
 		for (i = 0; i < 4; i++)
-			dev_warn(dev, "err[%d]: %#16.16llx\n",
-				 i, idxd->sw_err.bits[i]);
+			dev_warn_ratelimited(dev, "err[%d]: %#16.16llx\n",
+					     i, idxd->sw_err.bits[i]);
 		err = true;
 	}
 
-- 
2.32.0

