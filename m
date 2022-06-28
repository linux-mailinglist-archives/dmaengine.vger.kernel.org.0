Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D08155F1B7
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jun 2022 01:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiF1XBH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jun 2022 19:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiF1XBH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jun 2022 19:01:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E43E377EF;
        Tue, 28 Jun 2022 16:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656457265; x=1687993265;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YbIMgifgTky3rQPY8xXXhQKS50D+F5p42BBTLZSxVLU=;
  b=A0zzDB+Kvw+vfylBQEjWJ+Hn+HijO7KsfMSHcnegC2eP2gtWv6UoINQt
   8Hu+xo9FHBhZ2fSKjSDM0+/w938V8TB/vnoAr3RNB8BcUCx2JBKrvAD2K
   CnFFChK3GLX1+GUXztVoZ7ZexcSpfaTK39E0TCJUxX07TX5FyRke5oFs5
   g7t3ixXdm9yapSjpJIjKaIHyca1JDeyw3EB00wdlJgySDTWcHJTeqGIZf
   VYzioLJ0vJEKSu/KxyC7WlzM8YuDb1jVeCpiMoOmCy0kxC0p3pVvbNSfu
   znOvaGhC/TAz8rHPOBow6ssZy/WoMQ0zJtZxgKIa04C0EVIXRlDkKmW9S
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="343559113"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="343559113"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 16:01:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="693313974"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jun 2022 16:01:04 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Tony Zhu" <tony.zhu@intel.com>, dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3] dmaengine: idxd: force wq context cleanup on device disable path
Date:   Tue, 28 Jun 2022 16:00:56 -0700
Message-Id: <20220628230056.2527816-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

Testing shown that when a wq mode is setup to be dedicated and then torn
down and reconfigured to shared, the wq configured end up being dedicated
anyays. The root cause is when idxd_device_wqs_clear_state() gets called
during idxd_driver removal, idxd_wq_disable_cleanup() does not get called
vs when the wq driver is removed first. The check of wq state being
"enabled" causes the cleanup to be bypassed. However, idxd_driver->remove()
releases all wq drivers. So the wqs goes to "disabled" state and will never
be "enabled". By that point, the driver has no idea if the wq was
previously configured or clean. So force call idxd_wq_disable_cleanup() on
all wqs always to make sure everything gets cleaned up.

Reported-by: Tony Zhu <tony.zhu@intel.com>
Tested-by: Tony Zhu <tony.zhu@intel.com>
Fixes: 0dcfe41e9a4c ("dmanegine: idxd: cleanup all device related bits after disabling device")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
Change Log:
v3:
- Add Co-developed-by: and Signed-off-by: Fenghua Yu

v2:
- Re-based to 5.19-rc2 so that it can be applied cleanly. No functionality
  change.

v1:
https://patchwork.kernel.org/project/linux-dmaengine/patch/165090959239.1376825.18183942742142655091.stgit@djiang5-desk3.ch.intel.com/

 drivers/dma/idxd/device.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index ff0ea60051f0..5a8cc52c1abf 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -716,10 +716,7 @@ static void idxd_device_wqs_clear_state(struct idxd_device *idxd)
 		struct idxd_wq *wq = idxd->wqs[i];
 
 		mutex_lock(&wq->wq_lock);
-		if (wq->state == IDXD_WQ_ENABLED) {
-			idxd_wq_disable_cleanup(wq);
-			wq->state = IDXD_WQ_DISABLED;
-		}
+		idxd_wq_disable_cleanup(wq);
 		idxd_wq_device_reset_cleanup(wq);
 		mutex_unlock(&wq->wq_lock);
 	}
-- 
2.32.0

