Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1D558C19F
	for <lists+dmaengine@lfdr.de>; Mon,  8 Aug 2022 04:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242346AbiHHC2o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 7 Aug 2022 22:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243889AbiHHC2V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 7 Aug 2022 22:28:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39377FFA
        for <dmaengine@vger.kernel.org>; Sun,  7 Aug 2022 19:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659925651; x=1691461651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ve2XDTFKGQi5n8byEJl0i0T++O6SUb8NfKnj3Fcywy0=;
  b=TqDrzQWxoDfCZTawP1s7QfOoV2vudm0KRu+sTufSVdp6T5rabhyn6zL0
   z/J4mY+QxzwBNlm7cyrwG+f2xweW13iyuAXfLODd3lYmSe8Zlt8wiLdj/
   vG8fzy/5QXKQtpBYnB4xFVpOGnDbgXwCA1lq+nDWUeoumVlgrEM/zJo8J
   Mg/BOwg9md25xheXaOJBmgAQDVzp4hybMGgxgfnTCWtIVib2lRm8qafa/
   B1ovMuJUXlLDqPHVoEK0SIQAFMJare7FiMchXS8tgUKQy0N1Is4HNj5x5
   e9ub2T9vsDhk3XKJumGIDV0dHwdd6vZ9U2rpih+Q/Z/NVZij1WeDw4iwh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="290494618"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="290494618"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 19:27:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="663734212"
Received: from xshen14-linux.bj.intel.com ([10.238.155.105])
  by fmsmga008.fm.intel.com with ESMTP; 07 Aug 2022 19:27:11 -0700
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     vkoul@kernel.org, fenghua.yu@intel.com, dave.jiang@intel.com,
        dmaengine@vger.kernel.org
Cc:     ramesh.thomas@intel.com, tony.luck@intel.com, tony.zhu@intel.com,
        pei.p.jia@intel.com, xiaochen.shen@intel.com
Subject: [PATCH 2/2] dmaengine: idxd: Make max batch size attributes in sysfs invisible for Intel IAA
Date:   Mon,  8 Aug 2022 11:19:22 +0800
Message-Id: <20220808031922.29751-3-xiaochen.shen@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220808031922.29751-1-xiaochen.shen@intel.com>
References: <20220808031922.29751-1-xiaochen.shen@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In current code, dev.max_batch_size and wq.max_batch_size attributes in
sysfs are exposed to user to show or update the values.

From Intel IAA spec [1], Intel IAA does not support batch processing. So
these sysfs attributes should not be supported on IAA device.

Fix this issue by making the attributes of max_batch_size invisible in
sysfs through is_visible() filter when the device is IAA.

Add description in the ABI documentation to mention that the attributes
are not visible when the device does not support batch.

[1]: https://cdrdv2.intel.com/v1/dl/getContent/721858

Fixes: e7184b159dd3 ("dmaengine: idxd: add support for configurable max wq batch size")
Fixes: c52ca478233c ("dmaengine: idxd: add configuration component of driver")
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
---
 .../ABI/stable/sysfs-driver-dma-idxd          |  2 ++
 drivers/dma/idxd/sysfs.c                      | 30 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 0c2b613f2373..da3f6d01e0bd 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -22,6 +22,7 @@ Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The largest number of work descriptors in a batch.
+		It's not visible when the device does not support batch.
 
 What:           /sys/bus/dsa/devices/dsa<m>/max_work_queues_size
 Date:           Oct 25, 2019
@@ -205,6 +206,7 @@ KernelVersion:	5.10.0
 Contact:	dmaengine@vger.kernel.org
 Description:	The max batch size for this workqueue. Cannot exceed device
 		max batch size. Configurable parameter.
+		It's not visible when the device does not support batch.
 
 What:		/sys/bus/dsa/devices/wq<m>.<n>/ats_disable
 Date:		Nov 13, 2020
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index fa729fac4b97..b13a8cc4d24f 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1055,6 +1055,20 @@ static ssize_t wq_enqcmds_retries_store(struct device *dev, struct device_attrib
 static struct device_attribute dev_attr_wq_enqcmds_retries =
 		__ATTR(enqcmds_retries, 0644, wq_enqcmds_retries_show, wq_enqcmds_retries_store);
 
+static umode_t idxd_wq_visible(struct kobject *kobj,
+			       struct attribute *attr, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct idxd_wq *wq = confdev_to_wq(dev);
+
+	/* Intel IAA does not support batch processing, make it invisible */
+	if (attr == &dev_attr_wq_max_batch_size.attr &&
+			wq->idxd->data->type == IDXD_TYPE_IAX)
+		return 0;
+
+	return attr->mode;
+}
+
 static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_clients.attr,
 	&dev_attr_wq_state.attr,
@@ -1077,6 +1091,7 @@ static struct attribute *idxd_wq_attributes[] = {
 
 static const struct attribute_group idxd_wq_attribute_group = {
 	.attrs = idxd_wq_attributes,
+	.is_visible = idxd_wq_visible,
 };
 
 static const struct attribute_group *idxd_wq_attribute_groups[] = {
@@ -1366,6 +1381,20 @@ static ssize_t cmd_status_store(struct device *dev, struct device_attribute *att
 }
 static DEVICE_ATTR_RW(cmd_status);
 
+static umode_t idxd_device_visible(struct kobject *kobj,
+				   struct attribute *attr, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
+
+	/* Intel IAA does not support batch processing, make it invisible */
+	if (attr == &dev_attr_max_batch_size.attr &&
+			idxd->data->type == IDXD_TYPE_IAX)
+		return 0;
+
+	return attr->mode;
+}
+
 static struct attribute *idxd_device_attributes[] = {
 	&dev_attr_version.attr,
 	&dev_attr_max_groups.attr,
@@ -1393,6 +1422,7 @@ static struct attribute *idxd_device_attributes[] = {
 
 static const struct attribute_group idxd_device_attribute_group = {
 	.attrs = idxd_device_attributes,
+	.is_visible = idxd_device_visible,
 };
 
 static const struct attribute_group *idxd_attribute_groups[] = {
-- 
2.18.4

