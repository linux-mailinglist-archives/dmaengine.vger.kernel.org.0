Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB1738D152
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 00:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhEUWXK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 18:23:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:31707 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhEUWXJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 May 2021 18:23:09 -0400
IronPort-SDR: qPZiyMsWJRGw13XYqRPFAb6pWV6coWinfCx3RCB5PGNBBG/Ao/oLStcGW2yKyAR5ZBJvEpghbM
 Ph0PEaApR1Pw==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="201637906"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="201637906"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:21:46 -0700
IronPort-SDR: im/jibbqaSK1kDhPtNVVmksD50mrD17hQJqalliCYfirq3dy3sCk87D1My6/bMcuOsF6eU1fkc
 V/1ugcVL/6hQ==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="631963967"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:21:45 -0700
Subject: [PATCH 04/18] dmaengine: idxd: remove IDXD_DEV_CONF_READY
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        jgg@nvidia.com, ramesh.thomas@intel.com
Date:   Fri, 21 May 2021 15:21:45 -0700
Message-ID: <162163570529.260470.14858674473226719791.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
References: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The IDXD_DEV_CONF_READY state flag is no longer needed. The current
implementation uses this flag to stop the device from doing
configuration until the pci driver probe has completed. With the
driver architecture going towards multiple sub-driver attached to
the dsa_bus, this is no longer feasible. The sub-drivers will be
allowed to probe and return with failure when they are not ready
to complete the probe rather than using a state flag to gate the
probing.

There is no expectation that the devices auto-attach to a driver.
Userspace configuration is expected to setup the device before
enabling.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    4 ++--
 drivers/dma/idxd/idxd.h   |    1 -
 drivers/dma/idxd/init.c   |    2 --
 drivers/dma/idxd/sysfs.c  |   14 --------------
 4 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 420b93fe5feb..af7a526217d0 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -586,7 +586,7 @@ int idxd_device_disable(struct idxd_device *idxd)
 
 	spin_lock_irqsave(&idxd->dev_lock, flags);
 	idxd_device_wqs_clear_state(idxd);
-	idxd->state = IDXD_DEV_CONF_READY;
+	idxd->state = IDXD_DEV_DISABLED;
 	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 	return 0;
 }
@@ -598,7 +598,7 @@ void idxd_device_reset(struct idxd_device *idxd)
 	idxd_cmd_exec(idxd, IDXD_CMD_RESET_DEVICE, 0, NULL);
 	spin_lock_irqsave(&idxd->dev_lock, flags);
 	idxd_device_wqs_clear_state(idxd);
-	idxd->state = IDXD_DEV_CONF_READY;
+	idxd->state = IDXD_DEV_DISABLED;
 	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 }
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 86b31ff108b2..7ca379acca31 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -211,7 +211,6 @@ struct idxd_hw {
 enum idxd_device_state {
 	IDXD_DEV_HALTED = -1,
 	IDXD_DEV_DISABLED = 0,
-	IDXD_DEV_CONF_READY,
 	IDXD_DEV_ENABLED,
 };
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index ae2ada6cb8dc..89247ae8639a 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -633,8 +633,6 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err;
 	}
 
-	idxd->state = IDXD_DEV_CONF_READY;
-
 	dev_info(&pdev->dev, "Intel(R) Accelerator Device (v%x)\n",
 		 idxd->hw.version);
 
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 7b6d906ffb4d..069f70d5c81a 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -22,17 +22,9 @@ static int idxd_config_bus_match(struct device *dev,
 	int matched = 0;
 
 	if (is_idxd_dev(dev)) {
-		struct idxd_device *idxd = confdev_to_idxd(dev);
-
-		if (idxd->state != IDXD_DEV_CONF_READY)
-			return 0;
 		matched = 1;
 	} else if (is_idxd_wq_dev(dev)) {
 		struct idxd_wq *wq = confdev_to_wq(dev);
-		struct idxd_device *idxd = wq->idxd;
-
-		if (idxd->state < IDXD_DEV_CONF_READY)
-			return 0;
 
 		if (wq->state != IDXD_WQ_DISABLED) {
 			dev_dbg(dev, "%s not disabled\n", dev_name(dev));
@@ -179,11 +171,6 @@ static int idxd_config_bus_probe(struct device *dev)
 	if (is_idxd_dev(dev)) {
 		struct idxd_device *idxd = confdev_to_idxd(dev);
 
-		if (idxd->state != IDXD_DEV_CONF_READY) {
-			dev_warn(dev, "Device not ready for config\n");
-			return -EBUSY;
-		}
-
 		if (!try_module_get(THIS_MODULE))
 			return -ENXIO;
 
@@ -1423,7 +1410,6 @@ static ssize_t state_show(struct device *dev,
 
 	switch (idxd->state) {
 	case IDXD_DEV_DISABLED:
-	case IDXD_DEV_CONF_READY:
 		return sysfs_emit(buf, "disabled\n");
 	case IDXD_DEV_ENABLED:
 		return sysfs_emit(buf, "enabled\n");


