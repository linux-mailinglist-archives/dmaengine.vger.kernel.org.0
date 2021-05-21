Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4812138D15C
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 00:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhEUWXy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 18:23:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:16589 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhEUWXy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 May 2021 18:23:54 -0400
IronPort-SDR: aH1jtOP5SJCci+7twDNR/8f3hbYf1FpSG864s2WAbVXhtVADEu8KmzmpfNAlgA8uz1x7Pdn7SO
 x0FIfw+7Nlzg==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="181194042"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="181194042"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:22:30 -0700
IronPort-SDR: iWWvlJFLTd9kTxiPBh0Zl2pO1h9fK27qTeBuffB2+3PBlg0UJjezM5P6+Cxdh8qZFt1DwBITmx
 CX1E/nsDH/7A==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="474719270"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:22:29 -0700
Subject: [PATCH 11/18] dmaengine: idxd: idxd: move remove() bits for idxd
 'struct device' to device.c
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        jgg@nvidia.com, ramesh.thomas@intel.com
Date:   Fri, 21 May 2021 15:22:29 -0700
Message-ID: <162163574954.260470.7424531536208354286.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
References: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move the code related to a ->remove() function for the idxd
'struct device' to device.c to prep for the idxd device
sub-driver in device.c.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |   35 +++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/idxd.h   |    1 +
 drivers/dma/idxd/sysfs.c  |   32 +-------------------------------
 3 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index e3665bac9980..8fac0a3cdbcc 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1284,3 +1284,38 @@ int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
 
 	return 0;
 }
+
+void idxd_device_drv_remove(struct idxd_dev *idxd_dev)
+{
+	struct device *dev = &idxd_dev->conf_dev;
+	struct idxd_device *idxd = idxd_dev_to_idxd(idxd_dev);
+	int i, rc;
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		struct idxd_wq *wq = idxd->wqs[i];
+		struct device *wq_dev = wq_confdev(wq);
+
+		if (wq->state == IDXD_WQ_DISABLED)
+			continue;
+		dev_warn(dev, "Active wq %d on disable %s.\n", i, dev_name(wq_dev));
+		device_release_driver(wq_dev);
+	}
+
+	idxd_unregister_dma_device(idxd);
+	rc = idxd_device_disable(idxd);
+	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
+		for (i = 0; i < idxd->max_wqs; i++) {
+			struct idxd_wq *wq = idxd->wqs[i];
+			unsigned long flags;
+
+			mutex_lock(&wq->wq_lock);
+			spin_lock_irqsave(&idxd->dev_lock, flags);
+			idxd_wq_disable_cleanup(wq);
+			spin_unlock_irqrestore(&idxd->dev_lock, flags);
+			mutex_unlock(&wq->wq_lock);
+		}
+	}
+
+	if (rc < 0)
+		dev_dbg(dev, "Device disable failed\n");
+}
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index b1ec63ea0a00..cebed0270123 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -493,6 +493,7 @@ void idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id);
 
 /* device control */
 int idxd_device_drv_probe(struct idxd_dev *idxd_dev);
+void idxd_device_drv_remove(struct idxd_dev *idxd_dev);
 int drv_enable_wq(struct idxd_wq *wq);
 void drv_disable_wq(struct idxd_wq *wq);
 int idxd_device_init_reset(struct idxd_device *idxd);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 83f721fb3369..dcc7791a63fa 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -66,38 +66,8 @@ static int idxd_dsa_drv_probe(struct idxd_dev *idxd_dev)
 
 static void idxd_dsa_drv_remove(struct idxd_dev *idxd_dev)
 {
-	struct device *dev = &idxd_dev->conf_dev;
-
 	if (is_idxd_dev(idxd_dev)) {
-		struct idxd_device *idxd = idxd_dev_to_idxd(idxd_dev);
-		int i, rc;
-
-		for (i = 0; i < idxd->max_wqs; i++) {
-			struct idxd_wq *wq = idxd->wqs[i];
-
-			if (wq->state == IDXD_WQ_DISABLED)
-				continue;
-			dev_warn(dev, "Active wq %d on disable %s.\n", i,
-				 dev_name(wq_confdev(wq)));
-			device_release_driver(wq_confdev(wq));
-		}
-
-		idxd_unregister_dma_device(idxd);
-		rc = idxd_device_disable(idxd);
-		if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
-			for (i = 0; i < idxd->max_wqs; i++) {
-				struct idxd_wq *wq = idxd->wqs[i];
-
-				mutex_lock(&wq->wq_lock);
-				idxd_wq_disable_cleanup(wq);
-				mutex_unlock(&wq->wq_lock);
-			}
-		}
-
-		if (rc < 0)
-			dev_warn(dev, "Device disable failed\n");
-		else
-			dev_info(dev, "Device %s disabled\n", dev_name(dev));
+		idxd_device_drv_remove(idxd_dev);
 		return;
 	}
 


