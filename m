Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38F765C401
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jan 2023 17:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbjACQfV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Jan 2023 11:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237830AbjACQfR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Jan 2023 11:35:17 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A849F117D
        for <dmaengine@vger.kernel.org>; Tue,  3 Jan 2023 08:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672763716; x=1704299716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nu8TEDSnT8dGxQ+h9irNqBjORhczGl74ch1l5/VNNw4=;
  b=eyQax2kAZJ7tXfmjWu1x4eDUCRmMaxVOSz2W3Zd5xqKNZz0Lh5gplyei
   i6vPyl30fhqWbxyRVQM4z0bSyKeMpFCdam8OpAjPwUFjRuISYbpjDKWy7
   oTfnNMIZ1DwTdZU6cD6St1ez8t2J33O92DfebBtnPjmML83XYIc1l1ulF
   qPkOjOs6f9fVPjC2yP4ePChDQXOp52mPZ/1e94NYf5fZIwzA5OvSjIpbs
   VLQU8jxzTppQ4WG+m1jfLtHraffXFBffY7mkDgCCpyh3Q0PTTWbgiL8UV
   Alm5QvYhfl38GjNXk7cIbeOgLbq8hYFIqX9r15Qa6yiHF6h6d0bMY4Lyq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="302072293"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="302072293"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:35:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="604858460"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="604858460"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga003.jf.intel.com with ESMTP; 03 Jan 2023 08:35:10 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "Fenghua Yu" <fenghua.yu@intel.com>, dmaengine@vger.kernel.org,
        Tony Zhu <tony.zhu@intel.com>
Subject: [PATCH 02/17] dmaengine: idxd: add event log size sysfs attribute
Date:   Tue,  3 Jan 2023 08:34:50 -0800
Message-Id: <20230103163505.1569356-3-fenghua.yu@intel.com>
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
index 3becc9a82bdf..f7acb14bf255 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -136,6 +136,14 @@ Description:	The last executed device administrative command's status/error.
 		Also last configuration error overloaded.
 		Writing to it will clear the status.
 
+What:		/sys/bus/dsa/devices/dsa<m>/event_log_size
+Date:		Sept 14, 2022
+KernelVersion: 6.2.0
+Contact:	dmaengine@vger.kernel.org
+Description:	The event log size to be configured. Default is 64 entries and
+		occupies 4k size if the evl entry is 64 bytes. It's visible
+		only on platforms that support the capability.
+
 What:		/sys/bus/dsa/devices/wq<m>.<n>/block_on_fault
 Date:		Oct 27, 2020
 KernelVersion:	5.11.0
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 7ced8d283d98..f42f87c490b4 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -260,6 +260,10 @@ struct idxd_driver_data {
 	int align;
 };
 
+struct idxd_evl {
+	u16 size;
+};
+
 struct idxd_device {
 	struct idxd_dev idxd_dev;
 	struct idxd_driver_data *data;
@@ -316,6 +320,7 @@ struct idxd_device {
 	struct idxd_pmu *idxd_pmu;
 
 	unsigned long *opcap_bmap;
+	struct idxd_evl *evl;
 };
 
 /* IDXD software descriptor */
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 529ea09c9094..3f4540741d11 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -327,6 +327,23 @@ static void idxd_cleanup_internals(struct idxd_device *idxd)
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
@@ -352,8 +369,14 @@ static int idxd_setup_internals(struct idxd_device *idxd)
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
index fe3b8d04f9db..b36a743a94a4 100644
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
@@ -276,6 +278,9 @@ union sw_err_reg {
 	u64 bits[4];
 } __packed;
 
+#define IDXD_EVL_SIZE_MIN	0x0040
+#define IDXD_EVL_SIZE_MAX	0xffff
+
 union msix_perm {
 	struct {
 		u32 rsvd:2;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 3229dfc78650..3e27cd4d189f 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1563,6 +1563,46 @@ static ssize_t cmd_status_store(struct device *dev, struct device_attribute *att
 }
 static DEVICE_ATTR_RW(cmd_status);
 
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
@@ -1585,6 +1625,13 @@ static bool idxd_device_attr_read_buffers_invisible(struct attribute *attr,
 		idxd->data->type == IDXD_TYPE_IAX;
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
@@ -1597,6 +1644,9 @@ static umode_t idxd_device_attr_visible(struct kobject *kobj,
 	if (idxd_device_attr_read_buffers_invisible(attr, idxd))
 		return 0;
 
+	if (idxd_device_attr_event_log_size_invisible(attr, idxd))
+		return 0;
+
 	return attr->mode;
 }
 
@@ -1622,6 +1672,7 @@ static struct attribute *idxd_device_attributes[] = {
 	&dev_attr_read_buffer_limit.attr,
 	&dev_attr_cdev_major.attr,
 	&dev_attr_cmd_status.attr,
+	&dev_attr_event_log_size.attr,
 	NULL,
 };
 
@@ -1643,6 +1694,7 @@ static void idxd_conf_device_release(struct device *dev)
 	bitmap_free(idxd->wq_enable_map);
 	kfree(idxd->wqs);
 	kfree(idxd->engines);
+	kfree(idxd->evl);
 	ida_free(&idxd_ida, idxd->id);
 	bitmap_free(idxd->opcap_bmap);
 	kfree(idxd);
-- 
2.32.0

