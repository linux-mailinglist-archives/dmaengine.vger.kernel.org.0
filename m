Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8986B474C95
	for <lists+dmaengine@lfdr.de>; Tue, 14 Dec 2021 21:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhLNUXR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Dec 2021 15:23:17 -0500
Received: from mga06.intel.com ([134.134.136.31]:34487 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237611AbhLNUXR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Dec 2021 15:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639513397; x=1671049397;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1XJJzJUuyGL8NfojoavaWQBJGPAfpXaStR0KIcjsbvo=;
  b=ftr63mBEIjMVOD81Kd1k7GfOVANrITWLbQoPbSodSbh75t+bMiO1OwoI
   XYuoKtykLp4jyYIVAqTfO3z5OhB//phZYfRBkNA1ApLeZB0DZzvFmKKN8
   ilBwQ1bw9Qwv4EXUTNPm0pGxFCKATmoS+pz8eOdH6NEN3yXHxI6F45xW/
   tRLl70G5rtSF+IZuzImTpDrY5pDY3IxPVNIBoVdofFECfF8eIrFE5KGo/
   Z2xxpPyxPuHEar0eFL2i4R3eR29RS8YjGesXBm1avL5LGk7aTj7jN0Tul
   tGfjMo8gRou/Kubwfa3VPg0/bRd1i1jGM9N5PPol1kxPl21t1Gh5ef9jS
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="299856512"
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="299856512"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 12:23:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="519359384"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 12:23:15 -0800
Subject: [PATCH 2/2] dmaengine: idxd: deprecate token sysfs attributes for
 read buffers
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 14 Dec 2021 13:23:14 -0700
Message-ID: <163951339488.2988321.2424012059911316373.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <163951326835.2988321.1053110337527742301.stgit@djiang5-desk3.ch.intel.com>
References: <163951326835.2988321.1053110337527742301.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The following sysfs attributes will be obsolete due to the name change of
tokens to read buffers:
max_tokens
token_limit
group/tokens_allowed
group/tokens_reserved
group/use_token_limit

Create new entries and have old entry print warning of deprecation.

New attributes to replace the token ones:
max_read_buffers
read_buffer_limit
group/read_buffers_allowed
group/read_buffers_reserved
group/use_read_buffer_limit

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/stable/sysfs-driver-dma-idxd |   47 ++++++--
 drivers/dma/idxd/sysfs.c                       |  145 ++++++++++++++++++++----
 2 files changed, 153 insertions(+), 39 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 4d3a23eb05b9..0c2b613f2373 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -41,14 +41,14 @@ KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The maximum number of groups can be created under this device.
 
-What:           /sys/bus/dsa/devices/dsa<m>/max_tokens
-Date:           Oct 25, 2019
-KernelVersion:  5.6.0
+What:           /sys/bus/dsa/devices/dsa<m>/max_read_buffers
+Date:           Dec 10, 2021
+KernelVersion:  5.17.0
 Contact:        dmaengine@vger.kernel.org
-Description:    The total number of bandwidth tokens supported by this device.
-		The bandwidth tokens represent resources within the DSA
+Description:    The total number of read buffers supported by this device.
+		The read buffers represent resources within the DSA
 		implementation, and these resources are allocated by engines to
-		support operations.
+		support operations. See DSA spec v1.2 9.2.4 Total Read Buffers.
 
 What:           /sys/bus/dsa/devices/dsa<m>/max_transfer_size
 Date:           Oct 25, 2019
@@ -115,13 +115,13 @@ KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    To indicate if this device is configurable or not.
 
-What:           /sys/bus/dsa/devices/dsa<m>/token_limit
-Date:           Oct 25, 2019
-KernelVersion:  5.6.0
+What:           /sys/bus/dsa/devices/dsa<m>/read_buffer_limit
+Date:           Dec 10, 2021
+KernelVersion:  5.17.0
 Contact:        dmaengine@vger.kernel.org
-Description:    The maximum number of bandwidth tokens that may be in use at
+Description:    The maximum number of read buffers that may be in use at
 		one time by operations that access low bandwidth memory in the
-		device.
+		device. See DSA spec v1.2 9.2.8 GENCFG on Global Read Buffer Limit.
 
 What:		/sys/bus/dsa/devices/dsa<m>/cmd_status
 Date:		Aug 28, 2020
@@ -224,7 +224,7 @@ What:		/sys/bus/dsa/devices/wq<m>.<n>/enqcmds_retries
 Date		Oct 29, 2021
 KernelVersion:	5.17.0
 Contact:	dmaengine@vger.kernel.org
-Description:	Indicate the number of retires for an enqcmds submission on a shared wq.
+Description:	Indicate the number of retires for an enqcmds submission on a sharedwq.
 		A max value to set attribute is capped at 64.
 
 What:           /sys/bus/dsa/devices/engine<m>.<n>/group_id
@@ -232,3 +232,26 @@ Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
 Description:    The group that this engine belongs to.
+
+What:		/sys/bus/dsa/devices/group<m>.<n>/use_read_buffer_limit
+Date:		Dec 10, 2021
+KernelVersion:	5.17.0
+Contact:	dmaengine@vger.kernel.org
+Description:	Enable the use of global read buffer limit for the group. See DSA
+		spec v1.2 9.2.18 GRPCFG Use Global Read Buffer Limit.
+
+What:		/sys/bus/dsa/devices/group<m>.<n>/read_buffers_allowed
+Date:		Dec 10, 2021
+KernelVersion:	5.17.0
+Contact:	dmaengine@vger.kernel.org
+Description:	Indicates max number of read buffers that may be in use at one time
+		by all engines in the group. See DSA spec v1.2 9.2.18 GRPCFG Read
+		Buffers Allowed.
+
+What:		/sys/bus/dsa/devices/group<m>.<n>/read_buffers_reserved
+Date:		Dec 10, 2021
+KernelVersion:	5.17.0
+Contact:	dmaengine@vger.kernel.org
+Description:	Indicates the number of Read Buffers reserved for the use of
+		engines in the group. See DSA spec v1.2 9.2.18 GRPCFG Read Buffers
+		Reserved.
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 6f1ebf08878a..7e19ab92b61a 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -112,18 +112,26 @@ static void idxd_set_free_rdbufs(struct idxd_device *idxd)
 	idxd->nr_rdbufs = idxd->max_rdbufs - rdbufs;
 }
 
-static ssize_t group_tokens_reserved_show(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf)
+static ssize_t group_read_buffers_reserved_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
 {
 	struct idxd_group *group = confdev_to_group(dev);
 
 	return sysfs_emit(buf, "%u\n", group->rdbufs_reserved);
 }
 
-static ssize_t group_tokens_reserved_store(struct device *dev,
-					   struct device_attribute *attr,
-					   const char *buf, size_t count)
+static ssize_t group_tokens_reserved_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	dev_warn_once(dev, "attribute deprecated, see read_buffers_reserved.\n");
+	return group_read_buffers_reserved_show(dev, attr, buf);
+}
+
+static ssize_t group_read_buffers_reserved_store(struct device *dev,
+						 struct device_attribute *attr,
+						 const char *buf, size_t count)
 {
 	struct idxd_group *group = confdev_to_group(dev);
 	struct idxd_device *idxd = group->idxd;
@@ -154,22 +162,42 @@ static ssize_t group_tokens_reserved_store(struct device *dev,
 	return count;
 }
 
+static ssize_t group_tokens_reserved_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	dev_warn_once(dev, "attribute deprecated, see read_buffers_reserved.\n");
+	return group_read_buffers_reserved_store(dev, attr, buf, count);
+}
+
 static struct device_attribute dev_attr_group_tokens_reserved =
 		__ATTR(tokens_reserved, 0644, group_tokens_reserved_show,
 		       group_tokens_reserved_store);
 
-static ssize_t group_tokens_allowed_show(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
+static struct device_attribute dev_attr_group_read_buffers_reserved =
+		__ATTR(read_buffers_reserved, 0644, group_read_buffers_reserved_show,
+		       group_read_buffers_reserved_store);
+
+static ssize_t group_read_buffers_allowed_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
 {
 	struct idxd_group *group = confdev_to_group(dev);
 
 	return sysfs_emit(buf, "%u\n", group->rdbufs_allowed);
 }
 
-static ssize_t group_tokens_allowed_store(struct device *dev,
-					  struct device_attribute *attr,
-					  const char *buf, size_t count)
+static ssize_t group_tokens_allowed_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	dev_warn_once(dev, "attribute deprecated, see read_buffers_allowed.\n");
+	return group_read_buffers_allowed_show(dev, attr, buf);
+}
+
+static ssize_t group_read_buffers_allowed_store(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t count)
 {
 	struct idxd_group *group = confdev_to_group(dev);
 	struct idxd_device *idxd = group->idxd;
@@ -197,22 +225,42 @@ static ssize_t group_tokens_allowed_store(struct device *dev,
 	return count;
 }
 
+static ssize_t group_tokens_allowed_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	dev_warn_once(dev, "attribute deprecated, see read_buffers_allowed.\n");
+	return group_read_buffers_allowed_store(dev, attr, buf, count);
+}
+
 static struct device_attribute dev_attr_group_tokens_allowed =
 		__ATTR(tokens_allowed, 0644, group_tokens_allowed_show,
 		       group_tokens_allowed_store);
 
-static ssize_t group_use_token_limit_show(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf)
+static struct device_attribute dev_attr_group_read_buffers_allowed =
+		__ATTR(read_buffers_allowed, 0644, group_read_buffers_allowed_show,
+		       group_read_buffers_allowed_store);
+
+static ssize_t group_use_read_buffer_limit_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
 {
 	struct idxd_group *group = confdev_to_group(dev);
 
 	return sysfs_emit(buf, "%u\n", group->use_rdbuf_limit);
 }
 
-static ssize_t group_use_token_limit_store(struct device *dev,
-					   struct device_attribute *attr,
-					   const char *buf, size_t count)
+static ssize_t group_use_token_limit_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	dev_warn_once(dev, "attribute deprecated, see use_read_buffer_limit.\n");
+	return group_use_read_buffer_limit_show(dev, attr, buf);
+}
+
+static ssize_t group_use_read_buffer_limit_store(struct device *dev,
+						 struct device_attribute *attr,
+						 const char *buf, size_t count)
 {
 	struct idxd_group *group = confdev_to_group(dev);
 	struct idxd_device *idxd = group->idxd;
@@ -239,10 +287,22 @@ static ssize_t group_use_token_limit_store(struct device *dev,
 	return count;
 }
 
+static ssize_t group_use_token_limit_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	dev_warn_once(dev, "attribute deprecated, see use_read_buffer_limit.\n");
+	return group_use_read_buffer_limit_store(dev, attr, buf, count);
+}
+
 static struct device_attribute dev_attr_group_use_token_limit =
 		__ATTR(use_token_limit, 0644, group_use_token_limit_show,
 		       group_use_token_limit_store);
 
+static struct device_attribute dev_attr_group_use_read_buffer_limit =
+		__ATTR(use_read_buffer_limit, 0644, group_use_read_buffer_limit_show,
+		       group_use_read_buffer_limit_store);
+
 static ssize_t group_engines_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -387,8 +447,11 @@ static struct attribute *idxd_group_attributes[] = {
 	&dev_attr_group_work_queues.attr,
 	&dev_attr_group_engines.attr,
 	&dev_attr_group_use_token_limit.attr,
+	&dev_attr_group_use_read_buffer_limit.attr,
 	&dev_attr_group_tokens_allowed.attr,
+	&dev_attr_group_read_buffers_allowed.attr,
 	&dev_attr_group_tokens_reserved.attr,
+	&dev_attr_group_read_buffers_reserved.attr,
 	&dev_attr_group_traffic_class_a.attr,
 	&dev_attr_group_traffic_class_b.attr,
 	NULL,
@@ -1192,26 +1255,42 @@ static ssize_t errors_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(errors);
 
-static ssize_t max_tokens_show(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static ssize_t max_read_buffers_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	return sysfs_emit(buf, "%u\n", idxd->max_rdbufs);
 }
-static DEVICE_ATTR_RO(max_tokens);
 
-static ssize_t token_limit_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t max_tokens_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	dev_warn_once(dev, "attribute deprecated, see max_read_buffers.\n");
+	return max_read_buffers_show(dev, attr, buf);
+}
+
+static DEVICE_ATTR_RO(max_tokens);	/* deprecated */
+static DEVICE_ATTR_RO(max_read_buffers);
+
+static ssize_t read_buffer_limit_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	return sysfs_emit(buf, "%u\n", idxd->rdbuf_limit);
 }
 
-static ssize_t token_limit_store(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf, size_t count)
+static ssize_t token_limit_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	dev_warn_once(dev, "attribute deprecated, see read_buffer_limit.\n");
+	return read_buffer_limit_show(dev, attr, buf);
+}
+
+static ssize_t read_buffer_limit_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 	unsigned long val;
@@ -1236,7 +1315,17 @@ static ssize_t token_limit_store(struct device *dev,
 	idxd->rdbuf_limit = val;
 	return count;
 }
-static DEVICE_ATTR_RW(token_limit);
+
+static ssize_t token_limit_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	dev_warn_once(dev, "attribute deprecated, see read_buffer_limit\n");
+	return read_buffer_limit_store(dev, attr, buf, count);
+}
+
+static DEVICE_ATTR_RW(token_limit);	/* deprecated */
+static DEVICE_ATTR_RW(read_buffer_limit);
 
 static ssize_t cdev_major_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
@@ -1282,7 +1371,9 @@ static struct attribute *idxd_device_attributes[] = {
 	&dev_attr_state.attr,
 	&dev_attr_errors.attr,
 	&dev_attr_max_tokens.attr,
+	&dev_attr_max_read_buffers.attr,
 	&dev_attr_token_limit.attr,
+	&dev_attr_read_buffer_limit.attr,
 	&dev_attr_cdev_major.attr,
 	&dev_attr_cmd_status.attr,
 	NULL,


