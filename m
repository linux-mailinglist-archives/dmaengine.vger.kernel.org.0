Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622D035CAA8
	for <lists+dmaengine@lfdr.de>; Mon, 12 Apr 2021 18:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbhDLQC5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Apr 2021 12:02:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:37590 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238937AbhDLQC4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Apr 2021 12:02:56 -0400
IronPort-SDR: lqYmsTJaibwa1mowBBvSGhS6WwSh1sJjR/C6VQij1WSMsHamEh264ROZ8ET2YXPXjpbiVoj5ca
 6c1ioH3jZuZg==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="194340440"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="194340440"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 09:02:37 -0700
IronPort-SDR: EkA1pvtIm3huhK6IxEjedKBh8QdJuTY5BL7MVsT/63YKF7jPeJrWs4Iv08JcaSCd6o8hoXDJJ7
 q/Q8j2JaqY4A==
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="521245623"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 09:02:37 -0700
Subject: [PATCH v4] dmaengine: idxd: fix wq cleanup of WQCFG registers
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Shreenivaas Devarajan <shreenivaas.devarajan@intel.com>,
        dmaengine@vger.kernel.org
Date:   Mon, 12 Apr 2021 09:02:36 -0700
Message-ID: <161824330020.881560.16375921906426627033.stgit@djiang5-desk3.ch.intel.com>
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
v4:
- Remove noisy debug output (Vinod)
v3:
- Remove unused vars
v2:
- Set IDXD_WQ_DISABLED for internal state after reset.

 drivers/dma/idxd/device.c |   35 ++++++++++++++++++++++++-----------
 drivers/dma/idxd/idxd.h   |    1 +
 drivers/dma/idxd/sysfs.c  |    9 ++-------
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 84a6ea60ecf0..0375d9459e74 100644
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
+	operand = BIT(wq->id % 16) | ((wq->id / 16) << 16);
+	idxd_cmd_exec(idxd, IDXD_CMD_RESET_WQ, operand, NULL);
+	wq->state = IDXD_WQ_DISABLED;
+}
+
 int idxd_wq_map_portal(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
@@ -363,8 +379,6 @@ int idxd_wq_disable_pasid(struct idxd_wq *wq)
 void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
-	struct device *dev = &idxd->pdev->dev;
-	int i, wq_offset;
 
 	lockdep_assert_held(&idxd->dev_lock);
 	memset(wq->wqcfg, 0, idxd->wqcfg_size);
@@ -376,14 +390,6 @@ void idxd_wq_disable_cleanup(struct idxd_wq *wq)
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
@@ -642,7 +648,14 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 	if (!wq->group)
 		return 0;
 
-	memset(wq->wqcfg, 0, idxd->wqcfg_size);
+	/*
+	 * Instead of memset the entire shadow copy of WQCFG, copy from the hardware after
+	 * wq reset. This will copy back the sticky values that are present on some devices.
+	 */
+	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
+		wq_offset = WQCFG_OFFSET(idxd, wq->id, i);
+		wq->wqcfg->bits[i] = ioread32(idxd->reg_base + wq_offset);
+	}
 
 	/* byte 0-3 */
 	wq->wqcfg->wq_size = wq->size;
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 81a0e65fd316..730745d331e3 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -341,6 +341,7 @@ void idxd_wq_free_resources(struct idxd_wq *wq);
 int idxd_wq_enable(struct idxd_wq *wq);
 int idxd_wq_disable(struct idxd_wq *wq);
 void idxd_wq_drain(struct idxd_wq *wq);
+void idxd_wq_reset(struct idxd_wq *wq);
 int idxd_wq_map_portal(struct idxd_wq *wq);
 void idxd_wq_unmap_portal(struct idxd_wq *wq);
 void idxd_wq_disable_cleanup(struct idxd_wq *wq);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 5f7bc4b1621a..18bf4d148989 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -275,7 +275,6 @@ static void disable_wq(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
-	int rc;
 
 	mutex_lock(&wq->wq_lock);
 	dev_dbg(dev, "%s removing WQ %s\n", __func__, dev_name(&wq->conf_dev));
@@ -296,17 +295,13 @@ static void disable_wq(struct idxd_wq *wq)
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


