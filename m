Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5672758C19E
	for <lists+dmaengine@lfdr.de>; Mon,  8 Aug 2022 04:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243696AbiHHC2n (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 7 Aug 2022 22:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243793AbiHHC2V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 7 Aug 2022 22:28:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D4EFC8
        for <dmaengine@vger.kernel.org>; Sun,  7 Aug 2022 19:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659925650; x=1691461650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WtCEiUJ+AXBHLyNk63XdvE4e1+9YDyBC2YD61UkLWGU=;
  b=FQebNxC8UUTD/aE8aImTgT5WB7/XVJtAfepmuuBvOxOTt3B3xr4ZYd5v
   Wxuo2VYsXNw0986MMu/JLUCv6ByIHln6PyECM1TMllzthpcbhlGMFlFr+
   YVvKhuCq8vEGrx5j0w1DHGMKElG73/xXNV7ncjzAO4haWz31zgtZAaw2v
   lIadKBfjn0Mx85UX+58cWHJQUkOgINExiftV+WamrttwhsOZCVn/CEL5I
   7lCNTXP3eVSgNBH1SEfwzKRbUa7A3FL34hor2quTjgEr08IacZ6AAry1/
   yf2kG13hZSTAcj0TDd28Ie3HVxSGQKputk0IFut87YzP6PfCdiHOmeNt9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="290494605"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208,223";a="290494605"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 19:27:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208,223";a="663734204"
Received: from xshen14-linux.bj.intel.com ([10.238.155.105])
  by fmsmga008.fm.intel.com with ESMTP; 07 Aug 2022 19:27:08 -0700
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     vkoul@kernel.org, fenghua.yu@intel.com, dave.jiang@intel.com,
        dmaengine@vger.kernel.org
Cc:     ramesh.thomas@intel.com, tony.luck@intel.com, tony.zhu@intel.com,
        pei.p.jia@intel.com, xiaochen.shen@intel.com
Subject: [PATCH 1/2] dmaengine: idxd: Fix max batch size for Intel IAA
Date:   Mon,  8 Aug 2022 11:19:21 +0800
Message-Id: <20220808031922.29751-2-xiaochen.shen@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220808031922.29751-1-xiaochen.shen@intel.com>
References: <20220808031922.29751-1-xiaochen.shen@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 5a8cc52c1abf..cc7aabe4dc84 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -388,7 +388,7 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	clear_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags);
 	memset(wq->name, 0, WQ_NAME_SIZE);
 	wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
-	wq->max_batch_size = WQ_DEFAULT_MAX_BATCH;
+	idxd_wq_set_max_batch_size(idxd->data->type, wq, WQ_DEFAULT_MAX_BATCH);
 }
 
 static void idxd_wq_device_reset_cleanup(struct idxd_wq *wq)
@@ -863,7 +863,7 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 
 	/* bytes 12-15 */
 	wq->wqcfg->max_xfer_shift = ilog2(wq->max_xfer_bytes);
-	wq->wqcfg->max_batch_shift = ilog2(wq->max_batch_size);
+	idxd_wqcfg_set_max_batch_shift(idxd->data->type, wq->wqcfg, ilog2(wq->max_batch_size));
 
 	dev_dbg(dev, "WQ %d CFGs\n", wq->id);
 	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
@@ -1031,7 +1031,7 @@ static int idxd_wq_load_config(struct idxd_wq *wq)
 	wq->priority = wq->wqcfg->priority;
 
 	wq->max_xfer_bytes = 1ULL << wq->wqcfg->max_xfer_shift;
-	wq->max_batch_size = 1ULL << wq->wqcfg->max_batch_shift;
+	idxd_wq_set_max_batch_size(idxd->data->type, wq, 1U << wq->wqcfg->max_batch_shift);
 
 	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
 		wqcfg_offset = WQCFG_OFFSET(idxd, wq->id, i);
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index fed0dfc1eaa8..c1617416d379 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -540,6 +540,38 @@ static inline int idxd_wq_refcount(struct idxd_wq *wq)
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
index aa3478257ddb..6d03849c698b 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -177,7 +177,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		init_completion(&wq->wq_dead);
 		init_completion(&wq->wq_resurrect);
 		wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
-		wq->max_batch_size = WQ_DEFAULT_MAX_BATCH;
+		idxd_wq_set_max_batch_size(idxd->data->type, wq, WQ_DEFAULT_MAX_BATCH);
 		wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
@@ -389,7 +389,7 @@ static void idxd_read_caps(struct idxd_device *idxd)
 
 	idxd->max_xfer_bytes = 1ULL << idxd->hw.gen_cap.max_xfer_shift;
 	dev_dbg(dev, "max xfer size: %llu bytes\n", idxd->max_xfer_bytes);
-	idxd->max_batch_size = 1U << idxd->hw.gen_cap.max_batch_shift;
+	idxd_set_max_batch_size(idxd->data->type, idxd, 1U << idxd->hw.gen_cap.max_batch_shift);
 	dev_dbg(dev, "max batch size: %u\n", idxd->max_batch_size);
 	if (idxd->hw.gen_cap.config_en)
 		set_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 3f262a57441b..fa729fac4b97 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -961,7 +961,7 @@ static ssize_t wq_max_batch_size_store(struct device *dev, struct device_attribu
 	if (batch_size > idxd->max_batch_size)
 		return -EINVAL;
 
-	wq->max_batch_size = (u32)batch_size;
+	idxd_wq_set_max_batch_size(idxd->data->type, wq, (u32)batch_size);
 
 	return count;
 }
-- 
2.18.4

