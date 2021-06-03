Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5323939AD53
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jun 2021 23:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhFCV70 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 17:59:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:38235 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhFCV70 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Jun 2021 17:59:26 -0400
IronPort-SDR: K5FcYplquOae7aCncu3rkhxPIeGVPxix7WEcI+fhRD1SaV4uMRGN1m3IpdcdqItrw9Yb89uP80
 pnzq/bwZqUTg==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="265328694"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="265328694"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 14:57:37 -0700
IronPort-SDR: U8mgCbVSAy0LGup8TzP68XtKsla5weBuJjjxAeR2lyU9DuAf6Po5iMYo+rPh2hTjQug5SoQBf4
 U6zUx727vjVQ==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="550324478"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 14:57:36 -0700
Subject: [PATCH] dmaengine: idxd: Add wq occupancy information to sysfs
 attribute
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Thu, 03 Jun 2021 14:57:35 -0700
Message-ID: <162275745546.1857062.8765615879420582018.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add occupancy information to wq sysfs attribute. Attribute will show
wq occupancy data if "WQ Occupancy Support" field in WQCAP is 1. It
displays the number of entries currently in this WQ. This is provided
as an estimate and should not be relied on to determine whether there
is space in the WQ. The data is to provide information to user apps
for flow control.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/stable/sysfs-driver-dma-idxd |    7 +++++++
 drivers/dma/idxd/registers.h                   |    3 +++
 drivers/dma/idxd/sysfs.c                       |   19 +++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 55285c136cf0..ebd521314803 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -211,6 +211,13 @@ Contact:	dmaengine@vger.kernel.org
 Description:	Indicate whether ATS disable is turned on for the workqueue.
 		0 indicates ATS is on, and 1 indicates ATS is off for the workqueue.
 
+What:		/sys/bus/dsa/devices/wq<m>.<n>/occupancy
+Date		May 25, 2021
+KernelVersion:	5.14.0
+Contact:	dmaengine@vger.kernel.org
+Description:	Show the current number of entries in this WQ if WQ Occupancy
+		Support bit WQ capabilities is 1.
+
 What:           /sys/bus/dsa/devices/engine<m>.<n>/group_id
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index c970c3f025f0..7343a8f48819 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -349,6 +349,9 @@ union wqcfg {
 } __packed;
 
 #define WQCFG_PASID_IDX                2
+#define WQCFG_OCCUP_IDX		6
+
+#define WQCFG_OCCUP_MASK	0xffff
 
 /*
  * This macro calculates the offset into the WQCFG register
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index a8286995e316..429dc5d72265 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -918,6 +918,24 @@ static ssize_t wq_ats_disable_store(struct device *dev, struct device_attribute
 static struct device_attribute dev_attr_wq_ats_disable =
 		__ATTR(ats_disable, 0644, wq_ats_disable_show, wq_ats_disable_store);
 
+static ssize_t wq_occupancy_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct idxd_wq *wq = confdev_to_wq(dev);
+	struct idxd_device *idxd = wq->idxd;
+	u32 occup, offset;
+
+	if (!idxd->hw.wq_cap.occupancy)
+		return -EOPNOTSUPP;
+
+	offset = WQCFG_OFFSET(idxd, wq->id, WQCFG_OCCUP_IDX);
+	occup = ioread32(idxd->reg_base + offset) & WQCFG_OCCUP_MASK;
+
+	return sysfs_emit(buf, "%u\n", occup);
+}
+
+static struct device_attribute dev_attr_wq_occupancy =
+		__ATTR(occupancy, 0444, wq_occupancy_show, NULL);
+
 static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_clients.attr,
 	&dev_attr_wq_state.attr,
@@ -933,6 +951,7 @@ static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_max_transfer_size.attr,
 	&dev_attr_wq_max_batch_size.attr,
 	&dev_attr_wq_ats_disable.attr,
+	&dev_attr_wq_occupancy.attr,
 	NULL,
 };
 


