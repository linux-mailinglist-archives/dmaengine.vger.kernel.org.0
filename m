Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C556128AD29
	for <lists+dmaengine@lfdr.de>; Mon, 12 Oct 2020 06:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgJLEjT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Oct 2020 00:39:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:21608 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgJLEjQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Oct 2020 00:39:16 -0400
IronPort-SDR: tHCl38FnZLUYLn7emj35W0gAOyyfjtIY2sDkq+ZyA7CNM7DksLDxUiPcoyFy8AJv2v1E0uh9vJ
 7T889VSB8pOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="164903179"
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="164903179"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 21:39:16 -0700
IronPort-SDR: 2IkP2lM6PrOaw2Tz+vpmP3hEq58pID8meBryJ85pPjPQe0EKaIJOSG9LOBHyXQhtAHddPZPRGB
 hhBwk0806ODA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="313321314"
Received: from unknown (HELO jsia-HP-Z620-Workstation.png.intel.com) ([10.221.118.135])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2020 21:39:14 -0700
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] dmaengine: dw-axi-dmac: Support of_dma_controller_register()
Date:   Mon, 12 Oct 2020 12:21:53 +0800
Message-Id: <20201012042200.29787-9-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201012042200.29787-1-jee.heng.sia@intel.com>
References: <20201012042200.29787-1-jee.heng.sia@intel.com>
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
index 9e574753aaf0..011cf7134f25 100644
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
@@ -1103,6 +1104,22 @@ static int __maybe_unused axi_dma_runtime_resume(struct device *dev)
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
+	chan->hw_hs_num = dma_spec->args[0];
+	return dchan;
+}
+
 static int parse_device_properties(struct axi_dma_chip *chip)
 {
 	struct device *dev = chip->dev;
@@ -1292,6 +1309,13 @@ static int dw_probe(struct platform_device *pdev)
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
 
@@ -1325,6 +1349,8 @@ static int dw_remove(struct platform_device *pdev)
 
 	devm_free_irq(chip->dev, chip->irq, chip);
 
+	of_dma_controller_free(chip->dev->of_node);
+
 	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
 			vc.chan.device_node) {
 		list_del(&chan->vc.chan.device_node);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index a26b0a242a93..651874e5c88f 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -37,6 +37,7 @@ struct axi_dma_chan {
 	struct axi_dma_chip		*chip;
 	void __iomem			*chan_regs;
 	u8				id;
+	u8				hw_hs_num;
 	atomic_t			descs_allocated;
 
 	struct dma_pool			*desc_pool;
-- 
2.18.0

