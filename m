Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA90D367493
	for <lists+dmaengine@lfdr.de>; Wed, 21 Apr 2021 23:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245719AbhDUVFh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Apr 2021 17:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245716AbhDUVFh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 21 Apr 2021 17:05:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9841E613B7;
        Wed, 21 Apr 2021 21:05:02 +0000 (UTC)
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     vkoul@kernel.org
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, dave.jiang@intel.com,
        tony.luck@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v3 2/2] dmaengine: idxd: Enable IDXD performance monitor support
Date:   Wed, 21 Apr 2021 16:04:55 -0500
Message-Id: <cfa98a44dd90a40a1bb776bcb9b76c2cfb1ad232.1619033785.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1619033785.git.zanussi@kernel.org>
References: <cover.1619033785.git.zanussi@kernel.org>
In-Reply-To: <cover.1619033785.git.zanussi@kernel.org>
References: <cover.1619033785.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the code needed in the main IDXD driver to interface with the IDXD
perfmon implementation.

[ Based on work originally by Jing Lin. ]

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/dma/idxd/init.c | 9 +++++++++
 drivers/dma/idxd/irq.c  | 5 +----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index e8f64324bb3a..4c6ea15cb641 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -21,6 +21,7 @@
 #include "../dmaengine.h"
 #include "registers.h"
 #include "idxd.h"
+#include "perfmon.h"
 
 MODULE_VERSION(IDXD_DRIVER_VERSION);
 MODULE_LICENSE("GPL v2");
@@ -489,6 +490,10 @@ static int idxd_probe(struct idxd_device *idxd)
 
 	idxd->major = idxd_cdev_get_major(idxd);
 
+	rc = perfmon_pmu_init(idxd);
+	if (rc < 0)
+		dev_warn(dev, "Failed to initialize perfmon. No PMU support: %d\n", rc);
+
 	dev_dbg(dev, "IDXD device %d probed successfully\n", idxd->id);
 	return 0;
 
@@ -636,6 +641,7 @@ static void idxd_remove(struct pci_dev *pdev)
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
 	idxd_unregister_devices(idxd);
+	perfmon_pmu_remove(idxd);
 }
 
 static struct pci_driver idxd_pci_driver = {
@@ -664,6 +670,8 @@ static int __init idxd_init_module(void)
 	else
 		support_enqcmd = true;
 
+	perfmon_init();
+
 	err = idxd_register_bus_type();
 	if (err < 0)
 		return err;
@@ -697,5 +705,6 @@ static void __exit idxd_exit_module(void)
 	pci_unregister_driver(&idxd_pci_driver);
 	idxd_cdev_remove();
 	idxd_unregister_bus_type();
+	perfmon_exit();
 }
 module_exit(idxd_exit_module);
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index fc0781e3f36d..ae6738470fab 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -165,11 +165,8 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 	}
 
 	if (cause & IDXD_INTC_PERFMON_OVFL) {
-		/*
-		 * Driver does not utilize perfmon counter overflow interrupt
-		 * yet.
-		 */
 		val |= IDXD_INTC_PERFMON_OVFL;
+		perfmon_counter_overflow(idxd);
 	}
 
 	val ^= cause;
-- 
2.17.1

