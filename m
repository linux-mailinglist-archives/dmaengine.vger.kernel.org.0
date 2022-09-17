Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25545BB946
	for <lists+dmaengine@lfdr.de>; Sat, 17 Sep 2022 18:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiIQQNT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Sep 2022 12:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiIQQNS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Sep 2022 12:13:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DEE2ED66;
        Sat, 17 Sep 2022 09:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663431197; x=1694967197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HBWIwAR8yMUB4JUk2toz1ESMY37zb0vzYAO7ctg9dKM=;
  b=KiNfHuJ2+da+RZOcboN9BzVA4WUWm2TCqsUncE7b3SKzTjkZQpGv8Yeo
   2h5Oap9eXkXF1r+CX0UFZjXD7cc53TchQGlT+hHIBCAE46A2RMr6bm1iD
   gnGi1doik2DPhTS+z53mAuNYT3O48vkc89Oz4ZWjqJPCkjPoP5TSDqv54
   89dQSXXMsw0mwJcqovuouhZHE7w5NKVC/fIs+oTDNc0as6N/ebSqQCnNY
   uEoABZ5qJ6npFgGTKNpLdj3BkTUzZwy/nEjLky9DlkpY2yDOSdKQs6NCU
   1sN+l4jXvh8ZOhG+sIpEMBMdEzV6rjgImxVu6bj7KuZcVf8HqSQ0kDRhE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="286206511"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="286206511"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 09:13:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="686472598"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga004.fm.intel.com with ESMTP; 17 Sep 2022 09:13:14 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 1/5] dmaengine: idxd: convert ats_dis to a wq flag
Date:   Sat, 17 Sep 2022 09:12:18 -0700
Message-Id: <20220917161222.2835172-2-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220917161222.2835172-1-fenghua.yu@intel.com>
References: <20220917161222.2835172-1-fenghua.yu@intel.com>
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

Make wq attributes access consistent. Convert ats_dis to wq flag
WQ_FLAG_ATS_DISABLE.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/device.c | 4 ++--
 drivers/dma/idxd/idxd.h   | 2 +-
 drivers/dma/idxd/sysfs.c  | 7 +++++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5a8cc52c1abf..bbc3c8b9a10f 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -382,10 +382,10 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	wq->type = IDXD_WQT_NONE;
 	wq->threshold = 0;
 	wq->priority = 0;
-	wq->ats_dis = 0;
 	wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
 	clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
 	clear_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags);
+	clear_bit(WQ_FLAG_ATS_DISABLE, &wq->flags);
 	memset(wq->name, 0, WQ_NAME_SIZE);
 	wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
 	wq->max_batch_size = WQ_DEFAULT_MAX_BATCH;
@@ -859,7 +859,7 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 		wq->wqcfg->bof = 1;
 
 	if (idxd->hw.wq_cap.wq_ats_support)
-		wq->wqcfg->wq_ats_disable = wq->ats_dis;
+		wq->wqcfg->wq_ats_disable = test_bit(WQ_FLAG_ATS_DISABLE, &wq->flags);
 
 	/* bytes 12-15 */
 	wq->wqcfg->max_xfer_shift = ilog2(wq->max_xfer_bytes);
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index fed0dfc1eaa8..cda856bfc22a 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -132,6 +132,7 @@ enum idxd_wq_state {
 enum idxd_wq_flag {
 	WQ_FLAG_DEDICATED = 0,
 	WQ_FLAG_BLOCK_ON_FAULT,
+	WQ_FLAG_ATS_DISABLE,
 };
 
 enum idxd_wq_type {
@@ -208,7 +209,6 @@ struct idxd_wq {
 	char name[WQ_NAME_SIZE + 1];
 	u64 max_xfer_bytes;
 	u32 max_batch_size;
-	bool ats_dis;
 };
 
 struct idxd_engine {
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 3f262a57441b..be9ff9d4cc4b 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -973,7 +973,7 @@ static ssize_t wq_ats_disable_show(struct device *dev, struct device_attribute *
 {
 	struct idxd_wq *wq = confdev_to_wq(dev);
 
-	return sysfs_emit(buf, "%u\n", wq->ats_dis);
+	return sysfs_emit(buf, "%u\n", test_bit(WQ_FLAG_ATS_DISABLE, &wq->flags));
 }
 
 static ssize_t wq_ats_disable_store(struct device *dev, struct device_attribute *attr,
@@ -994,7 +994,10 @@ static ssize_t wq_ats_disable_store(struct device *dev, struct device_attribute
 	if (rc < 0)
 		return rc;
 
-	wq->ats_dis = ats_dis;
+	if (ats_dis)
+		set_bit(WQ_FLAG_ATS_DISABLE, &wq->flags);
+	else
+		clear_bit(WQ_FLAG_ATS_DISABLE, &wq->flags);
 
 	return count;
 }
-- 
2.32.0

