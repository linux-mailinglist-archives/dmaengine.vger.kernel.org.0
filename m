Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E0E345314
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 00:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCVXfz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 19:35:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:58763 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhCVXfn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Mar 2021 19:35:43 -0400
IronPort-SDR: fJUhtb6Vdxr0ysfXN1NGfZNe/QrOt6O5LzPwqiFqM5e9eMAjf7jbl4sL1Ok+o1BVyVpcPKEThM
 V7w0yyH2/WfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="170331445"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="170331445"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:35:42 -0700
IronPort-SDR: 6oWMoDRu4tnOT9Yz9TnD057VopKEp5fpEBL+huqFiNJfev+w2cmVAfcyZR3dtWbQHXlKwtD8Kx
 d+8L0/cahFtw==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="414701757"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:35:42 -0700
Subject: [PATCH] dmaengine: idxd: fix wq cleanup of WQCFG registers
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Mon, 22 Mar 2021 16:35:42 -0700
Message-ID: <161645614209.2003266.16919162188938345833.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

A pre-release silicon erratum workaround where wq reset does not clear
WQCFG registers was leaked into upstream code. Use wq reset command
instead of blasting the MMIO region. This also address an issue where
we clobber registers in future devices.

Fixes: da32b28c95a7 ("dmaengine: idxd: cleanup workqueue config after disabling")
Reported-by: Shreenivaas Devarajan <shreenivaas.devarajan@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |   24 ++++++++++++++++--------
 drivers/dma/idxd/idxd.h   |    1 +
 drivers/dma/idxd/sysfs.c  |    9 ++-------
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 1e5380b2a88c..e1fdd4c5c2fa 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -282,6 +282,22 @@ void idxd_wq_drain(struct idxd_wq *wq)
 	idxd_cmd_exec(idxd, IDXD_CMD_DRAIN_WQ, operand, NULL);
 }
 
+void idxd_wq_reset(struct idxd_wq *wq)
+{
+	struct idxd_device *idxd = wq->idxd;
+	struct device *dev = &idxd->pdev->dev;
+	u32 operand;
+
+	if (wq->state != IDXD_WQ_ENABLED) {
+		dev_dbg(dev, "WQ %d in wrong state: %d\n", wq->id, wq->state);
+		return;
+	}
+
+	dev_dbg(dev, "Resetting WQ %d\n", wq->id);
+	operand = BIT(wq->id % 16) | ((wq->id / 16) << 16);
+	idxd_cmd_exec(idxd, IDXD_CMD_RESET_WQ, operand, NULL);
+}
+
 int idxd_wq_map_portal(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
@@ -376,14 +392,6 @@ void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	wq->ats_dis = 0;
 	clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
 	memset(wq->name, 0, WQ_NAME_SIZE);
-
-	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
-		wq_offset = WQCFG_OFFSET(idxd, wq->id, i);
-		iowrite32(0, idxd->reg_base + wq_offset);
-		dev_dbg(dev, "WQ[%d][%d][%#x]: %#x\n",
-			wq->id, i, wq_offset,
-			ioread32(idxd->reg_base + wq_offset));
-	}
 }
 
 /* Device control bits */
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index acb70c3b7e36..d2c0ea7349ed 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -390,6 +390,7 @@ void idxd_wq_free_resources(struct idxd_wq *wq);
 int idxd_wq_enable(struct idxd_wq *wq);
 int idxd_wq_disable(struct idxd_wq *wq);
 void idxd_wq_drain(struct idxd_wq *wq);
+void idxd_wq_reset(struct idxd_wq *wq);
 int idxd_wq_map_portal(struct idxd_wq *wq);
 void idxd_wq_unmap_portal(struct idxd_wq *wq);
 void idxd_wq_disable_cleanup(struct idxd_wq *wq);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 8a08988ea9d1..e018d2339ccd 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -212,7 +212,6 @@ static void disable_wq(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
-	int rc;
 
 	mutex_lock(&wq->wq_lock);
 	dev_dbg(dev, "%s removing WQ %s\n", __func__, dev_name(&wq->conf_dev));
@@ -233,17 +232,13 @@ static void disable_wq(struct idxd_wq *wq)
 	idxd_wq_unmap_portal(wq);
 
 	idxd_wq_drain(wq);
-	rc = idxd_wq_disable(wq);
+	idxd_wq_reset(wq);
 
 	idxd_wq_free_resources(wq);
 	wq->client_count = 0;
 	mutex_unlock(&wq->wq_lock);
 
-	if (rc < 0)
-		dev_warn(dev, "Failed to disable %s: %d\n",
-			 dev_name(&wq->conf_dev), rc);
-	else
-		dev_info(dev, "wq %s disabled\n", dev_name(&wq->conf_dev));
+	dev_info(dev, "wq %s disabled\n", dev_name(&wq->conf_dev));
 }
 
 static int idxd_config_bus_remove(struct device *dev)


