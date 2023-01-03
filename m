Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C85065C449
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jan 2023 17:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjACQyD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Jan 2023 11:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjACQxx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Jan 2023 11:53:53 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ADB101D5;
        Tue,  3 Jan 2023 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672764832; x=1704300832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XBn7aa7KKmD9c2/FhVefs5yUCJ80XX0hDWmahUMXXac=;
  b=mp+Fu9p4paVRZ1bzmKpJePDc8rYzjH736eZC0/siKLjMQzd8uO4SHV4g
   R3pQU8vJ38wgJzAUClZYA0/LikxxsLZl8S0MDrtc/aIwi4yPCsRR8UzYB
   oF67m8th9TooGlNyZJuFQox8gSUaEvnKZAETnirB/4oiJMAOrmgar+KGt
   Poi9HeG6IaR2nCnjk8fkIOEaheiBc/TA+exH0JlKUgnCq3eQo1JmmYmQI
   Lt99x0cWdfjaS02SOTWJq+x+LPSiYthOFKLnbISY2UadLMpRnLfHYpUfp
   cnuUGC8tB4p5zt678APZ9dXEjI1/6y4aUv4j5PgsNgxlc7w/HQoJ2lra+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="322932868"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="322932868"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:53:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="828896811"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="828896811"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga005.jf.intel.com with ESMTP; 03 Jan 2023 08:53:51 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "Fenghua Yu" <fenghua.yu@intel.com>, dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dmaengine: idxd: reformat swerror output to standard Linux bitmap output
Date:   Tue,  3 Jan 2023 08:53:36 -0800
Message-Id: <20230103165337.1570238-2-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230103165337.1570238-1-fenghua.yu@intel.com>
References: <20230103165337.1570238-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

SWERROR register is 4 64bit wide registers. Currently the sysfs attribute
just outputs 4 64bit hex integers. Covert to output with %*pb format
specifier.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/idxd.h  |  1 +
 drivers/dma/idxd/init.c  |  2 +-
 drivers/dma/idxd/sysfs.c | 10 ++++------
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index f92f8ec83722..e449d905bea3 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -654,6 +654,7 @@ int idxd_register_driver(void);
 void idxd_unregister_driver(void);
 void idxd_wqs_quiesce(struct idxd_device *idxd);
 bool idxd_queue_int_handle_resubmit(struct idxd_desc *desc);
+void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count);
 
 /* device interrupt control */
 irqreturn_t idxd_misc_thread(int vec, void *data);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 564c025b9b7e..996bd3e4e50f 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -425,7 +425,7 @@ static void idxd_read_table_offsets(struct idxd_device *idxd)
 	dev_dbg(dev, "IDXD Perfmon Offset: %#x\n", idxd->perfmon_offset);
 }
 
-static void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count)
+void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count)
 {
 	int i, j, nr;
 
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index c772172d4ceb..dae28509e6ed 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1506,15 +1506,13 @@ static ssize_t errors_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
-	int i, out = 0;
+	DECLARE_BITMAP(swerr_bmap, 256);
 
+	bitmap_zero(swerr_bmap, 256);
 	spin_lock(&idxd->dev_lock);
-	for (i = 0; i < 4; i++)
-		out += sysfs_emit_at(buf, out, "%#018llx ", idxd->sw_err.bits[i]);
+	multi_u64_to_bmap(swerr_bmap, &idxd->sw_err.bits[0], 4);
 	spin_unlock(&idxd->dev_lock);
-	out--;
-	out += sysfs_emit_at(buf, out, "\n");
-	return out;
+	return sysfs_emit(buf, "%*pb\n", 256, swerr_bmap);
 }
 static DEVICE_ATTR_RO(errors);
 
-- 
2.32.0

