Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7A51D59EB
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2020 21:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgEOTYT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 May 2020 15:24:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:61574 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgEOTYS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 May 2020 15:24:18 -0400
IronPort-SDR: M8lAlr7ITtNnKSIwdtYqOdznWyjnGdRpMRyHZTB+SPcV8JYafqR4haZRyX9DdnvWtu5nG8zagl
 UzokrNoHy1lg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 12:24:18 -0700
IronPort-SDR: wIUqA+K/d/IySKjhc0Am99CrnUuuS9PaGU1AvcsB78Tr1qWVbqAXPyW2Y9hMRnswIFpOx+/dQL
 YDLXTt6yuxyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; 
   d="scan'208";a="464830187"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005.fm.intel.com with ESMTP; 15 May 2020 12:24:17 -0700
Subject: [PATCH] dmaengine: idxd: cleanup workqueue config after disabling
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, yixin.zhang@intel.com
Date:   Fri, 15 May 2020 12:24:17 -0700
Message-ID: <158957065768.11894.4009779253452766084.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

After disabling a device, we should clean up the internal state for
the wqs and zero out the configuration registers. Without doing so can cause
issues when the user reprogram the wqs.

Reported-by: Yixin Zhang <yixin.zhang@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Yixin Zhang <yixin.zhang@intel.com>
---
 drivers/dma/idxd/device.c |   24 ++++++++++++++++++++++++
 drivers/dma/idxd/idxd.h   |    1 +
 drivers/dma/idxd/sysfs.c  |    5 +++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 4669986fe018..104bb5b1bad2 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -325,6 +325,30 @@ void idxd_wq_unmap_portal(struct idxd_wq *wq)
 	devm_iounmap(dev, wq->dportal);
 }
 
+void idxd_wq_disable_cleanup(struct idxd_wq *wq)
+{
+	struct idxd_device *idxd = wq->idxd;
+	struct device *dev = &idxd->pdev->dev;
+	int i, wq_offset;
+
+	memset(&wq->wqcfg, 0, sizeof(wq->wqcfg));
+	wq->type = IDXD_WQT_NONE;
+	wq->size = 0;
+	wq->group = NULL;
+	wq->threshold = 0;
+	wq->priority = 0;
+	clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
+	memset(wq->name, 0, WQ_NAME_SIZE);
+
+	for (i = 0; i < 8; i++) {
+		wq_offset = idxd->wqcfg_offset + wq->id * 32 + i * sizeof(u32);
+		iowrite32(0, idxd->reg_base + wq_offset);
+		dev_dbg(dev, "WQ[%d][%d][%#x]: %#x\n",
+			wq->id, i, wq_offset,
+			ioread32(idxd->reg_base + wq_offset));
+	}
+}
+
 /* Device control bits */
 static inline bool idxd_is_enabled(struct idxd_device *idxd)
 {
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 9a69738e355d..3dfac462a0df 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -292,6 +292,7 @@ int idxd_wq_disable(struct idxd_wq *wq, unsigned long *irq_flags);
 void idxd_wq_drain(struct idxd_wq *wq, unsigned long *irq_flags);
 int idxd_wq_map_portal(struct idxd_wq *wq);
 void idxd_wq_unmap_portal(struct idxd_wq *wq);
+void idxd_wq_disable_cleanup(struct idxd_wq *wq);
 
 /* submission */
 int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 709a576a25e6..df585b0829db 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -317,6 +317,11 @@ static int idxd_config_bus_remove(struct device *dev)
 		idxd_unregister_dma_device(idxd);
 		spin_lock_irqsave(&idxd->dev_lock, flags);
 		rc = idxd_device_disable(idxd, &flags);
+		for (i = 0; i < idxd->max_wqs; i++) {
+			struct idxd_wq *wq = &idxd->wqs[i];
+
+			idxd_wq_disable_cleanup(wq);
+		}
 		spin_unlock_irqrestore(&idxd->dev_lock, flags);
 		module_put(THIS_MODULE);
 		if (rc < 0)

