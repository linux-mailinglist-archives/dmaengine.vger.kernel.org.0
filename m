Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1CF5BB94B
	for <lists+dmaengine@lfdr.de>; Sat, 17 Sep 2022 18:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIQQNX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Sep 2022 12:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIQQNT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Sep 2022 12:13:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C5C2EF09;
        Sat, 17 Sep 2022 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663431198; x=1694967198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aAb7yIrpsftIB78Rm6FyB5VzOmvfQy5Y3KIOVJs39jM=;
  b=V+TKWJYBYNnOrL6kltjT0+IiYs+a9tObYFDzMpndO1k1IsLwdnywhLzK
   o4GAI7pNTBwFq3oC5K0SGhD2VIjbrESidCrtaWCTt1pTQfscaGKkhwO96
   Yqu71uzqdCppMfP4Uio9lLgLLDaLGmCYJ7CTsigmnzZYQwvPc9+uKJWVJ
   tr6V5CTQ7B7IkCkD1gwAMhAxPiNkN6li24Z806kbS0KU5aD0i/9B+S0qt
   bvcz5Lr0rwN7dmO49hzVAix/UIIHwIhOKYI/CtWIz5617Zx6yPCgLFI2D
   /fiSI7orj7tkpQ0M+7Q5v1MCUJI6xgwKeghjX2wVVXTwYvaXt0+0fJtBI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="286206517"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="286206517"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 09:13:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="686472607"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga004.fm.intel.com with ESMTP; 17 Sep 2022 09:13:14 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 4/5] dmaengine: idxd: add configuration for concurrent work descriptor processing
Date:   Sat, 17 Sep 2022 09:12:21 -0700
Message-Id: <20220917161222.2835172-5-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220917161222.2835172-1-fenghua.yu@intel.com>
References: <20220917161222.2835172-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

Add sysfs knob to allow control of the number of work descriptors that can
be concurrently processed by an engine in the group as a fraction of the
Maximum Work Descriptors in Progress value specified in ENGCAP register.
This control knob is part of toggle for QoS control.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 .../ABI/stable/sysfs-driver-dma-idxd          | 12 +++++
 drivers/dma/idxd/device.c                     | 13 +++--
 drivers/dma/idxd/idxd.h                       |  1 +
 drivers/dma/idxd/registers.h                  | 23 ++++----
 drivers/dma/idxd/sysfs.c                      | 53 +++++++++++++++++++
 5 files changed, 87 insertions(+), 15 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 3f9f93b5e48c..02a721a8ea68 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -266,3 +266,15 @@ Contact:	dmaengine@vger.kernel.org
 Description:	Indicates the number of Read Buffers reserved for the use of
 		engines in the group. See DSA spec v1.2 9.2.18 GRPCFG Read Buffers
 		Reserved.
+
+What:		/sys/bus/dsa/devices/group<m>.<n>/desc_progress_limit
+Date:		Sept 14, 2022
+KernelVersion:	6.0.0
+Contact:	dmaengine@vger.kernel.org
+Description:	Allows control of the number of work descriptors that can be
+		concurrently processed by an engine in the group as a fraction
+		of the Maximum Work Descriptors in Progress value specified in
+		the ENGCAP register. The acceptable values are 0 (default),
+		1 (1/2 of max value), 2 (1/4 of the max value), and 3 (1/8 of
+		the max value). It's visible only on platforms that support
+		the capability.
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 81a81b8d769d..3aa583f70312 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -707,6 +707,7 @@ static void idxd_groups_clear_state(struct idxd_device *idxd)
 			group->tc_a = -1;
 			group->tc_b = -1;
 		}
+		group->desc_progress_limit = 0;
 	}
 }
 
@@ -763,10 +764,10 @@ static void idxd_group_config_write(struct idxd_group *group)
 
 	/* setup GRPFLAGS */
 	grpcfg_offset = GRPFLGCFG_OFFSET(idxd, group->id);
-	iowrite32(group->grpcfg.flags.bits, idxd->reg_base + grpcfg_offset);
-	dev_dbg(dev, "GRPFLAGS flags[%d: %#x]: %#x\n",
+	iowrite64(group->grpcfg.flags.bits, idxd->reg_base + grpcfg_offset);
+	dev_dbg(dev, "GRPFLAGS flags[%d: %#x]: %#llx\n",
 		group->id, grpcfg_offset,
-		ioread32(idxd->reg_base + grpcfg_offset));
+		ioread64(idxd->reg_base + grpcfg_offset));
 }
 
 static int idxd_groups_config_write(struct idxd_device *idxd)
@@ -927,6 +928,8 @@ static void idxd_group_flags_setup(struct idxd_device *idxd)
 			group->grpcfg.flags.rdbufs_allowed = group->rdbufs_allowed;
 		else
 			group->grpcfg.flags.rdbufs_allowed = idxd->max_rdbufs;
+
+		group->grpcfg.flags.desc_progress_limit = group->desc_progress_limit;
 	}
 }
 
@@ -1109,8 +1112,8 @@ static void idxd_group_load_config(struct idxd_group *group)
 	}
 
 	grpcfg_offset = GRPFLGCFG_OFFSET(idxd, group->id);
-	group->grpcfg.flags.bits = ioread32(idxd->reg_base + grpcfg_offset);
-	dev_dbg(dev, "GRPFLAGS flags[%d: %#x]: %#x\n",
+	group->grpcfg.flags.bits = ioread64(idxd->reg_base + grpcfg_offset);
+	dev_dbg(dev, "GRPFLAGS flags[%d: %#x]: %#llx\n",
 		group->id, grpcfg_offset, group->grpcfg.flags.bits);
 }
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index ba877ad31932..058010be0f87 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -95,6 +95,7 @@ struct idxd_group {
 	u8 rdbufs_reserved;
 	int tc_a;
 	int tc_b;
+	int desc_progress_limit;
 };
 
 struct idxd_pmu {
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 7b95be8f0f64..2cc2543edd58 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -68,7 +68,8 @@ union group_cap_reg {
 		u64 total_rdbufs:8;	/* formerly total_tokens */
 		u64 rdbuf_ctrl:1;	/* formerly token_en */
 		u64 rdbuf_limit:1;	/* formerly token_limit */
-		u64 rsvd:46;
+		u64 progress_limit:1;	/* descriptor and batch descriptor */
+		u64 rsvd:45;
 	};
 	u64 bits;
 } __packed;
@@ -288,16 +289,18 @@ union msix_perm {
 
 union group_flags {
 	struct {
-		u32 tc_a:3;
-		u32 tc_b:3;
-		u32 rsvd:1;
-		u32 use_rdbuf_limit:1;
-		u32 rdbufs_reserved:8;
-		u32 rsvd2:4;
-		u32 rdbufs_allowed:8;
-		u32 rsvd3:4;
+		u64 tc_a:3;
+		u64 tc_b:3;
+		u64 rsvd:1;
+		u64 use_rdbuf_limit:1;
+		u64 rdbufs_reserved:8;
+		u64 rsvd2:4;
+		u64 rdbufs_allowed:8;
+		u64 rsvd3:4;
+		u64 desc_progress_limit:2;
+		u64 rsvd4:30;
 	};
-	u32 bits;
+	u64 bits;
 } __packed;
 
 struct grpcfg {
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 3bb1ea02a338..3e655a3a4c7c 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -443,6 +443,37 @@ static struct device_attribute dev_attr_group_traffic_class_b =
 		__ATTR(traffic_class_b, 0644, group_traffic_class_b_show,
 		       group_traffic_class_b_store);
 
+static ssize_t group_desc_progress_limit_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct idxd_group *group = confdev_to_group(dev);
+
+	return sysfs_emit(buf, "%d\n", group->desc_progress_limit);
+}
+
+static ssize_t group_desc_progress_limit_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct idxd_group *group = confdev_to_group(dev);
+	int val, rc;
+
+	rc = kstrtoint(buf, 10, &val);
+	if (rc < 0)
+		return -EINVAL;
+
+	if (val & ~GENMASK(1, 0))
+		return -EINVAL;
+
+	group->desc_progress_limit = val;
+	return count;
+}
+
+static struct device_attribute dev_attr_group_desc_progress_limit =
+		__ATTR(desc_progress_limit, 0644, group_desc_progress_limit_show,
+		       group_desc_progress_limit_store);
+
 static struct attribute *idxd_group_attributes[] = {
 	&dev_attr_group_work_queues.attr,
 	&dev_attr_group_engines.attr,
@@ -454,11 +485,33 @@ static struct attribute *idxd_group_attributes[] = {
 	&dev_attr_group_read_buffers_reserved.attr,
 	&dev_attr_group_traffic_class_a.attr,
 	&dev_attr_group_traffic_class_b.attr,
+	&dev_attr_group_desc_progress_limit.attr,
 	NULL,
 };
 
+static bool idxd_group_attr_progress_limit_invisible(struct attribute *attr,
+						     struct idxd_device *idxd)
+{
+	return attr == &dev_attr_group_desc_progress_limit.attr &&
+	       !idxd->hw.group_cap.progress_limit;
+}
+
+static umode_t idxd_group_attr_visible(struct kobject *kobj,
+				       struct attribute *attr, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct idxd_group *group = confdev_to_group(dev);
+	struct idxd_device *idxd = group->idxd;
+
+	if (idxd_group_attr_progress_limit_invisible(attr, idxd))
+		return 0;
+
+	return attr->mode;
+}
+
 static const struct attribute_group idxd_group_attribute_group = {
 	.attrs = idxd_group_attributes,
+	.is_visible = idxd_group_attr_visible,
 };
 
 static const struct attribute_group *idxd_group_attribute_groups[] = {
-- 
2.32.0

