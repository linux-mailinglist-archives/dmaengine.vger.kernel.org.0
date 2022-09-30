Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECFA5F125E
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 21:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiI3T04 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Sep 2022 15:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiI3T0z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Sep 2022 15:26:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DDFBD062
        for <dmaengine@vger.kernel.org>; Fri, 30 Sep 2022 12:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664566014; x=1696102014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=m6T+Wlw3HCl6H/Vik+TkN6SfLCuA/ylb16iHSPGSN/M=;
  b=B63PZ93gc4uaSV0I7X2w31tje7RFjNhy01N3ptGFZ+w6OP20lAN2zP78
   wWBEz4r94rlPG7Gqh0/7NyfRUkX8TGOldaTD9NbpkzvzC0NeiHXvCm9rI
   tNfo3qCRtL+e+L3rxUGYmNlBey8enKA7YiRpEhVJ+Dd0BeFqEFz+7EPsg
   TM1ozlAyrvceyRa6jovslvlGISNJYp8OuSQdF9qstlsuz7hckA94NJJyd
   wzHG8xsK5/O+7BFBeiRPTPtK5sIVPAGp+Mab53CkWs3jQV3pKYvPxKkEA
   UfGBwJ4iJ07yr1mLA0mV57I34tFczMoyx/hMxshUtC2WC3dSOK9UoeLrt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="364119849"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208,223";a="364119849"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 12:26:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="625099123"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208,223";a="625099123"
Received: from xshen14-linux.bj.intel.com ([10.238.155.105])
  by fmsmga007.fm.intel.com with ESMTP; 30 Sep 2022 12:26:51 -0700
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     vkoul@kernel.org, fenghua.yu@intel.com, dave.jiang@intel.com,
        dmaengine@vger.kernel.org
Cc:     ramesh.thomas@intel.com, tony.luck@intel.com, tony.zhu@intel.com,
        pei.p.jia@intel.com, xiaochen.shen@intel.com
Subject: [PATCH v2 1/2] dmaengine: idxd: Fix max batch size for Intel IAA
Date:   Sat,  1 Oct 2022 04:15:27 +0800
Message-Id: <20220930201528.18621-2-xiaochen.shen@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220930201528.18621-1-xiaochen.shen@intel.com>
References: <20220930201528.18621-1-xiaochen.shen@intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From Intel IAA spec [1], Intel IAA does not support batch processing.

Two batch related default values for IAA are incorrect in current code:
(1) The max batch size of device is set during device initialization,
    that indicates batch is supported. It should be always 0 on IAA.
(2) The max batch size of work queue is set to WQ_DEFAULT_MAX_BATCH (32)
    as the default value regardless of Intel DSA or IAA device during
    work queue setup and cleanup. It should be always 0 on IAA.

Fix the issues by setting the max batch size of device and max batch
size of work queue to 0 on IAA device, that means batch is not
supported.

[1]: https://cdrdv2.intel.com/v1/dl/getContent/721858

Fixes: 23084545dbb0 ("dmaengine: idxd: set max_xfer and max_batch for RO device")
Fixes: 92452a72ebdf ("dmaengine: idxd: set defaults for wq configs")
Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/device.c |  6 +++---
 drivers/dma/idxd/idxd.h   | 32 ++++++++++++++++++++++++++++++++
 drivers/dma/idxd/init.c   |  4 ++--
 drivers/dma/idxd/sysfs.c  |  2 +-
 4 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 2c1e6f6daa62..670b71927db0 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -390,7 +390,7 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	clear_bit(WQ_FLAG_ATS_DISABLE, &wq->flags);
 	memset(wq->name, 0, WQ_NAME_SIZE);
 	wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
-	wq->max_batch_size = WQ_DEFAULT_MAX_BATCH;
+	idxd_wq_set_max_batch_size(idxd->data->type, wq, WQ_DEFAULT_MAX_BATCH);
 	if (wq->opcap_bmap)
 		bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
 }
@@ -869,7 +869,7 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 
 	/* bytes 12-15 */
 	wq->wqcfg->max_xfer_shift = ilog2(wq->max_xfer_bytes);
-	wq->wqcfg->max_batch_shift = ilog2(wq->max_batch_size);
+	idxd_wqcfg_set_max_batch_shift(idxd->data->type, wq->wqcfg, ilog2(wq->max_batch_size));
 
 	/* bytes 32-63 */
 	if (idxd->hw.wq_cap.op_config && wq->opcap_bmap) {
@@ -1051,7 +1051,7 @@ static int idxd_wq_load_config(struct idxd_wq *wq)
 	wq->priority = wq->wqcfg->priority;
 
 	wq->max_xfer_bytes = 1ULL << wq->wqcfg->max_xfer_shift;
-	wq->max_batch_size = 1ULL << wq->wqcfg->max_batch_shift;
+	idxd_wq_set_max_batch_size(idxd->data->type, wq, 1U << wq->wqcfg->max_batch_shift);
 
 	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
 		wqcfg_offset = WQCFG_OFFSET(idxd, wq->id, i);
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 1196ab342f01..7ced8d283d98 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -548,6 +548,38 @@ static inline int idxd_wq_refcount(struct idxd_wq *wq)
 	return wq->client_count;
 };
 
+/*
+ * Intel IAA does not support batch processing.
+ * The max batch size of device, max batch size of wq and
+ * max batch shift of wqcfg should be always 0 on IAA.
+ */
+static inline void idxd_set_max_batch_size(int idxd_type, struct idxd_device *idxd,
+					   u32 max_batch_size)
+{
+	if (idxd_type == IDXD_TYPE_IAX)
+		idxd->max_batch_size = 0;
+	else
+		idxd->max_batch_size = max_batch_size;
+}
+
+static inline void idxd_wq_set_max_batch_size(int idxd_type, struct idxd_wq *wq,
+					      u32 max_batch_size)
+{
+	if (idxd_type == IDXD_TYPE_IAX)
+		wq->max_batch_size = 0;
+	else
+		wq->max_batch_size = max_batch_size;
+}
+
+static inline void idxd_wqcfg_set_max_batch_shift(int idxd_type, union wqcfg *wqcfg,
+						  u32 max_batch_shift)
+{
+	if (idxd_type == IDXD_TYPE_IAX)
+		wqcfg->max_batch_shift = 0;
+	else
+		wqcfg->max_batch_shift = max_batch_shift;
+}
+
 int __must_check __idxd_driver_register(struct idxd_device_driver *idxd_drv,
 					struct module *module, const char *mod_name);
 #define idxd_driver_register(driver) \
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 2b18d512cbfc..09cbf0c179ba 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -183,7 +183,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		init_completion(&wq->wq_dead);
 		init_completion(&wq->wq_resurrect);
 		wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
-		wq->max_batch_size = WQ_DEFAULT_MAX_BATCH;
+		idxd_wq_set_max_batch_size(idxd->data->type, wq, WQ_DEFAULT_MAX_BATCH);
 		wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
@@ -418,7 +418,7 @@ static void idxd_read_caps(struct idxd_device *idxd)
 
 	idxd->max_xfer_bytes = 1ULL << idxd->hw.gen_cap.max_xfer_shift;
 	dev_dbg(dev, "max xfer size: %llu bytes\n", idxd->max_xfer_bytes);
-	idxd->max_batch_size = 1U << idxd->hw.gen_cap.max_batch_shift;
+	idxd_set_max_batch_size(idxd->data->type, idxd, 1U << idxd->hw.gen_cap.max_batch_shift);
 	dev_dbg(dev, "max batch size: %u\n", idxd->max_batch_size);
 	if (idxd->hw.gen_cap.config_en)
 		set_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index bdaccf9e0436..7269bd54554f 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1046,7 +1046,7 @@ static ssize_t wq_max_batch_size_store(struct device *dev, struct device_attribu
 	if (batch_size > idxd->max_batch_size)
 		return -EINVAL;
 
-	wq->max_batch_size = (u32)batch_size;
+	idxd_wq_set_max_batch_size(idxd->data->type, wq, (u32)batch_size);
 
 	return count;
 }
-- 
2.18.4

