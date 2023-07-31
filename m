Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BFB76A2A7
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jul 2023 23:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjGaV3t (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 17:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjGaV3s (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 17:29:48 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513A4126;
        Mon, 31 Jul 2023 14:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690838987; x=1722374987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wGNZTZdZ3vl0uz9s6q/PbHk9NU/vf0APCdkvTNbIklc=;
  b=ezD0ItSlpGgKK6QpJOvu70ut7TeZ+sVEgjn1DnKFZVD6w4S0KWGANIeE
   lMXGMv8yvVDUApparu7g7BHvNRQFD8ZjSbxi695/OLEyqmaDiRwQD5X3B
   qNKdi6mZapGT7B1zoxPL+LnWau/mk8QOwtkiC2/zBUb8yf2a6QBfxusiI
   4PkkeOVsGNHK3Ed1wmUyfUnvh4+d4RWNuCfHLH/88yQpkxWdoFOKyTy25
   8O1kOmEY+ZDpsnZ1zdFSPKehORac5P6IkvtRB1wRrws/zI1lfCp5dY8wm
   nyhV17QmEN79A/7ceOlQRzoYsBjjrRRwvpHOfyM7/qIVgNewPYGg1Egai
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="349425727"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="349425727"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 14:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="728428372"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="728428372"
Received: from sgimmeke-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.91.213])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 14:29:45 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v8 01/14] dmaengine: idxd: add wq driver name support for accel-config user tool
Date:   Mon, 31 Jul 2023 16:29:26 -0500
Message-Id: <20230731212939.1391453-2-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
References: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/dma/idxd/cdev.c                       |  7 ++++
 drivers/dma/idxd/dma.c                        |  6 ++++
 drivers/dma/idxd/idxd.h                       |  9 +++++
 drivers/dma/idxd/sysfs.c                      | 34 +++++++++++++++++++
 include/uapi/linux/idxd.h                     |  1 +
 6 files changed, 63 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 534b7a3d59fc..0e577209bee2 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -270,6 +270,12 @@ Description:	Shows the operation capability bits displayed in bitmap format
 		correlates to the operations allowed. It's visible only
 		on platforms that support the capability.
 
+What:		/sys/bus/dsa/devices/wq<m>.<n>/driver_name
+Date:		Mar 27, 2023
+KernelVersion:	6.6.0
+Contact:	dmaengine@vger.kernel.org
+Description:	Name of driver to be bounded to the wq.
+
 What:           /sys/bus/dsa/devices/engine<m>.<n>/group_id
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index d32deb9b4e3d..0423655f5a88 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -509,6 +509,7 @@ void idxd_wq_del_cdev(struct idxd_wq *wq)
 
 static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
 {
+	struct device *dev = &idxd_dev->conf_dev;
 	struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
 	struct idxd_device *idxd = wq->idxd;
 	int rc;
@@ -536,6 +537,12 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
 
 	mutex_lock(&wq->wq_lock);
 
+	if (!idxd_wq_driver_name_match(wq, dev)) {
+		idxd->cmd_status = IDXD_SCMD_WQ_NO_DRV_NAME;
+		rc = -ENODEV;
+		goto wq_err;
+	}
+
 	wq->wq = create_workqueue(dev_name(wq_confdev(wq)));
 	if (!wq->wq) {
 		rc = -ENOMEM;
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
index 5428a2e1b1ec..c62c78e1c9fa 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -159,6 +159,8 @@ struct idxd_cdev {
 	int minor;
 };
 
+#define DRIVER_NAME_SIZE		128
+
 #define IDXD_ALLOCATED_BATCH_SIZE	128U
 #define WQ_NAME_SIZE   1024
 #define WQ_TYPE_SIZE   10
@@ -227,6 +229,8 @@ struct idxd_wq {
 	/* Lock to protect upasid_xa access. */
 	struct mutex uc_lock;
 	struct xarray upasid_xa;
+
+	char driver_name[DRIVER_NAME_SIZE + 1];
 };
 
 struct idxd_engine {
@@ -637,6 +641,11 @@ static inline void idxd_wqcfg_set_max_batch_shift(int idxd_type, union wqcfg *wq
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
index 293739ac5596..92b2a1653f30 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1266,6 +1266,39 @@ static ssize_t wq_op_config_store(struct device *dev, struct device_attribute *a
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
+	char *input, *pos;
+
+	if (wq->state != IDXD_WQ_DISABLED)
+		return -EPERM;
+
+	if (strlen(buf) > DRIVER_NAME_SIZE || strlen(buf) == 0)
+		return -EINVAL;
+
+	input = kstrndup(buf, count, GFP_KERNEL);
+	if (!input)
+		return -ENOMEM;
+
+	pos = strim(input);
+	memset(wq->driver_name, 0, DRIVER_NAME_SIZE + 1);
+	sprintf(wq->driver_name, "%s", pos);
+	kfree(input);
+	return count;
+}
+
+static struct device_attribute dev_attr_wq_driver_name =
+		__ATTR(driver_name, 0644, wq_driver_name_show, wq_driver_name_store);
+
 static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_clients.attr,
 	&dev_attr_wq_state.attr,
@@ -1285,6 +1318,7 @@ static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_occupancy.attr,
 	&dev_attr_wq_enqcmds_retries.attr,
 	&dev_attr_wq_op_config.attr,
+	&dev_attr_wq_driver_name.attr,
 	NULL,
 };
 
diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index 606b52e88ce3..3d1987e1bb2d 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -31,6 +31,7 @@ enum idxd_scmd_stat {
 	IDXD_SCMD_WQ_IRQ_ERR = 0x80100000,
 	IDXD_SCMD_WQ_USER_NO_IOMMU = 0x80110000,
 	IDXD_SCMD_DEV_EVL_ERR = 0x80120000,
+	IDXD_SCMD_WQ_NO_DRV_NAME = 0x80200000,
 };
 
 #define IDXD_SCMD_SOFTERR_MASK	0x80000000
-- 
2.34.1

