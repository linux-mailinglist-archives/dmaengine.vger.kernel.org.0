Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B2B2B28D3
	for <lists+dmaengine@lfdr.de>; Fri, 13 Nov 2020 23:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKMWzL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Nov 2020 17:55:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:26995 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgKMWzL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 13 Nov 2020 17:55:11 -0500
IronPort-SDR: 5W1lfo9MvhZN3RXKIcW0GXU5wYkFdS2W4bQSnnfWZgKLK0MXsyESNh/xtOzmDbbBeuYJ8tzUq4
 YdhHrOs8QXhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="255252312"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="255252312"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 14:55:06 -0800
IronPort-SDR: +BxiCD0d/iG7CjrMWej8/oeVqUPWz+FUMh2mDOoqDAE29ihGN0GJ4zwCsAopuiZvbAGsWDGpbe
 eIvsZ+g6TmNQ==
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="474828929"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 14:55:06 -0800
Subject: [PATCH] dmaengine: idxd: add ATS disable knob for work queues
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Fri, 13 Nov 2020 15:55:05 -0700
Message-ID: <160530810593.1288392.2561048329116529566.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

With the DSA spec 1.1 update, a knob to disable ATS for individually is
introduced. Add enabling code to allow a system admin to make the
configuration through sysfs.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/stable/sysfs-driver-dma-idxd |    7 +++++
 drivers/dma/idxd/device.c                      |    4 +++
 drivers/dma/idxd/idxd.h                        |    1 +
 drivers/dma/idxd/registers.h                   |    5 ++--
 drivers/dma/idxd/sysfs.c                       |   34 ++++++++++++++++++++++++
 5 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 5ea81ffd3c1a..55285c136cf0 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -204,6 +204,13 @@ Contact:	dmaengine@vger.kernel.org
 Description:	The max batch size for this workqueue. Cannot exceed device
 		max batch size. Configurable parameter.
 
+What:		/sys/bus/dsa/devices/wq<m>.<n>/ats_disable
+Date:		Nov 13, 2020
+KernelVersion:	5.11.0
+Contact:	dmaengine@vger.kernel.org
+Description:	Indicate whether ATS disable is turned on for the workqueue.
+		0 indicates ATS is on, and 1 indicates ATS is off for the workqueue.
+
 What:           /sys/bus/dsa/devices/engine<m>.<n>/group_id
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index d6f551dcbcb6..b75f9a09666e 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -354,6 +354,7 @@ void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	wq->group = NULL;
 	wq->threshold = 0;
 	wq->priority = 0;
+	wq->ats_dis = 0;
 	clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
 	memset(wq->name, 0, WQ_NAME_SIZE);
 
@@ -631,6 +632,9 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 	    test_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags))
 		wq->wqcfg->bof = 1;
 
+	if (idxd->hw.wq_cap.wq_ats_support)
+		wq->wqcfg->wq_ats_disable = wq->ats_dis;
+
 	/* bytes 12-15 */
 	wq->wqcfg->max_xfer_shift = ilog2(wq->max_xfer_bytes);
 	wq->wqcfg->max_batch_shift = ilog2(wq->max_batch_size);
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 7e54209c433a..149934f8d097 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -123,6 +123,7 @@ struct idxd_wq {
 	char name[WQ_NAME_SIZE + 1];
 	u64 max_xfer_bytes;
 	u32 max_batch_size;
+	bool ats_dis;
 };
 
 struct idxd_engine {
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index d29a58ee2651..0cdc5405bc53 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -47,7 +47,7 @@ union wq_cap_reg {
 		u64 rsvd:20;
 		u64 shared_mode:1;
 		u64 dedicated_mode:1;
-		u64 rsvd2:1;
+		u64 wq_ats_support:1;
 		u64 priority:1;
 		u64 occupancy:1;
 		u64 occupancy_int:1;
@@ -303,7 +303,8 @@ union wqcfg {
 		/* bytes 8-11 */
 		u32 mode:1;	/* shared or dedicated */
 		u32 bof:1;	/* block on fault */
-		u32 rsvd2:2;
+		u32 wq_ats_disable:1;
+		u32 rsvd2:1;
 		u32 priority:4;
 		u32 pasid:20;
 		u32 pasid_en:1;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 6d292eb79bf3..3af83f1fd36e 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1261,6 +1261,39 @@ static ssize_t wq_max_batch_size_store(struct device *dev, struct device_attribu
 static struct device_attribute dev_attr_wq_max_batch_size =
 		__ATTR(max_batch_size, 0644, wq_max_batch_size_show, wq_max_batch_size_store);
 
+static ssize_t wq_ats_disable_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+
+	return sprintf(buf, "%u\n", wq->ats_dis);
+}
+
+static ssize_t wq_ats_disable_store(struct device *dev, struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_device *idxd = wq->idxd;
+	bool ats_dis;
+	int rc;
+
+	if (wq->state != IDXD_WQ_DISABLED)
+		return -EPERM;
+
+	if (!idxd->hw.wq_cap.wq_ats_support)
+		return -EOPNOTSUPP;
+
+	rc = kstrtobool(buf, &ats_dis);
+	if (rc < 0)
+		return rc;
+
+	wq->ats_dis = ats_dis;
+
+	return count;
+}
+
+static struct device_attribute dev_attr_wq_ats_disable =
+		__ATTR(ats_disable, 0644, wq_ats_disable_show, wq_ats_disable_store);
+
 static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_clients.attr,
 	&dev_attr_wq_state.attr,
@@ -1275,6 +1308,7 @@ static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_cdev_minor.attr,
 	&dev_attr_wq_max_transfer_size.attr,
 	&dev_attr_wq_max_batch_size.attr,
+	&dev_attr_wq_ats_disable.attr,
 	NULL,
 };
 


