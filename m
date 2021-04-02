Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B390D353005
	for <lists+dmaengine@lfdr.de>; Fri,  2 Apr 2021 21:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbhDBT5h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Apr 2021 15:57:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:9417 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhDBT5h (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 2 Apr 2021 15:57:37 -0400
IronPort-SDR: KJq8FABO8osnt8G3SAPmN/e0/HWvGfKDfjx8YoVrhX2Uce/KGMPSjxysd7JGS+3RSc7g37Itgf
 mR2AbFpugvtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="256506157"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="256506157"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 12:57:35 -0700
IronPort-SDR: +Bino5y7bSZYlizpyhsqRHOiqD0Oi4OI9Gt4kMIY5hWbvA0rDSHE4j+MMMsilDAEgGEIwp8SEQ
 tgh6zM9WYfOg==
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="446585184"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 12:57:34 -0700
Subject: [PATCH v9 07/11] dmaengine: idxd: fix engine conf_dev lifetime
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>, dmaengine@vger.kernel.org
Date:   Fri, 02 Apr 2021 12:57:33 -0700
Message-ID: <161739345396.2945060.1539081376027611049.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
References: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove devm_* allocation and fix engine->conf_dev 'struct device'
lifetime. Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE.
Add release functions in order to free the allocated memory at the
engine conf_dev destruction time.

Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    2 +
 drivers/dma/idxd/idxd.h   |    3 +-
 drivers/dma/idxd/init.c   |   60 +++++++++++++++++++++++++++++---------
 drivers/dma/idxd/sysfs.c  |   72 +++++++++++++++++++++++----------------------
 4 files changed, 86 insertions(+), 51 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 2292d7bfef58..d4fa9d2472c1 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -744,7 +744,7 @@ static int idxd_engines_setup(struct idxd_device *idxd)
 	}
 
 	for (i = 0; i < idxd->max_engines; i++) {
-		eng = &idxd->engines[i];
+		eng = idxd->engines[i];
 		group = eng->group;
 
 		if (!group)
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index bec5686b6ddd..05029f769ab3 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -195,7 +195,7 @@ struct idxd_device {
 	struct completion *cmd_done;
 	struct idxd_group *groups;
 	struct idxd_wq **wqs;
-	struct idxd_engine *engines;
+	struct idxd_engine **engines;
 
 	struct iommu_sva *sva;
 	unsigned int pasid;
@@ -259,6 +259,7 @@ extern bool support_enqcmd;
 extern struct device_type dsa_device_type;
 extern struct device_type iax_device_type;
 extern struct device_type idxd_wq_device_type;
+extern struct device_type idxd_engine_device_type;
 
 static inline bool is_dsa_dev(struct device *dev)
 {
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 983fbabe2ad7..1e26d7267946 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -204,6 +204,46 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 	return rc;
 }
 
+static int idxd_setup_engines(struct idxd_device *idxd)
+{
+	struct idxd_engine *engine;
+	struct device *dev = &idxd->pdev->dev;
+	int i, rc;
+
+	idxd->engines = kcalloc_node(idxd->max_engines, sizeof(struct idxd_engine *),
+				     GFP_KERNEL, dev_to_node(dev));
+	if (!idxd->engines)
+		return -ENOMEM;
+
+	for (i = 0; i < idxd->max_engines; i++) {
+		engine = kzalloc_node(sizeof(*engine), GFP_KERNEL, dev_to_node(dev));
+		if (!engine) {
+			rc = -ENOMEM;
+			goto err;
+		}
+
+		engine->id = i;
+		engine->idxd = idxd;
+		device_initialize(&engine->conf_dev);
+		engine->conf_dev.parent = &idxd->conf_dev;
+		engine->conf_dev.type = &idxd_engine_device_type;
+		rc = dev_set_name(&engine->conf_dev, "engine%d.%d", idxd->id, engine->id);
+		if (rc < 0) {
+			put_device(&engine->conf_dev);
+			goto err;
+		}
+
+		idxd->engines[i] = engine;
+	}
+
+	return 0;
+
+ err:
+	while (--i >= 0)
+		put_device(&idxd->engines[i]->conf_dev);
+	return rc;
+}
+
 static int idxd_setup_internals(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -215,6 +255,10 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 	if (rc < 0)
 		return rc;
 
+	rc = idxd_setup_engines(idxd);
+	if (rc < 0)
+		goto err_engine;
+
 	idxd->groups = devm_kcalloc(dev, idxd->max_groups,
 				    sizeof(struct idxd_group), GFP_KERNEL);
 	if (!idxd->groups) {
@@ -229,19 +273,6 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 		idxd->groups[i].tc_b = -1;
 	}
 
-	idxd->engines = devm_kcalloc(dev, idxd->max_engines,
-				     sizeof(struct idxd_engine), GFP_KERNEL);
-	if (!idxd->engines) {
-		rc = -ENOMEM;
-		goto err;
-	}
-
-
-	for (i = 0; i < idxd->max_engines; i++) {
-		idxd->engines[i].idxd = idxd;
-		idxd->engines[i].id = i;
-	}
-
 	idxd->wq = create_workqueue(dev_name(dev));
 	if (!idxd->wq) {
 		rc = -ENOMEM;
@@ -251,6 +282,9 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 	return 0;
 
  err:
+	for (i = 0; i < idxd->max_engines; i++)
+		put_device(&idxd->engines[i]->conf_dev);
+ err_engine:
 	for (i = 0; i < idxd->max_wqs; i++)
 		put_device(&idxd->wqs[i]->conf_dev);
 	return rc;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index d3f9b2bc2780..a304bc1da1d0 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -26,11 +26,6 @@ static struct device_type idxd_group_device_type = {
 	.release = idxd_conf_sub_device_release,
 };
 
-static struct device_type idxd_engine_device_type = {
-	.name = "engine",
-	.release = idxd_conf_sub_device_release,
-};
-
 static int idxd_config_bus_match(struct device *dev,
 				 struct device_driver *drv)
 {
@@ -469,6 +464,19 @@ static const struct attribute_group *idxd_engine_attribute_groups[] = {
 	NULL,
 };
 
+static void idxd_conf_engine_release(struct device *dev)
+{
+	struct idxd_engine *engine = container_of(dev, struct idxd_engine, conf_dev);
+
+	kfree(engine);
+}
+
+struct device_type idxd_engine_device_type = {
+	.name = "engine",
+	.release = idxd_conf_engine_release,
+	.groups = idxd_engine_attribute_groups,
+};
+
 /* Group attributes */
 
 static void idxd_set_free_tokens(struct idxd_device *idxd)
@@ -631,7 +639,7 @@ static ssize_t group_engines_show(struct device *dev,
 	struct idxd_device *idxd = group->idxd;
 
 	for (i = 0; i < idxd->max_engines; i++) {
-		struct idxd_engine *engine = &idxd->engines[i];
+		struct idxd_engine *engine = idxd->engines[i];
 
 		if (!engine->group)
 			continue;
@@ -1633,37 +1641,27 @@ struct device_type iax_device_type = {
 	.groups = idxd_attribute_groups,
 };
 
-static int idxd_setup_engine_sysfs(struct idxd_device *idxd)
+static int idxd_register_engine_devices(struct idxd_device *idxd)
 {
-	struct device *dev = &idxd->pdev->dev;
-	int i, rc;
+	int i, j, rc;
 
 	for (i = 0; i < idxd->max_engines; i++) {
-		struct idxd_engine *engine = &idxd->engines[i];
-
-		engine->conf_dev.parent = &idxd->conf_dev;
-		dev_set_name(&engine->conf_dev, "engine%d.%d",
-			     idxd->id, engine->id);
-		engine->conf_dev.bus = idxd_get_bus_type(idxd);
-		engine->conf_dev.groups = idxd_engine_attribute_groups;
-		engine->conf_dev.type = &idxd_engine_device_type;
-		dev_dbg(dev, "Engine device register: %s\n",
-			dev_name(&engine->conf_dev));
-		rc = device_register(&engine->conf_dev);
-		if (rc < 0) {
-			put_device(&engine->conf_dev);
+		struct idxd_engine *engine = idxd->engines[i];
+
+		rc = device_add(&engine->conf_dev);
+		if (rc < 0)
 			goto cleanup;
-		}
 	}
 
 	return 0;
 
 cleanup:
-	while (i--) {
-		struct idxd_engine *engine = &idxd->engines[i];
+	j = i - 1;
+	for (; i < idxd->max_engines; i++)
+		put_device(&idxd->engines[i]->conf_dev);
 
-		device_unregister(&engine->conf_dev);
-	}
+	while (j--)
+		device_unregister(&idxd->engines[j]->conf_dev);
 	return rc;
 }
 
@@ -1740,23 +1738,25 @@ int idxd_register_devices(struct idxd_device *idxd)
 		goto err_wq;
 	}
 
-	rc = idxd_setup_group_sysfs(idxd);
+	rc = idxd_register_engine_devices(idxd);
 	if (rc < 0) {
-		/* unregister conf dev */
-		dev_dbg(dev, "Group sysfs registering failed: %d\n", rc);
-		goto err;
+		dev_dbg(dev, "Engine devices registering failed: %d\n", rc);
+		goto err_engine;
 	}
 
-	rc = idxd_setup_engine_sysfs(idxd);
+	rc = idxd_setup_group_sysfs(idxd);
 	if (rc < 0) {
 		/* unregister conf dev */
-		dev_dbg(dev, "Engine sysfs registering failed: %d\n", rc);
-		goto err;
+		dev_dbg(dev, "Group sysfs registering failed: %d\n", rc);
+		goto err_group;
 	}
 
 	return 0;
 
- err:
+ err_group:
+	for (i = 0; i < idxd->max_engines; i++)
+		device_unregister(&idxd->engines[i]->conf_dev);
+ err_engine:
 	for (i = 0; i < idxd->max_wqs; i++)
 		device_unregister(&idxd->wqs[i]->conf_dev);
  err_wq:
@@ -1775,7 +1775,7 @@ void idxd_unregister_devices(struct idxd_device *idxd)
 	}
 
 	for (i = 0; i < idxd->max_engines; i++) {
-		struct idxd_engine *engine = &idxd->engines[i];
+		struct idxd_engine *engine = idxd->engines[i];
 
 		device_unregister(&engine->conf_dev);
 	}


