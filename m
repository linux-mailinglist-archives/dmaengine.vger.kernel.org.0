Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A896E2EA25B
	for <lists+dmaengine@lfdr.de>; Tue,  5 Jan 2021 02:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbhAEBB3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 Jan 2021 20:01:29 -0500
Received: from mga05.intel.com ([192.55.52.43]:29975 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbhAEBB3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 4 Jan 2021 20:01:29 -0500
IronPort-SDR: uuA4s1RXFeugyNBMX/yNFQTMwULYLF/W7L115p1/2S7K+b+ENxZ2+KuAh/dzwZfoWWgD0WbJCW
 R2Kyv48FqcIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="261794138"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="261794138"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 17:00:30 -0800
IronPort-SDR: 2d9r7053xEd0/o0cBIc+H98Xpfye77Zo/kkRS50fI4FBvDEFO61Kab1ArNXEZzL+PEgHQsdsSn
 q8/XjGAr+rtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="569540228"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jan 2021 17:00:28 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v9 08/16] dmaengine: dw-axi-dmac: Support of_dma_controller_register()
Date:   Tue,  5 Jan 2021 08:42:58 +0800
Message-Id: <20210105004306.13588-9-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210105004306.13588-1-jee.heng.sia@intel.com>
References: <20210105004306.13588-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for of_dma_controller_register() so that DMA clients
can pass in device handshake number to the AxiDMA driver.

DMA clients shall code the device handshake number in the Device tree.
When DMA activities are needed, DMA clients shall invoke OF helper
function to pass in the device handshake number to the AxiDMA.

Without register to the of_dma_controller_register(), data transfer
between memory to device and device to memory operations would failed.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 26 +++++++++++++++++++
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index a76299360f69..a8b6c8c8ef58 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_dma.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
@@ -1044,6 +1045,22 @@ static int __maybe_unused axi_dma_runtime_resume(struct device *dev)
 	return axi_dma_resume(chip);
 }
 
+static struct dma_chan *dw_axi_dma_of_xlate(struct of_phandle_args *dma_spec,
+					    struct of_dma *ofdma)
+{
+	struct dw_axi_dma *dw = ofdma->of_dma_data;
+	struct axi_dma_chan *chan;
+	struct dma_chan *dchan;
+
+	dchan = dma_get_any_slave_channel(&dw->dma);
+	if (!dchan)
+		return NULL;
+
+	chan = dchan_to_axi_dma_chan(dchan);
+	chan->hw_handshake_num = dma_spec->args[0];
+	return dchan;
+}
+
 static int parse_device_properties(struct axi_dma_chip *chip)
 {
 	struct device *dev = chip->dev;
@@ -1233,6 +1250,13 @@ static int dw_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pm_disable;
 
+	/* Register with OF helpers for DMA lookups */
+	ret = of_dma_controller_register(pdev->dev.of_node,
+					 dw_axi_dma_of_xlate, dw);
+	if (ret < 0)
+		dev_warn(&pdev->dev,
+			 "Failed to register OF DMA controller, fallback to MEM_TO_MEM mode\n");
+
 	dev_info(chip->dev, "DesignWare AXI DMA Controller, %d channels\n",
 		 dw->hdata->nr_channels);
 
@@ -1266,6 +1290,8 @@ static int dw_remove(struct platform_device *pdev)
 
 	devm_free_irq(chip->dev, chip->irq, chip);
 
+	of_dma_controller_free(chip->dev->of_node);
+
 	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
 			vc.chan.device_node) {
 		list_del(&chan->vc.chan.device_node);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index a26b0a242a93..3498bef5453b 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -37,6 +37,7 @@ struct axi_dma_chan {
 	struct axi_dma_chip		*chip;
 	void __iomem			*chan_regs;
 	u8				id;
+	u8				hw_handshake_num;
 	atomic_t			descs_allocated;
 
 	struct dma_pool			*desc_pool;
-- 
2.18.0

