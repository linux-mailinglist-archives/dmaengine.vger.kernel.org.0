Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000A96B7EDB
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjCMRHK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjCMRGl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:06:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6A87F01F;
        Mon, 13 Mar 2023 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678727164; x=1710263164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U1FC6TvDrEJVxS1ZALZrUjW7uENM7EPrWiu39Wh5u84=;
  b=FHsPgXcLdH+8zZemriZhfqkjsxErnr3JK/3MVAAtDFe6Y9ePsEEGVN4U
   +0Jup3ANSRjVa5ROSO3wgGgn7zLXWRACMiquflbfP1sZwTqJ4OR7zAwXq
   W6jaE3jWg7H6iJ26IRDUITEJZvYGCl55Xs+eYAeCWsQkqbnYGqO8oBdGk
   q8r+SIf8QueRdzdwA3XoBa9MUysDmpCNuXJcw17WA8o2OKlQ6/EszDoIc
   bOZsfsa6ViT9J0zbE3vk/N2EAwjRW4uadFugTooMg9KYD2/NSayJng9va
   4g7nYa4XEBAtrs5u+oDE7scJcMl7IMHTsjY1KPY+Rabd0HI4XHdZ57cx0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="334679696"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="334679696"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:02:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="708950959"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="708950959"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2023 10:02:43 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 15/16] dmaengine: idxd: add pid to exported sysfs attribute for opened file
Date:   Mon, 13 Mar 2023 10:02:18 -0700
Message-Id: <20230313170219.1956012-16-fenghua.yu@intel.com>
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
index d93d26834dc7..3d905087cbff 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -49,6 +49,7 @@ struct idxd_user_context {
 	struct idxd_dev idxd_dev;
 	u64 counters[COUNTER_MAX];
 	int id;
+	pid_t pid;
 };
 
 static void idxd_cdev_evl_drain_pasid(struct idxd_wq *wq, u32 pasid);
@@ -78,9 +79,18 @@ static ssize_t cr_fault_failures_show(struct device *dev,
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
 
@@ -238,6 +248,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 
 	ctx->wq = wq;
 	filp->private_data = ctx;
+	ctx->pid = current->pid;
 
 	if (device_user_pasid_enabled(idxd)) {
 		sva = iommu_sva_bind_device(dev, current->mm);
-- 
2.37.1

