Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2795353004
	for <lists+dmaengine@lfdr.de>; Fri,  2 Apr 2021 21:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhDBT5a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Apr 2021 15:57:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:2714 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhDBT5a (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 2 Apr 2021 15:57:30 -0400
IronPort-SDR: 8SwosnpwchiZs/S7AzcMjU+kg8t9rjuijU/xbKCPBuaXaq9Xe5Tx0870utArbkaC8oyLviflw9
 dLxRx4wTmrSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="192008295"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="192008295"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 12:57:29 -0700
IronPort-SDR: 5TNm4RZGTZmfDlFMwChB1MTPsTeq/4nIvqhmxmFS9OwcR3UePGpqRV2HNTTv9Kxfhlg26ot2D+
 cJsesTXPiYNw==
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="611408479"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 12:57:28 -0700
Subject: [PATCH v9 06/11] dmaengine: idxd: fix wq conf_dev 'struct device'
 lifetime
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>, dmaengine@vger.kernel.org
Date:   Fri, 02 Apr 2021 12:57:28 -0700
Message-ID: <161739344837.2945060.13120844486863527522.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
References: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove devm_* allocation and fix wq->conf_dev 'struct device' lifetime.
Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
functions in order to free the allocated memory for the wq context at
device destruction time.

Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    6 +--
 drivers/dma/idxd/idxd.h   |   20 ++++++++-
 drivers/dma/idxd/init.c   |  105 +++++++++++++++++++++++++++++++++------------
 drivers/dma/idxd/irq.c    |    6 +--
 drivers/dma/idxd/sysfs.c  |  100 +++++++++++++++++++------------------------
 5 files changed, 146 insertions(+), 91 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index a56af1d8b091..2292d7bfef58 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -515,7 +515,7 @@ void idxd_device_wqs_clear_state(struct idxd_device *idxd)
 	lockdep_assert_held(&idxd->dev_lock);
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		if (wq->state == IDXD_WQ_ENABLED) {
 			idxd_wq_disable_cleanup(wq);
@@ -696,7 +696,7 @@ static int idxd_wqs_config_write(struct idxd_device *idxd)
 	int i, rc;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		rc = idxd_wq_config_write(wq);
 		if (rc < 0)
@@ -774,7 +774,7 @@ static int idxd_wqs_setup(struct idxd_device *idxd)
 	}
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		wq = &idxd->wqs[i];
+		wq = idxd->wqs[i];
 		group = wq->group;
 
 		if (!wq->group)
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index dac5ca6fde32..bec5686b6ddd 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -194,7 +194,7 @@ struct idxd_device {
 	spinlock_t dev_lock;	/* spinlock for device */
 	struct completion *cmd_done;
 	struct idxd_group *groups;
-	struct idxd_wq *wqs;
+	struct idxd_wq **wqs;
 	struct idxd_engine *engines;
 
 	struct iommu_sva *sva;
@@ -258,6 +258,7 @@ extern struct bus_type iax_bus_type;
 extern bool support_enqcmd;
 extern struct device_type dsa_device_type;
 extern struct device_type iax_device_type;
+extern struct device_type idxd_wq_device_type;
 
 static inline bool is_dsa_dev(struct device *dev)
 {
@@ -274,6 +275,23 @@ static inline bool is_idxd_dev(struct device *dev)
 	return is_dsa_dev(dev) || is_iax_dev(dev);
 }
 
+static inline bool is_idxd_wq_dev(struct device *dev)
+{
+	return dev->type == &idxd_wq_device_type;
+}
+
+static inline bool is_idxd_wq_dmaengine(struct idxd_wq *wq)
+{
+	if (wq->type == IDXD_WQT_KERNEL && strcmp(wq->name, "dmaengine") == 0)
+		return true;
+	return false;
+}
+
+static inline bool is_idxd_wq_cdev(struct idxd_wq *wq)
+{
+	return wq->type == IDXD_WQT_USER;
+}
+
 static inline bool wq_dedicated(struct idxd_wq *wq)
 {
 	return test_bit(WQ_FLAG_DEDICATED, &wq->flags);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 1c6731764d62..983fbabe2ad7 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -153,16 +153,74 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 	return rc;
 }
 
+static int idxd_setup_wqs(struct idxd_device *idxd)
+{
+	struct device *dev = &idxd->pdev->dev;
+	struct idxd_wq *wq;
+	int i, rc;
+
+	idxd->wqs = kcalloc_node(idxd->max_wqs, sizeof(struct idxd_wq *),
+				 GFP_KERNEL, dev_to_node(dev));
+	if (!idxd->wqs)
+		return -ENOMEM;
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
+		if (!wq) {
+			rc = -ENOMEM;
+			goto err;
+		}
+
+		wq->id = i;
+		wq->idxd = idxd;
+		device_initialize(&wq->conf_dev);
+		wq->conf_dev.parent = &idxd->conf_dev;
+		wq->conf_dev.bus = idxd_get_bus_type(idxd);
+		wq->conf_dev.type = &idxd_wq_device_type;
+		rc = dev_set_name(&wq->conf_dev, "wq%d.%d", idxd->id, wq->id);
+		if (rc < 0) {
+			put_device(&wq->conf_dev);
+			goto err;
+		}
+
+		mutex_init(&wq->wq_lock);
+		wq->idxd_cdev.minor = -1;
+		wq->max_xfer_bytes = idxd->max_xfer_bytes;
+		wq->max_batch_size = idxd->max_batch_size;
+		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
+		if (!wq->wqcfg) {
+			put_device(&wq->conf_dev);
+			rc = -ENOMEM;
+			goto err;
+		}
+		idxd->wqs[i] = wq;
+	}
+
+	return 0;
+
+ err:
+	while (--i >= 0)
+		put_device(&idxd->wqs[i]->conf_dev);
+	return rc;
+}
+
 static int idxd_setup_internals(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
-	int i;
+	int i, rc;
 
 	init_waitqueue_head(&idxd->cmd_waitq);
+
+	rc = idxd_setup_wqs(idxd);
+	if (rc < 0)
+		return rc;
+
 	idxd->groups = devm_kcalloc(dev, idxd->max_groups,
 				    sizeof(struct idxd_group), GFP_KERNEL);
-	if (!idxd->groups)
-		return -ENOMEM;
+	if (!idxd->groups) {
+		rc = -ENOMEM;
+		goto err;
+	}
 
 	for (i = 0; i < idxd->max_groups; i++) {
 		idxd->groups[i].idxd = idxd;
@@ -171,40 +229,31 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 		idxd->groups[i].tc_b = -1;
 	}
 
-	idxd->wqs = devm_kcalloc(dev, idxd->max_wqs, sizeof(struct idxd_wq),
-				 GFP_KERNEL);
-	if (!idxd->wqs)
-		return -ENOMEM;
-
 	idxd->engines = devm_kcalloc(dev, idxd->max_engines,
 				     sizeof(struct idxd_engine), GFP_KERNEL);
-	if (!idxd->engines)
-		return -ENOMEM;
-
-	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
-
-		wq->id = i;
-		wq->idxd = idxd;
-		mutex_init(&wq->wq_lock);
-		wq->idxd_cdev.minor = -1;
-		wq->max_xfer_bytes = idxd->max_xfer_bytes;
-		wq->max_batch_size = idxd->max_batch_size;
-		wq->wqcfg = devm_kzalloc(dev, idxd->wqcfg_size, GFP_KERNEL);
-		if (!wq->wqcfg)
-			return -ENOMEM;
+	if (!idxd->engines) {
+		rc = -ENOMEM;
+		goto err;
 	}
 
+
 	for (i = 0; i < idxd->max_engines; i++) {
 		idxd->engines[i].idxd = idxd;
 		idxd->engines[i].id = i;
 	}
 
 	idxd->wq = create_workqueue(dev_name(dev));
-	if (!idxd->wq)
-		return -ENOMEM;
+	if (!idxd->wq) {
+		rc = -ENOMEM;
+		goto err;
+	}
 
 	return 0;
+
+ err:
+	for (i = 0; i < idxd->max_wqs; i++)
+		put_device(&idxd->wqs[i]->conf_dev);
+	return rc;
 }
 
 static void idxd_read_table_offsets(struct idxd_device *idxd)
@@ -379,11 +428,11 @@ static int idxd_probe(struct idxd_device *idxd)
 
 	rc = idxd_setup_internals(idxd);
 	if (rc)
-		goto err_setup;
+		goto err;
 
 	rc = idxd_setup_interrupts(idxd);
 	if (rc)
-		goto err_setup;
+		goto err;
 
 	dev_dbg(dev, "IDXD interrupt setup complete.\n");
 
@@ -392,7 +441,7 @@ static int idxd_probe(struct idxd_device *idxd)
 	dev_dbg(dev, "IDXD device %d probed successfully\n", idxd->id);
 	return 0;
 
- err_setup:
+ err:
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
 	return rc;
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index f1463fc58112..7b0181532f77 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -45,7 +45,7 @@ static void idxd_device_reinit(struct work_struct *work)
 		goto out;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		if (wq->state == IDXD_WQ_ENABLED) {
 			rc = idxd_wq_enable(wq);
@@ -130,7 +130,7 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 
 		if (idxd->sw_err.valid && idxd->sw_err.wq_idx_valid) {
 			int id = idxd->sw_err.wq_idx;
-			struct idxd_wq *wq = &idxd->wqs[id];
+			struct idxd_wq *wq = idxd->wqs[id];
 
 			if (wq->type == IDXD_WQT_USER)
 				wake_up_interruptible(&wq->idxd_cdev.err_queue);
@@ -138,7 +138,7 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 			int i;
 
 			for (i = 0; i < idxd->max_wqs; i++) {
-				struct idxd_wq *wq = &idxd->wqs[i];
+				struct idxd_wq *wq = idxd->wqs[i];
 
 				if (wq->type == IDXD_WQT_USER)
 					wake_up_interruptible(&wq->idxd_cdev.err_queue);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 651f1dec8ccd..d3f9b2bc2780 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -26,34 +26,11 @@ static struct device_type idxd_group_device_type = {
 	.release = idxd_conf_sub_device_release,
 };
 
-static struct device_type idxd_wq_device_type = {
-	.name = "wq",
-	.release = idxd_conf_sub_device_release,
-};
-
 static struct device_type idxd_engine_device_type = {
 	.name = "engine",
 	.release = idxd_conf_sub_device_release,
 };
 
-static inline bool is_idxd_wq_dev(struct device *dev)
-{
-	return dev ? dev->type == &idxd_wq_device_type : false;
-}
-
-static inline bool is_idxd_wq_dmaengine(struct idxd_wq *wq)
-{
-	if (wq->type == IDXD_WQT_KERNEL &&
-	    strcmp(wq->name, "dmaengine") == 0)
-		return true;
-	return false;
-}
-
-static inline bool is_idxd_wq_cdev(struct idxd_wq *wq)
-{
-	return wq->type == IDXD_WQT_USER;
-}
-
 static int idxd_config_bus_match(struct device *dev,
 				 struct device_driver *drv)
 {
@@ -302,7 +279,7 @@ static int idxd_config_bus_remove(struct device *dev)
 		dev_dbg(dev, "%s removing dev %s\n", __func__,
 			dev_name(&idxd->conf_dev));
 		for (i = 0; i < idxd->max_wqs; i++) {
-			struct idxd_wq *wq = &idxd->wqs[i];
+			struct idxd_wq *wq = idxd->wqs[i];
 
 			if (wq->state == IDXD_WQ_DISABLED)
 				continue;
@@ -314,7 +291,7 @@ static int idxd_config_bus_remove(struct device *dev)
 		idxd_unregister_dma_device(idxd);
 		rc = idxd_device_disable(idxd);
 		for (i = 0; i < idxd->max_wqs; i++) {
-			struct idxd_wq *wq = &idxd->wqs[i];
+			struct idxd_wq *wq = idxd->wqs[i];
 
 			mutex_lock(&wq->wq_lock);
 			idxd_wq_disable_cleanup(wq);
@@ -683,7 +660,7 @@ static ssize_t group_work_queues_show(struct device *dev,
 	struct idxd_device *idxd = group->idxd;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		if (!wq->group)
 			continue;
@@ -940,7 +917,7 @@ static int total_claimed_wq_size(struct idxd_device *idxd)
 	int wq_size = 0;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		wq_size += wq->size;
 	}
@@ -1336,6 +1313,20 @@ static const struct attribute_group *idxd_wq_attribute_groups[] = {
 	NULL,
 };
 
+static void idxd_conf_wq_release(struct device *dev)
+{
+	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+
+	kfree(wq->wqcfg);
+	kfree(wq);
+}
+
+struct device_type idxd_wq_device_type = {
+	.name = "wq",
+	.release = idxd_conf_wq_release,
+	.groups = idxd_wq_attribute_groups,
+};
+
 /* IDXD device attribs */
 static ssize_t version_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
@@ -1460,7 +1451,7 @@ static ssize_t clients_show(struct device *dev,
 
 	spin_lock_irqsave(&idxd->dev_lock, flags);
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		count += wq->client_count;
 	}
@@ -1710,70 +1701,67 @@ static int idxd_setup_group_sysfs(struct idxd_device *idxd)
 	return rc;
 }
 
-static int idxd_setup_wq_sysfs(struct idxd_device *idxd)
+static int idxd_register_wq_devices(struct idxd_device *idxd)
 {
-	struct device *dev = &idxd->pdev->dev;
-	int i, rc;
+	int i, rc, j;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
-
-		wq->conf_dev.parent = &idxd->conf_dev;
-		dev_set_name(&wq->conf_dev, "wq%d.%d", idxd->id, wq->id);
-		wq->conf_dev.bus = idxd_get_bus_type(idxd);
-		wq->conf_dev.groups = idxd_wq_attribute_groups;
-		wq->conf_dev.type = &idxd_wq_device_type;
-		dev_dbg(dev, "WQ device register: %s\n",
-			dev_name(&wq->conf_dev));
-		rc = device_register(&wq->conf_dev);
-		if (rc < 0) {
-			put_device(&wq->conf_dev);
+		struct idxd_wq *wq = idxd->wqs[i];
+
+		rc = device_add(&wq->conf_dev);
+		if (rc < 0)
 			goto cleanup;
-		}
 	}
 
 	return 0;
 
 cleanup:
-	while (i--) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+	j = i - 1;
+	for (; i < idxd->max_wqs; i++)
+		put_device(&idxd->wqs[i]->conf_dev);
 
-		device_unregister(&wq->conf_dev);
-	}
+	while (j--)
+		device_unregister(&idxd->wqs[j]->conf_dev);
 	return rc;
 }
 
 int idxd_register_devices(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
-	int rc;
+	int rc, i;
 
 	rc = device_add(&idxd->conf_dev);
 	if (rc < 0)
 		return rc;
 
-	rc = idxd_setup_wq_sysfs(idxd);
+	rc = idxd_register_wq_devices(idxd);
 	if (rc < 0) {
-		/* unregister conf dev */
-		dev_dbg(dev, "Work Queue sysfs registering failed: %d\n", rc);
-		return rc;
+		dev_dbg(dev, "WQ devices registering failed: %d\n", rc);
+		goto err_wq;
 	}
 
 	rc = idxd_setup_group_sysfs(idxd);
 	if (rc < 0) {
 		/* unregister conf dev */
 		dev_dbg(dev, "Group sysfs registering failed: %d\n", rc);
-		return rc;
+		goto err;
 	}
 
 	rc = idxd_setup_engine_sysfs(idxd);
 	if (rc < 0) {
 		/* unregister conf dev */
 		dev_dbg(dev, "Engine sysfs registering failed: %d\n", rc);
-		return rc;
+		goto err;
 	}
 
 	return 0;
+
+ err:
+	for (i = 0; i < idxd->max_wqs; i++)
+		device_unregister(&idxd->wqs[i]->conf_dev);
+ err_wq:
+	device_del(&idxd->conf_dev);
+	return rc;
 }
 
 void idxd_unregister_devices(struct idxd_device *idxd)
@@ -1781,7 +1769,7 @@ void idxd_unregister_devices(struct idxd_device *idxd)
 	int i;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		device_unregister(&wq->conf_dev);
 	}


