Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D7A3CA61C
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 20:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbhGOSqR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Jul 2021 14:46:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:21194 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhGOSqQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Jul 2021 14:46:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="190289111"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="190289111"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:43:21 -0700
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="430935921"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:43:21 -0700
Subject: [PATCH v3 03/18] dmaengine: idxd: add 'struct idxd_dev' as wrapper
 for conf_dev
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Thu, 15 Jul 2021 11:43:20 -0700
Message-ID: <162637460065.744545.584492831446090984.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
References: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a 'struct idxd_dev' that wraps the 'struct device' for idxd conf_dev
that registers with the dsa bus. This is introduced in order to deal with
multiple different types of 'devices' that are registered on the dsa_bus
when the compat driver needs to route them to the correct driver to attach.
The bind() call now can determine the type of device and then do the
appropriate driver matching.

Reviewed-by Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/cdev.c  |   11 +-
 drivers/dma/idxd/dma.c   |    4 -
 drivers/dma/idxd/idxd.h  |   82 ++++++++++++++--
 drivers/dma/idxd/init.c  |   96 +++++++++++-------
 drivers/dma/idxd/irq.c   |    2 
 drivers/dma/idxd/sysfs.c |  241 +++++++++++++++++++++-------------------------
 6 files changed, 251 insertions(+), 185 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index e9def577c697..18a003b93812 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -41,7 +41,7 @@ struct idxd_user_context {
 
 static void idxd_cdev_dev_release(struct device *dev)
 {
-	struct idxd_cdev *idxd_cdev = container_of(dev, struct idxd_cdev, dev);
+	struct idxd_cdev *idxd_cdev = dev_to_cdev(dev);
 	struct idxd_cdev_context *cdev_ctx;
 	struct idxd_wq *wq = idxd_cdev->wq;
 
@@ -256,9 +256,10 @@ int idxd_wq_add_cdev(struct idxd_wq *wq)
 	if (!idxd_cdev)
 		return -ENOMEM;
 
+	idxd_cdev->idxd_dev.type = IDXD_DEV_CDEV;
 	idxd_cdev->wq = wq;
 	cdev = &idxd_cdev->cdev;
-	dev = &idxd_cdev->dev;
+	dev = cdev_dev(idxd_cdev);
 	cdev_ctx = &ictx[wq->idxd->data->type];
 	minor = ida_simple_get(&cdev_ctx->minor_ida, 0, MINORMASK, GFP_KERNEL);
 	if (minor < 0) {
@@ -268,7 +269,7 @@ int idxd_wq_add_cdev(struct idxd_wq *wq)
 	idxd_cdev->minor = minor;
 
 	device_initialize(dev);
-	dev->parent = &wq->conf_dev;
+	dev->parent = wq_confdev(wq);
 	dev->bus = &dsa_bus_type;
 	dev->type = &idxd_cdev_device_type;
 	dev->devt = MKDEV(MAJOR(cdev_ctx->devt), minor);
@@ -299,8 +300,8 @@ void idxd_wq_del_cdev(struct idxd_wq *wq)
 
 	idxd_cdev = wq->idxd_cdev;
 	wq->idxd_cdev = NULL;
-	cdev_device_del(&idxd_cdev->cdev, &idxd_cdev->dev);
-	put_device(&idxd_cdev->dev);
+	cdev_device_del(&idxd_cdev->cdev, cdev_dev(idxd_cdev));
+	put_device(cdev_dev(idxd_cdev));
 }
 
 int idxd_cdev_register(void)
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index 77439b645044..2e52f9a50519 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -245,7 +245,7 @@ int idxd_register_dma_channel(struct idxd_wq *wq)
 
 	wq->idxd_chan = idxd_chan;
 	idxd_chan->wq = wq;
-	get_device(&wq->conf_dev);
+	get_device(wq_confdev(wq));
 
 	return 0;
 }
@@ -260,5 +260,5 @@ void idxd_unregister_dma_channel(struct idxd_wq *wq)
 	list_del(&chan->device_node);
 	kfree(wq->idxd_chan);
 	wq->idxd_chan = NULL;
-	put_device(&wq->conf_dev);
+	put_device(wq_confdev(wq));
 }
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index b1e4fd202d7e..8e62b647898f 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -17,8 +17,24 @@
 
 extern struct kmem_cache *idxd_desc_pool;
 
-struct idxd_device;
 struct idxd_wq;
+struct idxd_dev;
+
+enum idxd_dev_type {
+	IDXD_DEV_NONE = -1,
+	IDXD_DEV_DSA = 0,
+	IDXD_DEV_IAX,
+	IDXD_DEV_WQ,
+	IDXD_DEV_GROUP,
+	IDXD_DEV_ENGINE,
+	IDXD_DEV_CDEV,
+	IDXD_DEV_MAX_TYPE,
+};
+
+struct idxd_dev {
+	struct device conf_dev;
+	enum idxd_dev_type type;
+};
 
 #define IDXD_REG_TIMEOUT	50
 #define IDXD_DRAIN_TIMEOUT	5000
@@ -52,7 +68,7 @@ struct idxd_irq_entry {
 };
 
 struct idxd_group {
-	struct device conf_dev;
+	struct idxd_dev idxd_dev;
 	struct idxd_device *idxd;
 	struct grpcfg grpcfg;
 	int id;
@@ -111,7 +127,7 @@ enum idxd_wq_type {
 struct idxd_cdev {
 	struct idxd_wq *wq;
 	struct cdev cdev;
-	struct device dev;
+	struct idxd_dev idxd_dev;
 	int minor;
 };
 
@@ -139,7 +155,7 @@ struct idxd_wq {
 	void __iomem *portal;
 	struct percpu_ref wq_active;
 	struct completion wq_dead;
-	struct device conf_dev;
+	struct idxd_dev idxd_dev;
 	struct idxd_cdev *idxd_cdev;
 	struct wait_queue_head err_queue;
 	struct idxd_device *idxd;
@@ -174,7 +190,7 @@ struct idxd_wq {
 };
 
 struct idxd_engine {
-	struct device conf_dev;
+	struct idxd_dev idxd_dev;
 	int id;
 	struct idxd_group *group;
 	struct idxd_device *idxd;
@@ -218,7 +234,7 @@ struct idxd_driver_data {
 };
 
 struct idxd_device {
-	struct device conf_dev;
+	struct idxd_dev idxd_dev;
 	struct idxd_driver_data *data;
 	struct list_head list;
 	struct idxd_hw hw;
@@ -293,8 +309,58 @@ struct idxd_desc {
 	struct idxd_wq *wq;
 };
 
-#define confdev_to_idxd(dev) container_of(dev, struct idxd_device, conf_dev)
-#define confdev_to_wq(dev) container_of(dev, struct idxd_wq, conf_dev)
+#define idxd_confdev(idxd) &idxd->idxd_dev.conf_dev
+#define wq_confdev(wq) &wq->idxd_dev.conf_dev
+#define engine_confdev(engine) &engine->idxd_dev.conf_dev
+#define group_confdev(group) &group->idxd_dev.conf_dev
+#define cdev_dev(cdev) &cdev->idxd_dev.conf_dev
+
+#define confdev_to_idxd_dev(dev) container_of(dev, struct idxd_dev, conf_dev)
+
+static inline struct idxd_device *confdev_to_idxd(struct device *dev)
+{
+	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
+
+	return container_of(idxd_dev, struct idxd_device, idxd_dev);
+}
+
+static inline struct idxd_wq *confdev_to_wq(struct device *dev)
+{
+	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
+
+	return container_of(idxd_dev, struct idxd_wq, idxd_dev);
+}
+
+static inline struct idxd_engine *confdev_to_engine(struct device *dev)
+{
+	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
+
+	return container_of(idxd_dev, struct idxd_engine, idxd_dev);
+}
+
+static inline struct idxd_group *confdev_to_group(struct device *dev)
+{
+	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
+
+	return container_of(idxd_dev, struct idxd_group, idxd_dev);
+}
+
+static inline struct idxd_cdev *dev_to_cdev(struct device *dev)
+{
+	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
+
+	return container_of(idxd_dev, struct idxd_cdev, idxd_dev);
+}
+
+static inline void idxd_dev_set_type(struct idxd_dev *idev, int type)
+{
+	if (type >= IDXD_DEV_MAX_TYPE) {
+		idev->type = IDXD_DEV_NONE;
+		return;
+	}
+
+	idev->type = type;
+}
 
 extern struct bus_type dsa_bus_type;
 extern struct bus_type iax_bus_type;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 6b616ae47fc3..b4e105917b93 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -200,6 +200,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
 	struct idxd_wq *wq;
+	struct device *conf_dev;
 	int i, rc;
 
 	idxd->wqs = kcalloc_node(idxd->max_wqs, sizeof(struct idxd_wq *),
@@ -214,15 +215,17 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 			goto err;
 		}
 
+		idxd_dev_set_type(&wq->idxd_dev, IDXD_DEV_WQ);
+		conf_dev = wq_confdev(wq);
 		wq->id = i;
 		wq->idxd = idxd;
-		device_initialize(&wq->conf_dev);
-		wq->conf_dev.parent = &idxd->conf_dev;
-		wq->conf_dev.bus = &dsa_bus_type;
-		wq->conf_dev.type = &idxd_wq_device_type;
-		rc = dev_set_name(&wq->conf_dev, "wq%d.%d", idxd->id, wq->id);
+		device_initialize(wq_confdev(wq));
+		conf_dev->parent = idxd_confdev(idxd);
+		conf_dev->bus = &dsa_bus_type;
+		conf_dev->type = &idxd_wq_device_type;
+		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
 		if (rc < 0) {
-			put_device(&wq->conf_dev);
+			put_device(conf_dev);
 			goto err;
 		}
 
@@ -233,7 +236,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		wq->max_batch_size = idxd->max_batch_size;
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
-			put_device(&wq->conf_dev);
+			put_device(conf_dev);
 			rc = -ENOMEM;
 			goto err;
 		}
@@ -243,8 +246,11 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 	return 0;
 
  err:
-	while (--i >= 0)
-		put_device(&idxd->wqs[i]->conf_dev);
+	while (--i >= 0) {
+		wq = idxd->wqs[i];
+		conf_dev = wq_confdev(wq);
+		put_device(conf_dev);
+	}
 	return rc;
 }
 
@@ -252,6 +258,7 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 {
 	struct idxd_engine *engine;
 	struct device *dev = &idxd->pdev->dev;
+	struct device *conf_dev;
 	int i, rc;
 
 	idxd->engines = kcalloc_node(idxd->max_engines, sizeof(struct idxd_engine *),
@@ -266,15 +273,17 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 			goto err;
 		}
 
+		idxd_dev_set_type(&engine->idxd_dev, IDXD_DEV_ENGINE);
+		conf_dev = engine_confdev(engine);
 		engine->id = i;
 		engine->idxd = idxd;
-		device_initialize(&engine->conf_dev);
-		engine->conf_dev.parent = &idxd->conf_dev;
-		engine->conf_dev.bus = &dsa_bus_type;
-		engine->conf_dev.type = &idxd_engine_device_type;
-		rc = dev_set_name(&engine->conf_dev, "engine%d.%d", idxd->id, engine->id);
+		device_initialize(conf_dev);
+		conf_dev->parent = idxd_confdev(idxd);
+		conf_dev->bus = &dsa_bus_type;
+		conf_dev->type = &idxd_engine_device_type;
+		rc = dev_set_name(conf_dev, "engine%d.%d", idxd->id, engine->id);
 		if (rc < 0) {
-			put_device(&engine->conf_dev);
+			put_device(conf_dev);
 			goto err;
 		}
 
@@ -284,14 +293,18 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 	return 0;
 
  err:
-	while (--i >= 0)
-		put_device(&idxd->engines[i]->conf_dev);
+	while (--i >= 0) {
+		engine = idxd->engines[i];
+		conf_dev = engine_confdev(engine);
+		put_device(conf_dev);
+	}
 	return rc;
 }
 
 static int idxd_setup_groups(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
+	struct device *conf_dev;
 	struct idxd_group *group;
 	int i, rc;
 
@@ -307,15 +320,17 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 			goto err;
 		}
 
+		idxd_dev_set_type(&group->idxd_dev, IDXD_DEV_GROUP);
+		conf_dev = group_confdev(group);
 		group->id = i;
 		group->idxd = idxd;
-		device_initialize(&group->conf_dev);
-		group->conf_dev.parent = &idxd->conf_dev;
-		group->conf_dev.bus = &dsa_bus_type;
-		group->conf_dev.type = &idxd_group_device_type;
-		rc = dev_set_name(&group->conf_dev, "group%d.%d", idxd->id, group->id);
+		device_initialize(conf_dev);
+		conf_dev->parent = idxd_confdev(idxd);
+		conf_dev->bus = &dsa_bus_type;
+		conf_dev->type = &idxd_group_device_type;
+		rc = dev_set_name(conf_dev, "group%d.%d", idxd->id, group->id);
 		if (rc < 0) {
-			put_device(&group->conf_dev);
+			put_device(conf_dev);
 			goto err;
 		}
 
@@ -327,8 +342,10 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 	return 0;
 
  err:
-	while (--i >= 0)
-		put_device(&idxd->groups[i]->conf_dev);
+	while (--i >= 0) {
+		group = idxd->groups[i];
+		put_device(group_confdev(group));
+	}
 	return rc;
 }
 
@@ -337,11 +354,11 @@ static void idxd_cleanup_internals(struct idxd_device *idxd)
 	int i;
 
 	for (i = 0; i < idxd->max_groups; i++)
-		put_device(&idxd->groups[i]->conf_dev);
+		put_device(group_confdev(idxd->groups[i]));
 	for (i = 0; i < idxd->max_engines; i++)
-		put_device(&idxd->engines[i]->conf_dev);
+		put_device(engine_confdev(idxd->engines[i]));
 	for (i = 0; i < idxd->max_wqs; i++)
-		put_device(&idxd->wqs[i]->conf_dev);
+		put_device(wq_confdev(idxd->wqs[i]));
 	destroy_workqueue(idxd->wq);
 }
 
@@ -381,13 +398,13 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 
  err_wkq_create:
 	for (i = 0; i < idxd->max_groups; i++)
-		put_device(&idxd->groups[i]->conf_dev);
+		put_device(group_confdev(idxd->groups[i]));
  err_group:
 	for (i = 0; i < idxd->max_engines; i++)
-		put_device(&idxd->engines[i]->conf_dev);
+		put_device(engine_confdev(idxd->engines[i]));
  err_engine:
 	for (i = 0; i < idxd->max_wqs; i++)
-		put_device(&idxd->wqs[i]->conf_dev);
+		put_device(wq_confdev(idxd->wqs[i]));
  err_wqs:
 	kfree(idxd->int_handles);
 	return rc;
@@ -469,6 +486,7 @@ static void idxd_read_caps(struct idxd_device *idxd)
 static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
 {
 	struct device *dev = &pdev->dev;
+	struct device *conf_dev;
 	struct idxd_device *idxd;
 	int rc;
 
@@ -476,19 +494,21 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 	if (!idxd)
 		return NULL;
 
+	conf_dev = idxd_confdev(idxd);
 	idxd->pdev = pdev;
 	idxd->data = data;
+	idxd_dev_set_type(&idxd->idxd_dev, idxd->data->type);
 	idxd->id = ida_alloc(&idxd_ida, GFP_KERNEL);
 	if (idxd->id < 0)
 		return NULL;
 
-	device_initialize(&idxd->conf_dev);
-	idxd->conf_dev.parent = dev;
-	idxd->conf_dev.bus = &dsa_bus_type;
-	idxd->conf_dev.type = idxd->data->dev_type;
-	rc = dev_set_name(&idxd->conf_dev, "%s%d", idxd->data->name_prefix, idxd->id);
+	device_initialize(conf_dev);
+	conf_dev->parent = dev;
+	conf_dev->bus = &dsa_bus_type;
+	conf_dev->type = idxd->data->dev_type;
+	rc = dev_set_name(conf_dev, "%s%d", idxd->data->name_prefix, idxd->id);
 	if (rc < 0) {
-		put_device(&idxd->conf_dev);
+		put_device(conf_dev);
 		return NULL;
 	}
 
@@ -674,7 +694,7 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  err:
 	pci_iounmap(pdev, idxd->reg_base);
  err_iomap:
-	put_device(&idxd->conf_dev);
+	put_device(idxd_confdev(idxd));
  err_idxd_alloc:
 	pci_disable_device(pdev);
 	return rc;
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 7a2cf0512501..d974a2b45c59 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -51,7 +51,7 @@ static void idxd_device_reinit(struct work_struct *work)
 			rc = idxd_wq_enable(wq);
 			if (rc < 0) {
 				dev_warn(dev, "Unable to re-enable wq %s\n",
-					 dev_name(&wq->conf_dev));
+					 dev_name(wq_confdev(wq)));
 			}
 		}
 	}
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 1d71dbad85fc..be1ee748d754 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -164,7 +164,7 @@ static int enable_wq(struct idxd_wq *wq)
 	}
 
 	mutex_unlock(&wq->wq_lock);
-	dev_info(dev, "wq %s enabled\n", dev_name(&wq->conf_dev));
+	dev_info(dev, "wq %s enabled\n", dev_name(wq_confdev(wq)));
 
 	return 0;
 }
@@ -230,7 +230,7 @@ static void disable_wq(struct idxd_wq *wq)
 	struct device *dev = &idxd->pdev->dev;
 
 	mutex_lock(&wq->wq_lock);
-	dev_dbg(dev, "%s removing WQ %s\n", __func__, dev_name(&wq->conf_dev));
+	dev_dbg(dev, "%s removing WQ %s\n", __func__, dev_name(wq_confdev(wq)));
 	if (wq->state == IDXD_WQ_DISABLED) {
 		mutex_unlock(&wq->wq_lock);
 		return;
@@ -257,7 +257,7 @@ static void disable_wq(struct idxd_wq *wq)
 	wq->client_count = 0;
 	mutex_unlock(&wq->wq_lock);
 
-	dev_info(dev, "wq %s disabled\n", dev_name(&wq->conf_dev));
+	dev_info(dev, "wq %s disabled\n", dev_name(wq_confdev(wq)));
 }
 
 static int idxd_config_bus_remove(struct device *dev)
@@ -274,15 +274,15 @@ static int idxd_config_bus_remove(struct device *dev)
 		int i;
 
 		dev_dbg(dev, "%s removing dev %s\n", __func__,
-			dev_name(&idxd->conf_dev));
+			dev_name(idxd_confdev(idxd)));
 		for (i = 0; i < idxd->max_wqs; i++) {
 			struct idxd_wq *wq = idxd->wqs[i];
 
 			if (wq->state == IDXD_WQ_DISABLED)
 				continue;
 			dev_warn(dev, "Active wq %d on disable %s.\n", i,
-				 dev_name(&idxd->conf_dev));
-			device_release_driver(&wq->conf_dev);
+				 dev_name(wq_confdev(wq)));
+			device_release_driver(wq_confdev(wq));
 		}
 
 		idxd_unregister_dma_device(idxd);
@@ -329,8 +329,7 @@ void idxd_unregister_driver(void)
 static ssize_t engine_group_id_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	struct idxd_engine *engine =
-		container_of(dev, struct idxd_engine, conf_dev);
+	struct idxd_engine *engine = confdev_to_engine(dev);
 
 	if (engine->group)
 		return sysfs_emit(buf, "%d\n", engine->group->id);
@@ -342,8 +341,7 @@ static ssize_t engine_group_id_store(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t count)
 {
-	struct idxd_engine *engine =
-		container_of(dev, struct idxd_engine, conf_dev);
+	struct idxd_engine *engine = confdev_to_engine(dev);
 	struct idxd_device *idxd = engine->idxd;
 	long id;
 	int rc;
@@ -397,7 +395,7 @@ static const struct attribute_group *idxd_engine_attribute_groups[] = {
 
 static void idxd_conf_engine_release(struct device *dev)
 {
-	struct idxd_engine *engine = container_of(dev, struct idxd_engine, conf_dev);
+	struct idxd_engine *engine = confdev_to_engine(dev);
 
 	kfree(engine);
 }
@@ -427,8 +425,7 @@ static ssize_t group_tokens_reserved_show(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
-	struct idxd_group *group =
-		container_of(dev, struct idxd_group, conf_dev);
+	struct idxd_group *group = confdev_to_group(dev);
 
 	return sysfs_emit(buf, "%u\n", group->tokens_reserved);
 }
@@ -437,8 +434,7 @@ static ssize_t group_tokens_reserved_store(struct device *dev,
 					   struct device_attribute *attr,
 					   const char *buf, size_t count)
 {
-	struct idxd_group *group =
-		container_of(dev, struct idxd_group, conf_dev);
+	struct idxd_group *group = confdev_to_group(dev);
 	struct idxd_device *idxd = group->idxd;
 	unsigned long val;
 	int rc;
@@ -475,8 +471,7 @@ static ssize_t group_tokens_allowed_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct idxd_group *group =
-		container_of(dev, struct idxd_group, conf_dev);
+	struct idxd_group *group = confdev_to_group(dev);
 
 	return sysfs_emit(buf, "%u\n", group->tokens_allowed);
 }
@@ -485,8 +480,7 @@ static ssize_t group_tokens_allowed_store(struct device *dev,
 					  struct device_attribute *attr,
 					  const char *buf, size_t count)
 {
-	struct idxd_group *group =
-		container_of(dev, struct idxd_group, conf_dev);
+	struct idxd_group *group = confdev_to_group(dev);
 	struct idxd_device *idxd = group->idxd;
 	unsigned long val;
 	int rc;
@@ -520,8 +514,7 @@ static ssize_t group_use_token_limit_show(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
-	struct idxd_group *group =
-		container_of(dev, struct idxd_group, conf_dev);
+	struct idxd_group *group = confdev_to_group(dev);
 
 	return sysfs_emit(buf, "%u\n", group->use_token_limit);
 }
@@ -530,8 +523,7 @@ static ssize_t group_use_token_limit_store(struct device *dev,
 					   struct device_attribute *attr,
 					   const char *buf, size_t count)
 {
-	struct idxd_group *group =
-		container_of(dev, struct idxd_group, conf_dev);
+	struct idxd_group *group = confdev_to_group(dev);
 	struct idxd_device *idxd = group->idxd;
 	unsigned long val;
 	int rc;
@@ -563,8 +555,7 @@ static struct device_attribute dev_attr_group_use_token_limit =
 static ssize_t group_engines_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	struct idxd_group *group =
-		container_of(dev, struct idxd_group, conf_dev);
+	struct idxd_group *group = confdev_to_group(dev);
 	int i, rc = 0;
 	struct idxd_device *idxd = group->idxd;
 
@@ -592,8 +583,7 @@ static struct device_attribute dev_attr_group_engines =
 static ssize_t group_work_queues_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
-	struct idxd_group *group =
-		container_of(dev, struct idxd_group, conf_dev);
+	struct idxd_group *group = confdev_to_group(dev);
 	int i, rc = 0;
 	struct idxd_device *idxd = group->idxd;
 
@@ -622,8 +612,7 @@ static ssize_t group_traffic_class_a_show(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
-	struct idxd_group *group =
-		container_of(dev, struct idxd_group, conf_dev);
+	struct idxd_group *group = confdev_to_group(dev);
 
 	return sysfs_emit(buf, "%d\n", group->tc_a);
 }
@@ -632,8 +621,7 @@ static ssize_t group_traffic_class_a_store(struct device *dev,
 					   struct device_attribute *attr,
 					   const char *buf, size_t count)
 {
-	struct idxd_group *group =
-		container_of(dev, struct idxd_group, conf_dev);
+	struct idxd_group *group = confdev_to_group(dev);
 	struct idxd_device *idxd = group->idxd;
 	long val;
 	int rc;
@@ -663,8 +651,7 @@ static ssize_t group_traffic_class_b_show(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
-	struct idxd_group *group =
-		container_of(dev, struct idxd_group, conf_dev);
+	struct idxd_group *group = confdev_to_group(dev);
 
 	return sysfs_emit(buf, "%d\n", group->tc_b);
 }
@@ -673,8 +660,7 @@ static ssize_t group_traffic_class_b_store(struct device *dev,
 					   struct device_attribute *attr,
 					   const char *buf, size_t count)
 {
-	struct idxd_group *group =
-		container_of(dev, struct idxd_group, conf_dev);
+	struct idxd_group *group = confdev_to_group(dev);
 	struct idxd_device *idxd = group->idxd;
 	long val;
 	int rc;
@@ -722,7 +708,7 @@ static const struct attribute_group *idxd_group_attribute_groups[] = {
 
 static void idxd_conf_group_release(struct device *dev)
 {
-	struct idxd_group *group = container_of(dev, struct idxd_group, conf_dev);
+	struct idxd_group *group = confdev_to_group(dev);
 
 	kfree(group);
 }
@@ -737,7 +723,7 @@ struct device_type idxd_group_device_type = {
 static ssize_t wq_clients_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 
 	return sysfs_emit(buf, "%d\n", wq->client_count);
 }
@@ -748,7 +734,7 @@ static struct device_attribute dev_attr_wq_clients =
 static ssize_t wq_state_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 
 	switch (wq->state) {
 	case IDXD_WQ_DISABLED:
@@ -766,7 +752,7 @@ static struct device_attribute dev_attr_wq_state =
 static ssize_t wq_group_id_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 
 	if (wq->group)
 		return sysfs_emit(buf, "%u\n", wq->group->id);
@@ -778,7 +764,7 @@ static ssize_t wq_group_id_store(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 	struct idxd_device *idxd = wq->idxd;
 	long id;
 	int rc;
@@ -821,7 +807,7 @@ static struct device_attribute dev_attr_wq_group_id =
 static ssize_t wq_mode_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 
 	return sysfs_emit(buf, "%s\n", wq_dedicated(wq) ? "dedicated" : "shared");
 }
@@ -830,7 +816,7 @@ static ssize_t wq_mode_store(struct device *dev,
 			     struct device_attribute *attr, const char *buf,
 			     size_t count)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 	struct idxd_device *idxd = wq->idxd;
 
 	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
@@ -857,7 +843,7 @@ static struct device_attribute dev_attr_wq_mode =
 static ssize_t wq_size_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 
 	return sysfs_emit(buf, "%u\n", wq->size);
 }
@@ -880,7 +866,7 @@ static ssize_t wq_size_store(struct device *dev,
 			     struct device_attribute *attr, const char *buf,
 			     size_t count)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 	unsigned long size;
 	struct idxd_device *idxd = wq->idxd;
 	int rc;
@@ -908,7 +894,7 @@ static struct device_attribute dev_attr_wq_size =
 static ssize_t wq_priority_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 
 	return sysfs_emit(buf, "%u\n", wq->priority);
 }
@@ -917,7 +903,7 @@ static ssize_t wq_priority_store(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 	unsigned long prio;
 	struct idxd_device *idxd = wq->idxd;
 	int rc;
@@ -945,7 +931,7 @@ static struct device_attribute dev_attr_wq_priority =
 static ssize_t wq_block_on_fault_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 
 	return sysfs_emit(buf, "%u\n", test_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags));
 }
@@ -954,7 +940,7 @@ static ssize_t wq_block_on_fault_store(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t count)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 	struct idxd_device *idxd = wq->idxd;
 	bool bof;
 	int rc;
@@ -984,7 +970,7 @@ static struct device_attribute dev_attr_wq_block_on_fault =
 static ssize_t wq_threshold_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 
 	return sysfs_emit(buf, "%u\n", wq->threshold);
 }
@@ -993,7 +979,7 @@ static ssize_t wq_threshold_store(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 	struct idxd_device *idxd = wq->idxd;
 	unsigned int val;
 	int rc;
@@ -1025,7 +1011,7 @@ static struct device_attribute dev_attr_wq_threshold =
 static ssize_t wq_type_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 
 	switch (wq->type) {
 	case IDXD_WQT_KERNEL:
@@ -1044,7 +1030,7 @@ static ssize_t wq_type_store(struct device *dev,
 			     struct device_attribute *attr, const char *buf,
 			     size_t count)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 	enum idxd_wq_type old_type;
 
 	if (wq->state != IDXD_WQ_DISABLED)
@@ -1073,7 +1059,7 @@ static struct device_attribute dev_attr_wq_type =
 static ssize_t wq_name_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 
 	return sysfs_emit(buf, "%s\n", wq->name);
 }
@@ -1082,7 +1068,7 @@ static ssize_t wq_name_store(struct device *dev,
 			     struct device_attribute *attr, const char *buf,
 			     size_t count)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 
 	if (wq->state != IDXD_WQ_DISABLED)
 		return -EPERM;
@@ -1109,7 +1095,7 @@ static struct device_attribute dev_attr_wq_name =
 static ssize_t wq_cdev_minor_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 	int minor = -1;
 
 	mutex_lock(&wq->wq_lock);
@@ -1143,7 +1129,7 @@ static int __get_sysfs_u64(const char *buf, u64 *val)
 static ssize_t wq_max_transfer_size_show(struct device *dev, struct device_attribute *attr,
 					 char *buf)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 
 	return sysfs_emit(buf, "%llu\n", wq->max_xfer_bytes);
 }
@@ -1151,7 +1137,7 @@ static ssize_t wq_max_transfer_size_show(struct device *dev, struct device_attri
 static ssize_t wq_max_transfer_size_store(struct device *dev, struct device_attribute *attr,
 					  const char *buf, size_t count)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 	struct idxd_device *idxd = wq->idxd;
 	u64 xfer_size;
 	int rc;
@@ -1177,7 +1163,7 @@ static struct device_attribute dev_attr_wq_max_transfer_size =
 
 static ssize_t wq_max_batch_size_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 
 	return sysfs_emit(buf, "%u\n", wq->max_batch_size);
 }
@@ -1185,7 +1171,7 @@ static ssize_t wq_max_batch_size_show(struct device *dev, struct device_attribut
 static ssize_t wq_max_batch_size_store(struct device *dev, struct device_attribute *attr,
 				       const char *buf, size_t count)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 	struct idxd_device *idxd = wq->idxd;
 	u64 batch_size;
 	int rc;
@@ -1210,7 +1196,7 @@ static struct device_attribute dev_attr_wq_max_batch_size =
 
 static ssize_t wq_ats_disable_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 
 	return sysfs_emit(buf, "%u\n", wq->ats_dis);
 }
@@ -1218,7 +1204,7 @@ static ssize_t wq_ats_disable_show(struct device *dev, struct device_attribute *
 static ssize_t wq_ats_disable_store(struct device *dev, struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 	struct idxd_device *idxd = wq->idxd;
 	bool ats_dis;
 	int rc;
@@ -1289,7 +1275,7 @@ static const struct attribute_group *idxd_wq_attribute_groups[] = {
 
 static void idxd_conf_wq_release(struct device *dev)
 {
-	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_wq *wq = confdev_to_wq(dev);
 
 	kfree(wq->wqcfg);
 	kfree(wq);
@@ -1305,8 +1291,7 @@ struct device_type idxd_wq_device_type = {
 static ssize_t version_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	return sysfs_emit(buf, "%#x\n", idxd->hw.version);
 }
@@ -1316,8 +1301,7 @@ static ssize_t max_work_queues_size_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	return sysfs_emit(buf, "%u\n", idxd->max_wq_size);
 }
@@ -1326,8 +1310,7 @@ static DEVICE_ATTR_RO(max_work_queues_size);
 static ssize_t max_groups_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	return sysfs_emit(buf, "%u\n", idxd->max_groups);
 }
@@ -1336,8 +1319,7 @@ static DEVICE_ATTR_RO(max_groups);
 static ssize_t max_work_queues_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	return sysfs_emit(buf, "%u\n", idxd->max_wqs);
 }
@@ -1346,8 +1328,7 @@ static DEVICE_ATTR_RO(max_work_queues);
 static ssize_t max_engines_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	return sysfs_emit(buf, "%u\n", idxd->max_engines);
 }
@@ -1356,8 +1337,7 @@ static DEVICE_ATTR_RO(max_engines);
 static ssize_t numa_node_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	return sysfs_emit(buf, "%d\n", dev_to_node(&idxd->pdev->dev));
 }
@@ -1366,8 +1346,7 @@ static DEVICE_ATTR_RO(numa_node);
 static ssize_t max_batch_size_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	return sysfs_emit(buf, "%u\n", idxd->max_batch_size);
 }
@@ -1377,8 +1356,7 @@ static ssize_t max_transfer_size_show(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	return sysfs_emit(buf, "%llu\n", idxd->max_xfer_bytes);
 }
@@ -1387,8 +1365,7 @@ static DEVICE_ATTR_RO(max_transfer_size);
 static ssize_t op_cap_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 	int i, rc = 0;
 
 	for (i = 0; i < 4; i++)
@@ -1403,8 +1380,7 @@ static DEVICE_ATTR_RO(op_cap);
 static ssize_t gen_cap_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	return sysfs_emit(buf, "%#llx\n", idxd->hw.gen_cap.bits);
 }
@@ -1413,8 +1389,7 @@ static DEVICE_ATTR_RO(gen_cap);
 static ssize_t configurable_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	return sysfs_emit(buf, "%u\n", test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags));
 }
@@ -1423,8 +1398,7 @@ static DEVICE_ATTR_RO(configurable);
 static ssize_t clients_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 	unsigned long flags;
 	int count = 0, i;
 
@@ -1443,8 +1417,7 @@ static DEVICE_ATTR_RO(clients);
 static ssize_t pasid_enabled_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	return sysfs_emit(buf, "%u\n", device_pasid_enabled(idxd));
 }
@@ -1453,8 +1426,7 @@ static DEVICE_ATTR_RO(pasid_enabled);
 static ssize_t state_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	switch (idxd->state) {
 	case IDXD_DEV_DISABLED:
@@ -1473,8 +1445,7 @@ static DEVICE_ATTR_RO(state);
 static ssize_t errors_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 	int i, out = 0;
 	unsigned long flags;
 
@@ -1491,8 +1462,7 @@ static DEVICE_ATTR_RO(errors);
 static ssize_t max_tokens_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	return sysfs_emit(buf, "%u\n", idxd->max_tokens);
 }
@@ -1501,8 +1471,7 @@ static DEVICE_ATTR_RO(max_tokens);
 static ssize_t token_limit_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	return sysfs_emit(buf, "%u\n", idxd->token_limit);
 }
@@ -1511,8 +1480,7 @@ static ssize_t token_limit_store(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 	unsigned long val;
 	int rc;
 
@@ -1540,8 +1508,7 @@ static DEVICE_ATTR_RW(token_limit);
 static ssize_t cdev_major_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct idxd_device *idxd =
-		container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	return sysfs_emit(buf, "%u\n", idxd->major);
 }
@@ -1550,7 +1517,7 @@ static DEVICE_ATTR_RO(cdev_major);
 static ssize_t cmd_status_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct idxd_device *idxd = container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	return sysfs_emit(buf, "%#x\n", idxd->cmd_status);
 }
@@ -1590,7 +1557,7 @@ static const struct attribute_group *idxd_attribute_groups[] = {
 
 static void idxd_conf_device_release(struct device *dev)
 {
-	struct idxd_device *idxd = container_of(dev, struct idxd_device, conf_dev);
+	struct idxd_device *idxd = confdev_to_idxd(dev);
 
 	kfree(idxd->groups);
 	kfree(idxd->wqs);
@@ -1615,12 +1582,12 @@ struct device_type iax_device_type = {
 
 static int idxd_register_engine_devices(struct idxd_device *idxd)
 {
+	struct idxd_engine *engine;
 	int i, j, rc;
 
 	for (i = 0; i < idxd->max_engines; i++) {
-		struct idxd_engine *engine = idxd->engines[i];
-
-		rc = device_add(&engine->conf_dev);
+		engine = idxd->engines[i];
+		rc = device_add(engine_confdev(engine));
 		if (rc < 0)
 			goto cleanup;
 	}
@@ -1629,22 +1596,26 @@ static int idxd_register_engine_devices(struct idxd_device *idxd)
 
 cleanup:
 	j = i - 1;
-	for (; i < idxd->max_engines; i++)
-		put_device(&idxd->engines[i]->conf_dev);
+	for (; i < idxd->max_engines; i++) {
+		engine = idxd->engines[i];
+		put_device(engine_confdev(engine));
+	}
 
-	while (j--)
-		device_unregister(&idxd->engines[j]->conf_dev);
+	while (j--) {
+		engine = idxd->engines[j];
+		device_unregister(engine_confdev(engine));
+	}
 	return rc;
 }
 
 static int idxd_register_group_devices(struct idxd_device *idxd)
 {
+	struct idxd_group *group;
 	int i, j, rc;
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *group = idxd->groups[i];
-
-		rc = device_add(&group->conf_dev);
+		group = idxd->groups[i];
+		rc = device_add(group_confdev(group));
 		if (rc < 0)
 			goto cleanup;
 	}
@@ -1653,22 +1624,26 @@ static int idxd_register_group_devices(struct idxd_device *idxd)
 
 cleanup:
 	j = i - 1;
-	for (; i < idxd->max_groups; i++)
-		put_device(&idxd->groups[i]->conf_dev);
+	for (; i < idxd->max_groups; i++) {
+		group = idxd->groups[i];
+		put_device(group_confdev(group));
+	}
 
-	while (j--)
-		device_unregister(&idxd->groups[j]->conf_dev);
+	while (j--) {
+		group = idxd->groups[j];
+		device_unregister(group_confdev(group));
+	}
 	return rc;
 }
 
 static int idxd_register_wq_devices(struct idxd_device *idxd)
 {
+	struct idxd_wq *wq;
 	int i, rc, j;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = idxd->wqs[i];
-
-		rc = device_add(&wq->conf_dev);
+		wq = idxd->wqs[i];
+		rc = device_add(wq_confdev(wq));
 		if (rc < 0)
 			goto cleanup;
 	}
@@ -1677,11 +1652,15 @@ static int idxd_register_wq_devices(struct idxd_device *idxd)
 
 cleanup:
 	j = i - 1;
-	for (; i < idxd->max_wqs; i++)
-		put_device(&idxd->wqs[i]->conf_dev);
+	for (; i < idxd->max_wqs; i++) {
+		wq = idxd->wqs[i];
+		put_device(wq_confdev(wq));
+	}
 
-	while (j--)
-		device_unregister(&idxd->wqs[j]->conf_dev);
+	while (j--) {
+		wq = idxd->wqs[j];
+		device_unregister(wq_confdev(wq));
+	}
 	return rc;
 }
 
@@ -1690,7 +1669,7 @@ int idxd_register_devices(struct idxd_device *idxd)
 	struct device *dev = &idxd->pdev->dev;
 	int rc, i;
 
-	rc = device_add(&idxd->conf_dev);
+	rc = device_add(idxd_confdev(idxd));
 	if (rc < 0)
 		return rc;
 
@@ -1716,12 +1695,12 @@ int idxd_register_devices(struct idxd_device *idxd)
 
  err_group:
 	for (i = 0; i < idxd->max_engines; i++)
-		device_unregister(&idxd->engines[i]->conf_dev);
+		device_unregister(engine_confdev(idxd->engines[i]));
  err_engine:
 	for (i = 0; i < idxd->max_wqs; i++)
-		device_unregister(&idxd->wqs[i]->conf_dev);
+		device_unregister(wq_confdev(idxd->wqs[i]));
  err_wq:
-	device_del(&idxd->conf_dev);
+	device_del(idxd_confdev(idxd));
 	return rc;
 }
 
@@ -1732,22 +1711,22 @@ void idxd_unregister_devices(struct idxd_device *idxd)
 	for (i = 0; i < idxd->max_wqs; i++) {
 		struct idxd_wq *wq = idxd->wqs[i];
 
-		device_unregister(&wq->conf_dev);
+		device_unregister(wq_confdev(wq));
 	}
 
 	for (i = 0; i < idxd->max_engines; i++) {
 		struct idxd_engine *engine = idxd->engines[i];
 
-		device_unregister(&engine->conf_dev);
+		device_unregister(engine_confdev(engine));
 	}
 
 	for (i = 0; i < idxd->max_groups; i++) {
 		struct idxd_group *group = idxd->groups[i];
 
-		device_unregister(&group->conf_dev);
+		device_unregister(group_confdev(group));
 	}
 
-	device_unregister(&idxd->conf_dev);
+	device_unregister(idxd_confdev(idxd));
 }
 
 int idxd_register_bus_type(void)


