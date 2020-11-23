Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0975D2BFE74
	for <lists+dmaengine@lfdr.de>; Mon, 23 Nov 2020 03:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgKWCwS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 22 Nov 2020 21:52:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:60192 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbgKWCwS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 22 Nov 2020 21:52:18 -0500
IronPort-SDR: rxVnvIdyuSp/hKEqE8zA9PQ3CueMrxmwAYz8bsVo5rGu5zoRvVmeRZ5AMl6vFUCqIDkTS1ftL/
 zULMAz3Bwx0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="159460054"
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="159460054"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 18:52:17 -0800
IronPort-SDR: a9h0Sh8OqF7YBefKpUYiYR/iqJ+rBS/UM71e3RRFH0xyEpT54jc16Ggkkv2JO+1rFXAiSAsz/6
 8b/H8+YldfMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="369879945"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Nov 2020 18:52:15 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 15/16] dmaengine: dw-axi-dmac: Set constraint to the Max segment size
Date:   Mon, 23 Nov 2020 10:34:51 +0800
Message-Id: <20201123023452.7894-16-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201123023452.7894-1-jee.heng.sia@intel.com>
References: <20201123023452.7894-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for DMA Scatter-Gather (SG) constraint so that DMA clients can
handle the AxiDMA limitation.

Without supporting DMA constraint the default Max segment size reported by
dmaengine is 64KB, which is not supported by Intel KeemBay AxiDMA.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 ++++++++
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index dc7ddf98fd04..1a218fcdbb16 100644
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
@@ -1350,6 +1351,13 @@ static int dw_probe(struct platform_device *pdev)
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

