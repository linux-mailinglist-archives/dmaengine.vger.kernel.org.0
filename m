Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53C42562D3
	for <lists+dmaengine@lfdr.de>; Sat, 29 Aug 2020 00:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgH1WMM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Aug 2020 18:12:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:1966 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgH1WMM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Aug 2020 18:12:12 -0400
IronPort-SDR: 4EcHNwk51KpiM0Y2e2CxhSxJvTP541d4D6nk+hgK49tCtwsCHamlaDemA6eH1dWQTec0wyphXq
 CglPerTm0nnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="136296890"
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="136296890"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 15:12:11 -0700
IronPort-SDR: /k4RU2039CSnmIQRtgk6uWAjK7nENUdbE3/ZXXIemGHnsgLLOKUttcqyR6JQY+eNX9p4VCFjxr
 3gUm615OzJgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="340022276"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007.jf.intel.com with ESMTP; 28 Aug 2020 15:12:10 -0700
Subject: [PATCH v2 1/2] dmaengine: idxd: add support for configurable max wq
 xfer size
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Fri, 28 Aug 2020 15:12:10 -0700
Message-ID: <159865265404.29141.3049399618578194052.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add sysfs attribute max_xfer_size to wq in order to allow the max xfer
size configured on a per wq basis. Add support code to configure
the valid user input on wq enable. This is a performance tuning
parameter.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v2:
- Added ABI documentation (Vinod)

 Documentation/ABI/stable/sysfs-driver-dma-idxd |    7 ++++
 drivers/dma/idxd/device.c                      |    2 +
 drivers/dma/idxd/idxd.h                        |    1 +
 drivers/dma/idxd/init.c                        |    1 +
 drivers/dma/idxd/sysfs.c                       |   40 ++++++++++++++++++++++++
 5 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 1af9c4175213..452f353b4748 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -170,6 +170,13 @@ Contact:        dmaengine@vger.kernel.org
 Description:    The number of entries in this work queue that may be filled
 		via a limited portal.
 
+What:		/sys/bus/dsa/devices/wq<m>.<n>/max_transfer_size
+Date:		Aug 28, 2020
+KernelVersion:	5.10.0
+Contact:	dmaengine@vger.kernel.org
+Description:	The max transfer sized for this workqueue. Cannot exceed device
+		max transfer size. Configurable parameter.
+
 What:           /sys/bus/dsa/devices/engine<m>.<n>/group_id
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 14b45853aa5f..b8dbb7001933 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -529,7 +529,7 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 	wq->wqcfg.priority = wq->priority;
 
 	/* bytes 12-15 */
-	wq->wqcfg.max_xfer_shift = idxd->hw.gen_cap.max_xfer_shift;
+	wq->wqcfg.max_xfer_shift = ilog2(wq->max_xfer_bytes);
 	wq->wqcfg.max_batch_shift = idxd->hw.gen_cap.max_batch_shift;
 
 	dev_dbg(dev, "WQ %d CFGs\n", wq->id);
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index e62b4799d189..81db2a472822 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -114,6 +114,7 @@ struct idxd_wq {
 	struct sbitmap_queue sbq;
 	struct dma_chan dma_chan;
 	char name[WQ_NAME_SIZE + 1];
+	u64 max_xfer_bytes;
 };
 
 struct idxd_engine {
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index c7c61974f20f..e5ed5750a6d0 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -176,6 +176,7 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 		wq->idxd = idxd;
 		mutex_init(&wq->wq_lock);
 		wq->idxd_cdev.minor = -1;
+		wq->max_xfer_bytes = idxd->max_xfer_bytes;
 	}
 
 	for (i = 0; i < idxd->max_engines; i++) {
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index dcba60953217..a3bac7285975 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1064,6 +1064,45 @@ static ssize_t wq_cdev_minor_show(struct device *dev,
 static struct device_attribute dev_attr_wq_cdev_minor =
 		__ATTR(cdev_minor, 0444, wq_cdev_minor_show, NULL);
 
+static ssize_t wq_max_transfer_size_show(struct device *dev, struct device_attribute *attr,
+					 char *buf)
+{
+	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+
+	return sprintf(buf, "%llu\n", wq->max_xfer_bytes);
+}
+
+static ssize_t wq_max_transfer_size_store(struct device *dev, struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_device *idxd = wq->idxd;
+	u64 xfer_size;
+	int rc;
+
+	if (wq->state != IDXD_WQ_DISABLED)
+		return -EPERM;
+
+	rc = kstrtou64(buf, 0, &xfer_size);
+	if (rc < 0)
+		return -EINVAL;
+
+	if (xfer_size == 0)
+		return -EINVAL;
+
+	xfer_size = roundup_pow_of_two(xfer_size);
+	if (xfer_size > idxd->max_xfer_bytes)
+		return -EINVAL;
+
+	wq->max_xfer_bytes = xfer_size;
+
+	return count;
+}
+
+static struct device_attribute dev_attr_wq_max_transfer_size =
+		__ATTR(max_transfer_size, 0644,
+		       wq_max_transfer_size_show, wq_max_transfer_size_store);
+
 static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_clients.attr,
 	&dev_attr_wq_state.attr,
@@ -1074,6 +1113,7 @@ static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_type.attr,
 	&dev_attr_wq_name.attr,
 	&dev_attr_wq_cdev_minor.attr,
+	&dev_attr_wq_max_transfer_size.attr,
 	NULL,
 };
 

