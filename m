Return-Path: <dmaengine+bounces-3777-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8789D665C
	for <lists+dmaengine@lfdr.de>; Sat, 23 Nov 2024 00:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6CE2824A1
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2024 23:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EFE1DDA34;
	Fri, 22 Nov 2024 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flxftq3I"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C061D0E27;
	Fri, 22 Nov 2024 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732318240; cv=none; b=oRJWR1/jl4/yRUXNfNKh4rs4wL9XB1tSSgVvbNKBx/eLZJIUmI9RLSNQqCSGhi0mmXquMnlVcmQO0YcglSigbgsEcWzYgGhz4fcjQ2l3EAzJn86VCszA54um6FHcMIsmENiHILaZxzHwiO1xChJ9dvkidJrnOXP5qgeE8xclJJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732318240; c=relaxed/simple;
	bh=QIPNt4smMC5Q/51VS2y1UAhL0N+AzMjaWr8Ko2x7Gos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BfE1cCtbujpa2RpeDkkbtq/sVf5D3YrOIzxZyqRvOPsGDxfsooDmUJkrMq0Jb8I0901C6BQD4u6fHwIoR6JYzt6G3Mv31WqtcZndgYKWjG0SjVIvBnpAEB+KYKgJkYiaCqsjryd/R569h7mELtUZyb51OSGrN+B0xsNzmS0Qm60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=flxftq3I; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732318239; x=1763854239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QIPNt4smMC5Q/51VS2y1UAhL0N+AzMjaWr8Ko2x7Gos=;
  b=flxftq3Iipu0BsYgcuccUnJ2/wki7z1kcQT8goeqmVPYgFufWWhStN7f
   ySbbIIxjw1e6BgUcFy4GVETrwjyt/nQOGpI4+5EnQSpKOOQ738IFhRdFG
   PY+ISeyANw3HkU0QyCnK1lvhnhuhCVEmJ9c4wCMo97XtQeLsvP1kk7adx
   kbE8gjAbMyKVSCAbapEDs89447U/RnF6jiPS+/lieBpOqpght7WvdeYg+
   rlfxIXycAXtwbQswYz5dWxRpKaOJYccg5yKVGHVX7rwh385s34l36z1ug
   WSv9gkc+U4QTC+I72LaoYxmCmioXAzpTF8PWUH5pKXgv2fe0Ad0Wm0iHv
   Q==;
X-CSE-ConnectionGUID: +4QIFx5ySWiCKNpgz1IY0g==
X-CSE-MsgGUID: /f9vyhXhTFipT0MkXsSUBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43134427"
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="43134427"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:30:35 -0800
X-CSE-ConnectionGUID: k47nDH0CQUil5Fn0uWEbKQ==
X-CSE-MsgGUID: XzU7m1BGS6Wxae7cYYloyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="95127804"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmviesa005.fm.intel.com with ESMTP; 22 Nov 2024 15:30:35 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 5/5] dmaengine: idxd: Enable Function Level Reset (FLR) for halt
Date: Fri, 22 Nov 2024 15:30:28 -0800
Message-Id: <20241122233028.2762809-6-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241122233028.2762809-1-fenghua.yu@intel.com>
References: <20241122233028.2762809-1-fenghua.yu@intel.com>
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
index da5b76a1e208..ea44974e927c 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -981,6 +981,118 @@ static void idxd_device_config_restore(struct idxd_device *idxd,
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
@@ -1054,6 +1166,16 @@ int idxd_pci_probe_alloc(struct idxd_device *idxd, struct pci_dev *pdev,
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
 
@@ -1144,6 +1266,7 @@ static struct pci_driver idxd_pci_driver = {
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


