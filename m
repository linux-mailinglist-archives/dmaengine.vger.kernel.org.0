Return-Path: <dmaengine+bounces-3684-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D79229BB041
	for <lists+dmaengine@lfdr.de>; Mon,  4 Nov 2024 10:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C8ACB21353
	for <lists+dmaengine@lfdr.de>; Mon,  4 Nov 2024 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2F51AF0A0;
	Mon,  4 Nov 2024 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDRihWz7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAA21ABEDC;
	Mon,  4 Nov 2024 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713909; cv=none; b=lf0vQ5LC+yB7ysZrBHab52ZAwpmQ6N/XwpHlJmgc1DG6nYNK9Fh18S3+dfTU2hk9vkkW6x2RGvZ1x0iNXL3J/s88vVJo8Aba+yUd3y0zA7ToGk19OnSkEPgH1gMLGyhoBI6xXCzO0TeN7KBNTUENVABhbNbfuW+TiEkborafcd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713909; c=relaxed/simple;
	bh=ahGyIshc8FNCbmySdQOO1svr5ucdSpcHZk1Nk2dWoqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KqS4+uBdl1CdBLTT/uOH5zGPRMCuq9FhjhYJB8E0Fqlpo81zx/nHlQmL92y36pMkjOOp/fEsAfCMIQe/2GOT1oxU/mdlpe8oyniM6zxhdtd6He7rJzStc0+rcvVgceVapiKL8ik08Oi8KGpCH4FzQUToHpfHafsVAvWJozzN5bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDRihWz7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730713907; x=1762249907;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ahGyIshc8FNCbmySdQOO1svr5ucdSpcHZk1Nk2dWoqg=;
  b=PDRihWz7jxWuOOezJ6i686YfbkeGM+0945QYW9aSVnYvx6Bv/GRgmz81
   KpRvgSRT4gefYjjVHsQKRpMMjGxqXHjjXJWA1v/64dz6OJMdvlWZR8mr6
   uARVdwI1iZOp/kDRoYx1Q2+OCvoHkcVjFy2la/mdlHOVaf1CQVyqn4mqk
   8mMUuXGq6FXGNOqssD0Zk+ZpstMsrdvZUNOYupUlxyBtx9EZzSQ6ze7sN
   8bSn5q+azPaZZ5xNwa3xzc9CVnqZNW3RhwaTtLcjFufunexWVpAR7nB0q
   DlbWlV8LPNaeEVUUPe0LPTH1RT72MOIwq81yzFkZePZIVj0WhMOZNFKIY
   g==;
X-CSE-ConnectionGUID: HxIfwBOoSTCnGtRvNgamWw==
X-CSE-MsgGUID: Eks0lRvFTm+aQKsXFE0ZYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="47908571"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="47908571"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 01:51:47 -0800
X-CSE-ConnectionGUID: Pn0mpa4YSQeLt4fQQd9r4w==
X-CSE-MsgGUID: ghOYaXyWTU+x+1k/Rp85kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="83282586"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 04 Nov 2024 01:51:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2E7CA1C4; Mon, 04 Nov 2024 11:51:44 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Viresh Kumar <vireshk@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	stable@vger.kernel.org,
	Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v5 1/1] dmaengine: dw: Select only supported masters for ACPI devices
Date: Mon,  4 Nov 2024 11:50:50 +0200
Message-ID: <20241104095142.157925-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Tested-by: Ferry Toth <fntoth@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v5: rebranded to follow the compliances

Vinod, please apply this for v6.12-rcX as we have a problem to fix.

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


