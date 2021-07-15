Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215E83CA65C
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 20:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbhGOSrY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Jul 2021 14:47:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:13855 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238637AbhGOSrT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Jul 2021 14:47:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="210598862"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="210598862"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:44:25 -0700
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="630830985"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:44:25 -0700
Subject: [PATCH v3 14/18] dmaengine: idxd: create idxd_device sub-driver
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Thu, 15 Jul 2021 11:44:24 -0700
Message-ID: <162637466439.744545.15210886092627144577.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
References: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
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
index d5a0b6fff3b9..12ae3f1639f1 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1349,3 +1349,16 @@ void idxd_device_drv_remove(struct idxd_dev *idxd_dev)
 	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
 		idxd_device_reset(idxd);
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
index beb906bf7d66..8cfe96682097 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -58,6 +58,7 @@ struct idxd_device_driver {
 };
 
 extern struct idxd_device_driver dsa_drv;
+extern struct idxd_device_driver idxd_drv;
 
 struct idxd_irq_entry {
 	struct idxd_device *idxd;
@@ -493,6 +494,8 @@ void idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id);
 void idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id);
 
 /* device control */
+int idxd_register_idxd_drv(void);
+void idxd_unregister_idxd_drv(void);
 int idxd_device_drv_probe(struct idxd_dev *idxd_dev);
 void idxd_device_drv_remove(struct idxd_dev *idxd_dev);
 int drv_enable_wq(struct idxd_wq *wq);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index f04ee7f0de60..bb869109b3f1 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -832,6 +832,10 @@ static int __init idxd_init_module(void)
 	if (err < 0)
 		return err;
 
+	err = idxd_driver_register(&idxd_drv);
+	if (err < 0)
+		goto err_idxd_driver_register;
+
 	err = idxd_driver_register(&dsa_drv);
 	if (err < 0)
 		goto err_dsa_driver_register;
@@ -851,6 +855,8 @@ static int __init idxd_init_module(void)
 err_cdev_register:
 	idxd_driver_unregister(&dsa_drv);
 err_dsa_driver_register:
+	idxd_driver_unregister(&idxd_drv);
+err_idxd_driver_register:
 	idxd_unregister_bus_type();
 	return err;
 }
@@ -858,6 +864,7 @@ module_init(idxd_init_module);
 
 static void __exit idxd_exit_module(void)
 {
+	idxd_driver_unregister(&idxd_drv);
 	idxd_driver_unregister(&dsa_drv);
 	pci_unregister_driver(&idxd_pci_driver);
 	idxd_cdev_remove();


