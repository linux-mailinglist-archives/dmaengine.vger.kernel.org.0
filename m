Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D903832EF55
	for <lists+dmaengine@lfdr.de>; Fri,  5 Mar 2021 16:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhCEPul (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Mar 2021 10:50:41 -0500
Received: from mga17.intel.com ([192.55.52.151]:33401 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhCEPuW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 5 Mar 2021 10:50:22 -0500
IronPort-SDR: HgvwWkbWHkAj2xVP3ny1Wv+TCXvZbnfoB7n9aSWtI6DXMdTeEgaaplubXC2cqxldG+Kf1njffs
 RQ3xbWNO6F4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9914"; a="167569134"
X-IronPort-AV: E=Sophos;i="5.81,225,1610438400"; 
   d="scan'208";a="167569134"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 07:50:21 -0800
IronPort-SDR: OKT7CrXr7n/3cP4uSvL3CJYMSuXWRllC6QvHqULYWpAC4rdiLbVxaRAIWwDNhZbZgAb3e/pFpj
 kABlFV6C3HHw==
X-IronPort-AV: E=Sophos;i="5.81,225,1610438400"; 
   d="scan'208";a="508096508"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 07:50:21 -0800
Subject: [PATCH v2] dmaengine: idxd: convert sprintf() to sysfs_emit() for all
 usages
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Fri, 05 Mar 2021 08:50:20 -0700
Message-ID: <161495936863.573579.5804720281778882171.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert sprintf() to sysfs_emit() in order to check buffer overrun on sysfs
outputs.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Fix sysfs_emit_at() calls to not hit -1 offset.

 drivers/dma/idxd/sysfs.c |  120 ++++++++++++++++++++++------------------------
 1 file changed, 57 insertions(+), 63 deletions(-)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 21c1e23cdf23..ee0f4538cd3f 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -476,9 +476,9 @@ static ssize_t engine_group_id_show(struct device *dev,
 		container_of(dev, struct idxd_engine, conf_dev);
 
 	if (engine->group)
-		return sprintf(buf, "%d\n", engine->group->id);
+		return sysfs_emit(buf, "%d\n", engine->group->id);
 	else
-		return sprintf(buf, "%d\n", -1);
+		return sysfs_emit(buf, "%d\n", -1);
 }
 
 static ssize_t engine_group_id_store(struct device *dev,
@@ -560,7 +560,7 @@ static ssize_t group_tokens_reserved_show(struct device *dev,
 	struct idxd_group *group =
 		container_of(dev, struct idxd_group, conf_dev);
 
-	return sprintf(buf, "%u\n", group->tokens_reserved);
+	return sysfs_emit(buf, "%u\n", group->tokens_reserved);
 }
 
 static ssize_t group_tokens_reserved_store(struct device *dev,
@@ -608,7 +608,7 @@ static ssize_t group_tokens_allowed_show(struct device *dev,
 	struct idxd_group *group =
 		container_of(dev, struct idxd_group, conf_dev);
 
-	return sprintf(buf, "%u\n", group->tokens_allowed);
+	return sysfs_emit(buf, "%u\n", group->tokens_allowed);
 }
 
 static ssize_t group_tokens_allowed_store(struct device *dev,
@@ -653,7 +653,7 @@ static ssize_t group_use_token_limit_show(struct device *dev,
 	struct idxd_group *group =
 		container_of(dev, struct idxd_group, conf_dev);
 
-	return sprintf(buf, "%u\n", group->use_token_limit);
+	return sysfs_emit(buf, "%u\n", group->use_token_limit);
 }
 
 static ssize_t group_use_token_limit_store(struct device *dev,
@@ -696,7 +696,6 @@ static ssize_t group_engines_show(struct device *dev,
 	struct idxd_group *group =
 		container_of(dev, struct idxd_group, conf_dev);
 	int i, rc = 0;
-	char *tmp = buf;
 	struct idxd_device *idxd = group->idxd;
 
 	for (i = 0; i < idxd->max_engines; i++) {
@@ -706,12 +705,13 @@ static ssize_t group_engines_show(struct device *dev,
 			continue;
 
 		if (engine->group->id == group->id)
-			rc += sprintf(tmp + rc, "engine%d.%d ",
-					idxd->id, engine->id);
+			rc += sysfs_emit_at(buf, rc, "engine%d.%d ", idxd->id, engine->id);
 	}
 
+	if (!rc)
+		return 0;
 	rc--;
-	rc += sprintf(tmp + rc, "\n");
+	rc += sysfs_emit_at(buf, rc, "\n");
 
 	return rc;
 }
@@ -725,7 +725,6 @@ static ssize_t group_work_queues_show(struct device *dev,
 	struct idxd_group *group =
 		container_of(dev, struct idxd_group, conf_dev);
 	int i, rc = 0;
-	char *tmp = buf;
 	struct idxd_device *idxd = group->idxd;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
@@ -735,12 +734,13 @@ static ssize_t group_work_queues_show(struct device *dev,
 			continue;
 
 		if (wq->group->id == group->id)
-			rc += sprintf(tmp + rc, "wq%d.%d ",
-					idxd->id, wq->id);
+			rc += sysfs_emit_at(buf, rc, "wq%d.%d ", idxd->id, wq->id);
 	}
 
+	if (!rc)
+		return 0;
 	rc--;
-	rc += sprintf(tmp + rc, "\n");
+	rc += sysfs_emit_at(buf, rc, "\n");
 
 	return rc;
 }
@@ -755,7 +755,7 @@ static ssize_t group_traffic_class_a_show(struct device *dev,
 	struct idxd_group *group =
 		container_of(dev, struct idxd_group, conf_dev);
 
-	return sprintf(buf, "%d\n", group->tc_a);
+	return sysfs_emit(buf, "%d\n", group->tc_a);
 }
 
 static ssize_t group_traffic_class_a_store(struct device *dev,
@@ -796,7 +796,7 @@ static ssize_t group_traffic_class_b_show(struct device *dev,
 	struct idxd_group *group =
 		container_of(dev, struct idxd_group, conf_dev);
 
-	return sprintf(buf, "%d\n", group->tc_b);
+	return sysfs_emit(buf, "%d\n", group->tc_b);
 }
 
 static ssize_t group_traffic_class_b_store(struct device *dev,
@@ -856,7 +856,7 @@ static ssize_t wq_clients_show(struct device *dev,
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%d\n", wq->client_count);
+	return sysfs_emit(buf, "%d\n", wq->client_count);
 }
 
 static struct device_attribute dev_attr_wq_clients =
@@ -869,12 +869,12 @@ static ssize_t wq_state_show(struct device *dev,
 
 	switch (wq->state) {
 	case IDXD_WQ_DISABLED:
-		return sprintf(buf, "disabled\n");
+		return sysfs_emit(buf, "disabled\n");
 	case IDXD_WQ_ENABLED:
-		return sprintf(buf, "enabled\n");
+		return sysfs_emit(buf, "enabled\n");
 	}
 
-	return sprintf(buf, "unknown\n");
+	return sysfs_emit(buf, "unknown\n");
 }
 
 static struct device_attribute dev_attr_wq_state =
@@ -886,9 +886,9 @@ static ssize_t wq_group_id_show(struct device *dev,
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
 	if (wq->group)
-		return sprintf(buf, "%u\n", wq->group->id);
+		return sysfs_emit(buf, "%u\n", wq->group->id);
 	else
-		return sprintf(buf, "-1\n");
+		return sysfs_emit(buf, "-1\n");
 }
 
 static ssize_t wq_group_id_store(struct device *dev,
@@ -940,8 +940,7 @@ static ssize_t wq_mode_show(struct device *dev, struct device_attribute *attr,
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%s\n",
-			wq_dedicated(wq) ? "dedicated" : "shared");
+	return sysfs_emit(buf, "%s\n", wq_dedicated(wq) ? "dedicated" : "shared");
 }
 
 static ssize_t wq_mode_store(struct device *dev,
@@ -977,7 +976,7 @@ static ssize_t wq_size_show(struct device *dev, struct device_attribute *attr,
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%u\n", wq->size);
+	return sysfs_emit(buf, "%u\n", wq->size);
 }
 
 static int total_claimed_wq_size(struct idxd_device *idxd)
@@ -1028,7 +1027,7 @@ static ssize_t wq_priority_show(struct device *dev,
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%u\n", wq->priority);
+	return sysfs_emit(buf, "%u\n", wq->priority);
 }
 
 static ssize_t wq_priority_store(struct device *dev,
@@ -1065,8 +1064,7 @@ static ssize_t wq_block_on_fault_show(struct device *dev,
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%u\n",
-		       test_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags));
+	return sysfs_emit(buf, "%u\n", test_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags));
 }
 
 static ssize_t wq_block_on_fault_store(struct device *dev,
@@ -1105,7 +1103,7 @@ static ssize_t wq_threshold_show(struct device *dev,
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%u\n", wq->threshold);
+	return sysfs_emit(buf, "%u\n", wq->threshold);
 }
 
 static ssize_t wq_threshold_store(struct device *dev,
@@ -1148,15 +1146,12 @@ static ssize_t wq_type_show(struct device *dev,
 
 	switch (wq->type) {
 	case IDXD_WQT_KERNEL:
-		return sprintf(buf, "%s\n",
-			       idxd_wq_type_names[IDXD_WQT_KERNEL]);
+		return sysfs_emit(buf, "%s\n", idxd_wq_type_names[IDXD_WQT_KERNEL]);
 	case IDXD_WQT_USER:
-		return sprintf(buf, "%s\n",
-			       idxd_wq_type_names[IDXD_WQT_USER]);
+		return sysfs_emit(buf, "%s\n", idxd_wq_type_names[IDXD_WQT_USER]);
 	case IDXD_WQT_NONE:
 	default:
-		return sprintf(buf, "%s\n",
-			       idxd_wq_type_names[IDXD_WQT_NONE]);
+		return sysfs_emit(buf, "%s\n", idxd_wq_type_names[IDXD_WQT_NONE]);
 	}
 
 	return -EINVAL;
@@ -1197,7 +1192,7 @@ static ssize_t wq_name_show(struct device *dev,
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%s\n", wq->name);
+	return sysfs_emit(buf, "%s\n", wq->name);
 }
 
 static ssize_t wq_name_store(struct device *dev,
@@ -1233,7 +1228,7 @@ static ssize_t wq_cdev_minor_show(struct device *dev,
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%d\n", wq->idxd_cdev.minor);
+	return sysfs_emit(buf, "%d\n", wq->idxd_cdev.minor);
 }
 
 static struct device_attribute dev_attr_wq_cdev_minor =
@@ -1259,7 +1254,7 @@ static ssize_t wq_max_transfer_size_show(struct device *dev, struct device_attri
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%llu\n", wq->max_xfer_bytes);
+	return sysfs_emit(buf, "%llu\n", wq->max_xfer_bytes);
 }
 
 static ssize_t wq_max_transfer_size_store(struct device *dev, struct device_attribute *attr,
@@ -1293,7 +1288,7 @@ static ssize_t wq_max_batch_size_show(struct device *dev, struct device_attribut
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%u\n", wq->max_batch_size);
+	return sysfs_emit(buf, "%u\n", wq->max_batch_size);
 }
 
 static ssize_t wq_max_batch_size_store(struct device *dev, struct device_attribute *attr,
@@ -1326,7 +1321,7 @@ static ssize_t wq_ats_disable_show(struct device *dev, struct device_attribute *
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%u\n", wq->ats_dis);
+	return sysfs_emit(buf, "%u\n", wq->ats_dis);
 }
 
 static ssize_t wq_ats_disable_store(struct device *dev, struct device_attribute *attr,
@@ -1389,7 +1384,7 @@ static ssize_t version_show(struct device *dev, struct device_attribute *attr,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%#x\n", idxd->hw.version);
+	return sysfs_emit(buf, "%#x\n", idxd->hw.version);
 }
 static DEVICE_ATTR_RO(version);
 
@@ -1400,7 +1395,7 @@ static ssize_t max_work_queues_size_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n", idxd->max_wq_size);
+	return sysfs_emit(buf, "%u\n", idxd->max_wq_size);
 }
 static DEVICE_ATTR_RO(max_work_queues_size);
 
@@ -1410,7 +1405,7 @@ static ssize_t max_groups_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n", idxd->max_groups);
+	return sysfs_emit(buf, "%u\n", idxd->max_groups);
 }
 static DEVICE_ATTR_RO(max_groups);
 
@@ -1420,7 +1415,7 @@ static ssize_t max_work_queues_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n", idxd->max_wqs);
+	return sysfs_emit(buf, "%u\n", idxd->max_wqs);
 }
 static DEVICE_ATTR_RO(max_work_queues);
 
@@ -1430,7 +1425,7 @@ static ssize_t max_engines_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n", idxd->max_engines);
+	return sysfs_emit(buf, "%u\n", idxd->max_engines);
 }
 static DEVICE_ATTR_RO(max_engines);
 
@@ -1440,7 +1435,7 @@ static ssize_t numa_node_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%d\n", dev_to_node(&idxd->pdev->dev));
+	return sysfs_emit(buf, "%d\n", dev_to_node(&idxd->pdev->dev));
 }
 static DEVICE_ATTR_RO(numa_node);
 
@@ -1450,7 +1445,7 @@ static ssize_t max_batch_size_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n", idxd->max_batch_size);
+	return sysfs_emit(buf, "%u\n", idxd->max_batch_size);
 }
 static DEVICE_ATTR_RO(max_batch_size);
 
@@ -1461,7 +1456,7 @@ static ssize_t max_transfer_size_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%llu\n", idxd->max_xfer_bytes);
+	return sysfs_emit(buf, "%llu\n", idxd->max_xfer_bytes);
 }
 static DEVICE_ATTR_RO(max_transfer_size);
 
@@ -1471,7 +1466,7 @@ static ssize_t op_cap_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%#llx\n", idxd->hw.opcap.bits[0]);
+	return sysfs_emit(buf, "%#llx\n", idxd->hw.opcap.bits[0]);
 }
 static DEVICE_ATTR_RO(op_cap);
 
@@ -1481,7 +1476,7 @@ static ssize_t gen_cap_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%#llx\n", idxd->hw.gen_cap.bits);
+	return sysfs_emit(buf, "%#llx\n", idxd->hw.gen_cap.bits);
 }
 static DEVICE_ATTR_RO(gen_cap);
 
@@ -1491,8 +1486,7 @@ static ssize_t configurable_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n",
-			test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags));
+	return sysfs_emit(buf, "%u\n", test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags));
 }
 static DEVICE_ATTR_RO(configurable);
 
@@ -1512,7 +1506,7 @@ static ssize_t clients_show(struct device *dev,
 	}
 	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 
-	return sprintf(buf, "%d\n", count);
+	return sysfs_emit(buf, "%d\n", count);
 }
 static DEVICE_ATTR_RO(clients);
 
@@ -1522,7 +1516,7 @@ static ssize_t pasid_enabled_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n", device_pasid_enabled(idxd));
+	return sysfs_emit(buf, "%u\n", device_pasid_enabled(idxd));
 }
 static DEVICE_ATTR_RO(pasid_enabled);
 
@@ -1535,14 +1529,14 @@ static ssize_t state_show(struct device *dev,
 	switch (idxd->state) {
 	case IDXD_DEV_DISABLED:
 	case IDXD_DEV_CONF_READY:
-		return sprintf(buf, "disabled\n");
+		return sysfs_emit(buf, "disabled\n");
 	case IDXD_DEV_ENABLED:
-		return sprintf(buf, "enabled\n");
+		return sysfs_emit(buf, "enabled\n");
 	case IDXD_DEV_HALTED:
-		return sprintf(buf, "halted\n");
+		return sysfs_emit(buf, "halted\n");
 	}
 
-	return sprintf(buf, "unknown\n");
+	return sysfs_emit(buf, "unknown\n");
 }
 static DEVICE_ATTR_RO(state);
 
@@ -1556,10 +1550,10 @@ static ssize_t errors_show(struct device *dev,
 
 	spin_lock_irqsave(&idxd->dev_lock, flags);
 	for (i = 0; i < 4; i++)
-		out += sprintf(buf + out, "%#018llx ", idxd->sw_err.bits[i]);
+		out += sysfs_emit_at(buf, out, "%#018llx ", idxd->sw_err.bits[i]);
 	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 	out--;
-	out += sprintf(buf + out, "\n");
+	out += sysfs_emit_at(buf, out, "\n");
 	return out;
 }
 static DEVICE_ATTR_RO(errors);
@@ -1570,7 +1564,7 @@ static ssize_t max_tokens_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n", idxd->max_tokens);
+	return sysfs_emit(buf, "%u\n", idxd->max_tokens);
 }
 static DEVICE_ATTR_RO(max_tokens);
 
@@ -1580,7 +1574,7 @@ static ssize_t token_limit_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n", idxd->token_limit);
+	return sysfs_emit(buf, "%u\n", idxd->token_limit);
 }
 
 static ssize_t token_limit_store(struct device *dev,
@@ -1619,7 +1613,7 @@ static ssize_t cdev_major_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n", idxd->major);
+	return sysfs_emit(buf, "%u\n", idxd->major);
 }
 static DEVICE_ATTR_RO(cdev_major);
 
@@ -1628,7 +1622,7 @@ static ssize_t cmd_status_show(struct device *dev,
 {
 	struct idxd_device *idxd = container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%#x\n", idxd->cmd_status);
+	return sysfs_emit(buf, "%#x\n", idxd->cmd_status);
 }
 static DEVICE_ATTR_RO(cmd_status);
 


