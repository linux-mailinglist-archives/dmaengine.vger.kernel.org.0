Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308086487A7
	for <lists+dmaengine@lfdr.de>; Fri,  9 Dec 2022 18:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiLIRWC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Dec 2022 12:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiLIRVt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Dec 2022 12:21:49 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80DB2EA;
        Fri,  9 Dec 2022 09:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670606508; x=1702142508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qqpnrAny325mADylQgRrfNnHCsliT2KiaF1ZSIOdJqY=;
  b=cHAmMD0kcojb8uzCwxe82IZVsol5xNPjlqy6Gm3pvQg2W4YGELV5heQ3
   r11Z2NeyJLdkINorcC+WdZH58csp6GfmVEr6Ffimow8upFQyYaoXN7EEc
   nl9/+5gVzJ7Mh7XvHPglVRd3hStIUs/s5RXyuUNnkjamJHizqVDNJOEU3
   L0BAUeRqNO/4SBugKGowrbmP+d+VnQ8RItnes8KeTCWMPtVOXR23ERXzT
   fjZ1hHVt8cgllscePJjfAst8ODZWtU9wUpDh75tWE+XIZti7DuocmOfAQ
   ssneyrl+X5P7+mPzgVLF9BxuEIJ3cr5K2H0KxB66+a3LQENLNFPa7o/Qk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="379719514"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="379719514"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 09:21:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="678213784"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="678213784"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga008.jf.intel.com with ESMTP; 09 Dec 2022 09:21:44 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] dmaengine: idxd: Set traffic class values in GRPCFG on DSA 2.0
Date:   Fri,  9 Dec 2022 09:21:41 -0800
Message-Id: <20221209172141.562648-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
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

On DSA/IAX 1.0, TC-A and TC-B in GRPCFG are set as 1 to have best
performance and cannot be changed through sysfs knobs unless override
option is given.

The same values should be set on DSA 2.0 as well.

Fixes: ea7c8f598c32 ("dmaengine: idxd: restore traffic class defaults after wq reset")
Fixes: ade8a86b512c ("dmaengine: idxd: Set defaults for GRPCFG traffic class")
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c | 2 +-
 drivers/dma/idxd/init.c   | 2 +-
 drivers/dma/idxd/sysfs.c  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index b55405efd4ab..901257081524 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -834,7 +834,7 @@ static void idxd_groups_clear_state(struct idxd_device *idxd)
 		group->use_rdbuf_limit = false;
 		group->rdbufs_allowed = 0;
 		group->rdbufs_reserved = 0;
-		if (idxd->hw.version < DEVICE_VERSION_2 && !tc_override) {
+		if (idxd->hw.version <= DEVICE_VERSION_2 && !tc_override) {
 			group->tc_a = 1;
 			group->tc_b = 1;
 		} else {
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 1053e2bb4e9f..4ecd34200998 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -314,7 +314,7 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 		}
 
 		idxd->groups[i] = group;
-		if (idxd->hw.version < DEVICE_VERSION_2 && !tc_override) {
+		if (idxd->hw.version <= DEVICE_VERSION_2 && !tc_override) {
 			group->tc_a = 1;
 			group->tc_b = 1;
 		} else {
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 632166538458..9db35011037f 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -388,7 +388,7 @@ static ssize_t group_traffic_class_a_store(struct device *dev,
 	if (idxd->state == IDXD_DEV_ENABLED)
 		return -EPERM;
 
-	if (idxd->hw.version < DEVICE_VERSION_2 && !tc_override)
+	if (idxd->hw.version <= DEVICE_VERSION_2 && !tc_override)
 		return -EPERM;
 
 	if (val < 0 || val > 7)
@@ -430,7 +430,7 @@ static ssize_t group_traffic_class_b_store(struct device *dev,
 	if (idxd->state == IDXD_DEV_ENABLED)
 		return -EPERM;
 
-	if (idxd->hw.version < DEVICE_VERSION_2 && !tc_override)
+	if (idxd->hw.version <= DEVICE_VERSION_2 && !tc_override)
 		return -EPERM;
 
 	if (val < 0 || val > 7)
-- 
2.32.0

