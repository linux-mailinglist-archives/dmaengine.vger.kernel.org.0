Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA416AA16B
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 22:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjCCVhs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 16:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjCCVhr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 16:37:47 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C74062D8A;
        Fri,  3 Mar 2023 13:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677879466; x=1709415466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nFDhmcDkq7sy9mDQLCQjRicWl0xsl4vCeIKcGrjykb0=;
  b=DpBPqUWIYootO1eDPwdK0kP6++ixJtiUlqV9ESfJtx0bH17dQbj4yCCR
   00ovAJmFa6mRR+fsg5J9sUKevdVsfSDopdeY+csLhpe0ZZh0O7zDhgOrd
   QZoBipt9KwOUY5KV6ydu0hQIzyXiTVNU3nOLLbLlJK04IT4TwXqOo1GxA
   ZQ0M/IePaTwCJDAknNoc3vlCP2Q3Ljk76gfvbauWiUEGJXyyRPU22I0u2
   SO8LAHi44UhScw/RCqhTEXru7UK4ahgiTpZKc8MPf0pYCqbcGbwgNw5Es
   FdeQYuXsBOg35rrm2aD80poeNrUHE19bqplRTYjNVoXAqZXsELP5AgHGF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="332643551"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="332643551"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:37:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="818650492"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="818650492"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga001.fm.intel.com with ESMTP; 03 Mar 2023 13:37:45 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 1/2] dmaengine: idxd: reformat swerror output to standard Linux bitmap output
Date:   Fri,  3 Mar 2023 13:37:31 -0800
Message-Id: <20230303213732.3357494-2-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230303213732.3357494-1-fenghua.yu@intel.com>
References: <20230303213732.3357494-1-fenghua.yu@intel.com>
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

SWERROR register is 4 64bit wide registers. Currently the sysfs attribute
just outputs 4 64bit hex integers. Convert to output with %*pb format
specifier.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
v2:
- Fix a typo in commit message (Vinod)

 drivers/dma/idxd/idxd.h  |  1 +
 drivers/dma/idxd/init.c  |  2 +-
 drivers/dma/idxd/sysfs.c | 10 ++++------
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 7ced8d283d98..ad7a1e8a0e1c 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -598,6 +598,7 @@ int idxd_register_driver(void);
 void idxd_unregister_driver(void);
 void idxd_wqs_quiesce(struct idxd_device *idxd);
 bool idxd_queue_int_handle_resubmit(struct idxd_desc *desc);
+void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count);
 
 /* device interrupt control */
 irqreturn_t idxd_misc_thread(int vec, void *data);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 640d3048368e..68d1c7fc9112 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -389,7 +389,7 @@ static void idxd_read_table_offsets(struct idxd_device *idxd)
 	dev_dbg(dev, "IDXD Perfmon Offset: %#x\n", idxd->perfmon_offset);
 }
 
-static void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count)
+void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count)
 {
 	int i, j, nr;
 
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 18cd8151dee0..927c9d645121 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1452,15 +1452,13 @@ static ssize_t errors_show(struct device *dev,
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
2.37.1

