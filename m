Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7801F3C9470
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 01:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbhGNXYX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 19:24:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:11153 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhGNXYX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 19:24:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="197628193"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="197628193"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 16:21:30 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="412943588"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 16:21:30 -0700
Subject: [PATCH v2 12/18] dmanegine: idxd: open code the dsa_drv registration
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 14 Jul 2021 16:21:30 -0700
Message-ID: <162630489019.631529.10690722289824748208.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162630468448.631529.1963704964865951650.stgit@djiang5-desk3.ch.intel.com>
References: <162630468448.631529.1963704964865951650.stgit@djiang5-desk3.ch.intel.com>
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
index 33752a74e100..d44ee136c223 100644
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
index e4cb24769a4c..ada75bb7e71f 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -830,9 +830,9 @@ static int __init idxd_init_module(void)
 	if (err < 0)
 		return err;
 
-	err = idxd_register_driver();
+	err = idxd_driver_register(&dsa_drv);
 	if (err < 0)
-		goto err_idxd_driver_register;
+		goto err_dsa_driver_register;
 
 	err = idxd_cdev_register();
 	if (err)
@@ -847,8 +847,8 @@ static int __init idxd_init_module(void)
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
@@ -856,7 +856,7 @@ module_init(idxd_init_module);
 
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


