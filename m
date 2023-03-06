Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8606AC88A
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 17:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjCFQqC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 11:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjCFQoW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 11:44:22 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFC735242;
        Mon,  6 Mar 2023 08:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678121038; x=1709657038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f44hJzsv5G4du9Q7bT5CpVrZ9HY7StygNVQkHIRMAYU=;
  b=HwdY0UeVtGF8AZxQcXVSPqJ+94zU4ZEiJmTmswOf+kGT28pXKzroDX47
   C5Gz7Rh+BSdSfB7sTAloM3IE9mBo52OOtznYT6dRTVuY06erhnhLIYVcv
   Bu4w2YFpoeukfrYU1tBUrMRxpGoGmWkp/mHkVh5p9ARiHvpFgGCZ6oejD
   EShO29mYLc6M6o9j8JRc2blTk8akXqlSi6DcBYfst5SsQt1A8UGj2mDfM
   266jMAV2+xTI0RZtFY7WgMaVbPeQXsMW9KB4nn7ust/hZebN/zmT1Wt0L
   mg7nlXL2JRAv7tpyPKT8J1Xwwhtc1cvD37MvllL3a7bxDqj5gzJAArOvX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398181155"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398181155"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 08:31:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669504513"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="669504513"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 08:31:56 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 06/16] dmaengine: idxd: add per DSA wq workqueue for processing cr faults
Date:   Mon,  6 Mar 2023 08:31:28 -0800
Message-Id: <20230306163138.587484-7-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230306163138.587484-1-fenghua.yu@intel.com>
References: <20230306163138.587484-1-fenghua.yu@intel.com>
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

Add a workqueue for user submitted completion record fault processing.
The workqueue creation and destruction lifetime will be tied to the user
sub-driver since it will only be used when the wq is a user type.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/cdev.c | 11 +++++++++++
 drivers/dma/idxd/idxd.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 674bfefca088..cbe29e1a6a44 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -330,6 +330,13 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
 	}
 
 	mutex_lock(&wq->wq_lock);
+
+	wq->wq = create_workqueue(dev_name(wq_confdev(wq)));
+	if (!wq->wq) {
+		rc = -ENOMEM;
+		goto wq_err;
+	}
+
 	wq->type = IDXD_WQT_USER;
 	rc = drv_enable_wq(wq);
 	if (rc < 0)
@@ -348,7 +355,9 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
 err_cdev:
 	drv_disable_wq(wq);
 err:
+	destroy_workqueue(wq->wq);
 	wq->type = IDXD_WQT_NONE;
+wq_err:
 	mutex_unlock(&wq->wq_lock);
 	return rc;
 }
@@ -361,6 +370,8 @@ static void idxd_user_drv_remove(struct idxd_dev *idxd_dev)
 	idxd_wq_del_cdev(wq);
 	drv_disable_wq(wq);
 	wq->type = IDXD_WQT_NONE;
+	destroy_workqueue(wq->wq);
+	wq->wq = NULL;
 	mutex_unlock(&wq->wq_lock);
 }
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index b923b90b7299..6e56361ae658 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -185,6 +185,7 @@ struct idxd_wq {
 	struct idxd_dev idxd_dev;
 	struct idxd_cdev *idxd_cdev;
 	struct wait_queue_head err_queue;
+	struct workqueue_struct *wq;
 	struct idxd_device *idxd;
 	int id;
 	struct idxd_irq_entry ie;
-- 
2.37.1

