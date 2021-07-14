Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962563C946F
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 01:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbhGNXYR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 19:24:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:11148 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhGNXYR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 19:24:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="197628190"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="197628190"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 16:21:25 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="651360603"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 16:21:24 -0700
Subject: [PATCH v2 11/18] dmaengine: idxd: idxd: move remove() bits for idxd
 'struct device' to device.c
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 14 Jul 2021 16:21:24 -0700
Message-ID: <162630488467.631529.4445840639623548181.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162630468448.631529.1963704964865951650.stgit@djiang5-desk3.ch.intel.com>
References: <162630468448.631529.1963704964865951650.stgit@djiang5-desk3.ch.intel.com>
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
 drivers/dma/idxd/device.c |   22 ++++++++++++++++++++++
 drivers/dma/idxd/idxd.h   |    1 +
 drivers/dma/idxd/sysfs.c  |   20 +-------------------
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index b9aa209efee4..d5a0b6fff3b9 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1327,3 +1327,25 @@ int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
 
 	return 0;
 }
+
+void idxd_device_drv_remove(struct idxd_dev *idxd_dev)
+{
+	struct device *dev = &idxd_dev->conf_dev;
+	struct idxd_device *idxd = idxd_dev_to_idxd(idxd_dev);
+	int i;
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
+	idxd_device_disable(idxd);
+	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		idxd_device_reset(idxd);
+}
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 435cfb4fca29..33752a74e100 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -491,6 +491,7 @@ void idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id);
 
 /* device control */
 int idxd_device_drv_probe(struct idxd_dev *idxd_dev);
+void idxd_device_drv_remove(struct idxd_dev *idxd_dev);
 int drv_enable_wq(struct idxd_wq *wq);
 void drv_disable_wq(struct idxd_wq *wq);
 int idxd_device_init_reset(struct idxd_device *idxd);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 4822454aea45..233593ff784e 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -66,26 +66,8 @@ static int idxd_dsa_drv_probe(struct idxd_dev *idxd_dev)
 
 static void idxd_dsa_drv_remove(struct idxd_dev *idxd_dev)
 {
-	struct device *dev = &idxd_dev->conf_dev;
-
 	if (is_idxd_dev(idxd_dev)) {
-		struct idxd_device *idxd = idxd_dev_to_idxd(idxd_dev);
-		int i;
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
-		idxd_device_disable(idxd);
-		if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
-			idxd_device_reset(idxd);
+		idxd_device_drv_remove(idxd_dev);
 		return;
 	}
 


