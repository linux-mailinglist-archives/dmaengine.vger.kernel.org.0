Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BA83C9475
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 01:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbhGNXYv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 19:24:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:11190 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhGNXYv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 19:24:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="197628259"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="197628259"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 16:21:59 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="571353752"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 16:21:58 -0700
Subject: [PATCH v2 17/18] dmaengine: dsa: move dsa_bus_type out of idxd driver
 to standalone
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 14 Jul 2021 16:21:58 -0700
Message-ID: <162630491846.631529.13985146207669122564.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162630468448.631529.1963704964865951650.stgit@djiang5-desk3.ch.intel.com>
References: <162630468448.631529.1963704964865951650.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In preparation for dsa_drv compat support to be built-in, move the bus
code to its own compilation unit. A follow-on patch adds the compat
implementation. Recall that the compat implementation allows for the
deprecated / omnibus dsa_drv binding scheme rather than the idiomatic
organization of a full fledged bus driver per driver type.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/Kconfig       |    4 ++
 drivers/dma/Makefile      |    2 -
 drivers/dma/idxd/Makefile |    5 ++
 drivers/dma/idxd/bus.c    |   92 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/init.c   |   30 ---------------
 drivers/dma/idxd/sysfs.c  |   43 ---------------------
 6 files changed, 103 insertions(+), 73 deletions(-)
 create mode 100644 drivers/dma/idxd/bus.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index f450e4231db7..d7101bff1772 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -277,6 +277,10 @@ config INTEL_IDMA64
 	  Enable DMA support for Intel Low Power Subsystem such as found on
 	  Intel Skylake PCH.
 
+config INTEL_IDXD_BUS
+	tristate
+	default INTEL_IDXD
+
 config INTEL_IDXD
 	tristate "Intel Data Accelerators support"
 	depends on PCI && X86_64 && !UML
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index aa69094e3547..13b5258d04ea 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -41,7 +41,7 @@ obj-$(CONFIG_IMX_DMA) += imx-dma.o
 obj-$(CONFIG_IMX_SDMA) += imx-sdma.o
 obj-$(CONFIG_INTEL_IDMA64) += idma64.o
 obj-$(CONFIG_INTEL_IOATDMA) += ioat/
-obj-$(CONFIG_INTEL_IDXD) += idxd/
+obj-y += idxd/
 obj-$(CONFIG_INTEL_IOP_ADMA) += iop-adma.o
 obj-$(CONFIG_K3_DMA) += k3dma.o
 obj-$(CONFIG_LPC18XX_DMAMUX) += lpc18xx-dmamux.o
diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
index 6d11558756f8..8c29ed4d48c3 100644
--- a/drivers/dma/idxd/Makefile
+++ b/drivers/dma/idxd/Makefile
@@ -1,4 +1,9 @@
+ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=IDXD
+
 obj-$(CONFIG_INTEL_IDXD) += idxd.o
 idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o cdev.o
 
 idxd-$(CONFIG_INTEL_IDXD_PERFMON) += perfmon.o
+
+obj-$(CONFIG_INTEL_IDXD_BUS) += idxd_bus.o
+idxd_bus-y := bus.o
diff --git a/drivers/dma/idxd/bus.c b/drivers/dma/idxd/bus.c
new file mode 100644
index 000000000000..02837f0fb3e4
--- /dev/null
+++ b/drivers/dma/idxd/bus.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2021 Intel Corporation. All rights rsvd. */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include "idxd.h"
+
+
+int __idxd_driver_register(struct idxd_device_driver *idxd_drv, struct module *owner,
+			   const char *mod_name)
+{
+	struct device_driver *drv = &idxd_drv->drv;
+
+	if (!idxd_drv->type) {
+		pr_debug("driver type not set (%ps)\n", __builtin_return_address(0));
+		return -EINVAL;
+	}
+
+	drv->name = idxd_drv->name;
+	drv->bus = &dsa_bus_type;
+	drv->owner = owner;
+	drv->mod_name = mod_name;
+
+	return driver_register(drv);
+}
+EXPORT_SYMBOL_GPL(__idxd_driver_register);
+
+void idxd_driver_unregister(struct idxd_device_driver *idxd_drv)
+{
+	driver_unregister(&idxd_drv->drv);
+}
+EXPORT_SYMBOL_GPL(idxd_driver_unregister);
+
+static int idxd_config_bus_match(struct device *dev,
+				 struct device_driver *drv)
+{
+	struct idxd_device_driver *idxd_drv =
+		container_of(drv, struct idxd_device_driver, drv);
+	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
+	int i = 0;
+
+	while (idxd_drv->type[i] != IDXD_DEV_NONE) {
+		if (idxd_dev->type == idxd_drv->type[i])
+			return 1;
+		i++;
+	}
+
+	return 0;
+}
+
+static int idxd_config_bus_probe(struct device *dev)
+{
+	struct idxd_device_driver *idxd_drv =
+		container_of(dev->driver, struct idxd_device_driver, drv);
+	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
+
+	return idxd_drv->probe(idxd_dev);
+}
+
+static int idxd_config_bus_remove(struct device *dev)
+{
+	struct idxd_device_driver *idxd_drv =
+		container_of(dev->driver, struct idxd_device_driver, drv);
+	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
+
+	idxd_drv->remove(idxd_dev);
+	return 0;
+}
+
+struct bus_type dsa_bus_type = {
+	.name = "dsa",
+	.match = idxd_config_bus_match,
+	.probe = idxd_config_bus_probe,
+	.remove = idxd_config_bus_remove,
+};
+EXPORT_SYMBOL_GPL(dsa_bus_type);
+
+static int __init dsa_bus_init(void)
+{
+	return bus_register(&dsa_bus_type);
+}
+module_init(dsa_bus_init);
+
+static void __exit dsa_bus_exit(void)
+{
+	bus_unregister(&dsa_bus_type);
+}
+module_exit(dsa_bus_exit);
+
+MODULE_DESCRIPTION("IDXD driver dsa_bus_type driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 9fbd39ef495c..8bc9aede59a1 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -26,6 +26,7 @@
 MODULE_VERSION(IDXD_DRIVER_VERSION);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Intel Corporation");
+MODULE_IMPORT_NS(IDXD);
 
 static bool sva = true;
 module_param(sva, bool, 0644);
@@ -826,10 +827,6 @@ static int __init idxd_init_module(void)
 
 	perfmon_init();
 
-	err = idxd_register_bus_type();
-	if (err < 0)
-		return err;
-
 	err = idxd_driver_register(&idxd_drv);
 	if (err < 0)
 		goto err_idxd_driver_register;
@@ -867,7 +864,6 @@ static int __init idxd_init_module(void)
 err_idxd_dmaengine_driver_register:
 	idxd_driver_unregister(&idxd_drv);
 err_idxd_driver_register:
-	idxd_unregister_bus_type();
 	return err;
 }
 module_init(idxd_init_module);
@@ -880,30 +876,6 @@ static void __exit idxd_exit_module(void)
 	idxd_driver_unregister(&dsa_drv);
 	pci_unregister_driver(&idxd_pci_driver);
 	idxd_cdev_remove();
-	idxd_unregister_bus_type();
 	perfmon_exit();
 }
 module_exit(idxd_exit_module);
-
-int __idxd_driver_register(struct idxd_device_driver *idxd_drv, struct module *owner,
-			   const char *mod_name)
-{
-	struct device_driver *drv = &idxd_drv->drv;
-
-	if (!idxd_drv->type) {
-		pr_debug("driver type not set (%ps)\n", __builtin_return_address(0));
-		return -EINVAL;
-	}
-
-	drv->name = idxd_drv->name;
-	drv->bus = &dsa_bus_type;
-	drv->owner = owner;
-	drv->mod_name = mod_name;
-
-	return driver_register(drv);
-}
-
-void idxd_driver_unregister(struct idxd_device_driver *idxd_drv)
-{
-	driver_unregister(&idxd_drv->drv);
-}
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 500d6c64a1b0..58fc732afd25 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -16,49 +16,6 @@ static char *idxd_wq_type_names[] = {
 	[IDXD_WQT_USER]		= "user",
 };
 
-static int idxd_config_bus_match(struct device *dev,
-				 struct device_driver *drv)
-{
-	struct idxd_device_driver *idxd_drv =
-		container_of(drv, struct idxd_device_driver, drv);
-	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
-	int i = 0;
-
-	while (idxd_drv->type[i] != IDXD_DEV_NONE) {
-		if (idxd_dev->type == idxd_drv->type[i])
-			return 1;
-		i++;
-	}
-
-	return 0;
-}
-
-static int idxd_config_bus_probe(struct device *dev)
-{
-	struct idxd_device_driver *idxd_drv =
-		container_of(dev->driver, struct idxd_device_driver, drv);
-	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
-
-	return idxd_drv->probe(idxd_dev);
-}
-
-static int idxd_config_bus_remove(struct device *dev)
-{
-	struct idxd_device_driver *idxd_drv =
-		container_of(dev->driver, struct idxd_device_driver, drv);
-	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
-
-	idxd_drv->remove(idxd_dev);
-	return 0;
-}
-
-struct bus_type dsa_bus_type = {
-	.name = "dsa",
-	.match = idxd_config_bus_match,
-	.probe = idxd_config_bus_probe,
-	.remove = idxd_config_bus_remove,
-};
-
 static int idxd_dsa_drv_probe(struct idxd_dev *idxd_dev)
 {
 	if (is_idxd_dev(idxd_dev))


