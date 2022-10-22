Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1425608550
	for <lists+dmaengine@lfdr.de>; Sat, 22 Oct 2022 09:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJVHCm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 Oct 2022 03:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiJVHCl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 Oct 2022 03:02:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682CA28DC3A
        for <dmaengine@vger.kernel.org>; Sat, 22 Oct 2022 00:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666422159; x=1697958159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=5iP/k8aPc/xwM2x3OpsVjin81Wk55/3clzeVinNUSvU=;
  b=KIjUms56PEKsjewZ4xYK42JKuFCy2IIqwP2d7xCrAJFT5hDPrK8kSrCK
   baqyrpfMwH29MsN8tD5se/GCerPisozrYsaoXaxXpuAQKiWoulEobh+pY
   XS/HpWnidMqUjSsvSca1F4gsmbZ9ezPnN68OhYwEHyHSAd1pPCbsmNQa6
   9jh5vOgHEuH+B6XEJMqQU5P9x25TqIUykXrP+7kuauOi5hFAoTyYRnTxD
   E9fTkZPmbMLbHZRGiIsDv1obkDxpK9IpikgKzpmJH/coEGoK4RQ7akjP7
   31lpQW3M+qVMF7mSTiGzoHlocKU3Ogn+vUaIAMjcL8atmcrRZ/ROncmWp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="393475514"
X-IronPort-AV: E=Sophos;i="5.95,204,1661842800"; 
   d="scan'208";a="393475514"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 00:02:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="661865556"
X-IronPort-AV: E=Sophos;i="5.95,204,1661842800"; 
   d="scan'208";a="661865556"
Received: from xshen14-linux.bj.intel.com ([10.238.155.105])
  by orsmga008.jf.intel.com with ESMTP; 22 Oct 2022 00:02:36 -0700
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     vkoul@kernel.org, fenghua.yu@intel.com, dave.jiang@intel.com,
        dmaengine@vger.kernel.org
Cc:     ramesh.thomas@intel.com, tony.luck@intel.com, tony.zhu@intel.com,
        pei.p.jia@intel.com, xiaochen.shen@intel.com
Subject: [PATCH RESEND] dmaengine: idxd: Make read buffer sysfs attributes invisible for Intel IAA
Date:   Sat, 22 Oct 2022 15:49:49 +0800
Message-Id: <20221022074949.11719-1-xiaochen.shen@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220930213324.23897-1-xiaochen.shen@intel.com>
References: <20220930213324.23897-1-xiaochen.shen@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In current code, the following sysfs attributes are exposed to user to
show or update the values:
  max_read_buffers (max_tokens)
  read_buffer_limit (token_limit)
  group/read_buffers_allowed (group/tokens_allowed)
  group/read_buffers_reserved (group/tokens_reserved)
  group/use_read_buffer_limit (group/use_token_limit)

From Intel IAA spec [1], Intel IAA does not support Read Buffer
allocation control. So these sysfs attributes should not be supported on
IAA device.

Fix this issue by making these sysfs attributes invisible through
is_visible() filter when the device is IAA.

Add description in the ABI documentation to mention that these
attributes are not visible when the device does not support Read Buffer
allocation control.

[1]: https://cdrdv2.intel.com/v1/dl/getContent/721858

Fixes: fde212e44f45 ("dmaengine: idxd: deprecate token sysfs attributes for read buffers")
Fixes: c52ca478233c ("dmaengine: idxd: add configuration component of driver")
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 .../ABI/stable/sysfs-driver-dma-idxd          | 10 ++++++
 drivers/dma/idxd/sysfs.c                      | 36 +++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 69e2d9155e0d..3becc9a82bdf 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -50,6 +50,8 @@ Description:    The total number of read buffers supported by this device.
 		The read buffers represent resources within the DSA
 		implementation, and these resources are allocated by engines to
 		support operations. See DSA spec v1.2 9.2.4 Total Read Buffers.
+		It's not visible when the device does not support Read Buffer
+		allocation control.
 
 What:           /sys/bus/dsa/devices/dsa<m>/max_transfer_size
 Date:           Oct 25, 2019
@@ -123,6 +125,8 @@ Contact:        dmaengine@vger.kernel.org
 Description:    The maximum number of read buffers that may be in use at
 		one time by operations that access low bandwidth memory in the
 		device. See DSA spec v1.2 9.2.8 GENCFG on Global Read Buffer Limit.
+		It's not visible when the device does not support Read Buffer
+		allocation control.
 
 What:		/sys/bus/dsa/devices/dsa<m>/cmd_status
 Date:		Aug 28, 2020
@@ -252,6 +256,8 @@ KernelVersion:	5.17.0
 Contact:	dmaengine@vger.kernel.org
 Description:	Enable the use of global read buffer limit for the group. See DSA
 		spec v1.2 9.2.18 GRPCFG Use Global Read Buffer Limit.
+		It's not visible when the device does not support Read Buffer
+		allocation control.
 
 What:		/sys/bus/dsa/devices/group<m>.<n>/read_buffers_allowed
 Date:		Dec 10, 2021
@@ -260,6 +266,8 @@ Contact:	dmaengine@vger.kernel.org
 Description:	Indicates max number of read buffers that may be in use at one time
 		by all engines in the group. See DSA spec v1.2 9.2.18 GRPCFG Read
 		Buffers Allowed.
+		It's not visible when the device does not support Read Buffer
+		allocation control.
 
 What:		/sys/bus/dsa/devices/group<m>.<n>/read_buffers_reserved
 Date:		Dec 10, 2021
@@ -268,6 +276,8 @@ Contact:	dmaengine@vger.kernel.org
 Description:	Indicates the number of Read Buffers reserved for the use of
 		engines in the group. See DSA spec v1.2 9.2.18 GRPCFG Read Buffers
 		Reserved.
+		It's not visible when the device does not support Read Buffer
+		allocation control.
 
 What:		/sys/bus/dsa/devices/group<m>.<n>/desc_progress_limit
 Date:		Sept 14, 2022
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index f30aad90537b..7c7ec8323cb7 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -528,6 +528,22 @@ static bool idxd_group_attr_progress_limit_invisible(struct attribute *attr,
 		!idxd->hw.group_cap.progress_limit;
 }
 
+static bool idxd_group_attr_read_buffers_invisible(struct attribute *attr,
+						   struct idxd_device *idxd)
+{
+	/*
+	 * Intel IAA does not support Read Buffer allocation control,
+	 * make these attributes invisible.
+	 */
+	return (attr == &dev_attr_group_use_token_limit.attr ||
+		attr == &dev_attr_group_use_read_buffer_limit.attr ||
+		attr == &dev_attr_group_tokens_allowed.attr ||
+		attr == &dev_attr_group_read_buffers_allowed.attr ||
+		attr == &dev_attr_group_tokens_reserved.attr ||
+		attr == &dev_attr_group_read_buffers_reserved.attr) &&
+		idxd->data->type == IDXD_TYPE_IAX;
+}
+
 static umode_t idxd_group_attr_visible(struct kobject *kobj,
 				       struct attribute *attr, int n)
 {
@@ -538,6 +554,9 @@ static umode_t idxd_group_attr_visible(struct kobject *kobj,
 	if (idxd_group_attr_progress_limit_invisible(attr, idxd))
 		return 0;
 
+	if (idxd_group_attr_read_buffers_invisible(attr, idxd))
+		return 0;
+
 	return attr->mode;
 }
 
@@ -1552,6 +1571,20 @@ static bool idxd_device_attr_max_batch_size_invisible(struct attribute *attr,
 	       idxd->data->type == IDXD_TYPE_IAX;
 }
 
+static bool idxd_device_attr_read_buffers_invisible(struct attribute *attr,
+						    struct idxd_device *idxd)
+{
+	/*
+	 * Intel IAA does not support Read Buffer allocation control,
+	 * make these attributes invisible.
+	 */
+	return (attr == &dev_attr_max_tokens.attr ||
+		attr == &dev_attr_max_read_buffers.attr ||
+		attr == &dev_attr_token_limit.attr ||
+		attr == &dev_attr_read_buffer_limit.attr) &&
+		idxd->data->type == IDXD_TYPE_IAX;
+}
+
 static umode_t idxd_device_attr_visible(struct kobject *kobj,
 					struct attribute *attr, int n)
 {
@@ -1561,6 +1594,9 @@ static umode_t idxd_device_attr_visible(struct kobject *kobj,
 	if (idxd_device_attr_max_batch_size_invisible(attr, idxd))
 		return 0;
 
+	if (idxd_device_attr_read_buffers_invisible(attr, idxd))
+		return 0;
+
 	return attr->mode;
 }
 

base-commit: cd0ab43ec91a6114ea309e9e72382fdb184e7b9a
-- 
2.18.4

