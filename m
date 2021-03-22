Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF2D34530B
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 00:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhCVXcL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 19:32:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:27528 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230314AbhCVXbv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Mar 2021 19:31:51 -0400
IronPort-SDR: 0WK7u2ngM7RXV0U0kA76bpWI61xzyvJn/CFIEG1AYBqz7enO0TpSBNi2ktSg7NvOicT8CO7uwe
 aFQs9Zetrmdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="275468290"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="275468290"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:31:50 -0700
IronPort-SDR: I+X4xSbSfYCWKjtWHCuFEdhYXP6LryyqhlWlgCshE6Mb7NEQ6ws3AB+UeaJ38OBKQs6ADdymQY
 o38UpAckIvkQ==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="435332282"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:31:50 -0700
Subject: [PATCH v7 6/8] dmaengine: idxd: fix engine conf_dev lifetime
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, jgg@nvidia.com, dan.j.williams@intel.com
Date:   Mon, 22 Mar 2021 16:31:49 -0700
Message-ID: <161645590970.2002542.1417094139430441481.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
References: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The devm managed lifetime is incompatible with 'struct device' objects that
resides in idxd context. This is one of the series that clean up the idxd
driver 'struct device' lifetime. Fix engine->conf_dev 'struct device'
lifetime. Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE.
Add release functions in order to free the allocated memory at the
appropriate time.

Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dma/idxd/device.c |    2 +-
 drivers/dma/idxd/idxd.h   |    2 +-
 drivers/dma/idxd/init.c   |   51 +++++++++++++++++++++++++++++++++++++++------
 drivers/dma/idxd/sysfs.c  |   44 ++++++++++++++++++++++-----------------
 4 files changed, 71 insertions(+), 28 deletions(-)

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
index cd41baeb2bdf..6c217cab383f 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -194,7 +194,7 @@ struct idxd_device {
 	struct completion *cmd_done;
 	struct idxd_group *groups;
 	struct idxd_wq **wqs;
-	struct idxd_engine *engines;
+	struct idxd_engine **engines;
 
 	struct iommu_sva *sva;
 	unsigned int pasid;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 2aceb99ef9d1..6af896c6909b 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -181,6 +181,37 @@ static int idxd_allocate_wqs(struct idxd_device *idxd)
 	return rc;
 }
 
+static int idxd_allocate_engines(struct idxd_device *idxd)
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
+		idxd->engines[i] = engine;
+	}
+
+	return 0;
+
+ err:
+	while (--i)
+		kfree(idxd->engines[i]);
+	kfree(idxd->engines);
+	idxd->engines = NULL;
+	return rc;
+}
+
 static int idxd_setup_internals(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -217,15 +248,15 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 			return -ENOMEM;
 	}
 
-	idxd->engines = devm_kcalloc(dev, idxd->max_engines,
-				     sizeof(struct idxd_engine), GFP_KERNEL);
-	if (!idxd->engines)
-		return -ENOMEM;
-
+	rc = idxd_allocate_engines(idxd);
+	if (rc < 0)
+		return rc;
 
 	for (i = 0; i < idxd->max_engines; i++) {
-		idxd->engines[i].idxd = idxd;
-		idxd->engines[i].id = i;
+		struct idxd_engine *engine = idxd->engines[i];
+
+		engine->idxd = idxd;
+		engine->id = i;
 	}
 
 	idxd->wq = create_workqueue(dev_name(dev));
@@ -363,6 +394,12 @@ static void idxd_free(struct idxd_device *idxd)
 		kfree(idxd->wqs);
 	}
 
+	if (idxd->engines) {
+		for (i = 0; i < idxd->max_engines; i++)
+			kfree(idxd->engines[i]);
+		kfree(idxd->engines);
+	}
+
 	kfree(idxd);
 }
 
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 10ce9b5f2951..021da1752f2a 100644
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
+static struct device_type idxd_engine_device_type = {
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
@@ -1638,30 +1646,28 @@ static int idxd_setup_engine_sysfs(struct idxd_device *idxd)
 	int i, rc;
 
 	for (i = 0; i < idxd->max_engines; i++) {
-		struct idxd_engine *engine = &idxd->engines[i];
+		struct idxd_engine *engine = idxd->engines[i];
 
+		device_initialize(&engine->conf_dev);
 		engine->conf_dev.parent = &idxd->conf_dev;
-		dev_set_name(&engine->conf_dev, "engine%d.%d",
-			     idxd->id, engine->id);
 		engine->conf_dev.bus = idxd_get_bus_type(idxd);
-		engine->conf_dev.groups = idxd_engine_attribute_groups;
 		engine->conf_dev.type = &idxd_engine_device_type;
-		dev_dbg(dev, "Engine device register: %s\n",
-			dev_name(&engine->conf_dev));
-		rc = device_register(&engine->conf_dev);
-		if (rc < 0) {
-			put_device(&engine->conf_dev);
+		rc = dev_set_name(&engine->conf_dev, "engine%d.%d", idxd->id, engine->id);
+		if (rc < 0)
+			goto cleanup;
+		dev_dbg(dev, "Engine device register: %s\n", dev_name(&engine->conf_dev));
+		rc = device_add(&engine->conf_dev);
+		if (rc < 0)
 			goto cleanup;
-		}
 	}
 
 	return 0;
 
 cleanup:
 	while (i--) {
-		struct idxd_engine *engine = &idxd->engines[i];
+		struct idxd_engine *engine = idxd->engines[i];
 
-		device_unregister(&engine->conf_dev);
+		put_device(&engine->conf_dev);
 	}
 	return rc;
 }
@@ -1803,7 +1809,7 @@ void idxd_unregister_devices(struct idxd_device *idxd)
 	}
 
 	for (i = 0; i < idxd->max_engines; i++) {
-		struct idxd_engine *engine = &idxd->engines[i];
+		struct idxd_engine *engine = idxd->engines[i];
 
 		device_unregister(&engine->conf_dev);
 	}


