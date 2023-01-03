Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DB265C407
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jan 2023 17:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbjACQfa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Jan 2023 11:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238133AbjACQfV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Jan 2023 11:35:21 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4EFFF0
        for <dmaengine@vger.kernel.org>; Tue,  3 Jan 2023 08:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672763721; x=1704299721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CzlrQZIG0V7+ei7VGnHcABod19UcTqUVLr+R/QYm1iA=;
  b=VpmdNL81CZuFkf8gHzZQ4NUFA8+iZ3SSPgoYT7y1rb3sK14lp0iTgfiR
   UZKig17toBK8b23z0X/EBbaEoUSD4Th++Kk/cw2DMDaNxZQH1KCIaoa+1
   X3+NvyK8LvHEh4iRIQBnxNTsafrFRUu7YkAmMtHs4bEflr90aMWKmS857
   MqZ41kgH1vRC7QpF/9+vy0sV1KHAFzVfMF4j1NB3TpJCnSN4EXF0tF6Lf
   vy6T1/eETea3oCefwm7ytJU5HAnL4Rgn4LQxSde+XIohS5zDUzWLQeXLC
   4EdnzWmfoj1iCitt/9qNI72Y31DhBoewylpUsMv9W2I+6/jLsoI0Mn3NT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="302072347"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="302072347"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:35:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="604858585"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="604858585"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga003.jf.intel.com with ESMTP; 03 Jan 2023 08:35:17 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "Fenghua Yu" <fenghua.yu@intel.com>, dmaengine@vger.kernel.org,
        Tony Zhu <tony.zhu@intel.com>
Subject: [PATCH 16/17] dmaengine: idxd: add pid to exported sysfs attribute for opened file
Date:   Tue,  3 Jan 2023 08:35:04 -0800
Message-Id: <20230103163505.1569356-17-fenghua.yu@intel.com>
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
index a3ad253efbbc..be12612bd76e 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -327,3 +327,11 @@ Description:	Show the number of Completion Record (CR) faults failures that this
 		driver cannot fault in the address for the CR. Typically this is caused
 		by a bad address programmed in the submitted descriptor or a malicious
 		submitter is using bad CR address on purpose.
+
+What:		/sys/bus/dsa/devices/wq<m>.<n>/dsa<x>\!wq<m>.<n>/file<y>/pid
+Date:		Sept 14, 2022
+KernelVersion:	6.2.0
+Contact:	dmaengine@vger.kernel.org
+Description:	Show the process id of the application that opened the file. This is
+		helpful information for a monitor daemon that wants to kill the
+		application that opened the file.
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 121231a89060..7a82ce25c505 100644
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
2.32.0

