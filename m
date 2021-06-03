Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B36A39ACD9
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jun 2021 23:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhFCVaM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 17:30:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:9949 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhFCVaM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Jun 2021 17:30:12 -0400
IronPort-SDR: 2E6aORa6EzPk86sfuGmjz7/HXaR6QfNkqyTYmKtKyYyY4d3/w4VWryIvvoIJs8Fjb+PZ63Oe6t
 ga6hGVMoygnQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="203970012"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="203970012"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 14:28:21 -0700
IronPort-SDR: U3j1c9pJuChCGEdQU9r+6IcoVdUHZR0AKkxt5/gdmyd5iA4gmWxnzD8pr9XOBqZkAJ38BZhZdh
 DSKCVUIwM69A==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="550845322"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 14:28:19 -0700
Subject: [PATCH] dmanegine: idxd: cleanup all device related bits after
 disabling device
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Thu, 03 Jun 2021 14:28:19 -0700
Message-ID: <162275569924.1841529.11001980226941532212.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The previous state cleanup patch only performed wq state cleanups. This
does not go far enough as when device is disabled or reset, the state
for groups and engines must also be cleaned up. Add additional state
cleanup beyond wq cleanup. Tie those cleanups directly to device
disable and reset, and wq disable and reset.

Fixes: da32b28c95a7 ("dmaengine: idxd: cleanup workqueue config after disabling")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |   88 +++++++++++++++++++++++++++++++++------------
 drivers/dma/idxd/idxd.h   |    6 +--
 drivers/dma/idxd/irq.c    |    4 +-
 drivers/dma/idxd/sysfs.c  |   17 ++-------
 4 files changed, 72 insertions(+), 43 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5357dfdd02bb..c8cf1de72176 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -15,6 +15,8 @@
 
 static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 			  u32 *status);
+static void idxd_device_wqs_clear_state(struct idxd_device *idxd);
+static void idxd_wq_disable_cleanup(struct idxd_wq *wq);
 
 /* Interrupt control bits */
 void idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id)
@@ -234,7 +236,7 @@ int idxd_wq_enable(struct idxd_wq *wq)
 	return 0;
 }
 
-int idxd_wq_disable(struct idxd_wq *wq)
+int idxd_wq_disable(struct idxd_wq *wq, bool reset_config)
 {
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
@@ -255,6 +257,8 @@ int idxd_wq_disable(struct idxd_wq *wq)
 		return -ENXIO;
 	}
 
+	if (reset_config)
+		idxd_wq_disable_cleanup(wq);
 	wq->state = IDXD_WQ_DISABLED;
 	dev_dbg(dev, "WQ %d disabled\n", wq->id);
 	return 0;
@@ -289,6 +293,7 @@ void idxd_wq_reset(struct idxd_wq *wq)
 
 	operand = BIT(wq->id % 16) | ((wq->id / 16) << 16);
 	idxd_cmd_exec(idxd, IDXD_CMD_RESET_WQ, operand, NULL);
+	idxd_wq_disable_cleanup(wq);
 	wq->state = IDXD_WQ_DISABLED;
 }
 
@@ -337,7 +342,7 @@ int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid)
 	unsigned int offset;
 	unsigned long flags;
 
-	rc = idxd_wq_disable(wq);
+	rc = idxd_wq_disable(wq, false);
 	if (rc < 0)
 		return rc;
 
@@ -364,7 +369,7 @@ int idxd_wq_disable_pasid(struct idxd_wq *wq)
 	unsigned int offset;
 	unsigned long flags;
 
-	rc = idxd_wq_disable(wq);
+	rc = idxd_wq_disable(wq, false);
 	if (rc < 0)
 		return rc;
 
@@ -383,11 +388,11 @@ int idxd_wq_disable_pasid(struct idxd_wq *wq)
 	return 0;
 }
 
-void idxd_wq_disable_cleanup(struct idxd_wq *wq)
+static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
 
-	lockdep_assert_held(&idxd->dev_lock);
+	lockdep_assert_held(&wq->wq_lock);
 	memset(wq->wqcfg, 0, idxd->wqcfg_size);
 	wq->type = IDXD_WQT_NONE;
 	wq->size = 0;
@@ -549,22 +554,6 @@ int idxd_device_enable(struct idxd_device *idxd)
 	return 0;
 }
 
-void idxd_device_wqs_clear_state(struct idxd_device *idxd)
-{
-	int i;
-
-	lockdep_assert_held(&idxd->dev_lock);
-
-	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = idxd->wqs[i];
-
-		if (wq->state == IDXD_WQ_ENABLED) {
-			idxd_wq_disable_cleanup(wq);
-			wq->state = IDXD_WQ_DISABLED;
-		}
-	}
-}
-
 int idxd_device_disable(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -586,7 +575,7 @@ int idxd_device_disable(struct idxd_device *idxd)
 	}
 
 	spin_lock_irqsave(&idxd->dev_lock, flags);
-	idxd_device_wqs_clear_state(idxd);
+	idxd_device_clear_state(idxd);
 	idxd->state = IDXD_DEV_CONF_READY;
 	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 	return 0;
@@ -598,7 +587,7 @@ void idxd_device_reset(struct idxd_device *idxd)
 
 	idxd_cmd_exec(idxd, IDXD_CMD_RESET_DEVICE, 0, NULL);
 	spin_lock_irqsave(&idxd->dev_lock, flags);
-	idxd_device_wqs_clear_state(idxd);
+	idxd_device_clear_state(idxd);
 	idxd->state = IDXD_DEV_CONF_READY;
 	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 }
@@ -686,6 +675,59 @@ int idxd_device_release_int_handle(struct idxd_device *idxd, int handle,
 }
 
 /* Device configuration bits */
+static void idxd_engines_clear_state(struct idxd_device *idxd)
+{
+	struct idxd_engine *engine;
+	int i;
+
+	lockdep_assert_held(&idxd->dev_lock);
+	for (i = 0; i < idxd->max_engines; i++) {
+		engine = idxd->engines[i];
+		engine->group = NULL;
+	}
+}
+
+static void idxd_groups_clear_state(struct idxd_device *idxd)
+{
+	struct idxd_group *group;
+	int i;
+
+	lockdep_assert_held(&idxd->dev_lock);
+	for (i = 0; i < idxd->max_groups; i++) {
+		group = idxd->groups[i];
+		memset(&group->grpcfg, 0, sizeof(group->grpcfg));
+		group->num_engines = 0;
+		group->num_wqs = 0;
+		group->use_token_limit = false;
+		group->tokens_allowed = 0;
+		group->tokens_reserved = 0;
+		group->tc_a = -1;
+		group->tc_b = -1;
+	}
+}
+
+static void idxd_device_wqs_clear_state(struct idxd_device *idxd)
+{
+	int i;
+
+	lockdep_assert_held(&idxd->dev_lock);
+	for (i = 0; i < idxd->max_wqs; i++) {
+		struct idxd_wq *wq = idxd->wqs[i];
+
+		if (wq->state == IDXD_WQ_ENABLED) {
+			idxd_wq_disable_cleanup(wq);
+			wq->state = IDXD_WQ_DISABLED;
+		}
+	}
+}
+
+void idxd_device_clear_state(struct idxd_device *idxd)
+{
+	idxd_groups_clear_state(idxd);
+	idxd_engines_clear_state(idxd);
+	idxd_device_wqs_clear_state(idxd);
+}
+
 void idxd_msix_perm_setup(struct idxd_device *idxd)
 {
 	union msix_perm mperm;
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 26482c7d4c3a..1f0991dec679 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -420,9 +420,8 @@ int idxd_device_init_reset(struct idxd_device *idxd);
 int idxd_device_enable(struct idxd_device *idxd);
 int idxd_device_disable(struct idxd_device *idxd);
 void idxd_device_reset(struct idxd_device *idxd);
-void idxd_device_cleanup(struct idxd_device *idxd);
+void idxd_device_clear_state(struct idxd_device *idxd);
 int idxd_device_config(struct idxd_device *idxd);
-void idxd_device_wqs_clear_state(struct idxd_device *idxd);
 void idxd_device_drain_pasid(struct idxd_device *idxd, int pasid);
 int idxd_device_load_config(struct idxd_device *idxd);
 int idxd_device_request_int_handle(struct idxd_device *idxd, int idx, int *handle,
@@ -435,12 +434,11 @@ void idxd_wqs_unmap_portal(struct idxd_device *idxd);
 int idxd_wq_alloc_resources(struct idxd_wq *wq);
 void idxd_wq_free_resources(struct idxd_wq *wq);
 int idxd_wq_enable(struct idxd_wq *wq);
-int idxd_wq_disable(struct idxd_wq *wq);
+int idxd_wq_disable(struct idxd_wq *wq, bool reset_config);
 void idxd_wq_drain(struct idxd_wq *wq);
 void idxd_wq_reset(struct idxd_wq *wq);
 int idxd_wq_map_portal(struct idxd_wq *wq);
 void idxd_wq_unmap_portal(struct idxd_wq *wq);
-void idxd_wq_disable_cleanup(struct idxd_wq *wq);
 int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid);
 int idxd_wq_disable_pasid(struct idxd_wq *wq);
 void idxd_wq_quiesce(struct idxd_wq *wq);
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index ae68e1e5487a..7a2cf0512501 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -59,7 +59,7 @@ static void idxd_device_reinit(struct work_struct *work)
 	return;
 
  out:
-	idxd_device_wqs_clear_state(idxd);
+	idxd_device_clear_state(idxd);
 }
 
 static void idxd_device_fault_work(struct work_struct *work)
@@ -192,7 +192,7 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 			spin_lock_bh(&idxd->dev_lock);
 			idxd_wqs_quiesce(idxd);
 			idxd_wqs_unmap_portal(idxd);
-			idxd_device_wqs_clear_state(idxd);
+			idxd_device_clear_state(idxd);
 			dev_err(&idxd->pdev->dev,
 				"idxd halted, need %s.\n",
 				gensts.reset_type == IDXD_DEVICE_RESET_FLR ?
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 0460d58e3941..339d8ac3c73a 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -129,7 +129,7 @@ static int enable_wq(struct idxd_wq *wq)
 	rc = idxd_wq_map_portal(wq);
 	if (rc < 0) {
 		dev_warn(dev, "wq portal mapping failed: %d\n", rc);
-		rc = idxd_wq_disable(wq);
+		rc = idxd_wq_disable(wq, false);
 		if (rc < 0)
 			dev_warn(dev, "IDXD wq disable failed\n");
 		mutex_unlock(&wq->wq_lock);
@@ -289,21 +289,10 @@ static int idxd_config_bus_remove(struct device *dev)
 
 		idxd_unregister_dma_device(idxd);
 		rc = idxd_device_disable(idxd);
-		if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
-			for (i = 0; i < idxd->max_wqs; i++) {
-				struct idxd_wq *wq = idxd->wqs[i];
-
-				mutex_lock(&wq->wq_lock);
-				idxd_wq_disable_cleanup(wq);
-				mutex_unlock(&wq->wq_lock);
-			}
-		}
+		idxd_device_reset(idxd);
 		module_put(THIS_MODULE);
-		if (rc < 0)
-			dev_warn(dev, "Device disable failed\n");
-		else
-			dev_info(dev, "Device %s disabled\n", dev_name(dev));
 
+		dev_info(dev, "Device %s disabled\n", dev_name(dev));
 	}
 
 	return 0;


