Return-Path: <dmaengine+bounces-3200-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED78097D7EB
	for <lists+dmaengine@lfdr.de>; Fri, 20 Sep 2024 17:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BE42870B8
	for <lists+dmaengine@lfdr.de>; Fri, 20 Sep 2024 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2370617BEC8;
	Fri, 20 Sep 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8tWhv+x"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B71C17B500;
	Fri, 20 Sep 2024 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726847907; cv=none; b=VfhKpZE75W8fP6NJRBsJtxgyIyqveYOK2biGvHyZ6wfMKHNkxZR8rzhaj9kK8M716BuVwC0pXWtv51+eaHFamYnO1smnd/UDR+PE0+3F+1cN5w7tqbHOqCpcarMBAQgqvhaTZPT5Ez3aMuX7oGtRvuQNoHOTTfSiWR1N8AM728g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726847907; c=relaxed/simple;
	bh=zLM+YLXaA5lEuFe9YAJfou02iRG8+n5NAeXbA0HlgeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rWJmjIV9Pt6j4mTGAIz1OhhhIKvFfn8pmqWVawlNICOxoYE0/rJc7UEdOjRxwFkM3Q/GB0zG5noKrwAMRjGYe+lYIQ3bBV7z/s5XnIWQTbt0aHbbh2RDNAiuHNkrERuKzwqDSCnjf14jJZusvcjP6e8COQBZXP6UwNDAoK1o1RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8tWhv+x; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726847905; x=1758383905;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zLM+YLXaA5lEuFe9YAJfou02iRG8+n5NAeXbA0HlgeU=;
  b=H8tWhv+x+WMax0Ra+VVf21kxEAQv7IrMn76eEv3zZ13h/a+qVtNTzfv3
   zuyeAHFs83yRSd68z0bJZOdB6ng0KSVDm66HS4sXeTb6WjPP/Zxs67T/w
   azkJuVY5IQnjp1dNTRIXE6G/DcgOvuVFYewAtRhr3p9ctk3AbUxYWX1sa
   00/9npRoRDX2BTaxTmRFgTBj/b2uWfvwY1n3HX0JOFH2ceW0zFWlwse9K
   9Ce28C6MdeCKG68PqkKJP7iLZmK9TXLGTOEFtf0lPEx12wiqnS47q/030
   Taif5e7V7fcpOSuY+UFi+66CpB2CnzHYxwp3Ev5jVG9Oz7Ag/CXjGe5g5
   w==;
X-CSE-ConnectionGUID: iaXai1Z8Roy5Z6eOgkjr5Q==
X-CSE-MsgGUID: 8WK5JKuHSFq491jVGnJX4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="29589909"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="29589909"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 08:58:25 -0700
X-CSE-ConnectionGUID: 2drIpfLHTQihvx03s8xsDQ==
X-CSE-MsgGUID: b0r/LDokS4Ss+PC+ekgAww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="75306215"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 20 Sep 2024 08:58:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E4FA71C2; Fri, 20 Sep 2024 18:58:21 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Viresh Kumar <vireshk@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	stable@vger.kernel.org,
	Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v3 1/1] dmaengine: dw: Select only supported masters for ACPI devices
Date: Fri, 20 Sep 2024 18:56:17 +0300
Message-ID: <20240920155820.3340081-1-andriy.shevchenko@linux.intel.com>
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
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: rewrote to use driver_data
v2: https://lore.kernel.org/r/20240919185151.7331-1-fancer.lancer@gmail.com

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
index 779b3cbcf30d..99d9f61b2254 100644
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
 
 int dw_dma_fill_pdata(struct device *dev, struct dw_dma_platform_data *pdata);
diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
index adf2d69834b8..a3aae3d1c093 100644
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


