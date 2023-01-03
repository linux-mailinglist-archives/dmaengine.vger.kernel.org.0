Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45F665C40B
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jan 2023 17:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbjACQfc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Jan 2023 11:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbjACQfV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Jan 2023 11:35:21 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D046370
        for <dmaengine@vger.kernel.org>; Tue,  3 Jan 2023 08:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672763721; x=1704299721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+HXe6Jh2z6ezFiL+j/XwMs/rznYoSX81X0UZmjCu2V4=;
  b=eSChvrLbVusbL4kj5e4b7yPSlfohSmD6a7vw66PIHXYxPBEms9l6c+14
   tRZT211qNJyCIvDLBpMJfw+RSFq8uIDCffdZhZnvBrO4jvYt2hps/oU7C
   H5ZIzd4e3ODCLgMvahLR+dTJa0qr7W/yRkm89uC+ujVJ7TNEws2fel3hX
   TtKN+Bcw2THqYVR6Fydrl8Vgzmo9lDXMOQVCKpjZBTxB3PK3Ip1XfceOF
   h0cM32c7bbBlY31Gv3uQMINSyWkrZL8d88a6k0vjeF6sDNRB4/IuINTgJ
   V6/Lq93iIf6u43rkhNrhyv3nYCq64cnY5xmk2D+cNTk3OaZ2yqnaiGcU+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="302072352"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="302072352"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:35:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="604858596"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="604858596"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga003.jf.intel.com with ESMTP; 03 Jan 2023 08:35:18 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "Fenghua Yu" <fenghua.yu@intel.com>, dmaengine@vger.kernel.org,
        Tony Zhu <tony.zhu@intel.com>
Subject: [PATCH 17/17] dmaengine: idxd: add per wq PRS disable
Date:   Tue,  3 Jan 2023 08:35:05 -0800
Message-Id: <20230103163505.1569356-18-fenghua.yu@intel.com>
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

Add sysfs knob for per wq Page Request Service disable. This knob
disables PRS support for the specific wq. When this bit is set,
it also overrides the wq's block on fault enabling.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 .../ABI/stable/sysfs-driver-dma-idxd          | 10 ++++
 drivers/dma/idxd/device.c                     |  6 +-
 drivers/dma/idxd/idxd.h                       |  1 +
 drivers/dma/idxd/registers.h                  |  5 +-
 drivers/dma/idxd/sysfs.c                      | 57 ++++++++++++++++++-
 5 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index be12612bd76e..603869112887 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -227,6 +227,16 @@ Contact:	dmaengine@vger.kernel.org
 Description:	Indicate whether ATS disable is turned on for the workqueue.
 		0 indicates ATS is on, and 1 indicates ATS is off for the workqueue.
 
+What:		/sys/bus/dsa/devices/wq<m>.<n>/prs_disable
+Date:		Sept 14, 2022
+KernelVersion: 6.2.0
+Contact:	dmaengine@vger.kernel.org
+Description:	Controls whether PRS disable is turned on for the workqueue.
+		0 indicates PRS is on, and 1 indicates PRS is off for the
+		workqueue. This option overrides block_on_fault attribute
+		if set. It's visible only on platforms that support the
+		capability.
+
 What:		/sys/bus/dsa/devices/wq<m>.<n>/occupancy
 Date		May 25, 2021
 KernelVersion:	5.14.0
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index cef3f22dd48b..26f0463cff7e 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -963,12 +963,16 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 	wq->wqcfg->priority = wq->priority;
 
 	if (idxd->hw.gen_cap.block_on_fault &&
-	    test_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags))
+	    test_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags) &&
+	    !test_bit(WQ_FLAG_PRS_DISABLE, &wq->flags))
 		wq->wqcfg->bof = 1;
 
 	if (idxd->hw.wq_cap.wq_ats_support)
 		wq->wqcfg->wq_ats_disable = test_bit(WQ_FLAG_ATS_DISABLE, &wq->flags);
 
+	if (idxd->hw.wq_cap.wq_prs_support)
+		wq->wqcfg->wq_prs_disable = test_bit(WQ_FLAG_PRS_DISABLE, &wq->flags);
+
 	/* bytes 12-15 */
 	wq->wqcfg->max_xfer_shift = ilog2(wq->max_xfer_bytes);
 	idxd_wqcfg_set_max_batch_shift(idxd->data->type, wq->wqcfg, ilog2(wq->max_batch_size));
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 1ad4d9e1f06d..f92f8ec83722 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -143,6 +143,7 @@ enum idxd_wq_flag {
 	WQ_FLAG_DEDICATED = 0,
 	WQ_FLAG_BLOCK_ON_FAULT,
 	WQ_FLAG_ATS_DISABLE,
+	WQ_FLAG_PRS_DISABLE,
 };
 
 enum idxd_wq_type {
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index a772116b4c0d..6155dc7d2152 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -59,7 +59,8 @@ union wq_cap_reg {
 		u64 occupancy:1;
 		u64 occupancy_int:1;
 		u64 op_config:1;
-		u64 rsvd3:9;
+		u64 wq_prs_support:1;
+		u64 rsvd4:8;
 	};
 	u64 bits;
 } __packed;
@@ -350,7 +351,7 @@ union wqcfg {
 		u32 mode:1;	/* shared or dedicated */
 		u32 bof:1;	/* block on fault */
 		u32 wq_ats_disable:1;
-		u32 rsvd2:1;
+		u32 wq_prs_disable:1;
 		u32 priority:4;
 		u32 pasid:20;
 		u32 pasid_en:1;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 137126781362..c772172d4ceb 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -822,10 +822,14 @@ static ssize_t wq_block_on_fault_store(struct device *dev,
 	if (rc < 0)
 		return rc;
 
-	if (bof)
+	if (bof) {
+		if (test_bit(WQ_FLAG_PRS_DISABLE, &wq->flags))
+			return -EOPNOTSUPP;
+
 		set_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags);
-	else
+	} else {
 		clear_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags);
+	}
 
 	return count;
 }
@@ -1109,6 +1113,44 @@ static ssize_t wq_ats_disable_store(struct device *dev, struct device_attribute
 static struct device_attribute dev_attr_wq_ats_disable =
 		__ATTR(ats_disable, 0644, wq_ats_disable_show, wq_ats_disable_store);
 
+static ssize_t wq_prs_disable_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct idxd_wq *wq = confdev_to_wq(dev);
+
+	return sysfs_emit(buf, "%u\n", test_bit(WQ_FLAG_PRS_DISABLE, &wq->flags));
+}
+
+static ssize_t wq_prs_disable_store(struct device *dev, struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct idxd_wq *wq = confdev_to_wq(dev);
+	struct idxd_device *idxd = wq->idxd;
+	bool prs_dis;
+	int rc;
+
+	if (wq->state != IDXD_WQ_DISABLED)
+		return -EPERM;
+
+	if (!idxd->hw.wq_cap.wq_prs_support)
+		return -EOPNOTSUPP;
+
+	rc = kstrtobool(buf, &prs_dis);
+	if (rc < 0)
+		return rc;
+
+	if (prs_dis) {
+		set_bit(WQ_FLAG_PRS_DISABLE, &wq->flags);
+		/* when PRS is disabled, BOF needs to be off as well */
+		clear_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags);
+	} else {
+		clear_bit(WQ_FLAG_PRS_DISABLE, &wq->flags);
+	}
+	return count;
+}
+
+static struct device_attribute dev_attr_wq_prs_disable =
+		__ATTR(prs_disable, 0644, wq_prs_disable_show, wq_prs_disable_store);
+
 static ssize_t wq_occupancy_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct idxd_wq *wq = confdev_to_wq(dev);
@@ -1239,6 +1281,7 @@ static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_max_transfer_size.attr,
 	&dev_attr_wq_max_batch_size.attr,
 	&dev_attr_wq_ats_disable.attr,
+	&dev_attr_wq_prs_disable.attr,
 	&dev_attr_wq_occupancy.attr,
 	&dev_attr_wq_enqcmds_retries.attr,
 	&dev_attr_wq_op_config.attr,
@@ -1260,6 +1303,13 @@ static bool idxd_wq_attr_max_batch_size_invisible(struct attribute *attr,
 	       idxd->data->type == IDXD_TYPE_IAX;
 }
 
+static bool idxd_wq_attr_wq_prs_disable_invisible(struct attribute *attr,
+						  struct idxd_device *idxd)
+{
+	return attr == &dev_attr_wq_prs_disable.attr &&
+	       !idxd->hw.wq_cap.wq_prs_support;
+}
+
 static umode_t idxd_wq_attr_visible(struct kobject *kobj,
 				    struct attribute *attr, int n)
 {
@@ -1273,6 +1323,9 @@ static umode_t idxd_wq_attr_visible(struct kobject *kobj,
 	if (idxd_wq_attr_max_batch_size_invisible(attr, idxd))
 		return 0;
 
+	if (idxd_wq_attr_wq_prs_disable_invisible(attr, idxd))
+		return 0;
+
 	return attr->mode;
 }
 
-- 
2.32.0

