Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6767634530C
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 00:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhCVXcM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 19:32:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:27466 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230411AbhCVXb4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Mar 2021 19:31:56 -0400
IronPort-SDR: LrG7qeTt0GzFYoqq2SlhoYzXXSNrYRc8t/yhR9MPh/tsXSAf8UJ7RyBPHoqsOUQG9PwLKdQXYR
 QyIjZoKYYqug==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="177496974"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="177496974"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:31:56 -0700
IronPort-SDR: ARvzT2yJOGBJv2Od4VZx8FuY1tQRFmFCGqxhra7tXzNZVUkhL1zvEuzTLRRdtlO85GF0BVppy9
 Lk2CZd7KhbwQ==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="451907552"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:31:55 -0700
Subject: [PATCH v7 7/8] dmaengine: idxd: fix group conf_dev lifetime
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, jgg@nvidia.com, dan.j.williams@intel.com
Date:   Mon, 22 Mar 2021 16:31:55 -0700
Message-ID: <161645591527.2002542.11059634857977612320.stgit@djiang5-desk3.ch.intel.com>
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
driver 'struct device' lifetime. Fix group->conf_dev 'struct device'
lifetime. Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE.
Add release functions in order to free the allocated memory at the
appropriate time.

Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dma/idxd/device.c |    8 +++----
 drivers/dma/idxd/idxd.h   |    2 +-
 drivers/dma/idxd/init.c   |   55 ++++++++++++++++++++++++++++++++++++++-------
 drivers/dma/idxd/sysfs.c  |   53 ++++++++++++++++++++++---------------------
 4 files changed, 79 insertions(+), 39 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index d4fa9d2472c1..1e5380b2a88c 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -624,7 +624,7 @@ static int idxd_groups_config_write(struct idxd_device *idxd)
 		ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET));
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *group = &idxd->groups[i];
+		struct idxd_group *group = idxd->groups[i];
 
 		idxd_group_config_write(group);
 	}
@@ -712,7 +712,7 @@ static void idxd_group_flags_setup(struct idxd_device *idxd)
 
 	/* TC-A 0 and TC-B 1 should be defaults */
 	for (i = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *group = &idxd->groups[i];
+		struct idxd_group *group = idxd->groups[i];
 
 		if (group->tc_a == -1)
 			group->tc_a = group->grpcfg.flags.tc_a = 0;
@@ -739,7 +739,7 @@ static int idxd_engines_setup(struct idxd_device *idxd)
 	struct idxd_group *group;
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		group = &idxd->groups[i];
+		group = idxd->groups[i];
 		group->grpcfg.engines = 0;
 	}
 
@@ -768,7 +768,7 @@ static int idxd_wqs_setup(struct idxd_device *idxd)
 	struct device *dev = &idxd->pdev->dev;
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		group = &idxd->groups[i];
+		group = idxd->groups[i];
 		for (j = 0; j < 4; j++)
 			group->grpcfg.wqs[j] = 0;
 	}
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 6c217cab383f..35bb616f04d5 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -192,7 +192,7 @@ struct idxd_device {
 
 	spinlock_t dev_lock;	/* spinlock for device */
 	struct completion *cmd_done;
-	struct idxd_group *groups;
+	struct idxd_group **groups;
 	struct idxd_wq **wqs;
 	struct idxd_engine **engines;
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 6af896c6909b..72b859c33937 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -212,22 +212,55 @@ static int idxd_allocate_engines(struct idxd_device *idxd)
 	return rc;
 }
 
-static int idxd_setup_internals(struct idxd_device *idxd)
+static int idxd_allocate_groups(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
+	struct idxd_group *group;
 	int i, rc;
 
-	init_waitqueue_head(&idxd->cmd_waitq);
-	idxd->groups = devm_kcalloc(dev, idxd->max_groups,
-				    sizeof(struct idxd_group), GFP_KERNEL);
+	idxd->groups = kcalloc_node(idxd->max_groups, sizeof(struct idxd_group *),
+				    GFP_KERNEL, dev_to_node(dev));
 	if (!idxd->groups)
 		return -ENOMEM;
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		idxd->groups[i].idxd = idxd;
-		idxd->groups[i].id = i;
-		idxd->groups[i].tc_a = -1;
-		idxd->groups[i].tc_b = -1;
+		group = kzalloc_node(sizeof(*group), GFP_KERNEL, dev_to_node(dev));
+		if (!group) {
+			rc = -ENOMEM;
+			goto err;
+		}
+
+		idxd->groups[i] = group;
+	}
+
+	return 0;
+
+ err:
+	while (--i)
+		kfree(idxd->groups[i]);
+	kfree(idxd->groups);
+	idxd->groups = NULL;
+	return rc;
+}
+
+static int idxd_setup_internals(struct idxd_device *idxd)
+{
+	struct device *dev = &idxd->pdev->dev;
+	int i, rc;
+
+	init_waitqueue_head(&idxd->cmd_waitq);
+
+	rc = idxd_allocate_groups(idxd);
+	if (rc < 0)
+		return rc;
+
+	for (i = 0; i < idxd->max_groups; i++) {
+		struct idxd_group *group = idxd->groups[i];
+
+		group->idxd = idxd;
+		group->id = i;
+		group->tc_a = -1;
+		group->tc_b = -1;
 	}
 
 	rc = idxd_allocate_wqs(idxd);
@@ -400,6 +433,12 @@ static void idxd_free(struct idxd_device *idxd)
 		kfree(idxd->engines);
 	}
 
+	if (idxd->groups) {
+		for (i = 0; i < idxd->max_groups; i++)
+			kfree(idxd->groups[i]);
+		kfree(idxd->groups);
+	}
+
 	kfree(idxd);
 }
 
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 021da1752f2a..03079ff54889 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -16,16 +16,6 @@ static char *idxd_wq_type_names[] = {
 	[IDXD_WQT_USER]		= "user",
 };
 
-static void idxd_conf_sub_device_release(struct device *dev)
-{
-	dev_dbg(dev, "%s for %s\n", __func__, dev_name(dev));
-}
-
-static struct device_type idxd_group_device_type = {
-	.name = "group",
-	.release = idxd_conf_sub_device_release,
-};
-
 static int idxd_config_bus_match(struct device *dev,
 				 struct device_driver *drv)
 {
@@ -440,7 +430,7 @@ static ssize_t engine_group_id_store(struct device *dev,
 
 	if (prevg)
 		prevg->num_engines--;
-	engine->group = &idxd->groups[id];
+	engine->group = idxd->groups[id];
 	engine->group->num_engines++;
 
 	return count;
@@ -484,7 +474,7 @@ static void idxd_set_free_tokens(struct idxd_device *idxd)
 	int i, tokens;
 
 	for (i = 0, tokens = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *g = &idxd->groups[i];
+		struct idxd_group *g = idxd->groups[i];
 
 		tokens += g->tokens_reserved;
 	}
@@ -789,6 +779,19 @@ static const struct attribute_group *idxd_group_attribute_groups[] = {
 	NULL,
 };
 
+static void idxd_conf_group_release(struct device *dev)
+{
+	struct idxd_group *group = container_of(dev, struct idxd_group, conf_dev);
+
+	kfree(group);
+}
+
+static struct device_type idxd_group_device_type = {
+	.name = "group",
+	.release = idxd_conf_group_release,
+	.groups = idxd_group_attribute_groups,
+};
+
 /* IDXD work queue attribs */
 static ssize_t wq_clients_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
@@ -861,7 +864,7 @@ static ssize_t wq_group_id_store(struct device *dev,
 		return count;
 	}
 
-	group = &idxd->groups[id];
+	group = idxd->groups[id];
 	prevg = wq->group;
 
 	if (prevg)
@@ -1678,30 +1681,28 @@ static int idxd_setup_group_sysfs(struct idxd_device *idxd)
 	int i, rc;
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *group = &idxd->groups[i];
+		struct idxd_group *group = idxd->groups[i];
 
+		device_initialize(&group->conf_dev);
 		group->conf_dev.parent = &idxd->conf_dev;
-		dev_set_name(&group->conf_dev, "group%d.%d",
-			     idxd->id, group->id);
 		group->conf_dev.bus = idxd_get_bus_type(idxd);
-		group->conf_dev.groups = idxd_group_attribute_groups;
 		group->conf_dev.type = &idxd_group_device_type;
-		dev_dbg(dev, "Group device register: %s\n",
-			dev_name(&group->conf_dev));
-		rc = device_register(&group->conf_dev);
-		if (rc < 0) {
-			put_device(&group->conf_dev);
+		rc = dev_set_name(&group->conf_dev, "group%d.%d", idxd->id, group->id);
+		if (rc < 0)
+			goto cleanup;
+		dev_dbg(dev, "Group device register: %s\n", dev_name(&group->conf_dev));
+		rc = device_add(&group->conf_dev);
+		if (rc < 0)
 			goto cleanup;
-		}
 	}
 
 	return 0;
 
 cleanup:
 	while (i--) {
-		struct idxd_group *group = &idxd->groups[i];
+		struct idxd_group *group = idxd->groups[i];
 
-		device_unregister(&group->conf_dev);
+		put_device(&group->conf_dev);
 	}
 	return rc;
 }
@@ -1815,7 +1816,7 @@ void idxd_unregister_devices(struct idxd_device *idxd)
 	}
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *group = &idxd->groups[i];
+		struct idxd_group *group = idxd->groups[i];
 
 		device_unregister(&group->conf_dev);
 	}


