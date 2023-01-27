Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB23F67EE28
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jan 2023 20:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjA0T3c (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Jan 2023 14:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjA0T3Z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Jan 2023 14:29:25 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB9C6D5E0;
        Fri, 27 Jan 2023 11:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674847761; x=1706383761;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zon/6+Tnyyx6Alfmpf8RH++FBpnIXSclhVfwwyk9hRk=;
  b=dL3JLaUxFjsF1VeNUj7Xlt7YRJKQiucDTomp2uOc5i0dD7avt0BUsdxC
   2f7qCp4pyvW2lNXOefgARcQIzFDILDvlPho7DdR2BZzvF+R+zZiUuPXY/
   rgUENQ0SGQuqpgQi5ci+G7Ve6n+vBYWyxhErw+8GfjToAGyvqOdB4ngoI
   S3SKSFMBauItBzab+78TdUy9VFOKiMpH2urJ1O/eaKA/bLv92GHt05tpH
   xYwsUvEkVq6zby+SNDXVc25XqaCcbDMTiKKXn3t7E5iLkynQ6dK309rhn
   bg5jYdJOe5TomHJXP2azZYlGJOdl+hn5Rpcq1KiDhEeOsRm9zdM+BldDy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="389547556"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="389547556"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 11:29:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="992178911"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="992178911"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jan 2023 11:29:21 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Nikhil Rao <nikhil.rao@intel.com>
Subject: [PATCH] dmaengine: idxd: Fix default allowed read buffers value in group
Date:   Fri, 27 Jan 2023 11:28:55 -0800
Message-Id: <20230127192855.966929-1-fenghua.yu@intel.com>
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

Currently default read buffers that is allowed in a group is 0.
grpcfg will be configured to max read buffers that IDXD can support if
the group's allowed read buffers value is 0. But 0 is an invalid
read buffers value and user may get confused when seeing the invalid
initial value 0 through sysfs interface.

To show only valid allowed read buffers value and eliminate confusion,
directly initialize the allowed read buffers to IDXD's max read buffers.
User still can change the value through sysfs interface.

Suggested-by: Ramesh Thomas <ramesh.thomas@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Nikhil Rao <nikhil.rao@intel.com>
---
 drivers/dma/idxd/device.c | 12 ++++++------
 drivers/dma/idxd/init.c   |  5 +++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 29dbb0f52e18..8d0e3aab2ad2 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -699,7 +699,11 @@ static void idxd_groups_clear_state(struct idxd_device *idxd)
 		group->num_engines = 0;
 		group->num_wqs = 0;
 		group->use_rdbuf_limit = false;
-		group->rdbufs_allowed = 0;
+		/*
+		 * The default value is the same as the value of
+		 * total read buffers in GRPCAP.
+		 */
+		group->rdbufs_allowed = idxd->max_rdbufs;
 		group->rdbufs_reserved = 0;
 		if (idxd->hw.version < DEVICE_VERSION_2 && !tc_override) {
 			group->tc_a = 1;
@@ -934,11 +938,7 @@ static void idxd_group_flags_setup(struct idxd_device *idxd)
 			group->grpcfg.flags.tc_b = group->tc_b;
 		group->grpcfg.flags.use_rdbuf_limit = group->use_rdbuf_limit;
 		group->grpcfg.flags.rdbufs_reserved = group->rdbufs_reserved;
-		if (group->rdbufs_allowed)
-			group->grpcfg.flags.rdbufs_allowed = group->rdbufs_allowed;
-		else
-			group->grpcfg.flags.rdbufs_allowed = idxd->max_rdbufs;
-
+		group->grpcfg.flags.rdbufs_allowed = group->rdbufs_allowed;
 		group->grpcfg.flags.desc_progress_limit = group->desc_progress_limit;
 		group->grpcfg.flags.batch_progress_limit = group->batch_progress_limit;
 	}
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 529ea09c9094..b2df604e8a5f 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -302,6 +302,11 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 			group->tc_a = -1;
 			group->tc_b = -1;
 		}
+		/*
+		 * The default value is the same as the value of
+		 * total read buffers in GRPCAP.
+		 */
+		group->rdbufs_allowed = idxd->max_rdbufs;
 	}
 
 	return 0;
-- 
2.32.0

