Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5A638D15D
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 00:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhEUWYB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 18:24:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:56355 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhEUWYA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 May 2021 18:24:00 -0400
IronPort-SDR: kZ8oZ7NB1z0oTYjKFClRwOe1VVJw/ydp34ETUCptx1ChyxDJUGuBDviC6PQ91aJYky1oRnliUX
 d7gP7OaqZvkQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="287125654"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="287125654"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:22:36 -0700
IronPort-SDR: WHuZc8TMDN7SiKtB/h1AvZdHAkTkJPUKDGfJ0qJrcbwAEm15poxckuuh0w/ZGmVtmQx33nwv2N
 i9IAyLH5Jc0A==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441119364"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:22:35 -0700
Subject: [PATCH 12/18] dmanegine: idxd: open code the dsa_drv registration
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        jgg@nvidia.com, ramesh.thomas@intel.com
Date:   Fri, 21 May 2021 15:22:35 -0700
Message-ID: <162163575535.260470.3285758286246777321.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
References: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
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
 drivers/dma/idxd/init.c  |    9 +++++----
 drivers/dma/idxd/sysfs.c |   13 +------------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index cebed0270123..f530f90b28a8 100644
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
index 89247ae8639a..d576df19c401 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -781,9 +781,9 @@ static int __init idxd_init_module(void)
 	if (err < 0)
 		return err;
 
-	err = idxd_register_driver();
+	err = idxd_driver_register(&dsa_drv);
 	if (err < 0)
-		goto err_idxd_driver_register;
+		goto err_dsa_driver_register;
 
 	err = idxd_cdev_register();
 	if (err)
@@ -798,8 +798,8 @@ static int __init idxd_init_module(void)
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
@@ -807,6 +807,7 @@ module_init(idxd_init_module);
 
 static void __exit idxd_exit_module(void)
 {
+	idxd_driver_unregister(&dsa_drv);
 	pci_unregister_driver(&idxd_pci_driver);
 	idxd_cdev_remove();
 	idxd_unregister_bus_type();
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index dcc7791a63fa..f5471311788e 100644
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


