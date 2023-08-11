Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709D47784E3
	for <lists+dmaengine@lfdr.de>; Fri, 11 Aug 2023 03:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjHKB0u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Aug 2023 21:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjHKB0t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Aug 2023 21:26:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7412D58;
        Thu, 10 Aug 2023 18:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691717209; x=1723253209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CfqmXM4kRd4y1ZmEZGFxskOY7Nb1GwQfuLJ1S4oyD7w=;
  b=TwDPjNVbaOP7dJBgklf2JW+S1dCOoTTGdyrAxMPVf2SGYtjYk1bNg28W
   RbziWVnKO00/OGvesuB2YQhB5xqRGkdI5D3N+1SoNFQv7FIotln0HdJPY
   V1cBlESSM0YfRAUJBYdAzUlBJaxpkZCcgWWNdOnBnjFXiYeMIqyCFUv5V
   d+zpWQH8YvXphaYQyycmQTph7bpANhnuodAAOy00JKHDSnrztyKg8RKBk
   Nk3uQ4Sl0XPtVKqiVQv6tAdYWvm1GNSCpw5IMdxipKKKzs2wnj9HDCmR7
   Qa89n5CE1kLjF3WOXq0Jdl0E1SlAnax9QGfD6PL5QkfGva+S2U7oSdJoF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351884243"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="351884243"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 18:26:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="726060723"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="726060723"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2023 18:26:45 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 2/2] dmaengine: idxd: Fix issues with PRS disable sysfs knob
Date:   Thu, 10 Aug 2023 18:26:35 -0700
Message-Id: <20230811012635.535413-2-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230811012635.535413-1-fenghua.yu@intel.com>
References: <20230811012635.535413-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There are two issues in the current PRS disable sysfs store function
wq_prs_disable_store():

1. Since PRS disable knob is invisible if PRS disable is not supported
   in WQ, it's redundant to check PRS support again in the store function
   again. Remove the redundant PRS support check.
2. Since PRS disable is read-only when the device is not configurable,
   PRS disable cannot be changed on the device. Add device configurable
   check in the store function.

Fixes: f2dc327131b5 ("dmaengine: idxd: add per wq PRS disable")
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
Applied cleanly to
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine next

 drivers/dma/idxd/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 66c89b07b3f7..a5c3eb434832 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1131,8 +1131,8 @@ static ssize_t wq_prs_disable_store(struct device *dev, struct device_attribute
 	if (wq->state != IDXD_WQ_DISABLED)
 		return -EPERM;
 
-	if (!idxd->hw.wq_cap.wq_prs_support)
-		return -EOPNOTSUPP;
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		return -EPERM;
 
 	rc = kstrtobool(buf, &prs_dis);
 	if (rc < 0)
-- 
2.37.1

