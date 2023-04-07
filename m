Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F006DB53D
	for <lists+dmaengine@lfdr.de>; Fri,  7 Apr 2023 22:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjDGUbd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Apr 2023 16:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjDGUba (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Apr 2023 16:31:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F46F9741;
        Fri,  7 Apr 2023 13:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680899489; x=1712435489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f44hJzsv5G4du9Q7bT5CpVrZ9HY7StygNVQkHIRMAYU=;
  b=nki5jGbVr/xZrqz1v2z5ogGRvD1zbAm0Pd3bxiDXE4aSOl8sl/gcUew6
   vOZQJWGtgwj7zRT8onAcGRufD5bxLnpdWtQrKWF13D0XZoaXEAGv8/UET
   DBQUEnqy/cFgrbKeqvxIHWUn/fQ4ezRe27loby9sq2CAtoZfb0HG1WzNh
   uPIRz8OyGck/C4so/PVMo55oirc/yvVh8isqJi826pK9iDk5kFqiP7d/u
   uIsjEF4BN3qSAr6kUld/40A6nkGlmuE6Rl0h+NKv1lHdzdOyIa6VF+mR3
   mvUzCl0qMK+oswNcrsYfWZ/djk6HsxhHkDypaQlMNv32tizkwhjepKG3M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="408196860"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="408196860"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 13:31:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681125879"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="681125879"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 07 Apr 2023 13:31:26 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 06/16] dmaengine: idxd: add per DSA wq workqueue for processing cr faults
Date:   Fri,  7 Apr 2023 13:31:33 -0700
Message-Id: <20230407203143.2189681-7-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230407203143.2189681-1-fenghua.yu@intel.com>
References: <20230407203143.2189681-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

