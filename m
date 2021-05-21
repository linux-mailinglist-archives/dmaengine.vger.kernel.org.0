Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A78138D14F
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 00:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhEUWWx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 18:22:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:8247 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhEUWWx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 May 2021 18:22:53 -0400
IronPort-SDR: 6lj1I7Z3cI/EigZ6lUywncZXXmGi6cp3Z4P0s4XXAaXvkmvfMgTO8m2NkCUhJF0mQh5u1Mu5X8
 haN/tuOU+yEA==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="265489947"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="265489947"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:21:29 -0700
IronPort-SDR: 4zyq1dxQK3nfaRlnGksl0bq1u7I6cfbCeAVZt67ffFtoQpSc1pLs6TDPvZmNz01+X7y6kwlzhZ
 KGbvHZAtpZjg==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="406833612"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:21:28 -0700
Subject: [PATCH 01/18] dmaengine: idxd: add driver register helper
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        jgg@nvidia.com, ramesh.thomas@intel.com
Date:   Fri, 21 May 2021 15:21:28 -0700
Message-ID: <162163568848.260470.11021441784721444923.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
References: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
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
index 26482c7d4c3a..da4195a5e2f1 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -396,6 +396,13 @@ static inline int idxd_wq_refcount(struct idxd_wq *wq)
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
index 21d3dcb1c0e3..c46421452c9b 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -794,3 +794,20 @@ static void __exit idxd_exit_module(void)
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
index 0460d58e3941..c614ffa9a610 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -325,21 +325,18 @@ struct bus_type dsa_bus_type = {
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


