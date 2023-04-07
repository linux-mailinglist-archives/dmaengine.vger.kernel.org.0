Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2878C6DB550
	for <lists+dmaengine@lfdr.de>; Fri,  7 Apr 2023 22:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjDGUcL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Apr 2023 16:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjDGUbl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Apr 2023 16:31:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EAFC159;
        Fri,  7 Apr 2023 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680899494; x=1712435494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hPT8u68bZ2bhw3ksoI+ABo14zNuLKH375W6tuyoGx1s=;
  b=oCXOrYjUfhQQjOjC7ty2qS4yzDbkE6kraBw3Oq57LBx6xqzWdZSbyuJ+
   gE9lSaM8gKAXRqvwOq33Ahcb1T4sCF6hCkvOvwelP2M1oAQQ4ZakK6ZHi
   9cBf99iiDybjnWgdc9N8vGmdIOM7GT87yG72/goxV/Se7faqPUT8XfpcW
   BoBV/C9MiPsf/fL0Vm5oJVkn+LMk0OUYMZReh/3BfpgYBR9MvSCRAqzOB
   YVLjFV7sOylRexyI2mXxKLczmsDpiFUwb/S3KeQkr3pEp5vd0Pz3FDuc7
   y9r9dJ1l4OQsxZQk0onxxN9G8hDvMMns7gDwHJ6eJV1yPZwoTV8mjNh44
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="408196885"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="408196885"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 13:31:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681125909"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="681125909"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 07 Apr 2023 13:31:28 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 16/16] dmaengine: idxd: add per wq PRS disable
Date:   Fri,  7 Apr 2023 13:31:43 -0700
Message-Id: <20230407203143.2189681-17-fenghua.yu@intel.com>
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
index 5d0df57f5298..534b7a3d59fc 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -235,6 +235,16 @@ Contact:	dmaengine@vger.kernel.org
 Description:	Indicate whether ATS disable is turned on for the workqueue.
 		0 indicates ATS is on, and 1 indicates ATS is off for the workqueue.
 
+What:		/sys/bus/dsa/devices/wq<m>.<n>/prs_disable
+Date:		Sept 14, 2022
+KernelVersion: 6.4.0
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
index fd97b2b58734..3c80b9681c72 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -967,12 +967,16 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
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
index bd544eb2ddcb..e44b1d45ccd5 100644
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
index 9f3959d001b6..7b54a3939ea1 100644
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
@@ -371,7 +372,7 @@ union wqcfg {
 		u32 mode:1;	/* shared or dedicated */
 		u32 bof:1;	/* block on fault */
 		u32 wq_ats_disable:1;
-		u32 rsvd2:1;
+		u32 wq_prs_disable:1;
 		u32 priority:4;
 		u32 pasid:20;
 		u32 pasid_en:1;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 465d2e7627e4..293739ac5596 100644
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
2.37.1

