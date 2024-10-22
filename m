Return-Path: <dmaengine+bounces-3407-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEF19AA338
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 15:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25454B20F37
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 13:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFFC8063C;
	Tue, 22 Oct 2024 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUvY4C3w"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5DD1E481;
	Tue, 22 Oct 2024 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604064; cv=none; b=S6FZ9TolkdDF86kznvvwE9MjItWzFQoiYTv+Y/DZ8cDns5m9Xnutiq/Egvq2nV3CuACjzQDJhZMTgQKVxNC9I2UFPJ5WubQEg0kFVkPLBO/s1qrs+T1HcNirfOrdMroKDbto1uCVTz4vg/QN9+ekvU5GgRJZi8xLRk3AZ5YjsKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604064; c=relaxed/simple;
	bh=4HL4b4i9c4agqqV9zL0ufEJ2LcZ3lhHmuW+9U+/XujU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NbvmOZkylvc1pEraeS4p/YkXtdKnK8ern1WtJ1H1ek6XImMSJcJtGa2/1m1MyIGFpTWcNplWlz3Xzi+iR9aHLmr9LpNXtsRgqvDlsrI6730XX4CEvAoKdM6OcfOG1PIJvrwV1cTIcdnJiWkA0AhMlO2+KISRpvfE5UdkQJueSc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUvY4C3w; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729604063; x=1761140063;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4HL4b4i9c4agqqV9zL0ufEJ2LcZ3lhHmuW+9U+/XujU=;
  b=CUvY4C3wL4yqG8nmJNAnosvKxgHesY5g1fyGBPfVGDWTLuzt7jYOM7+J
   BCJ8IoRNDpV+eCbnqM/2eXZRFGm1SvCKy9PtY8LOIckTgvkGO60aUyRgh
   jmq9LueDwkahzmaElBtdL5XZ0+1G10U24ubKoXIouXlSCHpct9c+ziNn8
   AbTGF5lWHIQPGAix1nn480RyCvzhPj2BlY7VZlLPePbd860Kaza9B4k28
   a9L64Y7VAAUcn3KzcwzVB6xJ673cpSmNBFKP4Kopsq19pM489Ax/MWnVZ
   TshoDmhYWT0Tf7cUwVomyDl8LwY0D6Bg1kc3DDPXrZnUBmbN0TLoVqk6i
   Q==;
X-CSE-ConnectionGUID: biBpFvIKR8qdlulZXwt3xA==
X-CSE-MsgGUID: QBpjC+mgSZme5+PTvuSAxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29247373"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29247373"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 06:34:22 -0700
X-CSE-ConnectionGUID: WLNLc5ybStmRh5Y5dRWXDg==
X-CSE-MsgGUID: AOizc1ibRlSZbHX+I52sZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="110697051"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 22 Oct 2024 06:33:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CDB36301; Tue, 22 Oct 2024 16:33:10 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Viresh Kumar <vireshk@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	stable@vger.kernel.org,
	Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v4 1/1] dmaengine: dw: Select only supported masters for ACPI devices
Date: Tue, 22 Oct 2024 16:32:14 +0300
Message-ID: <20241022133307.3224336-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Serge Semin <fancer.lancer@gmail.com>

The recently submitted fix-commit revealed a problem in the iDMA 32-bit
platform code. Even though the controller supported only a single master
the dw_dma_acpi_filter() method hard-coded two master interfaces with IDs
0 and 1. As a result the sanity check implemented in the commit
b336268dde75 ("dmaengine: dw: Add peripheral bus width verification")
got incorrect interface data width and thus prevented the client drivers
from configuring the DMA-channel with the EINVAL error returned. E.g.,
the next error was printed for the PXA2xx SPI controller driver trying
to configure the requested channels:

> [  164.525604] pxa2xx_spi_pci 0000:00:07.1: DMA slave config failed
> [  164.536105] pxa2xx_spi_pci 0000:00:07.1: failed to get DMA TX descriptor
> [  164.543213] spidev spi-SPT0001:00: SPI transfer failed: -16

The problem would have been spotted much earlier if the iDMA 32-bit
controller supported more than one master interfaces. But since it
supports just a single master and the iDMA 32-bit specific code just
ignores the master IDs in the CTLLO preparation method, the issue has
been gone unnoticed so far.

Fix the problem by specifying the default master ID for both memory
and peripheral devices in the driver data. Thus the issue noticed for
the iDMA 32-bit controllers will be eliminated and the ACPI-probed
DW DMA controllers will be configured with the correct master ID by
default.

Cc: stable@vger.kernel.org
Fixes: b336268dde75 ("dmaengine: dw: Add peripheral bus width verification")
Fixes: 199244d69458 ("dmaengine: dw: add support of iDMA 32-bit hardware")
Reported-by: Ferry Toth <fntoth@gmail.com>
Closes: https://lore.kernel.org/dmaengine/ZuXbCKUs1iOqFu51@black.fi.intel.com/
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Closes: https://lore.kernel.org/dmaengine/ZuXgI-VcHpMgbZ91@black.fi.intel.com/
Co-developed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Ferry Toth <fntoth@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: gathered tag (Ferry), left the code as agreed with Serge and Andy
 drivers/dma/dw/acpi.c     | 6 ++++--
 drivers/dma/dw/internal.h | 8 ++++++++
 drivers/dma/dw/pci.c      | 4 ++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw/acpi.c b/drivers/dma/dw/acpi.c
index c510c109d2c3..b6452fffa657 100644
--- a/drivers/dma/dw/acpi.c
+++ b/drivers/dma/dw/acpi.c
@@ -8,13 +8,15 @@
 
 static bool dw_dma_acpi_filter(struct dma_chan *chan, void *param)
 {
+	struct dw_dma *dw = to_dw_dma(chan->device);
+	struct dw_dma_chip_pdata *data = dev_get_drvdata(dw->dma.dev);
 	struct acpi_dma_spec *dma_spec = param;
 	struct dw_dma_slave slave = {
 		.dma_dev = dma_spec->dev,
 		.src_id = dma_spec->slave_id,
 		.dst_id = dma_spec->slave_id,
-		.m_master = 0,
-		.p_master = 1,
+		.m_master = data->m_master,
+		.p_master = data->p_master,
 	};
 
 	return dw_dma_filter(chan, &slave);
diff --git a/drivers/dma/dw/internal.h b/drivers/dma/dw/internal.h
index 563ce73488db..f1bd06a20cd6 100644
--- a/drivers/dma/dw/internal.h
+++ b/drivers/dma/dw/internal.h
@@ -51,11 +51,15 @@ struct dw_dma_chip_pdata {
 	int (*probe)(struct dw_dma_chip *chip);
 	int (*remove)(struct dw_dma_chip *chip);
 	struct dw_dma_chip *chip;
+	u8 m_master;
+	u8 p_master;
 };
 
 static __maybe_unused const struct dw_dma_chip_pdata dw_dma_chip_pdata = {
 	.probe = dw_dma_probe,
 	.remove = dw_dma_remove,
+	.m_master = 0,
+	.p_master = 1,
 };
 
 static const struct dw_dma_platform_data idma32_pdata = {
@@ -72,6 +76,8 @@ static __maybe_unused const struct dw_dma_chip_pdata idma32_chip_pdata = {
 	.pdata = &idma32_pdata,
 	.probe = idma32_dma_probe,
 	.remove = idma32_dma_remove,
+	.m_master = 0,
+	.p_master = 0,
 };
 
 static const struct dw_dma_platform_data xbar_pdata = {
@@ -88,6 +94,8 @@ static __maybe_unused const struct dw_dma_chip_pdata xbar_chip_pdata = {
 	.pdata = &xbar_pdata,
 	.probe = idma32_dma_probe,
 	.remove = idma32_dma_remove,
+	.m_master = 0,
+	.p_master = 0,
 };
 
 #endif /* _DMA_DW_INTERNAL_H */
diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
index ad2d4d012cf7..e8a0eb81726a 100644
--- a/drivers/dma/dw/pci.c
+++ b/drivers/dma/dw/pci.c
@@ -56,10 +56,10 @@ static int dw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *pid)
 	if (ret)
 		return ret;
 
-	dw_dma_acpi_controller_register(chip->dw);
-
 	pci_set_drvdata(pdev, data);
 
+	dw_dma_acpi_controller_register(chip->dw);
+
 	return 0;
 }
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


