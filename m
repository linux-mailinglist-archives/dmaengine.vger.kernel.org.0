Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E6B2562D8
	for <lists+dmaengine@lfdr.de>; Sat, 29 Aug 2020 00:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgH1WMw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Aug 2020 18:12:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:26627 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgH1WMw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Aug 2020 18:12:52 -0400
IronPort-SDR: 1cmrZC/WTpW1Hcz6WRg775xEU6+0WS3ULt3ZllrqhGuqafuntLCSvGpwhganSEUqk5LpvhjO02
 Mjf8OCYTIy+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="144500759"
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="144500759"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 15:12:50 -0700
IronPort-SDR: ub0hMtiue8UF+fn5+9V9Y07DZZSMiGr3mZpMfvDf4eE8H6OLhONXCaB08Y8HTfUldxxoFWozFE
 Dn1NRr8NqjOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="501185281"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005.fm.intel.com with ESMTP; 28 Aug 2020 15:12:50 -0700
Subject: [PATCH v2 2/2] dmaengine: idxd: add support for configurable max wq
 batch size
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Fri, 28 Aug 2020 15:12:50 -0700
Message-ID: <159865273617.29141.4383066301730821749.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <159865265404.29141.3049399618578194052.stgit@djiang5-desk3.ch.intel.com>
References: <159865265404.29141.3049399618578194052.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add sysfs attribute max_batch_size to wq in order to allow the max batch
size configured on a per wq basis. Add support code to configure
the valid user input on wq enable. This is a performance tuning
parameter.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

V2:
- Add ABI documentation (Vinod)
- Move common code to helper function (Vinod)

 Documentation/ABI/stable/sysfs-driver-dma-idxd |    7 +++
 drivers/dma/idxd/device.c                      |    2 -
 drivers/dma/idxd/idxd.h                        |    1 
 drivers/dma/idxd/init.c                        |    1 
 drivers/dma/idxd/sysfs.c                       |   57 +++++++++++++++++++++---
 5 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 452f353b4748..a2bc4afbe308 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -177,6 +177,13 @@ Contact:	dmaengine@vger.kernel.org
 Description:	The max transfer sized for this workqueue. Cannot exceed device
 		max transfer size. Configurable parameter.
 
+What:		/sys/bus/dsa/devices/wq<m>.<n>/max_batch_size
+Date:		Aug 28, 2020
+KernelVersion:	5.10.0
+Contact:	dmaengine@vger.kernel.org
+Description:	The max batch size for this workqueue. Cannot exceed device
+		max batch size. Configurable parameter.
+
 What:           /sys/bus/dsa/devices/engine<m>.<n>/group_id
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index b8dbb7001933..00dab1465ca3 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -530,7 +530,7 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 
 	/* bytes 12-15 */
 	wq->wqcfg.max_xfer_shift = ilog2(wq->max_xfer_bytes);
-	wq->wqcfg.max_batch_shift = idxd->hw.gen_cap.max_batch_shift;
+	wq->wqcfg.max_batch_shift = ilog2(wq->max_batch_size);
 
 	dev_dbg(dev, "WQ %d CFGs\n", wq->id);
 	for (i = 0; i < 8; i++) {
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 81db2a472822..e8bec6eb9f7e 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -115,6 +115,7 @@ struct idxd_wq {
 	struct dma_chan dma_chan;
 	char name[WQ_NAME_SIZE + 1];
 	u64 max_xfer_bytes;
+	u32 max_batch_size;
 };
 
 struct idxd_engine {
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index e5ed5750a6d0..11e5ce168177 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -177,6 +177,7 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 		mutex_init(&wq->wq_lock);
 		wq->idxd_cdev.minor = -1;
 		wq->max_xfer_bytes = idxd->max_xfer_bytes;
+		wq->max_batch_size = idxd->max_batch_size;
 	}
 
 	for (i = 0; i < idxd->max_engines; i++) {
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index a3bac7285975..e6284cb78a4c 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1064,6 +1064,21 @@ static ssize_t wq_cdev_minor_show(struct device *dev,
 static struct device_attribute dev_attr_wq_cdev_minor =
 		__ATTR(cdev_minor, 0444, wq_cdev_minor_show, NULL);
 
+static int __get_sysfs_u64(const char *buf, u64 *val)
+{
+	int rc;
+
+	rc = kstrtou64(buf, 0, val);
+	if (rc < 0)
+		return -EINVAL;
+
+	if (*val == 0)
+		return -EINVAL;
+
+	*val = roundup_pow_of_two(*val);
+	return 0;
+}
+
 static ssize_t wq_max_transfer_size_show(struct device *dev, struct device_attribute *attr,
 					 char *buf)
 {
@@ -1083,14 +1098,10 @@ static ssize_t wq_max_transfer_size_store(struct device *dev, struct device_attr
 	if (wq->state != IDXD_WQ_DISABLED)
 		return -EPERM;
 
-	rc = kstrtou64(buf, 0, &xfer_size);
+	rc = __get_sysfs_u64(buf, &xfer_size);
 	if (rc < 0)
-		return -EINVAL;
-
-	if (xfer_size == 0)
-		return -EINVAL;
+		return rc;
 
-	xfer_size = roundup_pow_of_two(xfer_size);
 	if (xfer_size > idxd->max_xfer_bytes)
 		return -EINVAL;
 
@@ -1103,6 +1114,39 @@ static struct device_attribute dev_attr_wq_max_transfer_size =
 		__ATTR(max_transfer_size, 0644,
 		       wq_max_transfer_size_show, wq_max_transfer_size_store);
 
+static ssize_t wq_max_batch_size_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+
+	return sprintf(buf, "%u\n", wq->max_batch_size);
+}
+
+static ssize_t wq_max_batch_size_store(struct device *dev, struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_device *idxd = wq->idxd;
+	u64 batch_size;
+	int rc;
+
+	if (wq->state != IDXD_WQ_DISABLED)
+		return -EPERM;
+
+	rc = __get_sysfs_u64(buf, &batch_size);
+	if (rc < 0)
+		return rc;
+
+	if (batch_size > idxd->max_batch_size)
+		return -EINVAL;
+
+	wq->max_batch_size = (u32)batch_size;
+
+	return count;
+}
+
+static struct device_attribute dev_attr_wq_max_batch_size =
+		__ATTR(max_batch_size, 0644, wq_max_batch_size_show, wq_max_batch_size_store);
+
 static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_clients.attr,
 	&dev_attr_wq_state.attr,
@@ -1114,6 +1158,7 @@ static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_name.attr,
 	&dev_attr_wq_cdev_minor.attr,
 	&dev_attr_wq_max_transfer_size.attr,
+	&dev_attr_wq_max_batch_size.attr,
 	NULL,
 };
 

