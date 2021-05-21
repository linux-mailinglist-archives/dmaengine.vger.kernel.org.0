Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E9838D160
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 00:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhEUWYO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 18:24:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:16647 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhEUWYL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 May 2021 18:24:11 -0400
IronPort-SDR: DDIulCkf5YOwsCwtFNRes7nb7cKYshI07kUxj7/ZH6xkJ4tEuqYwIuTu+7BIkXtIeedw7T4IhS
 t8LFZBbz/92Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="222698406"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="222698406"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:22:48 -0700
IronPort-SDR: Vi4Zusx32r/WxeORy7gHQzHWLqDKbcyYptGwWgaJDSF2nHCcPW6Bsxx7aOtkMQZZugEdkbMEtp
 YfKpYrjVmB0A==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="412776655"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:22:47 -0700
Subject: [PATCH 14/18] dmaengine: idxd: create idxd_device sub-driver
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        jgg@nvidia.com, ramesh.thomas@intel.com
Date:   Fri, 21 May 2021 15:22:46 -0700
Message-ID: <162163576688.260470.16290873965761455524.stgit@djiang5-desk3.ch.intel.com>
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
individual drivers registered on /sys/bus/dsa. Establish the idxd_drv
driver that control the enabling and disabling of the accelerator device.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |   13 +++++++++++++
 drivers/dma/idxd/idxd.h   |    3 +++
 drivers/dma/idxd/init.c   |    7 +++++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 8fac0a3cdbcc..f1a82d46245f 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1319,3 +1319,16 @@ void idxd_device_drv_remove(struct idxd_dev *idxd_dev)
 	if (rc < 0)
 		dev_dbg(dev, "Device disable failed\n");
 }
+
+static enum idxd_dev_type dev_types[] = {
+	IDXD_DEV_DSA,
+	IDXD_DEV_IAX,
+	IDXD_DEV_NONE,
+};
+
+struct idxd_device_driver idxd_drv = {
+	.type = dev_types,
+	.probe = idxd_device_drv_probe,
+	.remove = idxd_device_drv_remove,
+	.name = "idxd",
+};
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index d19db0f71ab0..bb7561948abb 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -58,6 +58,7 @@ struct idxd_device_driver {
 };
 
 extern struct idxd_device_driver dsa_drv;
+extern struct idxd_device_driver idxd_drv;
 
 struct idxd_irq_entry {
 	struct idxd_device *idxd;
@@ -495,6 +496,8 @@ void idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id);
 void idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id);
 
 /* device control */
+int idxd_register_idxd_drv(void);
+void idxd_unregister_idxd_drv(void);
 int idxd_device_drv_probe(struct idxd_dev *idxd_dev);
 void idxd_device_drv_remove(struct idxd_dev *idxd_dev);
 int drv_enable_wq(struct idxd_wq *wq);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index d65d484483a3..01720d259259 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -781,6 +781,10 @@ static int __init idxd_init_module(void)
 	if (err < 0)
 		return err;
 
+	err = idxd_driver_register(&idxd_drv);
+	if (err < 0)
+		goto err_idxd_driver_register;
+
 	err = idxd_driver_register(&dsa_drv);
 	if (err < 0)
 		goto err_dsa_driver_register;
@@ -800,6 +804,8 @@ static int __init idxd_init_module(void)
 err_cdev_register:
 	idxd_driver_unregister(&dsa_drv);
 err_dsa_driver_register:
+	idxd_driver_unregister(&idxd_drv);
+err_idxd_driver_register:
 	idxd_unregister_bus_type();
 	return err;
 }
@@ -807,6 +813,7 @@ module_init(idxd_init_module);
 
 static void __exit idxd_exit_module(void)
 {
+	idxd_driver_unregister(&idxd_drv);
 	idxd_driver_unregister(&dsa_drv);
 	pci_unregister_driver(&idxd_pci_driver);
 	idxd_cdev_remove();


