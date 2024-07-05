Return-Path: <dmaengine+bounces-2642-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E0C928D65
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 20:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97BA01C219BA
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 18:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5206B16EBEF;
	Fri,  5 Jul 2024 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDkxbgln"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA7C16D9CF;
	Fri,  5 Jul 2024 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720203326; cv=none; b=EOe0J8l8gKQNoJuJM8uqIMXy0mJO7VpNJMm7y0MnwCaBAjjFa8vNPXB3CtpvcIGMor4b1mhVNu35D2lnFfb7ob/PVxfasUp41W3syCxw/Ib67VM9u8mWPjOa7peQnqPu+HhDQiRJqlONiwdJosZGjYE+xWtHcb501ydi2aOs/+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720203326; c=relaxed/simple;
	bh=dq/tINiRky6n3K6tZb7sRH+6JZSWm6yHcqMs5idQIJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HDWh8kFC0JdDiPu3C1FEq3YNntn4ZUTgQ+60k7eSz/YEPr+ST8jjfvd9qTC4DQ2oMcjIxdNuaADZ/0VDGaAaiDR68k/zfW6e9iXOLRj5ttfMUwUvxThYi1oa3PlxiXLaHaHghP4pcOhyDGxinVJFiNSx5fi0oi/Szc7mbtle7oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDkxbgln; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720203324; x=1751739324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dq/tINiRky6n3K6tZb7sRH+6JZSWm6yHcqMs5idQIJE=;
  b=MDkxbglnXcsnKj62QjpaNFMQKpyxTdrKNDZRqPUlpilsmqnrxSkKaWaG
   7ZVtIKzL1X850Io+W7ZhXjiDJeY5p7cDBkRiZWRXvu37ekP+ZlgOA0HGN
   O/2HL045IcbjQKxH1EMMJO15VSi5ttxuSH927FrSos6m5BWuoChA+q8Gy
   0PPRAfcLyXA03S1e7XkCEUw2OqG2Pz5N8XqsQcPY+GT3U+EwI+86k2gHm
   eXAD57rX/x452fRXQDkInXfmNgCpHlLNLTWGVY32vdIJhSKuN+XeohB3L
   VZdTyVP64fFtzsxsBl0v430hJaefZ7XmQ8uuf8z82KO5s74GMEiurH9d6
   Q==;
X-CSE-ConnectionGUID: vaS2101ZS3qCHEBwf9MyjA==
X-CSE-MsgGUID: vZm4Sb8oRaCUZ5GKAggRug==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="12410725"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="12410725"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 11:15:20 -0700
X-CSE-ConnectionGUID: 7cYuRPINRMyv0EsbC0ocDw==
X-CSE-MsgGUID: fCO0pt6URF+EG7a2vgCJHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="47672707"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa008.jf.intel.com with ESMTP; 05 Jul 2024 11:15:20 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 5/5] dmaengine: idxd: Enable Function Level Reset (FLR) for halt
Date: Fri,  5 Jul 2024 11:15:18 -0700
Message-Id: <20240705181519.4067507-6-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240705181519.4067507-1-fenghua.yu@intel.com>
References: <20240705181519.4067507-1-fenghua.yu@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When DSA/IAA device hits a fatal error, the device enters a halt state.
The driver can reset the device depending on Reset Type required by
hardware to recover the device.

Supported Reset Types are:
0: Reset Device command
1: Function Level Reset (FLR)
2: Warm reset
3: Cold reset

Currently, the driver only supports Reset Type 0.

This patch adds support for FLR recovery Type 1. Before issuing a PCIe
FLR command, IDXD device and WQ states are saved. After the FLR command
execution, the device is recovered to its previous states, allowing
the user can continue using the device.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/init.c | 123 ++++++++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/irq.c  |  28 ++++++++-
 2 files changed, 148 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index bb03d8cc5d32..87f2c6a878c6 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -973,6 +973,118 @@ static void idxd_device_config_restore(struct idxd_device *idxd,
 	kfree(idxd_saved->saved_wqs);
 }
 
+static void idxd_reset_prepare(struct pci_dev *pdev)
+{
+	struct idxd_device *idxd = pci_get_drvdata(pdev);
+	struct device *dev = &idxd->pdev->dev;
+	const char *idxd_name;
+	int rc;
+
+	dev = &idxd->pdev->dev;
+	idxd_name = dev_name(idxd_confdev(idxd));
+
+	struct idxd_saved_states *idxd_saved __free(kfree) =
+			kzalloc_node(sizeof(*idxd_saved), GFP_KERNEL,
+				     dev_to_node(&pdev->dev));
+	if (!idxd_saved) {
+		dev_err(dev, "HALT: no memory\n");
+
+		return;
+	}
+
+	/* Save IDXD configurations. */
+	rc = idxd_device_config_save(idxd, idxd_saved);
+	if (rc < 0) {
+		dev_err(dev, "HALT: cannot save %s configs\n", idxd_name);
+
+		return;
+	}
+
+	idxd->idxd_saved = no_free_ptr(idxd_saved);
+
+	/* Save PCI device state. */
+	pci_save_state(idxd->pdev);
+}
+
+static void idxd_reset_done(struct pci_dev *pdev)
+{
+	struct idxd_device *idxd = pci_get_drvdata(pdev);
+	const char *idxd_name;
+	struct device *dev;
+	int rc, i;
+
+	if (!idxd->idxd_saved)
+		return;
+
+	dev = &idxd->pdev->dev;
+	idxd_name = dev_name(idxd_confdev(idxd));
+
+	/* Restore PCI device state. */
+	pci_restore_state(idxd->pdev);
+
+	/* Unbind idxd device from driver. */
+	idxd_unbind(&idxd_drv.drv, idxd_name);
+
+	/*
+	 * Probe PCI device without allocating or changing
+	 * idxd software data which keeps the same as before FLR.
+	 */
+	idxd_pci_probe_alloc(idxd, NULL, NULL);
+
+	/* Restore IDXD configurations. */
+	idxd_device_config_restore(idxd, idxd->idxd_saved);
+
+	/* Re-configure IDXD device if allowed. */
+	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
+		rc = idxd_device_config(idxd);
+		if (rc < 0) {
+			dev_err(dev, "HALT: %s config fails\n", idxd_name);
+			goto out;
+		}
+	}
+
+	/* Bind IDXD device to driver. */
+	rc = idxd_bind(&idxd_drv.drv, idxd_name);
+	if (rc < 0) {
+		dev_err(dev, "HALT: binding %s to driver fails\n", idxd_name);
+		goto out;
+	}
+
+	/* Bind enabled wq in the IDXD device to driver. */
+	for (i = 0; i < idxd->max_wqs; i++) {
+		if (test_bit(i, idxd->wq_enable_map)) {
+			struct idxd_wq *wq = idxd->wqs[i];
+			char wq_name[32];
+
+			wq->state = IDXD_WQ_DISABLED;
+			sprintf(wq_name, "wq%d.%d", idxd->id, wq->id);
+			/*
+			 * Bind to user driver depending on wq type.
+			 *
+			 * Currently only support user type WQ. Will support
+			 * kernel type WQ in the future.
+			 */
+			if (wq->type == IDXD_WQT_USER)
+				rc = idxd_bind(&idxd_user_drv.drv, wq_name);
+			else
+				rc = -EINVAL;
+			if (rc < 0) {
+				clear_bit(i, idxd->wq_enable_map);
+				dev_err(dev,
+					"HALT: unable to re-enable wq %s\n",
+					dev_name(wq_confdev(wq)));
+			}
+		}
+	}
+out:
+	kfree(idxd->idxd_saved);
+}
+
+static const struct pci_error_handlers idxd_error_handler = {
+	.reset_prepare	= idxd_reset_prepare,
+	.reset_done	= idxd_reset_done,
+};
+
 /*
  * Probe idxd PCI device.
  * If idxd is not given, need to allocate idxd and set up its data.
@@ -1046,6 +1158,16 @@ int idxd_pci_probe_alloc(struct idxd_device *idxd, struct pci_dev *pdev,
 			dev_warn(dev, "IDXD debugfs failed to setup\n");
 	}
 
+	if (!alloc_idxd) {
+		/* Release interrupts in the IDXD device. */
+		idxd_cleanup_interrupts(idxd);
+
+		/* Re-enable interrupts in the IDXD device. */
+		rc = idxd_setup_interrupts(idxd);
+		if (rc)
+			dev_warn(dev, "IDXD interrupts failed to setup\n");
+	}
+
 	dev_info(&pdev->dev, "Intel(R) Accelerator Device (v%x)\n",
 		 idxd->hw.version);
 
@@ -1136,6 +1258,7 @@ static struct pci_driver idxd_pci_driver = {
 	.probe		= idxd_pci_probe,
 	.remove		= idxd_remove,
 	.shutdown	= idxd_shutdown,
+	.err_handler	= &idxd_error_handler,
 };
 
 static int __init idxd_init_module(void)
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index a46e58b756a5..1107db3ce0a3 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -383,6 +383,20 @@ static void process_evl_entries(struct idxd_device *idxd)
 	mutex_unlock(&evl->lock);
 }
 
+static void idxd_device_flr(struct work_struct *work)
+{
+	struct idxd_device *idxd = container_of(work, struct idxd_device, work);
+	int rc;
+
+	/*
+	 * IDXD device requires a Function Level Reset (FLR).
+	 * pci_reset_function() will reset the device with FLR.
+	 */
+	rc = pci_reset_function(idxd->pdev);
+	if (rc)
+		dev_err(&idxd->pdev->dev, "FLR failed\n");
+}
+
 static irqreturn_t idxd_halt(struct idxd_device *idxd)
 {
 	union gensts_reg gensts;
@@ -398,15 +412,23 @@ static irqreturn_t idxd_halt(struct idxd_device *idxd)
 			 */
 			INIT_WORK(&idxd->work, idxd_device_reinit);
 			queue_work(idxd->wq, &idxd->work);
+		} else if (gensts.reset_type == IDXD_DEVICE_RESET_FLR) {
+			idxd->state = IDXD_DEV_HALTED;
+			idxd_mask_error_interrupts(idxd);
+			dev_dbg(&idxd->pdev->dev,
+				"idxd halted, doing FLR. After FLR, configs are restored\n");
+			INIT_WORK(&idxd->work, idxd_device_flr);
+			queue_work(idxd->wq, &idxd->work);
+
 		} else {
 			idxd->state = IDXD_DEV_HALTED;
 			idxd_wqs_quiesce(idxd);
 			idxd_wqs_unmap_portal(idxd);
 			idxd_device_clear_state(idxd);
 			dev_err(&idxd->pdev->dev,
-				"idxd halted, need %s.\n",
-				gensts.reset_type == IDXD_DEVICE_RESET_FLR ?
-				"FLR" : "system reset");
+				"idxd halted, need system reset");
+
+			return -ENXIO;
 		}
 	}
 
-- 
2.37.1


