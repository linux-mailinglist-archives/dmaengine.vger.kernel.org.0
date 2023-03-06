Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDAB6AC871
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 17:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjCFQoU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 11:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCFQoG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 11:44:06 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A5E11656;
        Mon,  6 Mar 2023 08:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678121021; x=1709657021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQA41H+RPAVqxuNbQ0/QsFDmoozKBiZjnSHPBC3zUcc=;
  b=NbXMKRO57ZotgptSBcTa13gjerLNeG2hDicOfbOoNk94eF4EYrRtRS35
   tXu4F+WTjP+Pmq4eXKZzHOTgBArguGAa3plgPZ0IDaux7yL9tSVBuTaej
   1DbgNxlT/8uyq3y2n+vLi6kS4GkAnnnkqKypO0FoOo+q2rQCNtRjGF0re
   79lYTxSdP2u35l9wx4h/jcWzgPrQUs5TNz4cBwBjIS0rOGIAQIZi7ylCO
   u6NrsRsZtC/SCLX1GMCMscHyqE6d9W5UQPp8ENfb0ui0rCrEUFgPbLmr3
   GVe3Nbh23xk+0qFyIz65pbXrSkMcDg7TLERcMlluPCV28f72cS8x4jMtO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398181144"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398181144"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 08:31:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669504487"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="669504487"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 08:31:55 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 02/16] dmaengine: idxd: add event log size sysfs attribute
Date:   Mon,  6 Mar 2023 08:31:24 -0800
Message-Id: <20230306163138.587484-3-fenghua.yu@intel.com>
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

Add support for changing of the event log size. Event log is a
feature added to DSA 2.0 hardware to improve error reporting.
It supersedes the SWERROR register on DSA 1.0 hardware and hope
to prevent loss of reported errors.

The error log size determines how many error entries supported for
the device. It can be configured by the user via sysfs attribute.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 .../ABI/stable/sysfs-driver-dma-idxd          |  8 +++
 drivers/dma/idxd/idxd.h                       |  5 ++
 drivers/dma/idxd/init.c                       | 23 ++++++++
 drivers/dma/idxd/registers.h                  |  7 ++-
 drivers/dma/idxd/sysfs.c                      | 52 +++++++++++++++++++
 5 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index d5e3dd3d8434..e01916611452 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -144,6 +144,14 @@ Description:	IAA (IAX) capability mask. Exported to user space for application
 		consumption. This attribute should only be visible on IAA devices
 		that are version 2 or later.
 
+What:		/sys/bus/dsa/devices/dsa<m>/event_log_size
+Date:		Sept 14, 2022
+KernelVersion: 6.4.0
+Contact:	dmaengine@vger.kernel.org
+Description:	The event log size to be configured. Default is 64 entries and
+		occupies 4k size if the evl entry is 64 bytes. It's visible
+		only on platforms that support the capability.
+
 What:		/sys/bus/dsa/devices/wq<m>.<n>/block_on_fault
 Date:		Oct 27, 2020
 KernelVersion:	5.11.0
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index eca2c9d76db6..2a71273f1822 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -261,6 +261,10 @@ struct idxd_driver_data {
 	int align;
 };
 
+struct idxd_evl {
+	u16 size;
+};
+
 struct idxd_device {
 	struct idxd_dev idxd_dev;
 	struct idxd_driver_data *data;
@@ -317,6 +321,7 @@ struct idxd_device {
 	struct idxd_pmu *idxd_pmu;
 
 	unsigned long *opcap_bmap;
+	struct idxd_evl *evl;
 };
 
 /* IDXD software descriptor */
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index a408fc91144d..d1fb01c115d8 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -332,6 +332,23 @@ static void idxd_cleanup_internals(struct idxd_device *idxd)
 	destroy_workqueue(idxd->wq);
 }
 
+static int idxd_init_evl(struct idxd_device *idxd)
+{
+	struct device *dev = &idxd->pdev->dev;
+	struct idxd_evl *evl;
+
+	if (idxd->hw.gen_cap.evl_support == 0)
+		return 0;
+
+	evl = kzalloc_node(sizeof(*evl), GFP_KERNEL, dev_to_node(dev));
+	if (!evl)
+		return -ENOMEM;
+
+	evl->size = IDXD_EVL_SIZE_MIN;
+	idxd->evl = evl;
+	return 0;
+}
+
 static int idxd_setup_internals(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -357,8 +374,14 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 		goto err_wkq_create;
 	}
 
+	rc = idxd_init_evl(idxd);
+	if (rc < 0)
+		goto err_evl;
+
 	return 0;
 
+ err_evl:
+	destroy_workqueue(idxd->wq);
  err_wkq_create:
 	for (i = 0; i < idxd->max_groups; i++)
 		put_device(group_confdev(idxd->groups[i]));
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 338289a66f00..ea3a499a3c3c 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -31,7 +31,9 @@ union gen_cap_reg {
 		u64 rsvd:3;
 		u64 dest_readback:1;
 		u64 drain_readback:1;
-		u64 rsvd2:6;
+		u64 rsvd2:3;
+		u64 evl_support:2;
+		u64 rsvd4:1;
 		u64 max_xfer_shift:5;
 		u64 max_batch_shift:4;
 		u64 max_ims_mult:6;
@@ -297,6 +299,9 @@ union iaa_cap_reg {
 
 #define IDXD_IAACAP_OFFSET	0x180
 
+#define IDXD_EVL_SIZE_MIN	0x0040
+#define IDXD_EVL_SIZE_MAX	0xffff
+
 union msix_perm {
 	struct {
 		u32 rsvd:2;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 2eba8cab25a1..85644e5bde83 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1573,6 +1573,46 @@ static ssize_t iaa_cap_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(iaa_cap);
 
+static ssize_t event_log_size_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct idxd_device *idxd = confdev_to_idxd(dev);
+
+	if (!idxd->evl)
+		return -EOPNOTSUPP;
+
+	return sysfs_emit(buf, "%u\n", idxd->evl->size);
+}
+
+static ssize_t event_log_size_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct idxd_device *idxd = confdev_to_idxd(dev);
+	unsigned long val;
+	int rc;
+
+	if (!idxd->evl)
+		return -EOPNOTSUPP;
+
+	rc = kstrtoul(buf, 10, &val);
+	if (rc < 0)
+		return -EINVAL;
+
+	if (idxd->state == IDXD_DEV_ENABLED)
+		return -EPERM;
+
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		return -EPERM;
+
+	if (val < IDXD_EVL_SIZE_MIN || val > IDXD_EVL_SIZE_MAX)
+		return -EINVAL;
+
+	idxd->evl->size = val;
+	return count;
+}
+static DEVICE_ATTR_RW(event_log_size);
+
 static bool idxd_device_attr_max_batch_size_invisible(struct attribute *attr,
 						      struct idxd_device *idxd)
 {
@@ -1603,6 +1643,13 @@ static bool idxd_device_attr_iaa_cap_invisible(struct attribute *attr,
 	       idxd->hw.version < DEVICE_VERSION_2);
 }
 
+static bool idxd_device_attr_event_log_size_invisible(struct attribute *attr,
+						      struct idxd_device *idxd)
+{
+	return (attr == &dev_attr_event_log_size.attr &&
+		!idxd->hw.gen_cap.evl_support);
+}
+
 static umode_t idxd_device_attr_visible(struct kobject *kobj,
 					struct attribute *attr, int n)
 {
@@ -1618,6 +1665,9 @@ static umode_t idxd_device_attr_visible(struct kobject *kobj,
 	if (idxd_device_attr_iaa_cap_invisible(attr, idxd))
 		return 0;
 
+	if (idxd_device_attr_event_log_size_invisible(attr, idxd))
+		return 0;
+
 	return attr->mode;
 }
 
@@ -1644,6 +1694,7 @@ static struct attribute *idxd_device_attributes[] = {
 	&dev_attr_cdev_major.attr,
 	&dev_attr_cmd_status.attr,
 	&dev_attr_iaa_cap.attr,
+	&dev_attr_event_log_size.attr,
 	NULL,
 };
 
@@ -1665,6 +1716,7 @@ static void idxd_conf_device_release(struct device *dev)
 	bitmap_free(idxd->wq_enable_map);
 	kfree(idxd->wqs);
 	kfree(idxd->engines);
+	kfree(idxd->evl);
 	ida_free(&idxd_ida, idxd->id);
 	bitmap_free(idxd->opcap_bmap);
 	kfree(idxd);
-- 
2.37.1

