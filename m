Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB82B353009
	for <lists+dmaengine@lfdr.de>; Fri,  2 Apr 2021 21:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhDBT5x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Apr 2021 15:57:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:54206 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhDBT5x (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 2 Apr 2021 15:57:53 -0400
IronPort-SDR: PYjxRE7fPsTz8u1GrBQgr9sLweRxfjNoip9udp/ANA0+KkX969p3zIz8LsL4dDTm5pYaSEIoug
 7dhqMucqVZsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="171947164"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="171947164"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 12:57:51 -0700
IronPort-SDR: C2B2X34g2Tw4VtDvbb1YhQvCCZE9FPFRY6hf1FNpzyD8zmHBNwvQKaK81/blrv7FPdc4bHYT4z
 1kNuhTi6eTTg==
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="413315643"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 12:57:51 -0700
Subject: [PATCH v9 10/11] dmaengine: idxd: iax bus removal
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Fri, 02 Apr 2021 12:57:51 -0700
Message-ID: <161739347112.2945060.6126985786730866615.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
References: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no need to have an additional bus for the IAX device. The removal
of IAX will change user ABI as /sys/bus/iax will no longer exist.
The iax device will be moved to the dsa bus. The device id for dsa and
iax will now be combined rather than unique for each device type in order
to accommodate the iax devices. This is in preparation for fixing the
sub-driver code for idxd. There's no hardware deployment for Sapphire
Rapids platform yet, which means that users have no reason to have
developed scripts against this ABI. There is some exposure to
released versions of accel-config, but those are being fixed up and
an accel-config upgrade is reasonable to get IAX support. As far as
accel-config is concerned IAX support starts when these devices appear
under /sys/bus/dsa, and old accel-config just assumes that an empty /
missing /sys/bus/iax just means a lack of platform support.

Fixes: f25b463883a8 ("dmaengine: idxd: add IAX configuration support in the IDXD driver")
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/cdev.c  |    2 +
 drivers/dma/idxd/idxd.h  |    3 +-
 drivers/dma/idxd/init.c  |   21 ++++---------
 drivers/dma/idxd/sysfs.c |   74 +++-------------------------------------------
 4 files changed, 13 insertions(+), 87 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 1d8a3876b745..2d976905b2a3 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -268,7 +268,7 @@ int idxd_wq_add_cdev(struct idxd_wq *wq)
 
 	device_initialize(dev);
 	dev->parent = &wq->conf_dev;
-	dev->bus = idxd_get_bus_type(idxd);
+	dev->bus = &dsa_bus_type;
 	dev->type = &idxd_cdev_device_type;
 	dev->devt = MKDEV(MAJOR(cdev_ctx->devt), minor);
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index f24521f2cc3a..25b6b88f312f 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -257,6 +257,7 @@ extern struct bus_type dsa_bus_type;
 extern struct bus_type iax_bus_type;
 
 extern bool support_enqcmd;
+extern struct ida idxd_ida;
 extern struct device_type dsa_device_type;
 extern struct device_type iax_device_type;
 extern struct device_type idxd_wq_device_type;
@@ -346,7 +347,6 @@ static inline int idxd_wq_refcount(struct idxd_wq *wq)
 	return wq->client_count;
 };
 
-struct ida *idxd_ida(struct idxd_device *idxd);
 const char *idxd_get_dev_name(struct idxd_device *idxd);
 int idxd_register_bus_type(void);
 void idxd_unregister_bus_type(void);
@@ -354,7 +354,6 @@ int idxd_register_devices(struct idxd_device *idxd);
 void idxd_unregister_devices(struct idxd_device *idxd);
 int idxd_register_driver(void);
 void idxd_unregister_driver(void);
-struct bus_type *idxd_get_bus_type(struct idxd_device *idxd);
 struct device_type *idxd_get_device_type(struct idxd_device *idxd);
 
 /* device interrupt control */
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 928bc20d5c08..69f9fe0d2812 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -33,8 +33,7 @@ MODULE_PARM_DESC(sva, "Toggle SVA support on/off");
 #define DRV_NAME "idxd"
 
 bool support_enqcmd;
-
-static struct ida idxd_idas[IDXD_TYPE_MAX];
+DEFINE_IDA(idxd_ida);
 
 static struct pci_device_id idxd_pci_tbl[] = {
 	/* DSA ver 1.0 platforms */
@@ -51,11 +50,6 @@ static char *idxd_name[] = {
 	"iax"
 };
 
-struct ida *idxd_ida(struct idxd_device *idxd)
-{
-	return &idxd_idas[idxd->type];
-}
-
 const char *idxd_get_dev_name(struct idxd_device *idxd)
 {
 	return idxd_name[idxd->type];
@@ -175,7 +169,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		wq->idxd = idxd;
 		device_initialize(&wq->conf_dev);
 		wq->conf_dev.parent = &idxd->conf_dev;
-		wq->conf_dev.bus = idxd_get_bus_type(idxd);
+		wq->conf_dev.bus = &dsa_bus_type;
 		wq->conf_dev.type = &idxd_wq_device_type;
 		rc = dev_set_name(&wq->conf_dev, "wq%d.%d", idxd->id, wq->id);
 		if (rc < 0) {
@@ -266,7 +260,7 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 		group->idxd = idxd;
 		device_initialize(&group->conf_dev);
 		group->conf_dev.parent = &idxd->conf_dev;
-		group->conf_dev.bus = idxd_get_bus_type(idxd);
+		group->conf_dev.bus = &dsa_bus_type;
 		group->conf_dev.type = &idxd_group_device_type;
 		rc = dev_set_name(&group->conf_dev, "group%d.%d", idxd->id, group->id);
 		if (rc < 0) {
@@ -417,13 +411,13 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev)
 
 	idxd->pdev = pdev;
 	idxd_set_type(idxd);
-	idxd->id = ida_alloc(idxd_ida(idxd), GFP_KERNEL);
+	idxd->id = ida_alloc(&idxd_ida, GFP_KERNEL);
 	if (idxd->id < 0)
 		return NULL;
 
 	device_initialize(&idxd->conf_dev);
 	idxd->conf_dev.parent = dev;
-	idxd->conf_dev.bus = idxd_get_bus_type(idxd);
+	idxd->conf_dev.bus = &dsa_bus_type;
 	idxd->conf_dev.type = idxd_get_device_type(idxd);
 	rc = dev_set_name(&idxd->conf_dev, "%s%d", idxd_get_dev_name(idxd), idxd->id);
 	if (rc < 0) {
@@ -676,7 +670,7 @@ static struct pci_driver idxd_pci_driver = {
 
 static int __init idxd_init_module(void)
 {
-	int err, i;
+	int err;
 
 	/*
 	 * If the CPU does not support MOVDIR64B or ENQCMDS, there's no point in
@@ -692,9 +686,6 @@ static int __init idxd_init_module(void)
 	else
 		support_enqcmd = true;
 
-	for (i = 0; i < IDXD_TYPE_MAX; i++)
-		ida_init(&idxd_idas[i]);
-
 	err = idxd_register_bus_type();
 	if (err < 0)
 		return err;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 3ea58504e90d..5a87b9f9c06b 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -306,19 +306,6 @@ struct bus_type dsa_bus_type = {
 	.shutdown = idxd_config_bus_shutdown,
 };
 
-struct bus_type iax_bus_type = {
-	.name = "iax",
-	.match = idxd_config_bus_match,
-	.probe = idxd_config_bus_probe,
-	.remove = idxd_config_bus_remove,
-	.shutdown = idxd_config_bus_shutdown,
-};
-
-static struct bus_type *idxd_bus_types[] = {
-	&dsa_bus_type,
-	&iax_bus_type
-};
-
 static struct idxd_device_driver dsa_drv = {
 	.drv = {
 		.name = "dsa",
@@ -328,25 +315,6 @@ static struct idxd_device_driver dsa_drv = {
 	},
 };
 
-static struct idxd_device_driver iax_drv = {
-	.drv = {
-		.name = "iax",
-		.bus = &iax_bus_type,
-		.owner = THIS_MODULE,
-		.mod_name = KBUILD_MODNAME,
-	},
-};
-
-static struct idxd_device_driver *idxd_drvs[] = {
-	&dsa_drv,
-	&iax_drv
-};
-
-struct bus_type *idxd_get_bus_type(struct idxd_device *idxd)
-{
-	return idxd_bus_types[idxd->type];
-}
-
 struct device_type *idxd_get_device_type(struct idxd_device *idxd)
 {
 	if (idxd->type == IDXD_TYPE_DSA)
@@ -360,28 +328,12 @@ struct device_type *idxd_get_device_type(struct idxd_device *idxd)
 /* IDXD generic driver setup */
 int idxd_register_driver(void)
 {
-	int i, rc;
-
-	for (i = 0; i < IDXD_TYPE_MAX; i++) {
-		rc = driver_register(&idxd_drvs[i]->drv);
-		if (rc < 0)
-			goto drv_fail;
-	}
-
-	return 0;
-
-drv_fail:
-	while (--i >= 0)
-		driver_unregister(&idxd_drvs[i]->drv);
-	return rc;
+	return driver_register(&dsa_drv.drv);
 }
 
 void idxd_unregister_driver(void)
 {
-	int i;
-
-	for (i = 0; i < IDXD_TYPE_MAX; i++)
-		driver_unregister(&idxd_drvs[i]->drv);
+	driver_unregister(&dsa_drv.drv);
 }
 
 /* IDXD engine attributes */
@@ -1636,7 +1588,7 @@ static void idxd_conf_device_release(struct device *dev)
 	kfree(idxd->wqs);
 	kfree(idxd->engines);
 	kfree(idxd->irq_entries);
-	ida_free(idxd_ida(idxd), idxd->id);
+	ida_free(&idxd_ida, idxd->id);
 	kfree(idxd);
 }
 
@@ -1791,26 +1743,10 @@ void idxd_unregister_devices(struct idxd_device *idxd)
 
 int idxd_register_bus_type(void)
 {
-	int i, rc;
-
-	for (i = 0; i < IDXD_TYPE_MAX; i++) {
-		rc = bus_register(idxd_bus_types[i]);
-		if (rc < 0)
-			goto bus_err;
-	}
-
-	return 0;
-
-bus_err:
-	while (--i >= 0)
-		bus_unregister(idxd_bus_types[i]);
-	return rc;
+	return bus_register(&dsa_bus_type);
 }
 
 void idxd_unregister_bus_type(void)
 {
-	int i;
-
-	for (i = 0; i < IDXD_TYPE_MAX; i++)
-		bus_unregister(idxd_bus_types[i]);
+	bus_unregister(&dsa_bus_type);
 }


