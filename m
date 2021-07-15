Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4FE3CA659
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 20:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbhGOSrU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Jul 2021 14:47:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:63777 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238644AbhGOSrN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Jul 2021 14:47:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="190983282"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="190983282"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:44:19 -0700
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="430936307"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:44:19 -0700
Subject: [PATCH v3 13/18] dmaengine: idxd: add type to driver in order to
 allow device matching
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Willliams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Thu, 15 Jul 2021 11:44:18 -0700
Message-ID: <162637465882.744545.17456174666211577867.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
References: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add an array of support device types to the idxd_device_driver
definition in order to enable simple matching of device type to a
given driver. The deprecated / omnibus dsa_drv driver specifies
IDXD_DEV_NONE as its only role is to service legacy userspace (old
accel-config) directed bind requests and route them to them the proper
driver. It need not attach to a device when the bus is autoprobed. The
accel-config tooling is being updated to drop its dependency on this
deprecated bind scheme.

Reviewed-by: Dan Willliams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/idxd.h  |    1 +
 drivers/dma/idxd/init.c  |    5 +++++
 drivers/dma/idxd/sysfs.c |   16 +++++++++++++++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index f308ff7cc6a3..beb906bf7d66 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -51,6 +51,7 @@ enum idxd_type {
 
 struct idxd_device_driver {
 	const char *name;
+	enum idxd_dev_type *type;
 	int (*probe)(struct idxd_dev *idxd_dev);
 	void (*remove)(struct idxd_dev *idxd_dev);
 	struct device_driver drv;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 9d9376281def..f04ee7f0de60 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -871,6 +871,11 @@ int __idxd_driver_register(struct idxd_device_driver *idxd_drv, struct module *o
 {
 	struct device_driver *drv = &idxd_drv->drv;
 
+	if (!idxd_drv->type) {
+		pr_debug("driver type not set (%ps)\n", __builtin_return_address(0));
+		return -EINVAL;
+	}
+
 	drv->name = idxd_drv->name;
 	drv->bus = &dsa_bus_type;
 	drv->owner = owner;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 1a6c9cf16a40..500d6c64a1b0 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -19,9 +19,18 @@ static char *idxd_wq_type_names[] = {
 static int idxd_config_bus_match(struct device *dev,
 				 struct device_driver *drv)
 {
+	struct idxd_device_driver *idxd_drv =
+		container_of(drv, struct idxd_device_driver, drv);
 	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
+	int i = 0;
+
+	while (idxd_drv->type[i] != IDXD_DEV_NONE) {
+		if (idxd_dev->type == idxd_drv->type[i])
+			return 1;
+		i++;
+	}
 
-	return (is_idxd_dev(idxd_dev) || is_idxd_wq_dev(idxd_dev));
+	return 0;
 }
 
 static int idxd_config_bus_probe(struct device *dev)
@@ -79,10 +88,15 @@ static void idxd_dsa_drv_remove(struct idxd_dev *idxd_dev)
 	}
 }
 
+static enum idxd_dev_type dev_types[] = {
+	IDXD_DEV_NONE,
+};
+
 struct idxd_device_driver dsa_drv = {
 	.name = "dsa",
 	.probe = idxd_dsa_drv_probe,
 	.remove = idxd_dsa_drv_remove,
+	.type = dev_types,
 };
 
 /* IDXD engine attributes */


