Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AD1361665
	for <lists+dmaengine@lfdr.de>; Fri, 16 Apr 2021 01:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhDOXiQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Apr 2021 19:38:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:51888 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236032AbhDOXiQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Apr 2021 19:38:16 -0400
IronPort-SDR: 7LSJvEKSvQQawWT3n9Oe10CFuSCGJVmfTlTJn6XxrGnHejMSxW9ErlYHUdbNyBGddJJLIUWe69
 GGi8R6YjSbpg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="192836201"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="192836201"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:37:52 -0700
IronPort-SDR: L5qPGYpM1IMa8hjROOicGB9cCQ5+MdjXkmWoSz1rYgLAoSbfNjlh9jAV0bTppCL5VaL/IyT1BC
 WUGabwsqASVg==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="421850291"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:37:51 -0700
Subject: [PATCH v10 08/11] dmaengine: idxd: fix group conf_dev lifetime
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>, dmaengine@vger.kernel.org
Date:   Thu, 15 Apr 2021 16:37:51 -0700
Message-ID: <161852987144.2203940.8830315575880047.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161852959148.2203940.7484827367948091199.stgit@djiang5-desk3.ch.intel.com>
References: <161852959148.2203940.7484827367948091199.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove devm_* allocation and fix group->conf_dev 'struct device'
lifetime. Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE.
Add release functions in order to free the allocated memory at the
group->conf_dev destruction time.

Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    8 +++--
 drivers/dma/idxd/idxd.h   |    3 +-
 drivers/dma/idxd/init.c   |   68 ++++++++++++++++++++++++++++++++++-----------
 drivers/dma/idxd/sysfs.c  |   68 ++++++++++++++++++++-------------------------
 4 files changed, 88 insertions(+), 59 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index de34eec0fc39..63d10d526ec7 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -658,7 +658,7 @@ static int idxd_groups_config_write(struct idxd_device *idxd)
 		ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET));
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *group = &idxd->groups[i];
+		struct idxd_group *group = idxd->groups[i];
 
 		idxd_group_config_write(group);
 	}
@@ -753,7 +753,7 @@ static void idxd_group_flags_setup(struct idxd_device *idxd)
 
 	/* TC-A 0 and TC-B 1 should be defaults */
 	for (i = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *group = &idxd->groups[i];
+		struct idxd_group *group = idxd->groups[i];
 
 		if (group->tc_a == -1)
 			group->tc_a = group->grpcfg.flags.tc_a = 0;
@@ -780,7 +780,7 @@ static int idxd_engines_setup(struct idxd_device *idxd)
 	struct idxd_group *group;
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		group = &idxd->groups[i];
+		group = idxd->groups[i];
 		group->grpcfg.engines = 0;
 	}
 
@@ -809,7 +809,7 @@ static int idxd_wqs_setup(struct idxd_device *idxd)
 	struct device *dev = &idxd->pdev->dev;
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		group = &idxd->groups[i];
+		group = idxd->groups[i];
 		for (j = 0; j < 4; j++)
 			group->grpcfg.wqs[j] = 0;
 	}
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index b9b7e8e8c384..3c4ce7997c88 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -193,7 +193,7 @@ struct idxd_device {
 
 	spinlock_t dev_lock;	/* spinlock for device */
 	struct completion *cmd_done;
-	struct idxd_group *groups;
+	struct idxd_group **groups;
 	struct idxd_wq **wqs;
 	struct idxd_engine **engines;
 
@@ -260,6 +260,7 @@ extern struct device_type dsa_device_type;
 extern struct device_type iax_device_type;
 extern struct device_type idxd_wq_device_type;
 extern struct device_type idxd_engine_device_type;
+extern struct device_type idxd_group_device_type;
 
 static inline bool is_dsa_dev(struct device *dev)
 {
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index b90ef2f519eb..c20ea6bf09bf 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -236,11 +236,54 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 	return rc;
 }
 
-static int idxd_setup_internals(struct idxd_device *idxd)
+static int idxd_setup_groups(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
+	struct idxd_group *group;
 	int i, rc;
 
+	idxd->groups = kcalloc_node(idxd->max_groups, sizeof(struct idxd_group *),
+				    GFP_KERNEL, dev_to_node(dev));
+	if (!idxd->groups)
+		return -ENOMEM;
+
+	for (i = 0; i < idxd->max_groups; i++) {
+		group = kzalloc_node(sizeof(*group), GFP_KERNEL, dev_to_node(dev));
+		if (!group) {
+			rc = -ENOMEM;
+			goto err;
+		}
+
+		group->id = i;
+		group->idxd = idxd;
+		device_initialize(&group->conf_dev);
+		group->conf_dev.parent = &idxd->conf_dev;
+		group->conf_dev.bus = idxd_get_bus_type(idxd);
+		group->conf_dev.type = &idxd_group_device_type;
+		rc = dev_set_name(&group->conf_dev, "group%d.%d", idxd->id, group->id);
+		if (rc < 0) {
+			put_device(&group->conf_dev);
+			goto err;
+		}
+
+		idxd->groups[i] = group;
+		group->tc_a = -1;
+		group->tc_b = -1;
+	}
+
+	return 0;
+
+ err:
+	while (--i >= 0)
+		put_device(&idxd->groups[i]->conf_dev);
+	return rc;
+}
+
+static int idxd_setup_internals(struct idxd_device *idxd)
+{
+	struct device *dev = &idxd->pdev->dev;
+	int rc, i;
+
 	init_waitqueue_head(&idxd->cmd_waitq);
 
 	rc = idxd_setup_wqs(idxd);
@@ -251,29 +294,22 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 	if (rc < 0)
 		goto err_engine;
 
-	idxd->groups = devm_kcalloc(dev, idxd->max_groups,
-				    sizeof(struct idxd_group), GFP_KERNEL);
-	if (!idxd->groups) {
-		rc = -ENOMEM;
-		goto err;
-	}
-
-	for (i = 0; i < idxd->max_groups; i++) {
-		idxd->groups[i].idxd = idxd;
-		idxd->groups[i].id = i;
-		idxd->groups[i].tc_a = -1;
-		idxd->groups[i].tc_b = -1;
-	}
+	rc = idxd_setup_groups(idxd);
+	if (rc < 0)
+		goto err_group;
 
 	idxd->wq = create_workqueue(dev_name(dev));
 	if (!idxd->wq) {
 		rc = -ENOMEM;
-		goto err;
+		goto err_wkq_create;
 	}
 
 	return 0;
 
- err:
+ err_wkq_create:
+	for (i = 0; i < idxd->max_groups; i++)
+		put_device(&idxd->groups[i]->conf_dev);
+ err_group:
 	for (i = 0; i < idxd->max_engines; i++)
 		put_device(&idxd->engines[i]->conf_dev);
  err_engine:
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index ab02e3b4d75d..f793688039c9 100644
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
@@ -435,7 +425,7 @@ static ssize_t engine_group_id_store(struct device *dev,
 
 	if (prevg)
 		prevg->num_engines--;
-	engine->group = &idxd->groups[id];
+	engine->group = idxd->groups[id];
 	engine->group->num_engines++;
 
 	return count;
@@ -479,7 +469,7 @@ static void idxd_set_free_tokens(struct idxd_device *idxd)
 	int i, tokens;
 
 	for (i = 0, tokens = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *g = &idxd->groups[i];
+		struct idxd_group *g = idxd->groups[i];
 
 		tokens += g->tokens_reserved;
 	}
@@ -784,6 +774,19 @@ static const struct attribute_group *idxd_group_attribute_groups[] = {
 	NULL,
 };
 
+static void idxd_conf_group_release(struct device *dev)
+{
+	struct idxd_group *group = container_of(dev, struct idxd_group, conf_dev);
+
+	kfree(group);
+}
+
+struct device_type idxd_group_device_type = {
+	.name = "group",
+	.release = idxd_conf_group_release,
+	.groups = idxd_group_attribute_groups,
+};
+
 /* IDXD work queue attribs */
 static ssize_t wq_clients_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
@@ -856,7 +859,7 @@ static ssize_t wq_group_id_store(struct device *dev,
 		return count;
 	}
 
-	group = &idxd->groups[id];
+	group = idxd->groups[id];
 	prevg = wq->group;
 
 	if (prevg)
@@ -1666,37 +1669,27 @@ static int idxd_register_engine_devices(struct idxd_device *idxd)
 	return rc;
 }
 
-static int idxd_setup_group_sysfs(struct idxd_device *idxd)
+static int idxd_register_group_devices(struct idxd_device *idxd)
 {
-	struct device *dev = &idxd->pdev->dev;
-	int i, rc;
+	int i, j, rc;
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *group = &idxd->groups[i];
-
-		group->conf_dev.parent = &idxd->conf_dev;
-		dev_set_name(&group->conf_dev, "group%d.%d",
-			     idxd->id, group->id);
-		group->conf_dev.bus = idxd_get_bus_type(idxd);
-		group->conf_dev.groups = idxd_group_attribute_groups;
-		group->conf_dev.type = &idxd_group_device_type;
-		dev_dbg(dev, "Group device register: %s\n",
-			dev_name(&group->conf_dev));
-		rc = device_register(&group->conf_dev);
-		if (rc < 0) {
-			put_device(&group->conf_dev);
+		struct idxd_group *group = idxd->groups[i];
+
+		rc = device_add(&group->conf_dev);
+		if (rc < 0)
 			goto cleanup;
-		}
 	}
 
 	return 0;
 
 cleanup:
-	while (i--) {
-		struct idxd_group *group = &idxd->groups[i];
+	j = i - 1;
+	for (; i < idxd->max_groups; i++)
+		put_device(&idxd->groups[i]->conf_dev);
 
-		device_unregister(&group->conf_dev);
-	}
+	while (j--)
+		device_unregister(&idxd->groups[j]->conf_dev);
 	return rc;
 }
 
@@ -1745,10 +1738,9 @@ int idxd_register_devices(struct idxd_device *idxd)
 		goto err_engine;
 	}
 
-	rc = idxd_setup_group_sysfs(idxd);
+	rc = idxd_register_group_devices(idxd);
 	if (rc < 0) {
-		/* unregister conf dev */
-		dev_dbg(dev, "Group sysfs registering failed: %d\n", rc);
+		dev_dbg(dev, "Group device registering failed: %d\n", rc);
 		goto err_group;
 	}
 
@@ -1782,7 +1774,7 @@ void idxd_unregister_devices(struct idxd_device *idxd)
 	}
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *group = &idxd->groups[i];
+		struct idxd_group *group = idxd->groups[i];
 
 		device_unregister(&group->conf_dev);
 	}


