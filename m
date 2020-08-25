Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856F82521F5
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 22:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgHYUZJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 16:25:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:61548 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYUZJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Aug 2020 16:25:09 -0400
IronPort-SDR: PmSsSGFxWX0IQd9HSFhLr4KPG55LeFpDHZ/B1IXl8MJyqnhlJs3miYm+TpntnfaId+uUT6q2nD
 TFHawQCQhYAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="143966328"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="143966328"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 13:25:08 -0700
IronPort-SDR: Ji7GbzIizgSWMEBMekqQJYIW4FZ2aiDj7mkw3o5pG30B56t6mjt3bkSRmvo5U8H4xWm5dPzZbi
 IORqHLefiJUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="338918192"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007.jf.intel.com with ESMTP; 25 Aug 2020 13:25:07 -0700
Subject: [PATCH 2/2] dmaengine: idxd: add support for configurable max wq
 batch size
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 25 Aug 2020 13:25:07 -0700
Message-ID: <159838710759.14812.4195210748462962591.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <159838710214.14812.7574610309412397859.stgit@djiang5-desk3.ch.intel.com>
References: <159838710214.14812.7574610309412397859.stgit@djiang5-desk3.ch.intel.com>
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
 drivers/dma/idxd/device.c |    2 +-
 drivers/dma/idxd/idxd.h   |    1 +
 drivers/dma/idxd/init.c   |    1 +
 drivers/dma/idxd/sysfs.c  |   38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 41 insertions(+), 1 deletion(-)

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
index 26b3ace66782..c5f19802cb9e 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1103,6 +1103,43 @@ static struct device_attribute dev_attr_wq_max_transfer_size =
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
+	u32 batch_size;
+	int rc;
+
+	if (wq->state != IDXD_WQ_DISABLED)
+		return -EPERM;
+
+	rc = kstrtou32(buf, 10, &batch_size);
+	if (rc < 0)
+		return -EINVAL;
+
+	if (batch_size == 0)
+		return -EINVAL;
+
+	batch_size = roundup_pow_of_two(batch_size);
+	if (batch_size > idxd->max_batch_size)
+		return -EINVAL;
+
+	wq->max_batch_size = batch_size;
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
@@ -1114,6 +1151,7 @@ static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_name.attr,
 	&dev_attr_wq_cdev_minor.attr,
 	&dev_attr_wq_max_transfer_size.attr,
+	&dev_attr_wq_max_batch_size.attr,
 	NULL,
 };
 

