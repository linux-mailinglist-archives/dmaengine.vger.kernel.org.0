Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1E665C3FE
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jan 2023 17:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbjACQfY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Jan 2023 11:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbjACQfS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Jan 2023 11:35:18 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A52A6370
        for <dmaengine@vger.kernel.org>; Tue,  3 Jan 2023 08:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672763718; x=1704299718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CLUXsFE5EVP8Q5PfXafyc3Q8oQLrvadR0wo4A8ARGrw=;
  b=abpCbURcABG3QrtFPplVDjyj71JcN9KJMUda5oN0ph+1SwCeMoyzhNWw
   k5FafKbTQlAqOsWEjxESSfzd9uDmLKRWaB627IAcQ0qLI0gTsFls7f4Ju
   XpxaKl3fvCcl06QCjJM3EbRS0G8kWndfJ6EDPfdRhHvEdpCuAXktIYHLW
   GptB80/iyOk5x+4e66Mi73Ex1cdWQkoG1BZEvMkjWzgkQUz7YG9S8/l6q
   2scNbl0h7TRlvpskH95A81QHN0BL1v4nfOW3lKR6F/f0fQPzAg+mZwHwu
   poYvV8s2ZAOGjJ7jaRDdM537a+FQ6L+ULDrUmjOeVpZvXxZlJRloXOTI9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="302072315"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="302072315"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:35:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="604858504"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="604858504"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga003.jf.intel.com with ESMTP; 03 Jan 2023 08:35:13 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "Fenghua Yu" <fenghua.yu@intel.com>, dmaengine@vger.kernel.org,
        Tony Zhu <tony.zhu@intel.com>
Subject: [PATCH 07/17] dmaengine: idxd: create kmem cache for event log fault items
Date:   Tue,  3 Jan 2023 08:34:55 -0800
Message-Id: <20230103163505.1569356-8-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230103163505.1569356-1-fenghua.yu@intel.com>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
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
index 3f182540b040..b4fa1051a482 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -273,6 +273,15 @@ struct idxd_evl {
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
@@ -330,6 +339,7 @@ struct idxd_device {
 
 	unsigned long *opcap_bmap;
 	struct idxd_evl *evl;
+	struct kmem_cache *evl_cache;
 
 	struct dentry *dbgfs_dir;
 	struct dentry *dbgfs_evl_file;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 9a5ab223d8ac..74d6a12d4bd3 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -341,6 +341,15 @@ static int idxd_init_evl(struct idxd_device *idxd)
 
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
index 3e8c4ecd40ee..ea696e3c5680 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1696,6 +1696,7 @@ static void idxd_conf_device_release(struct device *dev)
 	kfree(idxd->wqs);
 	kfree(idxd->engines);
 	kfree(idxd->evl);
+	kmem_cache_destroy(idxd->evl_cache);
 	ida_free(&idxd_ida, idxd->id);
 	bitmap_free(idxd->opcap_bmap);
 	kfree(idxd);
-- 
2.32.0

