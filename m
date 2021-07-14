Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9235D3C9474
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 01:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbhGNXYq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 19:24:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:16082 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhGNXYp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 19:24:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="190819276"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="190819276"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 16:21:53 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="452236301"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 16:21:53 -0700
Subject: [PATCH v2 16/18] dmaengine: idxd: create user driver for wq 'device'
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 14 Jul 2021 16:21:52 -0700
Message-ID: <162630491274.631529.11156460153957675613.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162630468448.631529.1963704964865951650.stgit@djiang5-desk3.ch.intel.com>
References: <162630468448.631529.1963704964865951650.stgit@djiang5-desk3.ch.intel.com>
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
idxd_user_drv driver that controls the enabling and disabling of the
wq and also register and unregister a char device to allow user space
to mmap the descriptor submission portal.

The cdev related bits are moved to the cdev driver probe/remove and out of
the drv_enabe/disable_wq() calls. These bits are exclusive to the cdev
operation and not part of the generic enable/disable of the wq device.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/cdev.c   |   53 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/device.c |   14 ------------
 drivers/dma/idxd/idxd.h   |    1 +
 drivers/dma/idxd/init.c   |    7 ++++++
 4 files changed, 61 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 18a003b93812..b67bbf24242a 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -304,6 +304,59 @@ void idxd_wq_del_cdev(struct idxd_wq *wq)
 	put_device(cdev_dev(idxd_cdev));
 }
 
+static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
+{
+	struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
+	struct idxd_device *idxd = wq->idxd;
+	int rc;
+
+	if (idxd->state != IDXD_DEV_ENABLED)
+		return -ENXIO;
+
+	mutex_lock(&wq->wq_lock);
+	wq->type = IDXD_WQT_USER;
+	rc = __drv_enable_wq(wq);
+	if (rc < 0)
+		goto err;
+
+	rc = idxd_wq_add_cdev(wq);
+	if (rc < 0)
+		goto err_cdev;
+
+	mutex_unlock(&wq->wq_lock);
+	return 0;
+
+err_cdev:
+	__drv_disable_wq(wq);
+err:
+	wq->type = IDXD_WQT_NONE;
+	mutex_unlock(&wq->wq_lock);
+	return rc;
+}
+
+static void idxd_user_drv_remove(struct idxd_dev *idxd_dev)
+{
+	struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
+
+	mutex_lock(&wq->wq_lock);
+	idxd_wq_del_cdev(wq);
+	__drv_disable_wq(wq);
+	wq->type = IDXD_WQT_NONE;
+	mutex_unlock(&wq->wq_lock);
+}
+
+static enum idxd_dev_type dev_types[] = {
+	IDXD_DEV_WQ,
+	IDXD_DEV_NONE,
+};
+
+struct idxd_device_driver idxd_user_drv = {
+	.probe = idxd_user_drv_probe,
+	.remove = idxd_user_drv_remove,
+	.name = "user",
+	.type = dev_types,
+};
+
 int idxd_cdev_register(void)
 {
 	int rc, i;
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 4dcc9431ae3d..9bbc28d9a9eb 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1201,19 +1201,8 @@ int __drv_enable_wq(struct idxd_wq *wq)
 	}
 
 	wq->client_count = 0;
-
-	if (is_idxd_wq_cdev(wq)) {
-		rc = idxd_wq_add_cdev(wq);
-		if (rc < 0) {
-			dev_dbg(dev, "wq %d cdev creation failed\n", wq->id);
-			goto err_client;
-		}
-	}
-
 	return 0;
 
-err_client:
-	idxd_wq_unmap_portal(wq);
 err_map_portal:
 	rc = idxd_wq_disable(wq, false);
 	if (rc < 0)
@@ -1239,9 +1228,6 @@ void __drv_disable_wq(struct idxd_wq *wq)
 
 	lockdep_assert_held(&wq->wq_lock);
 
-	if (is_idxd_wq_cdev(wq))
-		idxd_wq_del_cdev(wq);
-
 	if (idxd_wq_refcount(wq))
 		dev_warn(dev, "Clients has claim on wq %d: %d\n",
 			 wq->id, idxd_wq_refcount(wq));
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index d7db4f9b7137..8cf13f599af2 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -60,6 +60,7 @@ struct idxd_device_driver {
 extern struct idxd_device_driver dsa_drv;
 extern struct idxd_device_driver idxd_drv;
 extern struct idxd_device_driver idxd_dmaengine_drv;
+extern struct idxd_device_driver idxd_user_drv;
 
 struct idxd_irq_entry {
 	struct idxd_device *idxd;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 08cdb803c499..9fbd39ef495c 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -838,6 +838,10 @@ static int __init idxd_init_module(void)
 	if (err < 0)
 		goto err_idxd_dmaengine_driver_register;
 
+	err = idxd_driver_register(&idxd_user_drv);
+	if (err < 0)
+		goto err_idxd_user_driver_register;
+
 	err = idxd_driver_register(&dsa_drv);
 	if (err < 0)
 		goto err_dsa_driver_register;
@@ -857,6 +861,8 @@ static int __init idxd_init_module(void)
 err_cdev_register:
 	idxd_driver_unregister(&dsa_drv);
 err_dsa_driver_register:
+	idxd_driver_unregister(&idxd_user_drv);
+err_idxd_user_driver_register:
 	idxd_driver_unregister(&idxd_dmaengine_drv);
 err_idxd_dmaengine_driver_register:
 	idxd_driver_unregister(&idxd_drv);
@@ -868,6 +874,7 @@ module_init(idxd_init_module);
 
 static void __exit idxd_exit_module(void)
 {
+	idxd_driver_unregister(&idxd_user_drv);
 	idxd_driver_unregister(&idxd_dmaengine_drv);
 	idxd_driver_unregister(&idxd_drv);
 	idxd_driver_unregister(&dsa_drv);


