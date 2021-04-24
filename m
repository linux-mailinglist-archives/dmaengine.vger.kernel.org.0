Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5599B36A1B8
	for <lists+dmaengine@lfdr.de>; Sat, 24 Apr 2021 17:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbhDXPFG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 24 Apr 2021 11:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233833AbhDXPFC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 24 Apr 2021 11:05:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D97136148E;
        Sat, 24 Apr 2021 15:04:23 +0000 (UTC)
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     vkoul@kernel.org
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, dave.jiang@intel.com,
        tony.luck@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v4 2/2] dmaengine: idxd: Enable IDXD performance monitor support
Date:   Sat, 24 Apr 2021 10:04:16 -0500
Message-Id: <a5564a5583911565d31c2af9234218c5166c4b2c.1619276133.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1619276133.git.zanussi@kernel.org>
References: <cover.1619276133.git.zanussi@kernel.org>
In-Reply-To: <cover.1619276133.git.zanussi@kernel.org>
References: <cover.1619276133.git.zanussi@kernel.org>
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
index 8003f8a25fff..2a926bef87f2 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -21,6 +21,7 @@
 #include "../dmaengine.h"
 #include "registers.h"
 #include "idxd.h"
+#include "perfmon.h"
 
 MODULE_VERSION(IDXD_DRIVER_VERSION);
 MODULE_LICENSE("GPL v2");
@@ -541,6 +542,10 @@ static int idxd_probe(struct idxd_device *idxd)
 
 	idxd->major = idxd_cdev_get_major(idxd);
 
+	rc = perfmon_pmu_init(idxd);
+	if (rc < 0)
+		dev_warn(dev, "Failed to initialize perfmon. No PMU support: %d\n", rc);
+
 	dev_dbg(dev, "IDXD device %d probed successfully\n", idxd->id);
 	return 0;
 
@@ -720,6 +725,7 @@ static void idxd_remove(struct pci_dev *pdev)
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
 	idxd_unregister_devices(idxd);
+	perfmon_pmu_remove(idxd);
 	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
 }
 
@@ -749,6 +755,8 @@ static int __init idxd_init_module(void)
 	else
 		support_enqcmd = true;
 
+	perfmon_init();
+
 	err = idxd_register_bus_type();
 	if (err < 0)
 		return err;
@@ -782,5 +790,6 @@ static void __exit idxd_exit_module(void)
 	pci_unregister_driver(&idxd_pci_driver);
 	idxd_cdev_remove();
 	idxd_unregister_bus_type();
+	perfmon_exit();
 }
 module_exit(idxd_exit_module);
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index afee571e0194..ae68e1e5487a 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -156,11 +156,8 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
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

