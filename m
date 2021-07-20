Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FFF3D0379
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jul 2021 22:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbhGTULe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jul 2021 16:11:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:62680 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234571AbhGTUBd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Jul 2021 16:01:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="198595678"
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="198595678"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 13:42:10 -0700
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="564539392"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 13:42:10 -0700
Subject: [PATCH] dmaengine: idxd: Set defaults for GRPCFG traffic class
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 20 Jul 2021 13:42:10 -0700
Message-ID: <162681373005.1968485.3761065664382799202.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Set GRPCFG traffic class to value of 1 for best performance on current
generation of accelerators. Also add override option to allow experimentation.
Sysfs knobs are disabled for DSA/IAX gen1 devices.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |    5 +++++
 drivers/dma/idxd/idxd.h                         |    1 +
 drivers/dma/idxd/init.c                         |   13 +++++++++++--
 drivers/dma/idxd/registers.h                    |    3 +++
 drivers/dma/idxd/sysfs.c                        |    6 ++++++
 5 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdb22006f713..ec5411cdec20 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1747,6 +1747,11 @@
 			support for the idxd driver. By default it is set to
 			true (1).
 
+	idxd.tc_override= [HW]
+			Format: <bool>
+			Allow override of default traffic class configuration
+			for the device. By default it is set to false (0).
+
 	ieee754=	[MIPS] Select IEEE Std 754 conformance mode
 			Format: { strict | legacy | 2008 | relaxed }
 			Default: strict
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 34d4f43bfedc..94983bced189 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -17,6 +17,7 @@
 #define IDXD_DRIVER_VERSION	"1.00"
 
 extern struct kmem_cache *idxd_desc_pool;
+extern bool tc_override;
 
 struct idxd_wq;
 struct idxd_dev;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 8db56f98059f..eb09bc591c31 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -32,6 +32,10 @@ static bool sva = true;
 module_param(sva, bool, 0644);
 MODULE_PARM_DESC(sva, "Toggle SVA support on/off");
 
+bool tc_override;
+module_param(tc_override, bool, 0644);
+MODULE_PARM_DESC(tc_override, "Override traffic class defaults");
+
 #define DRV_NAME "idxd"
 
 bool support_enqcmd;
@@ -336,8 +340,13 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 		}
 
 		idxd->groups[i] = group;
-		group->tc_a = -1;
-		group->tc_b = -1;
+		if (idxd->hw.version < DEVICE_VERSION_2 && !tc_override) {
+			group->tc_a = 1;
+			group->tc_b = 1;
+		} else {
+			group->tc_a = -1;
+			group->tc_b = -1;
+		}
 	}
 
 	return 0;
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 7343a8f48819..ffc7550a77ee 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -7,6 +7,9 @@
 #define PCI_DEVICE_ID_INTEL_DSA_SPR0	0x0b25
 #define PCI_DEVICE_ID_INTEL_IAX_SPR0	0x0cfe
 
+#define DEVICE_VERSION_1		0x100
+#define DEVICE_VERSION_2		0x200
+
 #define IDXD_MMIO_BAR		0
 #define IDXD_WQ_BAR		2
 #define IDXD_PORTAL_SIZE	PAGE_SIZE
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index b883e9f16e7f..881a12596d4b 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -327,6 +327,9 @@ static ssize_t group_traffic_class_a_store(struct device *dev,
 	if (idxd->state == IDXD_DEV_ENABLED)
 		return -EPERM;
 
+	if (idxd->hw.version < DEVICE_VERSION_2 && !tc_override)
+		return -EPERM;
+
 	if (val < 0 || val > 7)
 		return -EINVAL;
 
@@ -366,6 +369,9 @@ static ssize_t group_traffic_class_b_store(struct device *dev,
 	if (idxd->state == IDXD_DEV_ENABLED)
 		return -EPERM;
 
+	if (idxd->hw.version < DEVICE_VERSION_2 && !tc_override)
+		return -EPERM;
+
 	if (val < 0 || val > 7)
 		return -EINVAL;
 


