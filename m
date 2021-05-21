Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF0C38D161
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 00:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhEUWYR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 18:24:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:7063 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhEUWYR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 May 2021 18:24:17 -0400
IronPort-SDR: Cm9/LqpFRzWghL3zY71msa3ej1gBzoh0/XoBendf43eoNKZNTr69XX7K1mga1jGuiVaRHB+NRC
 BVIYtONVivNQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="188979741"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="188979741"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:22:53 -0700
IronPort-SDR: qkLf+1iEUeRJQ7UQTB7O6S8ozsmOlUIWMw2rrBIjK8fG5vQKI87BJpNXJqk5NQ+leJLbkXYRJV
 gJ8rk1rCup/Q==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="476285584"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:22:53 -0700
Subject: [PATCH 15/18] dmaengine: idxd: create dmaengine driver for wq
 'device'
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        jgg@nvidia.com, ramesh.thomas@intel.com
Date:   Fri, 21 May 2021 15:22:52 -0700
Message-ID: <162163577286.260470.5823300826030028426.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
References: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The original architecture of /sys/bus/dsa invented a scheme whereby a
single entry in the list of bus drivers, /sys/bus/drivers/dsa, handled
all device types and internally routed them to different drivers.
Those internal drivers were invisible to userspace. Now, as
/sys/bus/dsa wants to grow support for alternate drivers for a given
device, for example vfio-mdev instead of kernel-internal-dmaengine, a
proper bus device-driver model is needed. The first step in that process
is separating the existing omnibus/implicit "dsa" driver into proper
individual drivers registered on /sys/bus/dsa. Establish the
idxd_dmaengine_drv driver that controls the enabling and disabling of the
wq and also register and unregister the dma channel.

idxd_wq_alloc_resources() and idxd_wq_free_resources() also get moved to
the dmaengine driver. The resources (dma descriptors allocation and setup)
are only used by the dmaengine driver and should only happen when it loads.

The char dev driver (cdev) related bits are left in the __drv_enable_wq()
and __drv_disable_wq() calls to be moved when we split out the char dev
driver just like how the dmaengine driver is split out.

WQ autoload support is not expected currently. With the amount of
configuration needed for the device, the wq is always expected to
be enabled by a tool (or via sysfs) rather than auto enabled at driver
load.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |   40 +++--------------------
 drivers/dma/idxd/dma.c    |   77 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/idxd.h   |    3 ++
 drivers/dma/idxd/init.c   |    7 ++++
 4 files changed, 92 insertions(+), 35 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index f1a82d46245f..85ee5d65c724 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1087,7 +1087,7 @@ int idxd_device_load_config(struct idxd_device *idxd)
 	return 0;
 }
 
-static int __drv_enable_wq(struct idxd_wq *wq)
+int __drv_enable_wq(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
@@ -1135,12 +1135,7 @@ static int __drv_enable_wq(struct idxd_wq *wq)
 		}
 	}
 
-	rc = idxd_wq_alloc_resources(wq);
-	if (rc < 0) {
-		dev_dbg(dev, "wq resource alloc failed\n");
-		goto err;
-	}
-
+	rc = 0;
 	spin_lock_irqsave(&idxd->dev_lock, flags);
 	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
 		rc = idxd_device_config(idxd);
@@ -1164,21 +1159,7 @@ static int __drv_enable_wq(struct idxd_wq *wq)
 
 	wq->client_count = 0;
 
-	if (wq->type == IDXD_WQT_KERNEL) {
-		rc = idxd_wq_init_percpu_ref(wq);
-		if (rc < 0) {
-			dev_dbg(dev, "wq %d percpu_ref setup failed\n", wq->id);
-			goto err_cpu_ref;
-		}
-	}
-
-	if (is_idxd_wq_dmaengine(wq)) {
-		rc = idxd_register_dma_channel(wq);
-		if (rc < 0) {
-			dev_dbg(dev, "wq %d DMA channel register failed\n", wq->id);
-			goto err_client;
-		}
-	} else if (is_idxd_wq_cdev(wq)) {
+	if (is_idxd_wq_cdev(wq)) {
 		rc = idxd_wq_add_cdev(wq);
 		if (rc < 0) {
 			dev_dbg(dev, "wq %d cdev creation failed\n", wq->id);
@@ -1186,12 +1167,9 @@ static int __drv_enable_wq(struct idxd_wq *wq)
 		}
 	}
 
-	dev_info(dev, "wq %s enabled\n", dev_name(wq_confdev(wq)));
 	return 0;
 
 err_client:
-	idxd_wq_quiesce(wq);
-err_cpu_ref:
 	idxd_wq_unmap_portal(wq);
 err_map_portal:
 	rc = idxd_wq_disable(wq);
@@ -1211,19 +1189,14 @@ int drv_enable_wq(struct idxd_wq *wq)
 	return rc;
 }
 
-static void __drv_disable_wq(struct idxd_wq *wq)
+void __drv_disable_wq(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
 
 	lockdep_assert_held(&wq->wq_lock);
 
-	if (wq->type == IDXD_WQT_KERNEL)
-		idxd_wq_quiesce(wq);
-
-	if (is_idxd_wq_dmaengine(wq))
-		idxd_unregister_dma_channel(wq);
-	else if (is_idxd_wq_cdev(wq))
+	if (is_idxd_wq_cdev(wq))
 		idxd_wq_del_cdev(wq);
 
 	if (idxd_wq_refcount(wq))
@@ -1235,10 +1208,7 @@ static void __drv_disable_wq(struct idxd_wq *wq)
 	idxd_wq_drain(wq);
 	idxd_wq_reset(wq);
 
-	idxd_wq_free_resources(wq);
 	wq->client_count = 0;
-
-	dev_info(dev, "wq %s disabled\n", dev_name(wq_confdev(wq)));
 }
 
 void drv_disable_wq(struct idxd_wq *wq)
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index 2e52f9a50519..7e3281700183 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -262,3 +262,80 @@ void idxd_unregister_dma_channel(struct idxd_wq *wq)
 	wq->idxd_chan = NULL;
 	put_device(wq_confdev(wq));
 }
+
+static int idxd_dmaengine_drv_probe(struct idxd_dev *idxd_dev)
+{
+	struct device *dev = &idxd_dev->conf_dev;
+	struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
+	struct idxd_device *idxd = wq->idxd;
+	int rc;
+
+	if (idxd->state != IDXD_DEV_ENABLED)
+		return -ENXIO;
+
+	mutex_lock(&wq->wq_lock);
+	wq->type = IDXD_WQT_KERNEL;
+	rc = __drv_enable_wq(wq);
+	if (rc < 0) {
+		dev_dbg(dev, "Enable wq %d failed: %d\n", wq->id, rc);
+		rc = -ENXIO;
+		goto err;
+	}
+
+	rc = idxd_wq_alloc_resources(wq);
+	if (rc < 0) {
+		dev_dbg(dev, "WQ resource alloc failed\n");
+		goto err_res_alloc;
+	}
+
+	rc = idxd_wq_init_percpu_ref(wq);
+	if (rc < 0) {
+		dev_dbg(dev, "percpu_ref setup failed\n");
+		goto err_ref;
+	}
+
+	rc = idxd_register_dma_channel(wq);
+	if (rc < 0) {
+		dev_dbg(dev, "Failed to register dma channel\n");
+		goto err_dma;
+	}
+
+	mutex_unlock(&wq->wq_lock);
+	return 0;
+
+err_dma:
+	idxd_wq_quiesce(wq);
+err_ref:
+	idxd_wq_free_resources(wq);
+err_res_alloc:
+	__drv_disable_wq(wq);
+err:
+	wq->type = IDXD_WQT_NONE;
+	mutex_unlock(&wq->wq_lock);
+	return rc;
+}
+
+static void idxd_dmaengine_drv_remove(struct idxd_dev *idxd_dev)
+{
+	struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
+
+	mutex_lock(&wq->wq_lock);
+	idxd_wq_quiesce(wq);
+	idxd_unregister_dma_channel(wq);
+	__drv_disable_wq(wq);
+	idxd_wq_free_resources(wq);
+	wq->type = IDXD_WQT_NONE;
+	mutex_unlock(&wq->wq_lock);
+}
+
+static enum idxd_dev_type dev_types[] = {
+	IDXD_DEV_WQ,
+	IDXD_DEV_NONE,
+};
+
+struct idxd_device_driver idxd_dmaengine_drv = {
+	.probe = idxd_dmaengine_drv_probe,
+	.remove = idxd_dmaengine_drv_remove,
+	.name = "dmaengine",
+	.type = dev_types,
+};
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index bb7561948abb..43ec1472ce25 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -59,6 +59,7 @@ struct idxd_device_driver {
 
 extern struct idxd_device_driver dsa_drv;
 extern struct idxd_device_driver idxd_drv;
+extern struct idxd_device_driver idxd_dmaengine_drv;
 
 struct idxd_irq_entry {
 	struct idxd_device *idxd;
@@ -501,7 +502,9 @@ void idxd_unregister_idxd_drv(void);
 int idxd_device_drv_probe(struct idxd_dev *idxd_dev);
 void idxd_device_drv_remove(struct idxd_dev *idxd_dev);
 int drv_enable_wq(struct idxd_wq *wq);
+int __drv_enable_wq(struct idxd_wq *wq);
 void drv_disable_wq(struct idxd_wq *wq);
+void __drv_disable_wq(struct idxd_wq *wq);
 int idxd_device_init_reset(struct idxd_device *idxd);
 int idxd_device_enable(struct idxd_device *idxd);
 int idxd_device_disable(struct idxd_device *idxd);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 01720d259259..72f49e072e1c 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -785,6 +785,10 @@ static int __init idxd_init_module(void)
 	if (err < 0)
 		goto err_idxd_driver_register;
 
+	err = idxd_driver_register(&idxd_dmaengine_drv);
+	if (err < 0)
+		goto err_idxd_dmaengine_driver_register;
+
 	err = idxd_driver_register(&dsa_drv);
 	if (err < 0)
 		goto err_dsa_driver_register;
@@ -804,6 +808,8 @@ static int __init idxd_init_module(void)
 err_cdev_register:
 	idxd_driver_unregister(&dsa_drv);
 err_dsa_driver_register:
+	idxd_driver_unregister(&idxd_dmaengine_drv);
+err_idxd_dmaengine_driver_register:
 	idxd_driver_unregister(&idxd_drv);
 err_idxd_driver_register:
 	idxd_unregister_bus_type();
@@ -813,6 +819,7 @@ module_init(idxd_init_module);
 
 static void __exit idxd_exit_module(void)
 {
+	idxd_driver_unregister(&idxd_dmaengine_drv);
 	idxd_driver_unregister(&idxd_drv);
 	idxd_driver_unregister(&dsa_drv);
 	pci_unregister_driver(&idxd_pci_driver);


