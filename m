Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EEB54D570
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 01:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241580AbiFOXl5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jun 2022 19:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiFOXl4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jun 2022 19:41:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2EE3632E
        for <dmaengine@vger.kernel.org>; Wed, 15 Jun 2022 16:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655336515; x=1686872515;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W4Jvv8jec5QfeykLHRTOnuYoNQ1wOjtYIHEIkIB1tYc=;
  b=Xqv5CP5YU7quM3ekLQ+6Y7Yk3SdZGKpk4yBg4Qiw45X4s4hXiFPJzJK7
   +E7nUsua9C3rCrTDSmJ5YPoR58JjyjbXYbqSUTDyjxZJ19w12naS9h3qu
   zJlZVO5Qqwgriq+NJTT9hj0WYPs2XDBIQHjT5l07ITisGF2OXogSKpaox
   aCt1GieH50jEVSK5NAQ6sfYl6aXSh3aqAdx0UEv8KrNLFyUQQCjnuXDbE
   ABVCtaqqxk/tk/ks+UbL/xaU9CgXiMz4DVk8SQV1RuRQvrKAKhm0tLdGR
   574gvQKTrrlGX7Rgpe4KRXhHPW7dRz/lLVUMeiPRknO8/EBNKzYdyWXsh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="259588492"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="259588492"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 16:41:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="911912263"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jun 2022 16:41:55 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>
Cc:     "Dave Jiang" <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Tony Zhu <tony.zhu@intel.com>
Subject: [PATCH v2] dmaengine: idxd: force wq context cleanup on device disable path
Date:   Wed, 15 Jun 2022 16:42:19 -0700
Message-Id: <20220615234219.178186-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
Change Log:
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

