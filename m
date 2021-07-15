Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CFE3CA6D0
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 20:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbhGOSut (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Jul 2021 14:50:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:33181 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239968AbhGOSsu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Jul 2021 14:48:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="197872635"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="197872635"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:44:47 -0700
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="495601707"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:44:47 -0700
Subject: [PATCH v3 18/18] dmaengine: idxd: move dsa_drv support to compatible
 mode
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Thu, 15 Jul 2021 11:44:47 -0700
Message-ID: <162637468705.744545.4399080971745974435.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
References: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The original architecture of /sys/bus/dsa invented a scheme whereby
a single entry in the list of bus drivers, /sys/bus/drivers/dsa,
handled all device types and internally routed them to different
different drivers. Those internal drivers were invisible to
userspace.

With the idxd driver transitioned to a proper bus device-driver model,
the legacy behavior needs to be preserved due to it being exposed to
user space via sysfs. Create a compat driver to provide the legacy
behavior for /sys/bus/dsa/drivers/dsa. This should satisfy user
tool accel-config v3.2 or ealier where this behavior is expected.
If the distro has a newer accel-config then the legacy mode does
not need to be enabled.

When the compat driver binds the device (i.e. dsa0) to the dsa driver,
it will be bound to the new idxd_drv. The wq device (i.e. wq0.0) will
be bound to either the dmaengine_drv or the user_drv. The dsa_drv
becomes a routing mechansim for the new drivers. It will not support
additional external drivers that are implemented later.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/Kconfig       |   17 +++++++
 drivers/dma/idxd/Makefile |    3 +
 drivers/dma/idxd/cdev.c   |    1 
 drivers/dma/idxd/compat.c |  114 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/device.c |    1 
 drivers/dma/idxd/dma.c    |    1 
 drivers/dma/idxd/idxd.h   |   10 ++++
 drivers/dma/idxd/init.c   |    7 ---
 drivers/dma/idxd/sysfs.c  |   40 ----------------
 9 files changed, 146 insertions(+), 48 deletions(-)
 create mode 100644 drivers/dma/idxd/compat.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d7101bff1772..ceb41be0505e 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -295,6 +295,23 @@ config INTEL_IDXD
 
 	  If unsure, say N.
 
+config INTEL_IDXD_COMPAT
+	bool "Legacy behavior for idxd driver"
+	depends on PCI && X86_64
+	select INTEL_IDXD_BUS
+	help
+	  Compatible driver to support old /sys/bus/dsa/drivers/dsa behavior.
+	  The old behavior performed driver bind/unbind for device and wq
+	  devices all under the dsa driver. The compat driver will emulate
+	  the legacy behavior in order to allow existing support apps (i.e.
+	  accel-config) to continue function. It is expected that accel-config
+	  v3.2 and earlier will need the compat mode. A distro with later
+	  accel-config version can disable this compat config.
+
+	  Say Y if you have old applications that require such behavior.
+
+	  If unsure, say N.
+
 # Config symbol that collects all the dependencies that's necessary to
 # support shared virtual memory for the devices supported by idxd.
 config INTEL_IDXD_SVM
diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
index 8c29ed4d48c3..a1e9f2b3a37c 100644
--- a/drivers/dma/idxd/Makefile
+++ b/drivers/dma/idxd/Makefile
@@ -7,3 +7,6 @@ idxd-$(CONFIG_INTEL_IDXD_PERFMON) += perfmon.o
 
 obj-$(CONFIG_INTEL_IDXD_BUS) += idxd_bus.o
 idxd_bus-y := bus.o
+
+obj-$(CONFIG_INTEL_IDXD_COMPAT) += idxd_compat.o
+idxd_compat-y := compat.o
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index b67bbf24242a..f6a4603517ba 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -356,6 +356,7 @@ struct idxd_device_driver idxd_user_drv = {
 	.name = "user",
 	.type = dev_types,
 };
+EXPORT_SYMBOL_GPL(idxd_user_drv);
 
 int idxd_cdev_register(void)
 {
diff --git a/drivers/dma/idxd/compat.c b/drivers/dma/idxd/compat.c
new file mode 100644
index 000000000000..d67746ee0c1a
--- /dev/null
+++ b/drivers/dma/idxd/compat.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2021 Intel Corporation. All rights rsvd. */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/device/bus.h>
+#include "idxd.h"
+
+extern int device_driver_attach(struct device_driver *drv, struct device *dev);
+extern void device_driver_detach(struct device *dev);
+
+#define DRIVER_ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store)	\
+	struct driver_attribute driver_attr_##_name =		\
+	__ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store)
+
+static ssize_t unbind_store(struct device_driver *drv, const char *buf, size_t count)
+{
+	struct bus_type *bus = drv->bus;
+	struct device *dev;
+	int rc = -ENODEV;
+
+	dev = bus_find_device_by_name(bus, NULL, buf);
+	if (dev && dev->driver) {
+		device_driver_detach(dev);
+		rc = count;
+	}
+
+	return rc;
+}
+static DRIVER_ATTR_IGNORE_LOCKDEP(unbind, 0200, NULL, unbind_store);
+
+static ssize_t bind_store(struct device_driver *drv, const char *buf, size_t count)
+{
+	struct bus_type *bus = drv->bus;
+	struct device *dev;
+	struct device_driver *alt_drv;
+	int rc = -ENODEV;
+	struct idxd_dev *idxd_dev;
+
+	dev = bus_find_device_by_name(bus, NULL, buf);
+	if (!dev || dev->driver || drv != &dsa_drv.drv)
+		return -ENODEV;
+
+	idxd_dev = confdev_to_idxd_dev(dev);
+	if (is_idxd_dev(idxd_dev)) {
+		alt_drv = driver_find("idxd", bus);
+		if (!alt_drv)
+			return -ENODEV;
+	} else if (is_idxd_wq_dev(idxd_dev)) {
+		struct idxd_wq *wq = confdev_to_wq(dev);
+
+		if (is_idxd_wq_kernel(wq)) {
+			alt_drv = driver_find("dmaengine", bus);
+			if (!alt_drv)
+				return -ENODEV;
+		} else if (is_idxd_wq_user(wq)) {
+			alt_drv = driver_find("user", bus);
+			if (!alt_drv)
+				return -ENODEV;
+		} else {
+			return -ENODEV;
+		}
+	}
+
+	rc = device_driver_attach(alt_drv, dev);
+	if (rc < 0)
+		return rc;
+
+	return count;
+}
+static DRIVER_ATTR_IGNORE_LOCKDEP(bind, 0200, NULL, bind_store);
+
+static struct attribute *dsa_drv_compat_attrs[] = {
+	&driver_attr_bind.attr,
+	&driver_attr_unbind.attr,
+	NULL,
+};
+
+static const struct attribute_group dsa_drv_compat_attr_group = {
+	.attrs = dsa_drv_compat_attrs,
+};
+
+static const struct attribute_group *dsa_drv_compat_groups[] = {
+	&dsa_drv_compat_attr_group,
+	NULL,
+};
+
+static int idxd_dsa_drv_probe(struct idxd_dev *idxd_dev)
+{
+	return -ENODEV;
+}
+
+static void idxd_dsa_drv_remove(struct idxd_dev *idxd_dev)
+{
+}
+
+static enum idxd_dev_type dev_types[] = {
+	IDXD_DEV_NONE,
+};
+
+struct idxd_device_driver dsa_drv = {
+	.name = "dsa",
+	.probe = idxd_dsa_drv_probe,
+	.remove = idxd_dsa_drv_remove,
+	.type = dev_types,
+	.drv = {
+		.suppress_bind_attrs = true,
+		.groups = dsa_drv_compat_groups,
+	},
+};
+
+module_idxd_driver(dsa_drv);
+MODULE_IMPORT_NS(IDXD);
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 9bbc28d9a9eb..99350ac9a292 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1318,3 +1318,4 @@ struct idxd_device_driver idxd_drv = {
 	.remove = idxd_device_drv_remove,
 	.name = "idxd",
 };
+EXPORT_SYMBOL_GPL(idxd_drv);
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index 7e3281700183..2fd7ec29a08f 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -339,3 +339,4 @@ struct idxd_device_driver idxd_dmaengine_drv = {
 	.name = "dmaengine",
 	.type = dev_types,
 };
+EXPORT_SYMBOL_GPL(idxd_dmaengine_drv);
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 3eca72b0c8a7..ff418a4e80b1 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -408,11 +408,16 @@ static inline bool is_idxd_wq_dmaengine(struct idxd_wq *wq)
 	return false;
 }
 
-static inline bool is_idxd_wq_cdev(struct idxd_wq *wq)
+static inline bool is_idxd_wq_user(struct idxd_wq *wq)
 {
 	return wq->type == IDXD_WQT_USER;
 }
 
+static inline bool is_idxd_wq_kernel(struct idxd_wq *wq)
+{
+	return wq->type == IDXD_WQT_KERNEL;
+}
+
 static inline bool wq_dedicated(struct idxd_wq *wq)
 {
 	return test_bit(WQ_FLAG_DEDICATED, &wq->flags);
@@ -476,6 +481,9 @@ int __must_check __idxd_driver_register(struct idxd_device_driver *idxd_drv,
 
 void idxd_driver_unregister(struct idxd_device_driver *idxd_drv);
 
+#define module_idxd_driver(__idxd_driver) \
+	module_driver(__idxd_driver, idxd_driver_register, idxd_driver_unregister)
+
 int idxd_register_bus_type(void);
 void idxd_unregister_bus_type(void);
 int idxd_register_devices(struct idxd_device *idxd);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index a3aa7458cc4c..02d89ee6b5d7 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -841,10 +841,6 @@ static int __init idxd_init_module(void)
 	if (err < 0)
 		goto err_idxd_user_driver_register;
 
-	err = idxd_driver_register(&dsa_drv);
-	if (err < 0)
-		goto err_dsa_driver_register;
-
 	err = idxd_cdev_register();
 	if (err)
 		goto err_cdev_register;
@@ -858,8 +854,6 @@ static int __init idxd_init_module(void)
 err_pci_register:
 	idxd_cdev_remove();
 err_cdev_register:
-	idxd_driver_unregister(&dsa_drv);
-err_dsa_driver_register:
 	idxd_driver_unregister(&idxd_user_drv);
 err_idxd_user_driver_register:
 	idxd_driver_unregister(&idxd_dmaengine_drv);
@@ -875,7 +869,6 @@ static void __exit idxd_exit_module(void)
 	idxd_driver_unregister(&idxd_user_drv);
 	idxd_driver_unregister(&idxd_dmaengine_drv);
 	idxd_driver_unregister(&idxd_drv);
-	idxd_driver_unregister(&dsa_drv);
 	pci_unregister_driver(&idxd_pci_driver);
 	idxd_cdev_remove();
 	perfmon_exit();
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 58fc732afd25..429dc5d72265 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -16,46 +16,6 @@ static char *idxd_wq_type_names[] = {
 	[IDXD_WQT_USER]		= "user",
 };
 
-static int idxd_dsa_drv_probe(struct idxd_dev *idxd_dev)
-{
-	if (is_idxd_dev(idxd_dev))
-		return idxd_device_drv_probe(idxd_dev);
-
-	if (is_idxd_wq_dev(idxd_dev)) {
-		struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
-
-		return drv_enable_wq(wq);
-	}
-
-	return -ENODEV;
-}
-
-static void idxd_dsa_drv_remove(struct idxd_dev *idxd_dev)
-{
-	if (is_idxd_dev(idxd_dev)) {
-		idxd_device_drv_remove(idxd_dev);
-		return;
-	}
-
-	if (is_idxd_wq_dev(idxd_dev)) {
-		struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
-
-		drv_disable_wq(wq);
-		return;
-	}
-}
-
-static enum idxd_dev_type dev_types[] = {
-	IDXD_DEV_NONE,
-};
-
-struct idxd_device_driver dsa_drv = {
-	.name = "dsa",
-	.probe = idxd_dsa_drv_probe,
-	.remove = idxd_dsa_drv_remove,
-	.type = dev_types,
-};
-
 /* IDXD engine attributes */
 static ssize_t engine_group_id_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)


