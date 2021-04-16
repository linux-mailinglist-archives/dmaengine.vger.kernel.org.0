Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59422361664
	for <lists+dmaengine@lfdr.de>; Fri, 16 Apr 2021 01:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbhDOXiK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Apr 2021 19:38:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:18008 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235828AbhDOXiK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Apr 2021 19:38:10 -0400
IronPort-SDR: BqL+tedMH9hp9ouh7qxYczXZLKwFmyFdF5fVUTy0EHdhum6thtw2N4MUbVi9m/ewhWxGWP6Kso
 dI1utaRdnGRg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="195076057"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="195076057"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:37:46 -0700
IronPort-SDR: zH6FzaPHiMQk4BZZTs9Awsc3k6Xyrq+kQuqonmJ+2RVxhQxf1vOqPLVATVhfAC5FpPLMGwMUQT
 oKSGRMMDQgig==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="384166797"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:37:46 -0700
Subject: [PATCH v10 07/11] dmaengine: idxd: fix engine conf_dev lifetime
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>, dmaengine@vger.kernel.org
Date:   Thu, 15 Apr 2021 16:37:44 -0700
Message-ID: <161852986460.2203940.16603218225412118431.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161852959148.2203940.7484827367948091199.stgit@djiang5-desk3.ch.intel.com>
References: <161852959148.2203940.7484827367948091199.stgit@djiang5-desk3.ch.intel.com>
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
index df53422380a2..de34eec0fc39 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -785,7 +785,7 @@ static int idxd_engines_setup(struct idxd_device *idxd)
 	}
 
 	for (i = 0; i < idxd->max_engines; i++) {
-		eng = &idxd->engines[i];
+		eng = idxd->engines[i];
 		group = eng->group;
 
 		if (!group)
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 6cade6a05314..b9b7e8e8c384 100644
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
index a2dca27aebc3..b90ef2f519eb 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -196,6 +196,46 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
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
@@ -207,6 +247,10 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 	if (rc < 0)
 		return rc;
 
+	rc = idxd_setup_engines(idxd);
+	if (rc < 0)
+		goto err_engine;
+
 	idxd->groups = devm_kcalloc(dev, idxd->max_groups,
 				    sizeof(struct idxd_group), GFP_KERNEL);
 	if (!idxd->groups) {
@@ -221,19 +265,6 @@ static int idxd_setup_internals(struct idxd_device *idxd)
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
@@ -243,6 +274,9 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 	return 0;
 
  err:
+	for (i = 0; i < idxd->max_engines; i++)
+		put_device(&idxd->engines[i]->conf_dev);
+ err_engine:
 	for (i = 0; i < idxd->max_wqs; i++)
 		put_device(&idxd->wqs[i]->conf_dev);
 	return rc;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 409b3ce52f07..ab02e3b4d75d 100644
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
@@ -464,6 +459,19 @@ static const struct attribute_group *idxd_engine_attribute_groups[] = {
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
@@ -626,7 +634,7 @@ static ssize_t group_engines_show(struct device *dev,
 	struct idxd_device *idxd = group->idxd;
 
 	for (i = 0; i < idxd->max_engines; i++) {
-		struct idxd_engine *engine = &idxd->engines[i];
+		struct idxd_engine *engine = idxd->engines[i];
 
 		if (!engine->group)
 			continue;
@@ -1634,37 +1642,27 @@ struct device_type iax_device_type = {
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
 
@@ -1741,23 +1739,25 @@ int idxd_register_devices(struct idxd_device *idxd)
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
@@ -1776,7 +1776,7 @@ void idxd_unregister_devices(struct idxd_device *idxd)
 	}
 
 	for (i = 0; i < idxd->max_engines; i++) {
-		struct idxd_engine *engine = &idxd->engines[i];
+		struct idxd_engine *engine = idxd->engines[i];
 
 		device_unregister(&engine->conf_dev);
 	}


