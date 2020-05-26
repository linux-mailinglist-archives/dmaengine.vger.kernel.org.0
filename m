Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2041E29FC
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2020 20:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgEZSYU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 May 2020 14:24:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:37437 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgEZSYT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 May 2020 14:24:19 -0400
IronPort-SDR: SN8aVZY1lqRTFxYL3S6VQ/1j+aVkTEnh0XWg8xbsjjcIcNAkqTnxcS28h5ZUXZlN517k5oUl7w
 RLVOMJDteKlg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 11:24:19 -0700
IronPort-SDR: 9IG/SNxnqZiiE2W4uKopTYTN0MULzmiIOOXg0v2bFkrw55JxhzXLqS/OhU+mzSUJliOYhAGeV2
 U/G4Qnsua0ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; 
   d="scan'208";a="302193723"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 26 May 2020 11:24:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DE3DFD2; Tue, 26 May 2020 21:24:16 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] dmaengine: dw: Register ACPI DMA controller for PCI that has companion
Date:   Tue, 26 May 2020 21:24:15 +0300
Message-Id: <20200526182416.52805-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If PCI enumerated controller has a companion device,
register it in the ACPI DMA controllers as well.

Fixes: f7c799e950f9 ("dmaengine: dw: we do support Merrifield SoC in PCI mode")
Depends-on: b685fe26e9af ("dmaengine: dw: platform: Split ACPI helpers to separate module")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/Makefile | 2 +-
 drivers/dma/dw/acpi.c   | 2 ++
 drivers/dma/dw/pci.c    | 4 ++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw/Makefile b/drivers/dma/dw/Makefile
index b6f06699e91a..9e949f13e1b5 100644
--- a/drivers/dma/dw/Makefile
+++ b/drivers/dma/dw/Makefile
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DW_DMAC_CORE)	+= dw_dmac_core.o
 dw_dmac_core-objs	:= core.o dw.o idma32.o
+dw_dmac_core-$(CONFIG_ACPI)	+= acpi.o
 
 obj-$(CONFIG_DW_DMAC)		+= dw_dmac.o
 dw_dmac-y			:= platform.o
-dw_dmac-$(CONFIG_ACPI)		+= acpi.o
 dw_dmac-$(CONFIG_OF)		+= of.o
 
 obj-$(CONFIG_DW_DMAC_PCI)	+= dw_dmac_pci.o
diff --git a/drivers/dma/dw/acpi.c b/drivers/dma/dw/acpi.c
index f6e8d55b4f6e..c510c109d2c3 100644
--- a/drivers/dma/dw/acpi.c
+++ b/drivers/dma/dw/acpi.c
@@ -41,6 +41,7 @@ void dw_dma_acpi_controller_register(struct dw_dma *dw)
 	if (ret)
 		dev_err(dev, "could not register acpi_dma_controller\n");
 }
+EXPORT_SYMBOL_GPL(dw_dma_acpi_controller_register);
 
 void dw_dma_acpi_controller_free(struct dw_dma *dw)
 {
@@ -51,3 +52,4 @@ void dw_dma_acpi_controller_free(struct dw_dma *dw)
 
 	acpi_dma_controller_free(dev);
 }
+EXPORT_SYMBOL_GPL(dw_dma_acpi_controller_free);
diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
index cf6e8ec4c0ff..1142aa6f8c4a 100644
--- a/drivers/dma/dw/pci.c
+++ b/drivers/dma/dw/pci.c
@@ -60,6 +60,8 @@ static int dw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *pid)
 	if (ret)
 		return ret;
 
+	dw_dma_acpi_controller_register(chip->dw);
+
 	pci_set_drvdata(pdev, data);
 
 	return 0;
@@ -71,6 +73,8 @@ static void dw_pci_remove(struct pci_dev *pdev)
 	struct dw_dma_chip *chip = data->chip;
 	int ret;
 
+	dw_dma_acpi_controller_free(chip->dw);
+
 	ret = data->remove(chip);
 	if (ret)
 		dev_warn(&pdev->dev, "can't remove device properly: %d\n", ret);
-- 
2.26.2

