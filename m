Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314A35BB94A
	for <lists+dmaengine@lfdr.de>; Sat, 17 Sep 2022 18:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIQQNW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Sep 2022 12:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiIQQNT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Sep 2022 12:13:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E2D2EF14;
        Sat, 17 Sep 2022 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663431198; x=1694967198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JO+oLYND6Ukf6p3x84OrVXmziEpNarXqa1kze0fLaLM=;
  b=WnY2dLZq+eoijYrfySyUP+5PH9K+TBqGYxjpzmcRlgZrukSUx9/RCp6i
   1gEr90xRSZh8fRYsAzUhrMR6ZKBX6HfL2P0CLlJUjZZYvKeuAGaaPUgpT
   0gyk+GuPCI4z0cCTfXEmyvmJvoqermnwSh+EiE5VL5BJtNH1BaJr2/nn6
   FUyY9RqTf5cCMwTXiZYTAGEBT9TD6fg9+aal9s0VZVr0r1Yp1ALnC9bFg
   ihJ+3xMyqyiCPQyw6vtUxqj4YtdPyCUYrpPUB9MojqCfbYSrLYhSsMuFs
   m7NWg3mvnFH6M6jWNtQZqMfn+B4qJvgpsUkF3FxPwadN7VCkqPNgPIikZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="286206518"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="286206518"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 09:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="686472610"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga004.fm.intel.com with ESMTP; 17 Sep 2022 09:13:14 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 5/5] dmaengine: idxd: add configuration for concurrent batch descriptor processing
Date:   Sat, 17 Sep 2022 09:12:22 -0700
Message-Id: <20220917161222.2835172-6-fenghua.yu@intel.com>
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

Add sysfs knob to allow control of the number of batch descriptors that can
be concurrently processed by an engine in the group as a fraction of the
Maximum Work Descriptors in Progress value specfied in ENGCAP register.
This control knob is part of toggle for QoS control.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 .../ABI/stable/sysfs-driver-dma-idxd          | 12 +++++++
 drivers/dma/idxd/device.c                     |  2 ++
 drivers/dma/idxd/idxd.h                       |  1 +
 drivers/dma/idxd/registers.h                  |  4 ++-
 drivers/dma/idxd/sysfs.c                      | 36 +++++++++++++++++--
 5 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 02a721a8ea68..8e2c2c405db2 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -278,3 +278,15 @@ Description:	Allows control of the number of work descriptors that can be
 		1 (1/2 of max value), 2 (1/4 of the max value), and 3 (1/8 of
 		the max value). It's visible only on platforms that support
 		the capability.
+
+What:		/sys/bus/dsa/devices/group<m>.<n>/batch_progress_limit
+Date:		Sept 14, 2022
+KernelVersion:	6.0.0
+Contact:	dmaengine@vger.kernel.org
+Description:	Allows control of the number of batch descriptors that can be
+		concurrently processed by an engine in the group as a fraction
+		of the Maximum Batch Descriptors in Progress value specified in
+		the ENGCAP register. The acceptable values are 0 (default),
+		1 (1/2 of max value), 2 (1/4 of the max value), and 3 (1/8 of
+		the max value). It's visible only on platforms that support
+		the capability.
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 3aa583f70312..7a9f3110552b 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -708,6 +708,7 @@ static void idxd_groups_clear_state(struct idxd_device *idxd)
 			group->tc_b = -1;
 		}
 		group->desc_progress_limit = 0;
+		group->batch_progress_limit = 0;
 	}
 }
 
@@ -930,6 +931,7 @@ static void idxd_group_flags_setup(struct idxd_device *idxd)
 			group->grpcfg.flags.rdbufs_allowed = idxd->max_rdbufs;
 
 		group->grpcfg.flags.desc_progress_limit = group->desc_progress_limit;
+		group->grpcfg.flags.batch_progress_limit = group->batch_progress_limit;
 	}
 }
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 058010be0f87..8035c7982f93 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -96,6 +96,7 @@ struct idxd_group {
 	int tc_a;
 	int tc_b;
 	int desc_progress_limit;
+	int batch_progress_limit;
 };
 
 struct idxd_pmu {
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 2cc2543edd58..fe3b8d04f9db 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -298,7 +298,9 @@ union group_flags {
 		u64 rdbufs_allowed:8;
 		u64 rsvd3:4;
 		u64 desc_progress_limit:2;
-		u64 rsvd4:30;
+		u64 rsvd4:2;
+		u64 batch_progress_limit:2;
+		u64 rsvd5:26;
 	};
 	u64 bits;
 } __packed;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 3e655a3a4c7c..88d2cac316fe 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -474,6 +474,36 @@ static struct device_attribute dev_attr_group_desc_progress_limit =
 		__ATTR(desc_progress_limit, 0644, group_desc_progress_limit_show,
 		       group_desc_progress_limit_store);
 
+static ssize_t group_batch_progress_limit_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct idxd_group *group = confdev_to_group(dev);
+
+	return sysfs_emit(buf, "%d\n", group->batch_progress_limit);
+}
+
+static ssize_t group_batch_progress_limit_store(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t count)
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
+	group->batch_progress_limit = val;
+	return count;
+}
+
+static struct device_attribute dev_attr_group_batch_progress_limit =
+		__ATTR(batch_progress_limit, 0644, group_batch_progress_limit_show,
+		       group_batch_progress_limit_store);
 static struct attribute *idxd_group_attributes[] = {
 	&dev_attr_group_work_queues.attr,
 	&dev_attr_group_engines.attr,
@@ -486,14 +516,16 @@ static struct attribute *idxd_group_attributes[] = {
 	&dev_attr_group_traffic_class_a.attr,
 	&dev_attr_group_traffic_class_b.attr,
 	&dev_attr_group_desc_progress_limit.attr,
+	&dev_attr_group_batch_progress_limit.attr,
 	NULL,
 };
 
 static bool idxd_group_attr_progress_limit_invisible(struct attribute *attr,
 						     struct idxd_device *idxd)
 {
-	return attr == &dev_attr_group_desc_progress_limit.attr &&
-	       !idxd->hw.group_cap.progress_limit;
+	return (attr == &dev_attr_group_desc_progress_limit.attr ||
+		attr == &dev_attr_group_batch_progress_limit.attr) &&
+		!idxd->hw.group_cap.progress_limit;
 }
 
 static umode_t idxd_group_attr_visible(struct kobject *kobj,
-- 
2.32.0

