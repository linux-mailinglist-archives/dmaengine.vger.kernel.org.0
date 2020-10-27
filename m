Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735E129A50D
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 07:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507033AbgJ0G4W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 02:56:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:5231 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgJ0G4W (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 27 Oct 2020 02:56:22 -0400
IronPort-SDR: AEDjvXpK2lTAMwGtONLe6vfGTB5bMwWcosvIDNtktljbcNGlz+DY2/1FeSyHRc1UEEy6Zk9z8B
 WnE8w63gYZEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="147890922"
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="147890922"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 23:56:21 -0700
IronPort-SDR: QaOlEoRhUV+JodA1Sj1/ocP4n/rBDfGsJVpuB1kj7egQrdJqC8sgsLDYIWl35Fp9NJFQ65pa8M
 KQaFcrkfaByQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="350176007"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga008.jf.intel.com with ESMTP; 26 Oct 2020 23:56:20 -0700
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/15] dmaengine: dw-axi-dmac: Set constraint to the Max segment size
Date:   Tue, 27 Oct 2020 14:38:58 +0800
Message-Id: <20201027063858.4877-16-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201027063858.4877-1-jee.heng.sia@intel.com>
References: <20201027063858.4877-1-jee.heng.sia@intel.com>
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
index d4fca3ffe67f..bd56e21663c3 100644
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
@@ -1407,6 +1408,13 @@ static int dw_probe(struct platform_device *pdev)
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
index f64e8d33b127..67669049cead 100644
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

