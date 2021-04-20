Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76876365FAF
	for <lists+dmaengine@lfdr.de>; Tue, 20 Apr 2021 20:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhDTSrO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Apr 2021 14:47:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:56624 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233541AbhDTSrN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Apr 2021 14:47:13 -0400
IronPort-SDR: EbXTqflUP6Z8uhaHrUYLbk1DAFBf0HnhyyAxkKNqIzEGtblyxgO7u7gkTias+U9iGnhnIi1eqL
 TCKTU2S9h1TA==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="280896743"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="280896743"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 11:46:41 -0700
IronPort-SDR: Urce3yoC/LPYM+C5KMMskN5fceWdvyWS4It0g0nJdzLLPT5z3isT5Z1YffVu65s7o5lNBZNgal
 y562pArBtilg==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="384173211"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 11:46:40 -0700
Subject: [PATCH 4/6] dmaengine: idxd: convert sprintf() to sysfs_emit() for
 all usages
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 20 Apr 2021 11:46:40 -0700
Message-ID: <161894440044.3202472.13926639619695319753.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161894424826.3202472.897357148671784604.stgit@djiang5-desk3.ch.intel.com>
References: <161894424826.3202472.897357148671784604.stgit@djiang5-desk3.ch.intel.com>
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
 drivers/dma/idxd/sysfs.c |  116 ++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 61 deletions(-)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 3f4ea4d0fae7..0460d58e3941 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -350,9 +350,9 @@ static ssize_t engine_group_id_show(struct device *dev,
 		container_of(dev, struct idxd_engine, conf_dev);
 
 	if (engine->group)
-		return sprintf(buf, "%d\n", engine->group->id);
+		return sysfs_emit(buf, "%d\n", engine->group->id);
 	else
-		return sprintf(buf, "%d\n", -1);
+		return sysfs_emit(buf, "%d\n", -1);
 }
 
 static ssize_t engine_group_id_store(struct device *dev,
@@ -447,7 +447,7 @@ static ssize_t group_tokens_reserved_show(struct device *dev,
 	struct idxd_group *group =
 		container_of(dev, struct idxd_group, conf_dev);
 
-	return sprintf(buf, "%u\n", group->tokens_reserved);
+	return sysfs_emit(buf, "%u\n", group->tokens_reserved);
 }
 
 static ssize_t group_tokens_reserved_store(struct device *dev,
@@ -495,7 +495,7 @@ static ssize_t group_tokens_allowed_show(struct device *dev,
 	struct idxd_group *group =
 		container_of(dev, struct idxd_group, conf_dev);
 
-	return sprintf(buf, "%u\n", group->tokens_allowed);
+	return sysfs_emit(buf, "%u\n", group->tokens_allowed);
 }
 
 static ssize_t group_tokens_allowed_store(struct device *dev,
@@ -540,7 +540,7 @@ static ssize_t group_use_token_limit_show(struct device *dev,
 	struct idxd_group *group =
 		container_of(dev, struct idxd_group, conf_dev);
 
-	return sprintf(buf, "%u\n", group->use_token_limit);
+	return sysfs_emit(buf, "%u\n", group->use_token_limit);
 }
 
 static ssize_t group_use_token_limit_store(struct device *dev,
@@ -583,7 +583,6 @@ static ssize_t group_engines_show(struct device *dev,
 	struct idxd_group *group =
 		container_of(dev, struct idxd_group, conf_dev);
 	int i, rc = 0;
-	char *tmp = buf;
 	struct idxd_device *idxd = group->idxd;
 
 	for (i = 0; i < idxd->max_engines; i++) {
@@ -593,12 +592,13 @@ static ssize_t group_engines_show(struct device *dev,
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
@@ -612,7 +612,6 @@ static ssize_t group_work_queues_show(struct device *dev,
 	struct idxd_group *group =
 		container_of(dev, struct idxd_group, conf_dev);
 	int i, rc = 0;
-	char *tmp = buf;
 	struct idxd_device *idxd = group->idxd;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
@@ -622,12 +621,13 @@ static ssize_t group_work_queues_show(struct device *dev,
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
@@ -642,7 +642,7 @@ static ssize_t group_traffic_class_a_show(struct device *dev,
 	struct idxd_group *group =
 		container_of(dev, struct idxd_group, conf_dev);
 
-	return sprintf(buf, "%d\n", group->tc_a);
+	return sysfs_emit(buf, "%d\n", group->tc_a);
 }
 
 static ssize_t group_traffic_class_a_store(struct device *dev,
@@ -683,7 +683,7 @@ static ssize_t group_traffic_class_b_show(struct device *dev,
 	struct idxd_group *group =
 		container_of(dev, struct idxd_group, conf_dev);
 
-	return sprintf(buf, "%d\n", group->tc_b);
+	return sysfs_emit(buf, "%d\n", group->tc_b);
 }
 
 static ssize_t group_traffic_class_b_store(struct device *dev,
@@ -756,7 +756,7 @@ static ssize_t wq_clients_show(struct device *dev,
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%d\n", wq->client_count);
+	return sysfs_emit(buf, "%d\n", wq->client_count);
 }
 
 static struct device_attribute dev_attr_wq_clients =
@@ -769,12 +769,12 @@ static ssize_t wq_state_show(struct device *dev,
 
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
@@ -786,9 +786,9 @@ static ssize_t wq_group_id_show(struct device *dev,
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
 	if (wq->group)
-		return sprintf(buf, "%u\n", wq->group->id);
+		return sysfs_emit(buf, "%u\n", wq->group->id);
 	else
-		return sprintf(buf, "-1\n");
+		return sysfs_emit(buf, "-1\n");
 }
 
 static ssize_t wq_group_id_store(struct device *dev,
@@ -840,8 +840,7 @@ static ssize_t wq_mode_show(struct device *dev, struct device_attribute *attr,
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%s\n",
-			wq_dedicated(wq) ? "dedicated" : "shared");
+	return sysfs_emit(buf, "%s\n", wq_dedicated(wq) ? "dedicated" : "shared");
 }
 
 static ssize_t wq_mode_store(struct device *dev,
@@ -877,7 +876,7 @@ static ssize_t wq_size_show(struct device *dev, struct device_attribute *attr,
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%u\n", wq->size);
+	return sysfs_emit(buf, "%u\n", wq->size);
 }
 
 static int total_claimed_wq_size(struct idxd_device *idxd)
@@ -928,7 +927,7 @@ static ssize_t wq_priority_show(struct device *dev,
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%u\n", wq->priority);
+	return sysfs_emit(buf, "%u\n", wq->priority);
 }
 
 static ssize_t wq_priority_store(struct device *dev,
@@ -965,8 +964,7 @@ static ssize_t wq_block_on_fault_show(struct device *dev,
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%u\n",
-		       test_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags));
+	return sysfs_emit(buf, "%u\n", test_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags));
 }
 
 static ssize_t wq_block_on_fault_store(struct device *dev,
@@ -1005,7 +1003,7 @@ static ssize_t wq_threshold_show(struct device *dev,
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%u\n", wq->threshold);
+	return sysfs_emit(buf, "%u\n", wq->threshold);
 }
 
 static ssize_t wq_threshold_store(struct device *dev,
@@ -1048,15 +1046,12 @@ static ssize_t wq_type_show(struct device *dev,
 
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
@@ -1097,7 +1092,7 @@ static ssize_t wq_name_show(struct device *dev,
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%s\n", wq->name);
+	return sysfs_emit(buf, "%s\n", wq->name);
 }
 
 static ssize_t wq_name_store(struct device *dev,
@@ -1167,7 +1162,7 @@ static ssize_t wq_max_transfer_size_show(struct device *dev, struct device_attri
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%llu\n", wq->max_xfer_bytes);
+	return sysfs_emit(buf, "%llu\n", wq->max_xfer_bytes);
 }
 
 static ssize_t wq_max_transfer_size_store(struct device *dev, struct device_attribute *attr,
@@ -1201,7 +1196,7 @@ static ssize_t wq_max_batch_size_show(struct device *dev, struct device_attribut
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%u\n", wq->max_batch_size);
+	return sysfs_emit(buf, "%u\n", wq->max_batch_size);
 }
 
 static ssize_t wq_max_batch_size_store(struct device *dev, struct device_attribute *attr,
@@ -1234,7 +1229,7 @@ static ssize_t wq_ats_disable_show(struct device *dev, struct device_attribute *
 {
 	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
 
-	return sprintf(buf, "%u\n", wq->ats_dis);
+	return sysfs_emit(buf, "%u\n", wq->ats_dis);
 }
 
 static ssize_t wq_ats_disable_store(struct device *dev, struct device_attribute *attr,
@@ -1311,7 +1306,7 @@ static ssize_t version_show(struct device *dev, struct device_attribute *attr,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%#x\n", idxd->hw.version);
+	return sysfs_emit(buf, "%#x\n", idxd->hw.version);
 }
 static DEVICE_ATTR_RO(version);
 
@@ -1322,7 +1317,7 @@ static ssize_t max_work_queues_size_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n", idxd->max_wq_size);
+	return sysfs_emit(buf, "%u\n", idxd->max_wq_size);
 }
 static DEVICE_ATTR_RO(max_work_queues_size);
 
@@ -1332,7 +1327,7 @@ static ssize_t max_groups_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n", idxd->max_groups);
+	return sysfs_emit(buf, "%u\n", idxd->max_groups);
 }
 static DEVICE_ATTR_RO(max_groups);
 
@@ -1342,7 +1337,7 @@ static ssize_t max_work_queues_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n", idxd->max_wqs);
+	return sysfs_emit(buf, "%u\n", idxd->max_wqs);
 }
 static DEVICE_ATTR_RO(max_work_queues);
 
@@ -1352,7 +1347,7 @@ static ssize_t max_engines_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n", idxd->max_engines);
+	return sysfs_emit(buf, "%u\n", idxd->max_engines);
 }
 static DEVICE_ATTR_RO(max_engines);
 
@@ -1362,7 +1357,7 @@ static ssize_t numa_node_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%d\n", dev_to_node(&idxd->pdev->dev));
+	return sysfs_emit(buf, "%d\n", dev_to_node(&idxd->pdev->dev));
 }
 static DEVICE_ATTR_RO(numa_node);
 
@@ -1372,7 +1367,7 @@ static ssize_t max_batch_size_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n", idxd->max_batch_size);
+	return sysfs_emit(buf, "%u\n", idxd->max_batch_size);
 }
 static DEVICE_ATTR_RO(max_batch_size);
 
@@ -1383,7 +1378,7 @@ static ssize_t max_transfer_size_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%llu\n", idxd->max_xfer_bytes);
+	return sysfs_emit(buf, "%llu\n", idxd->max_xfer_bytes);
 }
 static DEVICE_ATTR_RO(max_transfer_size);
 
@@ -1409,7 +1404,7 @@ static ssize_t gen_cap_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%#llx\n", idxd->hw.gen_cap.bits);
+	return sysfs_emit(buf, "%#llx\n", idxd->hw.gen_cap.bits);
 }
 static DEVICE_ATTR_RO(gen_cap);
 
@@ -1419,8 +1414,7 @@ static ssize_t configurable_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n",
-			test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags));
+	return sysfs_emit(buf, "%u\n", test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags));
 }
 static DEVICE_ATTR_RO(configurable);
 
@@ -1440,7 +1434,7 @@ static ssize_t clients_show(struct device *dev,
 	}
 	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 
-	return sprintf(buf, "%d\n", count);
+	return sysfs_emit(buf, "%d\n", count);
 }
 static DEVICE_ATTR_RO(clients);
 
@@ -1450,7 +1444,7 @@ static ssize_t pasid_enabled_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n", device_pasid_enabled(idxd));
+	return sysfs_emit(buf, "%u\n", device_pasid_enabled(idxd));
 }
 static DEVICE_ATTR_RO(pasid_enabled);
 
@@ -1463,14 +1457,14 @@ static ssize_t state_show(struct device *dev,
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
 
@@ -1484,10 +1478,10 @@ static ssize_t errors_show(struct device *dev,
 
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
@@ -1498,7 +1492,7 @@ static ssize_t max_tokens_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n", idxd->max_tokens);
+	return sysfs_emit(buf, "%u\n", idxd->max_tokens);
 }
 static DEVICE_ATTR_RO(max_tokens);
 
@@ -1508,7 +1502,7 @@ static ssize_t token_limit_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n", idxd->token_limit);
+	return sysfs_emit(buf, "%u\n", idxd->token_limit);
 }
 
 static ssize_t token_limit_store(struct device *dev,
@@ -1547,7 +1541,7 @@ static ssize_t cdev_major_show(struct device *dev,
 	struct idxd_device *idxd =
 		container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%u\n", idxd->major);
+	return sysfs_emit(buf, "%u\n", idxd->major);
 }
 static DEVICE_ATTR_RO(cdev_major);
 
@@ -1556,7 +1550,7 @@ static ssize_t cmd_status_show(struct device *dev,
 {
 	struct idxd_device *idxd = container_of(dev, struct idxd_device, conf_dev);
 
-	return sprintf(buf, "%#x\n", idxd->cmd_status);
+	return sysfs_emit(buf, "%#x\n", idxd->cmd_status);
 }
 static DEVICE_ATTR_RO(cmd_status);
 


