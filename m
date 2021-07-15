Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1153CA656
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 20:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbhGOSrT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Jul 2021 14:47:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:37325 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238617AbhGOSrN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Jul 2021 14:47:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="207587137"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="207587137"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:44:13 -0700
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="494679021"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:44:13 -0700
Subject: [PATCH v3 12/18] dmanegine: idxd: open code the dsa_drv registration
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Thu, 15 Jul 2021 11:44:13 -0700
Message-ID: <162637465319.744545.16325178432532362906.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
References: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Don't need a wrapper to register the driver. Just do it directly.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/idxd.h  |    2 ++
 drivers/dma/idxd/init.c  |   10 +++++-----
 drivers/dma/idxd/sysfs.c |   13 +------------
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index f933fd23155a..f308ff7cc6a3 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -56,6 +56,8 @@ struct idxd_device_driver {
 	struct device_driver drv;
 };
 
+extern struct idxd_device_driver dsa_drv;
+
 struct idxd_irq_entry {
 	struct idxd_device *idxd;
 	int id;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 9d62ba7f3bf7..9d9376281def 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -832,9 +832,9 @@ static int __init idxd_init_module(void)
 	if (err < 0)
 		return err;
 
-	err = idxd_register_driver();
+	err = idxd_driver_register(&dsa_drv);
 	if (err < 0)
-		goto err_idxd_driver_register;
+		goto err_dsa_driver_register;
 
 	err = idxd_cdev_register();
 	if (err)
@@ -849,8 +849,8 @@ static int __init idxd_init_module(void)
 err_pci_register:
 	idxd_cdev_remove();
 err_cdev_register:
-	idxd_unregister_driver();
-err_idxd_driver_register:
+	idxd_driver_unregister(&dsa_drv);
+err_dsa_driver_register:
 	idxd_unregister_bus_type();
 	return err;
 }
@@ -858,7 +858,7 @@ module_init(idxd_init_module);
 
 static void __exit idxd_exit_module(void)
 {
-	idxd_unregister_driver();
+	idxd_driver_unregister(&dsa_drv);
 	pci_unregister_driver(&idxd_pci_driver);
 	idxd_cdev_remove();
 	idxd_unregister_bus_type();
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 233593ff784e..1a6c9cf16a40 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -79,23 +79,12 @@ static void idxd_dsa_drv_remove(struct idxd_dev *idxd_dev)
 	}
 }
 
-static struct idxd_device_driver dsa_drv = {
+struct idxd_device_driver dsa_drv = {
 	.name = "dsa",
 	.probe = idxd_dsa_drv_probe,
 	.remove = idxd_dsa_drv_remove,
 };
 
-/* IDXD generic driver setup */
-int idxd_register_driver(void)
-{
-	return idxd_driver_register(&dsa_drv);
-}
-
-void idxd_unregister_driver(void)
-{
-	idxd_driver_unregister(&dsa_drv);
-}
-
 /* IDXD engine attributes */
 static ssize_t engine_group_id_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)


