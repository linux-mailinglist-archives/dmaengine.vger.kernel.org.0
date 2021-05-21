Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747E238D162
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 00:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhEUWYX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 18:24:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:7072 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhEUWYX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 May 2021 18:24:23 -0400
IronPort-SDR: aM3TpqVFYmd8bqwjPmvcGIhCygAMeV1QVlp3FDaIIijaT3pFbQtYaBuGqqEZqEbFesapRLgsoD
 Wy8xJtC+Ecgw==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="188979766"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="188979766"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:22:59 -0700
IronPort-SDR: 2Is2eHedVKZfel3ZNFDDDdwBDAoBStW5AAnRxCq++7hWDG/WYY2/5Ud9PEfHw+2cVjiOBSHl5J
 BmM1iUcdULaA==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="395500981"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:22:59 -0700
Subject: [PATCH 16/18] dmaengine: idxd: create user driver for wq 'device'
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        jgg@nvidia.com, ramesh.thomas@intel.com
Date:   Fri, 21 May 2021 15:22:58 -0700
Message-ID: <162163577862.260470.14616746707295758859.stgit@djiang5-desk3.ch.intel.com>
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
index 0b0c8d1c4d6c..32254996fbfb 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -303,6 +303,59 @@ void idxd_wq_del_cdev(struct idxd_wq *wq)
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
index 85ee5d65c724..2ead07909459 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1158,19 +1158,8 @@ int __drv_enable_wq(struct idxd_wq *wq)
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
 	rc = idxd_wq_disable(wq);
 	if (rc < 0)
@@ -1196,9 +1185,6 @@ void __drv_disable_wq(struct idxd_wq *wq)
 
 	lockdep_assert_held(&wq->wq_lock);
 
-	if (is_idxd_wq_cdev(wq))
-		idxd_wq_del_cdev(wq);
-
 	if (idxd_wq_refcount(wq))
 		dev_warn(dev, "Clients has claim on wq %d: %d\n",
 			 wq->id, idxd_wq_refcount(wq));
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 43ec1472ce25..b5c485e17d11 100644
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
index 72f49e072e1c..bde0126d4f85 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -789,6 +789,10 @@ static int __init idxd_init_module(void)
 	if (err < 0)
 		goto err_idxd_dmaengine_driver_register;
 
+	err = idxd_driver_register(&idxd_user_drv);
+	if (err < 0)
+		goto err_idxd_user_driver_register;
+
 	err = idxd_driver_register(&dsa_drv);
 	if (err < 0)
 		goto err_dsa_driver_register;
@@ -808,6 +812,8 @@ static int __init idxd_init_module(void)
 err_cdev_register:
 	idxd_driver_unregister(&dsa_drv);
 err_dsa_driver_register:
+	idxd_driver_unregister(&idxd_user_drv);
+err_idxd_user_driver_register:
 	idxd_driver_unregister(&idxd_dmaengine_drv);
 err_idxd_dmaengine_driver_register:
 	idxd_driver_unregister(&idxd_drv);
@@ -819,6 +825,7 @@ module_init(idxd_init_module);
 
 static void __exit idxd_exit_module(void)
 {
+	idxd_driver_unregister(&idxd_user_drv);
 	idxd_driver_unregister(&idxd_dmaengine_drv);
 	idxd_driver_unregister(&idxd_drv);
 	idxd_driver_unregister(&dsa_drv);


