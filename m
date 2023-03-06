Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395A56AC882
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 17:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCFQp5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 11:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjCFQoq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 11:44:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344733E0B9;
        Mon,  6 Mar 2023 08:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678121052; x=1709657052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7mSzveSNY4kQknpqyVT1O/9858OwAEHn5l3ARji8dAY=;
  b=OfDxNkdPUD3viI0Z/KfUkMLfwX4gGiKs/rRMhQP2WeRr/A+U/LaYKjpg
   5GicFpOik0CHwkgfDhgBEsszrDyu/HsVcqy4aaM02fSTLUIBYDheydy36
   Obmkwwv7udFJ3mgwzqMRB3oljDxHy74k6R5JpVKJuhnUxv4fD0GKQwp/v
   d3lv/J3pR1vRRdv0Hu+Z2iCKFJmaaOHRrC1EjNEuTHSNZhzG+w71cwURy
   B50UjetpjF4/XWIzkcw0trKbDx+fvfKfYbzsjwrDYWAdMbBm9mELGVFEP
   mA7tdN9DkkykRLcyp3JQXD6/sthGrGa4c0TZcbxf1x4qM6NRllHUNCsbU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398181189"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398181189"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 08:31:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669504562"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="669504562"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 08:31:59 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 15/16] dmaengine: idxd: add pid to exported sysfs attribute for opened file
Date:   Mon,  6 Mar 2023 08:31:37 -0800
Message-Id: <20230306163138.587484-16-fenghua.yu@intel.com>
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

Provide the pid of the application for the opened file. This allows the
monitor daemon to easily correlate which app opened the file and easily
kill the app by pid if that is desired action.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 Documentation/ABI/stable/sysfs-driver-dma-idxd |  8 ++++++++
 drivers/dma/idxd/cdev.c                        | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 73ab86196a41..5d0df57f5298 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -335,3 +335,11 @@ Description:	Show the number of Completion Record (CR) faults failures that this
 		driver cannot fault in the address for the CR. Typically this is caused
 		by a bad address programmed in the submitted descriptor or a malicious
 		submitter is using bad CR address on purpose.
+
+What:		/sys/bus/dsa/devices/wq<m>.<n>/dsa<x>\!wq<m>.<n>/file<y>/pid
+Date:		Sept 14, 2022
+KernelVersion:	6.4.0
+Contact:	dmaengine@vger.kernel.org
+Description:	Show the process id of the application that opened the file. This is
+		helpful information for a monitor daemon that wants to kill the
+		application that opened the file.
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 9fc6565bf807..e124f0628f1c 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -47,6 +47,7 @@ struct idxd_user_context {
 	struct idxd_dev idxd_dev;
 	u64 counters[COUNTER_MAX];
 	int id;
+	pid_t pid;
 };
 
 static void idxd_cdev_evl_drain_pasid(struct idxd_wq *wq, u32 pasid);
@@ -76,9 +77,18 @@ static ssize_t cr_fault_failures_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(cr_fault_failures);
 
+static ssize_t pid_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct idxd_user_context *ctx = dev_to_uctx(dev);
+
+	return sysfs_emit(buf, "%u\n", ctx->pid);
+}
+static DEVICE_ATTR_RO(pid);
+
 static struct attribute *cdev_file_attributes[] = {
 	&dev_attr_cr_faults.attr,
 	&dev_attr_cr_fault_failures.attr,
+	&dev_attr_pid.attr,
 	NULL
 };
 
@@ -236,6 +246,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 
 	ctx->wq = wq;
 	filp->private_data = ctx;
+	ctx->pid = current->pid;
 
 	if (device_user_pasid_enabled(idxd)) {
 		sva = iommu_sva_bind_device(dev, current->mm);
-- 
2.37.1

