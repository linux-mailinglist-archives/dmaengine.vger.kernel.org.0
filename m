Return-Path: <dmaengine+bounces-3774-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFCE9D6654
	for <lists+dmaengine@lfdr.de>; Sat, 23 Nov 2024 00:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E579160E73
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2024 23:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E8D1C9B97;
	Fri, 22 Nov 2024 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Byk1mCFi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7E415E5CA;
	Fri, 22 Nov 2024 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732318237; cv=none; b=rNQa0b5Wcp2qVJvCGNVv8aUmkFzH7pcVsGyyZwYkNduyf3ndSMPeZCXAalHPPaBaWr2ND1r6DAEUmLR0WfUGX8IZEWs8yaJ/YpLqiTtpPxYz0SmkXO3tSRjGYUVIuUW/SSjaX2bz4WtKbqf6S033UQ8tSXCqt67/Eq7HraSTJo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732318237; c=relaxed/simple;
	bh=T3IQWECVwZlsM5ccaOAt9n04a8H44ydKWkEdbwlB5Fk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/ULiK+BMVE7aJJvrNDRuMRKbKNYHQiEFLvALFJUJpq4NO0pkrKo9kVugi+SRD0K14ELCGXA6rFYhqmRabnD0qNhiczk6QScQ6p3XigT03M8Ej7cKW2zP0RJUfN6pTvUlS1PXaoH7OA7xCAIKA2aeXRrZlJE7C/5pqrNQlSe+eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Byk1mCFi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732318235; x=1763854235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T3IQWECVwZlsM5ccaOAt9n04a8H44ydKWkEdbwlB5Fk=;
  b=Byk1mCFiQbcpqKN0Q2s/3zo2mqVDYAWJlr2LXbBlybUMjgRpG3tZo4y1
   UrwyG8dgACWFvK1WPsXbCfDvDH3XAmV4b+U8YIOhl6AhoGkIcj+r6Qnw5
   Y4fWCt8T3WGPP0AhDb3OAUwUTleCRJy/EbdZuqMkGOVafU4QLgWANSGd3
   MjpgpiBwkXGQGVH1lPsn34e/rKXWtMa4IGxLxZRqd5CQvkr3LZuVLgk/M
   Tnoe8v+YpyAuJcETO7X/XE4w4RW5TEf4f9yrkjKys9vhOWvrY+TuwEqpA
   dA3tA80IgQwWdU0IV9UAI9fc7SGsj0g0AFxbBn3crGVfw4iBtdd4ShEoH
   g==;
X-CSE-ConnectionGUID: 4mHSTVZ3QGmkYLgOcw4F2w==
X-CSE-MsgGUID: X9oqtK6vSouVlUsl+I6YNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43134419"
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="43134419"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:30:34 -0800
X-CSE-ConnectionGUID: yxtsQ0lkQ62xSIQ6EaVHhw==
X-CSE-MsgGUID: yQd1xIDFSfqogn6vmxTHLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="95127791"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmviesa005.fm.intel.com with ESMTP; 22 Nov 2024 15:30:34 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 1/5] dmaengine: idxd: Add idxd_pci_probe_alloc() helper
Date: Fri, 22 Nov 2024 15:30:24 -0800
Message-Id: <20241122233028.2762809-2-fenghua.yu@intel.com>
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
index d84e21daa991..1f93dd6db28f 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -742,6 +742,8 @@ void idxd_unmask_error_interrupts(struct idxd_device *idxd);
 
 /* device control */
 int idxd_device_drv_probe(struct idxd_dev *idxd_dev);
+int idxd_pci_probe_alloc(struct idxd_device *idxd, struct pci_dev *pdev,
+			 const struct pci_device_id *id);
 void idxd_device_drv_remove(struct idxd_dev *idxd_dev);
 int idxd_drv_enable_wq(struct idxd_wq *wq);
 void idxd_drv_disable_wq(struct idxd_wq *wq);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 234c1c658ec7..6679105336ca 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -723,67 +723,84 @@ static void idxd_cleanup(struct idxd_device *idxd)
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
 
@@ -798,6 +815,11 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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


