Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329F85F125F
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 21:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiI3T07 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Sep 2022 15:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiI3T06 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Sep 2022 15:26:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31563BF1CE
        for <dmaengine@vger.kernel.org>; Fri, 30 Sep 2022 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664566017; x=1696102017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IhiKkyq1l0oH6fGNtP9nJ0q8vTBtTvTWOaasqmAZZzQ=;
  b=MAULpD5pAC5Q8wxqmWehVyhaXZ1qXV8elfIb/xC7WpLcGDtDv4ZXbR4E
   8mKOq6H+k/chYrtp3PhIlp7WGVZnIl+d/SLWONLQyYyqxWL2GbqHHJNIV
   C69oHBz7WkrMTVlF0FtWPw3fK+VwLJR9woIAsJsy4zjw5W4wlBGvvlsCm
   qq1dFwo7PvFkoFYYv7LPQwWS1upaFCmVcHh4bIJTmKuK0yejQkvXOsiu6
   LS1h1wCeObeIPbu08DPfUxVBCcdgf21MISHPNRpTvHgONlvTzM1tIrsEt
   iKYPvEQee7ZF8hGRZEqBRbzfAPJA97oGfkaJY4khuO+gn6kExm9xPl6ba
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="364119855"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="364119855"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 12:26:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="625099129"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="625099129"
Received: from xshen14-linux.bj.intel.com ([10.238.155.105])
  by fmsmga007.fm.intel.com with ESMTP; 30 Sep 2022 12:26:54 -0700
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     vkoul@kernel.org, fenghua.yu@intel.com, dave.jiang@intel.com,
        dmaengine@vger.kernel.org
Cc:     ramesh.thomas@intel.com, tony.luck@intel.com, tony.zhu@intel.com,
        pei.p.jia@intel.com, xiaochen.shen@intel.com
Subject: [PATCH v2 2/2] dmaengine: idxd: Make max batch size attributes in sysfs invisible for Intel IAA
Date:   Sat,  1 Oct 2022 04:15:28 +0800
Message-Id: <20220930201528.18621-3-xiaochen.shen@intel.com>
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

In current code, dev.max_batch_size and wq.max_batch_size attributes in
sysfs are exposed to user to show or update the values.

From Intel IAA spec [1], Intel IAA does not support batch processing. So
these sysfs attributes should not be supported on IAA device.

Fix this issue by making the attributes of max_batch_size invisible in
sysfs through is_visible() filter when the device is IAA.

Add description in the ABI documentation to mention that the attributes
are not visible when the device does not support batch.

[1]: https://cdrdv2.intel.com/v1/dl/getContent/721858

Fixes: e7184b159dd3 ("dmaengine: idxd: add support for configurable max wq batch size")
Fixes: c52ca478233c ("dmaengine: idxd: add configuration component of driver")
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
---
 .../ABI/stable/sysfs-driver-dma-idxd          |  2 ++
 drivers/dma/idxd/sysfs.c                      | 32 +++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 8e2c2c405db2..69e2d9155e0d 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -22,6 +22,7 @@ Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The largest number of work descriptors in a batch.
+                It's not visible when the device does not support batch.
 
 What:           /sys/bus/dsa/devices/dsa<m>/max_work_queues_size
 Date:           Oct 25, 2019
@@ -205,6 +206,7 @@ KernelVersion:	5.10.0
 Contact:	dmaengine@vger.kernel.org
 Description:	The max batch size for this workqueue. Cannot exceed device
 		max batch size. Configurable parameter.
+		It's not visible when the device does not support batch.
 
 What:		/sys/bus/dsa/devices/wq<m>.<n>/ats_disable
 Date:		Nov 13, 2020
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 7269bd54554f..7909767e9836 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1233,6 +1233,14 @@ static bool idxd_wq_attr_op_config_invisible(struct attribute *attr,
 	       !idxd->hw.wq_cap.op_config;
 }
 
+static bool idxd_wq_attr_max_batch_size_invisible(struct attribute *attr,
+						  struct idxd_device *idxd)
+{
+	/* Intel IAA does not support batch processing, make it invisible */
+	return attr == &dev_attr_wq_max_batch_size.attr &&
+	       idxd->data->type == IDXD_TYPE_IAX;
+}
+
 static umode_t idxd_wq_attr_visible(struct kobject *kobj,
 				    struct attribute *attr, int n)
 {
@@ -1243,6 +1251,9 @@ static umode_t idxd_wq_attr_visible(struct kobject *kobj,
 	if (idxd_wq_attr_op_config_invisible(attr, idxd))
 		return 0;
 
+	if (idxd_wq_attr_max_batch_size_invisible(attr, idxd))
+		return 0;
+
 	return attr->mode;
 }
 
@@ -1533,6 +1544,26 @@ static ssize_t cmd_status_store(struct device *dev, struct device_attribute *att
 }
 static DEVICE_ATTR_RW(cmd_status);
 
+static bool idxd_device_attr_max_batch_size_invisible(struct attribute *attr,
+						      struct idxd_device *idxd)
+{
+	/* Intel IAA does not support batch processing, make it invisible */
+	return attr == &dev_attr_max_batch_size.attr &&
+	       idxd->data->type == IDXD_TYPE_IAX;
+}
+
+static umode_t idxd_device_attr_visible(struct kobject *kobj,
+					struct attribute *attr, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
+
+	if (idxd_device_attr_max_batch_size_invisible(attr, idxd))
+		return 0;
+
+	return attr->mode;
+}
+
 static struct attribute *idxd_device_attributes[] = {
 	&dev_attr_version.attr,
 	&dev_attr_max_groups.attr,
@@ -1560,6 +1591,7 @@ static struct attribute *idxd_device_attributes[] = {
 
 static const struct attribute_group idxd_device_attribute_group = {
 	.attrs = idxd_device_attributes,
+	.is_visible = idxd_device_attr_visible,
 };
 
 static const struct attribute_group *idxd_attribute_groups[] = {
-- 
2.18.4

