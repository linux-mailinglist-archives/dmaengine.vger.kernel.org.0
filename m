Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F486AC87C
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 17:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCFQpy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 11:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjCFQoR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 11:44:17 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F3D298FF;
        Mon,  6 Mar 2023 08:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678121034; x=1709657034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mn1nFVof/uaU7GNK/6NGBnoeC6aCmePHCwCCzsaRLNQ=;
  b=k8k7g/oXbjX47R3xtZRhZFbTg9xKD2PY9eHihoDLD9ZVStyGnljG6qF0
   53y+LdnhKEmHNtcQ6edSP90IenXfMgKkJxVp65iNrMhiYm2CX+W0pd3/3
   xZTqnGcdD6NS7JPy5lCbIydBJnjW6t5711SWVQeMPlQZV3rNs7kId2eJb
   HPX1PWuA0aKg4ggSsZUAXzqt67BHE0GBFUyQznbD7t8rMC7tmW/TcWuOq
   ddFv0WX0XAEEm3A7rU69Sc4nl6mAi+ci+RiFN1VCtOYmNziA0k88fSo4e
   IZFjPHcDXHIhDufIXpakYHK2jN4RJEeJ/geE0WJ1q4DQv/Szv85V8YwVd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398181160"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398181160"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 08:31:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669504517"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="669504517"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 08:31:57 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 07/16] dmaengine: idxd: create kmem cache for event log fault items
Date:   Mon,  6 Mar 2023 08:31:29 -0800
Message-Id: <20230306163138.587484-8-fenghua.yu@intel.com>
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

Add a kmem cache per device for allocating event log fault context. The
context allows an event log entry to be copied and passed to a software
workqueue to be processed. Due to each device can have different sized
event log entry depending on device type, it's not possible to have a
global kmem cache.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/idxd.h  | 10 ++++++++++
 drivers/dma/idxd/init.c  |  9 +++++++++
 drivers/dma/idxd/sysfs.c |  1 +
 3 files changed, 20 insertions(+)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 6e56361ae658..c5d99c179902 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -274,6 +274,15 @@ struct idxd_evl {
 	u16 head;
 };
 
+struct idxd_evl_fault {
+	struct work_struct work;
+	struct idxd_wq *wq;
+	u8 status;
+
+	/* make this last member always */
+	struct __evl_entry entry[];
+};
+
 struct idxd_device {
 	struct idxd_dev idxd_dev;
 	struct idxd_driver_data *data;
@@ -331,6 +340,7 @@ struct idxd_device {
 
 	unsigned long *opcap_bmap;
 	struct idxd_evl *evl;
+	struct kmem_cache *evl_cache;
 
 	struct dentry *dbgfs_dir;
 	struct dentry *dbgfs_evl_file;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index d19bc6389221..a7c98fac7a85 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -346,6 +346,15 @@ static int idxd_init_evl(struct idxd_device *idxd)
 
 	spin_lock_init(&evl->lock);
 	evl->size = IDXD_EVL_SIZE_MIN;
+
+	idxd->evl_cache = kmem_cache_create(dev_name(idxd_confdev(idxd)),
+					    sizeof(struct idxd_evl_fault) + evl_ent_size(idxd),
+					    0, 0, NULL);
+	if (!idxd->evl_cache) {
+		kfree(evl);
+		return -ENOMEM;
+	}
+
 	idxd->evl = evl;
 	return 0;
 }
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 163fdfaa5022..8b9dfa0d2b99 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1718,6 +1718,7 @@ static void idxd_conf_device_release(struct device *dev)
 	kfree(idxd->wqs);
 	kfree(idxd->engines);
 	kfree(idxd->evl);
+	kmem_cache_destroy(idxd->evl_cache);
 	ida_free(&idxd_ida, idxd->id);
 	bitmap_free(idxd->opcap_bmap);
 	kfree(idxd);
-- 
2.37.1

