Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD07990DB
	for <lists+dmaengine@lfdr.de>; Fri,  8 Sep 2023 22:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbjIHUKx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Sep 2023 16:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjIHUKu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Sep 2023 16:10:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE978E;
        Fri,  8 Sep 2023 13:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694203844; x=1725739844;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cyNIqzHzFbt3kTtjv0BnfNWVtOBRC0rRScqzT/ho4ig=;
  b=aqbbxHZpvZ71vrU2ZB9BE+NS5mfxUQqpTo4arsMbZ07YXO45bWvotxqA
   FItUZakz0YunwknsolsH0G4+mafvbh8j4EYh/gBKC/McaHqJe9Be4yRj/
   Ny/sezSB8igsdO656wkrguZgnMPChD6dtiB3KovkygjoI4J88aZ8LG4PW
   u4/b16iwE2WUvbHsw6vsPIOgg00yy3N/06dTSNRHMWy+g3cSeSBdPBBU/
   TWLahQtkH/Spr9tI2K1DrV+tmk4Om0FXa1yBDMnahv4hr2YqmfiwIWLUI
   LDX+TjI/4NeNS9sNlcAnIu+zHsh97T5WW6g/Mqzi1yj7Xkn1mdlQWUyWA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="408716854"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="408716854"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 13:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="812678393"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="812678393"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga004.fm.intel.com with ESMTP; 08 Sep 2023 13:10:44 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] dmaengine: idxd: add wq driver name support for accel-config user tool
Date:   Fri,  8 Sep 2023 13:10:45 -0700
Message-Id: <20230908201045.4115614-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---

Hi, Vinod,

This patch is part of IAA crypto patch series:
https://lore.kernel.org/all/20230731212939.1391453-2-tom.zanussi@linux.intel.com/
I'm sending this patch indepentantly here because:
1. the IAA crypto patch series is unlikely to be merged into 6.7
2. this patch is useful by itself in a few other places
3. this patch doesn't depend on the IAA crypto patch set and can
   be used and applied cleanly by itself
4. this patch has only dmaengine code

So it would be good to merge this patch into 6.7 first. An updated
IAA crypto patch set will be submitted later after 6.7 time frame
and merged in a later kernel version.

 .../ABI/stable/sysfs-driver-dma-idxd          |  6 ++++
 drivers/dma/idxd/cdev.c                       |  7 ++++
 drivers/dma/idxd/dma.c                        |  6 ++++
 drivers/dma/idxd/idxd.h                       |  9 +++++
 drivers/dma/idxd/sysfs.c                      | 34 +++++++++++++++++++
 include/uapi/linux/idxd.h                     |  1 +
 6 files changed, 63 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 825e619250bf..982e9f3b80e2 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -270,6 +270,12 @@ Description:	Shows the operation capability bits displayed in bitmap format
 		correlates to the operations allowed. It's visible only
 		on platforms that support the capability.
 
+What:		/sys/bus/dsa/devices/wq<m>.<n>/driver_name
+Date:		Sept 8, 2023
+KernelVersion:	6.7.0
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
index 07623fb0f52f..47a01893cfdb 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -306,6 +306,12 @@ static int idxd_dmaengine_drv_probe(struct idxd_dev *idxd_dev)
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
index e269ca1f4862..1e89c80a07fc 100644
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
@@ -646,6 +650,11 @@ static inline void idxd_wqcfg_set_max_batch_shift(int idxd_type, union wqcfg *wq
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
index 7caba90d85b3..523ae0dff7d4 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1259,6 +1259,39 @@ static ssize_t wq_op_config_store(struct device *dev, struct device_attribute *a
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
@@ -1278,6 +1311,7 @@ static struct attribute *idxd_wq_attributes[] = {
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
2.37.1

