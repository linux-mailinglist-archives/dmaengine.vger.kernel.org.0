Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D116DB551
	for <lists+dmaengine@lfdr.de>; Fri,  7 Apr 2023 22:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjDGUcK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Apr 2023 16:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjDGUbl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Apr 2023 16:31:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4543CA1C;
        Fri,  7 Apr 2023 13:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680899493; x=1712435493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+iqZKLVe13EZnrppVcirChYzm/SHpJjyJP0Q/X+NHWw=;
  b=IYvY1FdcVldW65is41Ex1kamAWr9JppHMMGzaJypCG01Quo34pfvGtFV
   hNJCKO1bXmLOaoOWT/0YzDjy07irNqZXQ1BQo45NJkoQDW4UNPSDeLlNl
   XlkhUOgWfLTdNiVCY9BhozIOcoUCMu4sGrWBKeFEh/xhAAASwNH2On8ip
   CyNqcAbrSOqPSGb6DNifdaqEFy2x4pGHkVk8GNHfVBjDtbAHigH3fRy7X
   rNm28rz8aev/XvPYc6LKIJrg13SIptkYWxNecLTL3Tw9odkJgTg3Q5tXJ
   nOctgVFhGsRaNtY19DvnULnLH2hr9jm6UGdJp76kzLDjDlpwSBAgtnd3w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="408196880"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="408196880"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 13:31:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681125903"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="681125903"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 07 Apr 2023 13:31:28 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 14/16] dmaengine: idxd: expose fault counters to sysfs
Date:   Fri,  7 Apr 2023 13:31:41 -0700
Message-Id: <20230407203143.2189681-15-fenghua.yu@intel.com>
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

Expose cr_faults and cr_fault_failures counters to the user space. This
allows a user app to keep track of how many fault the application is
causing with the completion record (CR) and also the number of failures
of the CR writeback. Having a high number of cr_fault_failures is bad as
the app is submitting descriptors with the CR addresses that are bad. User
monitoring daemon may want to consider killing the application as it may be
malicious and attempting to flood the device event log.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 .../ABI/stable/sysfs-driver-dma-idxd          | 17 +++++++
 drivers/dma/idxd/cdev.c                       | 46 +++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index e01916611452..73ab86196a41 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -318,3 +318,20 @@ Description:	Allows control of the number of batch descriptors that can be
 		1 (1/2 of max value), 2 (1/4 of the max value), and 3 (1/8 of
 		the max value). It's visible only on platforms that support
 		the capability.
+
+What:		/sys/bus/dsa/devices/wq<m>.<n>/dsa<x>\!wq<m>.<n>/file<y>/cr_faults
+Date:		Sept 14, 2022
+KernelVersion:	6.4.0
+Contact:	dmaengine@vger.kernel.org
+Description:	Show the number of Completion Record (CR) faults this application
+		has caused.
+
+What:		/sys/bus/dsa/devices/wq<m>.<n>/dsa<x>\!wq<m>.<n>/file<y>/cr_fault_failures
+Date:		Sept 14, 2022
+KernelVersion:	6.4.0
+Contact:	dmaengine@vger.kernel.org
+Description:	Show the number of Completion Record (CR) faults failures that this
+		application has caused. The failure counter is incremented when the
+		driver cannot fault in the address for the CR. Typically this is caused
+		by a bad address programmed in the submitted descriptor or a malicious
+		submitter is using bad CR address on purpose.
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index e07411053e21..2fb905f2545b 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -61,6 +61,51 @@ static inline struct idxd_user_context *dev_to_uctx(struct device *dev)
 	return container_of(idxd_dev, struct idxd_user_context, idxd_dev);
 }
 
+static ssize_t cr_faults_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct idxd_user_context *ctx = dev_to_uctx(dev);
+
+	return sysfs_emit(buf, "%llu\n", ctx->counters[COUNTER_FAULTS]);
+}
+static DEVICE_ATTR_RO(cr_faults);
+
+static ssize_t cr_fault_failures_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct idxd_user_context *ctx = dev_to_uctx(dev);
+
+	return sysfs_emit(buf, "%llu\n", ctx->counters[COUNTER_FAULT_FAILS]);
+}
+static DEVICE_ATTR_RO(cr_fault_failures);
+
+static struct attribute *cdev_file_attributes[] = {
+	&dev_attr_cr_faults.attr,
+	&dev_attr_cr_fault_failures.attr,
+	NULL
+};
+
+static umode_t cdev_file_attr_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct idxd_user_context *ctx = dev_to_uctx(dev);
+	struct idxd_wq *wq = ctx->wq;
+
+	if (!wq_pasid_enabled(wq))
+		return 0;
+
+	return a->mode;
+}
+
+static const struct attribute_group cdev_file_attribute_group = {
+	.attrs = cdev_file_attributes,
+	.is_visible = cdev_file_attr_visible,
+};
+
+static const struct attribute_group *cdev_file_attribute_groups[] = {
+	&cdev_file_attribute_group,
+	NULL
+};
+
 static void idxd_file_dev_release(struct device *dev)
 {
 	struct idxd_user_context *ctx = dev_to_uctx(dev);
@@ -100,6 +145,7 @@ static void idxd_file_dev_release(struct device *dev)
 static struct device_type idxd_cdev_file_type = {
 	.name = "idxd_file",
 	.release = idxd_file_dev_release,
+	.groups = cdev_file_attribute_groups,
 };
 
 static void idxd_cdev_dev_release(struct device *dev)
-- 
2.37.1

