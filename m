Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AA95F034D
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 05:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiI3D2y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 23:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiI3D2h (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 23:28:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1A015935C
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 20:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664508516; x=1696044516;
  h=from:to:cc:subject:date:message-id;
  bh=4RyAsolEIbR1o8oMUe/70E8iOQr4Kf0XTNvRkl8rap8=;
  b=Xc4Zl7xsQrsnW4UWjqaiypUElpyWdYBoTq9ny+zs3R5SFfzYe30L7sKn
   UdTzWZ6hs4XKtVSJNETpInaAqBdTJ87oKoo4q2ivSXBh1LbrDwT+NxNU0
   eDUvpbQq3+kpRtPzXLmJMGK9B2AYHZhMip7/0UFMdsIJghJiKWTLzBbIb
   bnPhGmP3ai0MYUGuBQOFCdN801AAJcLc7MoN/I7RYhY4iXJ6RqL96SGq/
   dfdtSi6uGuFndqKK3dF189cv+eODrCVX5NQ6JX5AVO6TEI0X1hRE1xmYb
   dvDWOqVciv/EJ6Kk/1xt+mvPDD5eWZ2XgAMiEjHE6hx3erIkCtMyoYwSe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285229525"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="285229525"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 20:28:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="653382804"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="653382804"
Received: from fgao-dev-hp-compaq-elite-8300-cmt.sh.intel.com ([10.239.131.213])
  by orsmga008.jf.intel.com with ESMTP; 29 Sep 2022 20:28:34 -0700
From:   Fengqian Gao <fengqian.gao@intel.com>
To:     vkoul@kernel.org, fenghua.yu@intel.com, dave.jiang@intel.com,
        dmaengine@vger.kernel.org
Cc:     pei.p.jia@intel.com, xiaochen.shen@intel.com,
        fengqian.gao@intel.com
Subject: [PATCH] dmaengine: idxd: fix RO device state error after been disabled/reset
Date:   Fri, 30 Sep 2022 11:28:35 +0800
Message-Id: <20220930032835.2290-1-fengqian.gao@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When IDXD is not configurable, that means its WQ, engine, and group
configurations cannot be changed. But it can be disabled and its state
should be set as disabled regardless it's configurable or not.

Fix this by setting device state IDXD_DEV_DISABLED for read-only device
as well in idxd_device_clear_state().

Fixes: cf4ac3fef338 ("dmaengine: idxd: fix lockdep warning on device driver removal")
Signed-off-by: Fengqian Gao <fengqian.gao@intel.com>
Reviewed-by: Xiaochen Shen <xiaochen.shen@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/device.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5a8cc52c1abf..bdd67728e507 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -724,13 +724,21 @@ static void idxd_device_wqs_clear_state(struct idxd_device *idxd)
 
 void idxd_device_clear_state(struct idxd_device *idxd)
 {
-	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
-		return;
+	/* IDXD is always disabled. Other states are cleared only when IDXD is configurable. */
+	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
+		/*
+		 * Clearing wq state is protected by wq lock.
+		 * So no need to be protected by device lock.
+		 */
+		idxd_device_wqs_clear_state(idxd);
+
+		spin_lock(&idxd->dev_lock);
+		idxd_groups_clear_state(idxd);
+		idxd_engines_clear_state(idxd);
+	} else {
+		spin_lock(&idxd->dev_lock);
+	}
 
-	idxd_device_wqs_clear_state(idxd);
-	spin_lock(&idxd->dev_lock);
-	idxd_groups_clear_state(idxd);
-	idxd_engines_clear_state(idxd);
 	idxd->state = IDXD_DEV_DISABLED;
 	spin_unlock(&idxd->dev_lock);
 }
-- 
2.17.1

