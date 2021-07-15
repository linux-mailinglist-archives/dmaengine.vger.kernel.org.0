Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D07E3CA624
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 20:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbhGOSqW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Jul 2021 14:46:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:48212 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237940AbhGOSqU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Jul 2021 14:46:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="296251159"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="296251159"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:43:26 -0700
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="495601471"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:43:26 -0700
Subject: [PATCH v3 04/18] dmaengine: idxd: remove IDXD_DEV_CONF_READY
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Thu, 15 Jul 2021 11:43:26 -0700
Message-ID: <162637460633.744545.8902095097471365420.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
References: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
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
index c8cf1de72176..4a2af9799239 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -576,7 +576,7 @@ int idxd_device_disable(struct idxd_device *idxd)
 
 	spin_lock_irqsave(&idxd->dev_lock, flags);
 	idxd_device_clear_state(idxd);
-	idxd->state = IDXD_DEV_CONF_READY;
+	idxd->state = IDXD_DEV_DISABLED;
 	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 	return 0;
 }
@@ -588,7 +588,7 @@ void idxd_device_reset(struct idxd_device *idxd)
 	idxd_cmd_exec(idxd, IDXD_CMD_RESET_DEVICE, 0, NULL);
 	spin_lock_irqsave(&idxd->dev_lock, flags);
 	idxd_device_clear_state(idxd);
-	idxd->state = IDXD_DEV_CONF_READY;
+	idxd->state = IDXD_DEV_DISABLED;
 	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 }
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 8e62b647898f..0f0a938854a9 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -210,7 +210,6 @@ struct idxd_hw {
 enum idxd_device_state {
 	IDXD_DEV_HALTED = -1,
 	IDXD_DEV_DISABLED = 0,
-	IDXD_DEV_CONF_READY,
 	IDXD_DEV_ENABLED,
 };
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index b4e105917b93..9d62ba7f3bf7 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -682,8 +682,6 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_dev_register;
 	}
 
-	idxd->state = IDXD_DEV_CONF_READY;
-
 	dev_info(&pdev->dev, "Intel(R) Accelerator Device (v%x)\n",
 		 idxd->hw.version);
 
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index be1ee748d754..56f13a71c1cb 100644
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
 
@@ -1430,7 +1417,6 @@ static ssize_t state_show(struct device *dev,
 
 	switch (idxd->state) {
 	case IDXD_DEV_DISABLED:
-	case IDXD_DEV_CONF_READY:
 		return sysfs_emit(buf, "disabled\n");
 	case IDXD_DEV_ENABLED:
 		return sysfs_emit(buf, "enabled\n");


