Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905D42DB917
	for <lists+dmaengine@lfdr.de>; Wed, 16 Dec 2020 03:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgLPC2n (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Dec 2020 21:28:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:7325 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgLPC2n (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Dec 2020 21:28:43 -0500
IronPort-SDR: +dRe1dZPCQ7WVRawCvAYNhHQTIvX95nF0cNtJnLahtsyUqHORes+vjLppCyo3Havs4woun8xl7
 xAa4BMul585A==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="259716484"
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="259716484"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 18:27:25 -0800
IronPort-SDR: D+C0PLdIHcXdJkSWKMLflmkHjDyCi4gUn1KgDYhnGyAlH+v7JQS4f7YZQJhaEx8ED79EQMN373
 2vuSSPxQruXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="557080864"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga005.jf.intel.com with ESMTP; 15 Dec 2020 18:27:23 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 15/16] dmaengine: dw-axi-dmac: Set constraint to the Max segment size
Date:   Wed, 16 Dec 2020 10:10:02 +0800
Message-Id: <20201216021003.26911-16-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201216021003.26911-1-jee.heng.sia@intel.com>
References: <20201216021003.26911-1-jee.heng.sia@intel.com>
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

