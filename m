Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05C43CA619
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 20:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhGOSqQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Jul 2021 14:46:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:48212 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237890AbhGOSqG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Jul 2021 14:46:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="296251118"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="296251118"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:43:11 -0700
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="494678810"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:43:09 -0700
Subject: [PATCH v3 01/18] dmaengine: idxd: add driver register helper
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Thu, 15 Jul 2021 11:43:09 -0700
Message-ID: <162637458949.744545.14996726325385482050.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
References: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add helper functions for dsa-driver registration similar to other
bus-types. In particular, do not require dsa-drivers to open-code the
bus, owner, and mod_name fields. Let registration and unregistration
operate on the 'struct idxd_device_driver' instead of the raw /
embedded 'struct device_driver'.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/idxd.h  |    7 +++++++
 drivers/dma/idxd/init.c  |   17 +++++++++++++++++
 drivers/dma/idxd/sysfs.c |    7 ++-----
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index edfa81f0fe18..c26f7baa812d 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -394,6 +394,13 @@ static inline int idxd_wq_refcount(struct idxd_wq *wq)
 	return wq->client_count;
 };
 
+int __must_check __idxd_driver_register(struct idxd_device_driver *idxd_drv,
+					struct module *module, const char *mod_name);
+#define idxd_driver_register(driver) \
+	__idxd_driver_register(driver, THIS_MODULE, KBUILD_MODNAME)
+
+void idxd_driver_unregister(struct idxd_device_driver *idxd_drv);
+
 int idxd_register_bus_type(void);
 void idxd_unregister_bus_type(void);
 int idxd_register_devices(struct idxd_device *idxd);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 7eac0d167bde..19f5cf9a1c55 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -847,3 +847,20 @@ static void __exit idxd_exit_module(void)
 	perfmon_exit();
 }
 module_exit(idxd_exit_module);
+
+int __idxd_driver_register(struct idxd_device_driver *idxd_drv, struct module *owner,
+			   const char *mod_name)
+{
+	struct device_driver *drv = &idxd_drv->drv;
+
+	drv->bus = &dsa_bus_type;
+	drv->owner = owner;
+	drv->mod_name = mod_name;
+
+	return driver_register(drv);
+}
+
+void idxd_driver_unregister(struct idxd_device_driver *idxd_drv)
+{
+	driver_unregister(&idxd_drv->drv);
+}
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index a193de32536d..983ccc32813e 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -313,21 +313,18 @@ struct bus_type dsa_bus_type = {
 static struct idxd_device_driver dsa_drv = {
 	.drv = {
 		.name = "dsa",
-		.bus = &dsa_bus_type,
-		.owner = THIS_MODULE,
-		.mod_name = KBUILD_MODNAME,
 	},
 };
 
 /* IDXD generic driver setup */
 int idxd_register_driver(void)
 {
-	return driver_register(&dsa_drv.drv);
+	return idxd_driver_register(&dsa_drv);
 }
 
 void idxd_unregister_driver(void)
 {
-	driver_unregister(&dsa_drv.drv);
+	idxd_driver_unregister(&dsa_drv);
 }
 
 /* IDXD engine attributes */


