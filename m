Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD0530201A
	for <lists+dmaengine@lfdr.de>; Mon, 25 Jan 2021 02:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbhAYBzY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 Jan 2021 20:55:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:4250 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbhAYByv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 24 Jan 2021 20:54:51 -0500
IronPort-SDR: B3ufs60HUikr9KhpHLGh/hc8dFI8m5snTJVRp/TXLLkzZD5pCxcFed601iRMpJhDqSv38Ptbbw
 IEk7vHQWp7iA==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="176137845"
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="176137845"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 17:51:10 -0800
IronPort-SDR: k8U4O8emf+eQNtfAcfU/mj3r4gxfmgMUDZyS1xC+4llgiWrs3iqratf5XyOyl15A+ScxLxnn3r
 mgBb7r6banPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="352796020"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2021 17:51:08 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jee.heng.sia@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v12 16/17] dmaengine: dw-axi-dmac: Set constraint to the Max segment size
Date:   Mon, 25 Jan 2021 09:32:54 +0800
Message-Id: <20210125013255.25799-17-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210125013255.25799-1-jee.heng.sia@intel.com>
References: <20210125013255.25799-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for DMA Scatter-Gather (SG) constraint so that DMA clients can
handle the AxiDMA limitation.

Without supporting DMA constraint the default Max segment size reported by
dmaengine is 64KB, which is not supported by Intel KeemBay AxiDMA.

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Tested-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 ++++++++
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index a1dddec95316..88d4923dee6c 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/dmaengine.h>
 #include <linux/dmapool.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -1340,6 +1341,13 @@ static int dw_probe(struct platform_device *pdev)
 	dw->dma.device_prep_slave_sg = dw_axi_dma_chan_prep_slave_sg;
 	dw->dma.device_prep_dma_cyclic = dw_axi_dma_chan_prep_cyclic;
 
+	/*
+	 * Synopsis DesignWare AxiDMA datasheet mentioned Maximum
+	 * supported blocks is 1024. Device register width is 4 bytes.
+	 * Therefore, set constraint to 1024 * 4.
+	 */
+	dw->dma.dev->dma_parms = &dw->dma_parms;
+	dma_set_max_seg_size(&pdev->dev, MAX_BLOCK_SIZE);
 	platform_set_drvdata(pdev, chip);
 
 	pm_runtime_enable(chip->dev);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 3a357f7fda02..1e937ea2a96d 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -54,6 +54,7 @@ struct axi_dma_chan {
 struct dw_axi_dma {
 	struct dma_device	dma;
 	struct dw_axi_dma_hcfg	*hdata;
+	struct device_dma_parameters	dma_parms;
 
 	/* channels */
 	struct axi_dma_chan	*chan;
-- 
2.18.0

