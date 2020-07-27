Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439FB22F581
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jul 2020 18:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgG0QhM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jul 2020 12:37:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:55283 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbgG0QhM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Jul 2020 12:37:12 -0400
IronPort-SDR: SSN7DRZ9aSeuK0rciOwmDMB8djs16O4euYFRsQm0T3ELCPaG2Y09vdWqqt7fjWSRP+mfptulhx
 ySSzJH4zdEJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="138574529"
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="138574529"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 09:37:11 -0700
IronPort-SDR: ahppDWwWFt/B4EZ01uw/jA16UC/2WUSFUgObNCRhV6TykUlYvWC4Qj9YMqIxjCluID2upxEoH2
 /bUGNMtKjXEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="490027095"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jul 2020 09:37:11 -0700
Subject: [PATCH v2] dmaengine: idxd: reset states after device disable or
 reset
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Mona Hossain <mona.hossain@intel.com>, dmaengine@vger.kernel.org
Date:   Mon, 27 Jul 2020 09:37:11 -0700
Message-ID: <159586777684.27150.17589406415773568534.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The state for WQs should be reset to disabled when a device is reset or
disabled.

Fixes: da32b28c95a7 ("dmaengine: idxd: cleanup workqueue config after disabling")
Reported-by: Mona Hossain <mona.hossain@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v2:
- Combine code to helper routine (Vinod)

 drivers/dma/idxd/device.c |   26 ++++++++++++++++++++++++++
 drivers/dma/idxd/irq.c    |   12 ------------
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 14b45853aa5f..b75d699160bf 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -410,10 +410,27 @@ int idxd_device_enable(struct idxd_device *idxd)
 	return 0;
 }
 
+void idxd_device_wqs_clear_state(struct idxd_device *idxd)
+{
+	int i;
+
+	lockdep_assert_held(&idxd->dev_lock);
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		struct idxd_wq *wq = &idxd->wqs[i];
+
+		if (wq->state == IDXD_WQ_ENABLED) {
+			idxd_wq_disable_cleanup(wq);
+			wq->state = IDXD_WQ_DISABLED;
+		}
+	}
+}
+
 int idxd_device_disable(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
 	u32 status;
+	unsigned long flags;
 
 	if (!idxd_is_enabled(idxd)) {
 		dev_dbg(dev, "Device is not enabled\n");
@@ -429,13 +446,22 @@ int idxd_device_disable(struct idxd_device *idxd)
 		return -ENXIO;
 	}
 
+	spin_lock_irqsave(&idxd->dev_lock, flags);
+	idxd_device_wqs_clear_state(idxd);
 	idxd->state = IDXD_DEV_CONF_READY;
+	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 	return 0;
 }
 
 void idxd_device_reset(struct idxd_device *idxd)
 {
+	unsigned long flags;
+
 	idxd_cmd_exec(idxd, IDXD_CMD_RESET_DEVICE, 0, NULL);
+	spin_lock_irqsave(&idxd->dev_lock, flags);
+	idxd_device_wqs_clear_state(idxd);
+	idxd->state = IDXD_DEV_CONF_READY;
+	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 }
 
 /* Device configuration bits */
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index b5142556cc4e..1e9e6991f543 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -11,18 +11,6 @@
 #include "idxd.h"
 #include "registers.h"
 
-void idxd_device_wqs_clear_state(struct idxd_device *idxd)
-{
-	int i;
-
-	lockdep_assert_held(&idxd->dev_lock);
-	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
-
-		wq->state = IDXD_WQ_DISABLED;
-	}
-}
-
 static void idxd_device_reinit(struct work_struct *work)
 {
 	struct idxd_device *idxd = container_of(work, struct idxd_device, work);

