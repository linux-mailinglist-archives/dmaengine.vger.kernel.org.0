Return-Path: <dmaengine+bounces-2638-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AF0928D5F
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 20:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583E41C21716
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 18:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F199114BF98;
	Fri,  5 Jul 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/SuDYcs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F532C85;
	Fri,  5 Jul 2024 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720203323; cv=none; b=mGS8eBfI62VD5XD5XtDdrxJyz4aBRvBp9VFgQj0IISy/2GZoH/TvbZOaMXGJ0/R9PyMylClri+0X07bqh7se/57pS0XE/Nm3BXVCPqMU3OJ5muIIRG5XCE+uJW0GoqaBGsRSxLG7a7rLAiaWm7NcBNzZ4lgeELD6rN2FMwL1KxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720203323; c=relaxed/simple;
	bh=eAqcbvZBW12oKX8Ej57NmOzehI48/9qfpOiRlYOqkyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LMU5YtdEA/6n2Kd8zW8XB/d3R3H4Y9egn3hEiKMcb60p5yXi+J5n+s4puuy14dAmwRUSeawViD1KYcIfvas1/KwtfYSldAgHjlPReEhYlQXHFwcPXw2aIE6+M9w0foWCjMaRsaMiAYB21M0YFJB76M6FND3vqI6wesn9dtx6XDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/SuDYcs; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720203322; x=1751739322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eAqcbvZBW12oKX8Ej57NmOzehI48/9qfpOiRlYOqkyo=;
  b=j/SuDYcsO2q85htFsCEyuppRXSTqZxd/RKHeXQ8sr30q4qnluza4ZjXb
   Dt4A8wX+ze/KtQkMXF3lgOVu4VKRHRqjfxUUudbRNhV/nMWBieAYjV9jt
   rE1Gh8ciDIh1yy6UlgskYj/V5IopS6EWj3jlIIMddo3JzFgNQHqiwijPx
   KfdZJDyPDd2QbdajIdO1FUEQbFUludZJBRtNTt5ygnzfyCioT8S5AxBr8
   4yjG26pRumbA4py3sNYxLZ/soBI4Rw2pkz9mybuQq4n8/ZkqKezK2WQTn
   qz6JiV5W1xHxI+WeBhLdCpiT3P0se7xny9qZ8dlQ9qEgksut9drIM7rSJ
   Q==;
X-CSE-ConnectionGUID: NHK4YA7GQtu8esjwe5nrqA==
X-CSE-MsgGUID: YAi93fDvTtuHqmzleFLPHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="12410718"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="12410718"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 11:15:19 -0700
X-CSE-ConnectionGUID: 1oUP/byjTs+eIA28nhFi1w==
X-CSE-MsgGUID: IUYhmJCRS/Wal4Btkfhi1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="47672694"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa008.jf.intel.com with ESMTP; 05 Jul 2024 11:15:19 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 1/5] dmaengine: idxd: Add idxd_pci_probe_alloc() helper
Date: Fri,  5 Jul 2024 11:15:14 -0700
Message-Id: <20240705181519.4067507-2-fenghua.yu@intel.com>
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

Add the idxd_pci_probe_alloc() helper to probe IDXD PCI device with or
without allocating and setting idxd software values.

The idxd_pci_probe() function is refactored to call this helper and
always probe the IDXD device with allocating and setting the software
values.

This helper will be called later in the Function Level Reset (FLR)
process without modifying the idxd software data.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/idxd.h |   2 +
 drivers/dma/idxd/init.c | 102 ++++++++++++++++++++++++----------------
 2 files changed, 64 insertions(+), 40 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 868b724a3b75..03f099518ec1 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -745,6 +745,8 @@ void idxd_unmask_error_interrupts(struct idxd_device *idxd);
 
 /* device control */
 int idxd_device_drv_probe(struct idxd_dev *idxd_dev);
+int idxd_pci_probe_alloc(struct idxd_device *idxd, struct pci_dev *pdev,
+			 const struct pci_device_id *id);
 void idxd_device_drv_remove(struct idxd_dev *idxd_dev);
 int idxd_drv_enable_wq(struct idxd_wq *wq);
 void idxd_drv_disable_wq(struct idxd_wq *wq);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index a7295943fa22..068103b40223 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -716,67 +716,84 @@ static void idxd_cleanup(struct idxd_device *idxd)
 		idxd_disable_sva(idxd->pdev);
 }
 
-static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+/*
+ * Probe idxd PCI device.
+ * If idxd is not given, need to allocate idxd and set up its data.
+ *
+ * If idxd is given, idxd was allocated and setup already. Just need to
+ * configure device without re-allocating and re-configuring idxd data.
+ * This is useful for recovering from FLR.
+ */
+int idxd_pci_probe_alloc(struct idxd_device *idxd, struct pci_dev *pdev,
+			 const struct pci_device_id *id)
 {
-	struct device *dev = &pdev->dev;
-	struct idxd_device *idxd;
-	struct idxd_driver_data *data = (struct idxd_driver_data *)id->driver_data;
+	bool alloc_idxd = idxd ? false : true;
+	struct idxd_driver_data *data;
+	struct device *dev;
 	int rc;
 
+	pdev = idxd ? idxd->pdev : pdev;
+	dev = &pdev->dev;
+	data = id ? (struct idxd_driver_data *)id->driver_data : NULL;
 	rc = pci_enable_device(pdev);
 	if (rc)
 		return rc;
 
-	dev_dbg(dev, "Alloc IDXD context\n");
-	idxd = idxd_alloc(pdev, data);
-	if (!idxd) {
-		rc = -ENOMEM;
-		goto err_idxd_alloc;
-	}
+	if (alloc_idxd) {
+		dev_dbg(dev, "Alloc IDXD context\n");
+		idxd = idxd_alloc(pdev, data);
+		if (!idxd) {
+			rc = -ENOMEM;
+			goto err_idxd_alloc;
+		}
 
-	dev_dbg(dev, "Mapping BARs\n");
-	idxd->reg_base = pci_iomap(pdev, IDXD_MMIO_BAR, 0);
-	if (!idxd->reg_base) {
-		rc = -ENOMEM;
-		goto err_iomap;
-	}
+		dev_dbg(dev, "Mapping BARs\n");
+		idxd->reg_base = pci_iomap(pdev, IDXD_MMIO_BAR, 0);
+		if (!idxd->reg_base) {
+			rc = -ENOMEM;
+			goto err_iomap;
+		}
 
-	dev_dbg(dev, "Set DMA masks\n");
-	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (rc)
-		goto err;
+		dev_dbg(dev, "Set DMA masks\n");
+		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+		if (rc)
+			goto err;
+	}
 
 	dev_dbg(dev, "Set PCI master\n");
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, idxd);
 
-	idxd->hw.version = ioread32(idxd->reg_base + IDXD_VER_OFFSET);
-	rc = idxd_probe(idxd);
-	if (rc) {
-		dev_err(dev, "Intel(R) IDXD DMA Engine init failed\n");
-		goto err;
-	}
+	if (alloc_idxd) {
+		idxd->hw.version = ioread32(idxd->reg_base + IDXD_VER_OFFSET);
+		rc = idxd_probe(idxd);
+		if (rc) {
+			dev_err(dev, "Intel(R) IDXD DMA Engine init failed\n");
+			goto err;
+		}
 
-	if (data->load_device_defaults) {
-		rc = data->load_device_defaults(idxd);
-		if (rc)
-			dev_warn(dev, "IDXD loading device defaults failed\n");
-	}
+		if (data->load_device_defaults) {
+			rc = data->load_device_defaults(idxd);
+			if (rc)
+				dev_warn(dev, "IDXD loading device defaults failed\n");
+		}
 
-	rc = idxd_register_devices(idxd);
-	if (rc) {
-		dev_err(dev, "IDXD sysfs setup failed\n");
-		goto err_dev_register;
-	}
+		rc = idxd_register_devices(idxd);
+		if (rc) {
+			dev_err(dev, "IDXD sysfs setup failed\n");
+			goto err_dev_register;
+		}
 
-	rc = idxd_device_init_debugfs(idxd);
-	if (rc)
-		dev_warn(dev, "IDXD debugfs failed to setup\n");
+		rc = idxd_device_init_debugfs(idxd);
+		if (rc)
+			dev_warn(dev, "IDXD debugfs failed to setup\n");
+	}
 
 	dev_info(&pdev->dev, "Intel(R) Accelerator Device (v%x)\n",
 		 idxd->hw.version);
 
-	idxd->user_submission_safe = data->user_submission_safe;
+	if (data)
+		idxd->user_submission_safe = data->user_submission_safe;
 
 	return 0;
 
@@ -791,6 +808,11 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return rc;
 }
 
+static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	return idxd_pci_probe_alloc(NULL, pdev, id);
+}
+
 void idxd_wqs_quiesce(struct idxd_device *idxd)
 {
 	struct idxd_wq *wq;
-- 
2.37.1


