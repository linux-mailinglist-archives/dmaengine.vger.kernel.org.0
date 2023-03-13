Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDA16B7EAF
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCMRFV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjCMRE5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:04:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AA0211E4;
        Mon, 13 Mar 2023 10:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678727065; x=1710263065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQA41H+RPAVqxuNbQ0/QsFDmoozKBiZjnSHPBC3zUcc=;
  b=W0BrlNclq1h/WGSF9qCXRdB5CaVUD3QbpseFd2WcsSShOheapm0QDdR9
   M5sq2bdu08nvR9zNLrZ8vBmLWmxEgj7tRzANwZjcqCHgntp5sy7xjMtpi
   4g53FEjAWyUleVFddjyekY1KcKveKOVO8BXgV6Z5Svd8bkvP8iWOhfFmt
   rdc7DzNBcaHlBvxV0IlrdZz7miJ80LHLHcSDhaMhZJmYX/ufH8+JRUu/+
   HyiMM7D91IwUa0YLX/z1zmvcnplWeaDXSkUHbxKU0KVPyDasdoLMD+o1F
   oXzCb3wWOO2/hA/g6MQ0+Tfc2VWgLv+pEVz/voFoTgsKrfp4HkZEOzmZc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="334679621"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="334679621"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:02:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="708950892"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="708950892"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2023 10:02:40 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 02/16] dmaengine: idxd: add event log size sysfs attribute
Date:   Mon, 13 Mar 2023 10:02:05 -0700
Message-Id: <20230313170219.1956012-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230313170219.1956012-1-fenghua.yu@intel.com>
References: <20230313170219.1956012-1-fenghua.yu@intel.com>
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

