Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F226DB53E
	for <lists+dmaengine@lfdr.de>; Fri,  7 Apr 2023 22:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjDGUbe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Apr 2023 16:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjDGUba (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Apr 2023 16:31:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D7DA279;
        Fri,  7 Apr 2023 13:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680899489; x=1712435489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mn1nFVof/uaU7GNK/6NGBnoeC6aCmePHCwCCzsaRLNQ=;
  b=UNWxE0nLIhagaqc0FDbH8VYOfm6KMNqImncTYoCDpIMPuokG3TaFInLR
   6QQRNAUMpqWIDOdt54/aeG2fra09jQvVwMGoCdXCwj9YNHtfHjk+jOuhE
   JI8v1j6WYHgA/bkqSd0ybpbHJETP3sP56w5RO8qfAjF162ZNuhc/BLhbj
   R/QMtrhIX3J80t9/H5UR1UuTlmvlGsrkNBgpyDI8xCDkXpeM24mz5UKN3
   IIXMrkjSitx5a1RUM7lIMK3boM99XsX9MqchQWwwXkkL49aZCiRbRQEOl
   Oi4/4GyPYGpxRNVhAR/vy9cMRwXUQxUXms0vNswMc5trVKHQDUNLY1eGe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="408196862"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="408196862"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 13:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681125882"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="681125882"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 07 Apr 2023 13:31:26 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 07/16] dmaengine: idxd: create kmem cache for event log fault items
Date:   Fri,  7 Apr 2023 13:31:34 -0700
Message-Id: <20230407203143.2189681-8-fenghua.yu@intel.com>
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

