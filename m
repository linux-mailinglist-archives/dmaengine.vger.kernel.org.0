Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B346ACD16
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 19:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjCFSwt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 13:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjCFSwk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 13:52:40 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F11741B4E;
        Mon,  6 Mar 2023 10:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678128757; x=1709664757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oowziMwXwVGyoGa9lxmkLd9ABSwpuSTfsdgiXE790Ps=;
  b=N10jfWfuvdc1zFQza1b6LM2f0RikZCsF9tzAH/vhd6CKAiVvuzge0BD5
   fKkSOsBKiSYYj5dNM4hTv/VHafJAwPoAPRWhB0TbEhvjeV5N7dO0EqplN
   LrzemKLIkRXRiYx2XEduaWAJn8SiUF2QA+00qMgVEMjkUovd1BLRYuI8M
   Z2VuGbhiBvmBqwx9uABjj1yi10gLANHEDpDSV8OcvdXtVwCbHsWZj6/+U
   uCttXGXbWC8SX4HdcZS59RCgeXvm8hyH9/HDlPoqytaRE0pQbDUnKBfFh
   XtBA66wAenTjPUM2xGXTw7SriG8WEvbW7qhpet46ttGk5TNhETM5ehWRO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398227656"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398227656"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="626255730"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="626255730"
Received: from jeblanco-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.212.118.26])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:32 -0800
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 01/16] dmaengine: idxd: add wq driver name support for accel-config user tool
Date:   Mon,  6 Mar 2023 12:52:11 -0600
Message-Id: <20230306185226.26483-2-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
References: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

With the possibility of multiple wq drivers that can be bound to the wq,
the user config tool accel-config needs a way to know which wq driver to
bind to the wq. Introduce per wq driver_name sysfs attribute where the user
can indicate the driver to be bound to the wq. This allows accel-config to
just bind to the driver using wq->driver_name.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 .../ABI/stable/sysfs-driver-dma-idxd          |  6 ++++
 drivers/dma/idxd/cdev.c                       |  8 ++++++
 drivers/dma/idxd/dma.c                        |  6 ++++
 drivers/dma/idxd/idxd.h                       |  7 +++++
 drivers/dma/idxd/sysfs.c                      | 28 +++++++++++++++++++
 include/uapi/linux/idxd.h                     |  1 +
 6 files changed, 56 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 3becc9a82bdf..e9a37e064193 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -244,6 +244,12 @@ Description:	Shows the operation capability bits displayed in bitmap format
 		correlates to the operations allowed. It's visible only
 		on platforms that support the capability.
 
+What:		/sys/bus/dsa/devices/wq<m>.<n>/driver_name
+Date:		Feb 23, 2023
+KernelVersion:	6.3.0
+Contact:	dmaengine@vger.kernel.org
+Description:	Name of driver to be bounded to the wq.
+
 What:           /sys/bus/dsa/devices/engine<m>.<n>/group_id
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 674bfefca088..f3d1604e753d 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -304,6 +304,7 @@ void idxd_wq_del_cdev(struct idxd_wq *wq)
 
 static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
 {
+	struct device *dev = &idxd_dev->conf_dev;
 	struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
 	struct idxd_device *idxd = wq->idxd;
 	int rc;
@@ -330,6 +331,13 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
 	}
 
 	mutex_lock(&wq->wq_lock);
+
+	if (!idxd_wq_driver_name_match(wq, dev)) {
+		idxd->cmd_status = IDXD_SCMD_WQ_NO_DRV_NAME;
+		rc = -ENODEV;
+		goto err;
+	}
+
 	wq->type = IDXD_WQT_USER;
 	rc = drv_enable_wq(wq);
 	if (rc < 0)
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index eb35ca313684..8bb7e7ff8d6a 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -305,6 +305,12 @@ static int idxd_dmaengine_drv_probe(struct idxd_dev *idxd_dev)
 		return -ENXIO;
 
 	mutex_lock(&wq->wq_lock);
+	if (!idxd_wq_driver_name_match(wq, dev)) {
+		idxd->cmd_status = IDXD_SCMD_WQ_NO_DRV_NAME;
+		rc = -ENODEV;
+		goto err;
+	}
+
 	wq->type = IDXD_WQT_KERNEL;
 
 	rc = drv_enable_wq(wq);
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 7ced8d283d98..505118fc19de 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -214,6 +214,8 @@ struct idxd_wq {
 	char name[WQ_NAME_SIZE + 1];
 	u64 max_xfer_bytes;
 	u32 max_batch_size;
+
+	char driver_name[WQ_NAME_SIZE + 1];
 };
 
 struct idxd_engine {
@@ -580,6 +582,11 @@ static inline void idxd_wqcfg_set_max_batch_shift(int idxd_type, union wqcfg *wq
 		wqcfg->max_batch_shift = max_batch_shift;
 }
 
+static inline int idxd_wq_driver_name_match(struct idxd_wq *wq, struct device *dev)
+{
+	return (strncmp(wq->driver_name, dev->driver->name, strlen(dev->driver->name)) == 0);
+}
+
 int __must_check __idxd_driver_register(struct idxd_device_driver *idxd_drv,
 					struct module *module, const char *mod_name);
 #define idxd_driver_register(driver) \
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 18cd8151dee0..cb5864c98d5a 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1224,6 +1224,33 @@ static ssize_t wq_op_config_store(struct device *dev, struct device_attribute *a
 static struct device_attribute dev_attr_wq_op_config =
 		__ATTR(op_config, 0644, wq_op_config_show, wq_op_config_store);
 
+static ssize_t wq_driver_name_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct idxd_wq *wq = confdev_to_wq(dev);
+
+	return sysfs_emit(buf, "%s\n", wq->driver_name);
+}
+
+static ssize_t wq_driver_name_store(struct device *dev, struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct idxd_wq *wq = confdev_to_wq(dev);
+
+	if (wq->state != IDXD_WQ_DISABLED)
+		return -EPERM;
+
+	if (strlen(buf) > WQ_NAME_SIZE || strlen(buf) == 0)
+		return -EINVAL;
+
+	memset(wq->driver_name, 0, WQ_NAME_SIZE + 1);
+	strncpy(wq->driver_name, buf, WQ_NAME_SIZE);
+	strreplace(wq->name, '\n', '\0');
+	return count;
+}
+
+static struct device_attribute dev_attr_wq_driver_name =
+		__ATTR(driver_name, 0644, wq_driver_name_show, wq_driver_name_store);
+
 static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_clients.attr,
 	&dev_attr_wq_state.attr,
@@ -1242,6 +1269,7 @@ static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_occupancy.attr,
 	&dev_attr_wq_enqcmds_retries.attr,
 	&dev_attr_wq_op_config.attr,
+	&dev_attr_wq_driver_name.attr,
 	NULL,
 };
 
diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index 1d553bedbdb5..2f85c8f59eb5 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -30,6 +30,7 @@ enum idxd_scmd_stat {
 	IDXD_SCMD_WQ_NO_PRIV = 0x800f0000,
 	IDXD_SCMD_WQ_IRQ_ERR = 0x80100000,
 	IDXD_SCMD_WQ_USER_NO_IOMMU = 0x80110000,
+	IDXD_SCMD_WQ_NO_DRV_NAME = 0x80200000,
 };
 
 #define IDXD_SCMD_SOFTERR_MASK	0x80000000
-- 
2.34.1

