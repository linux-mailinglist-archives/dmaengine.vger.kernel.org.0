Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671EB2B0194
	for <lists+dmaengine@lfdr.de>; Thu, 12 Nov 2020 10:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbgKLJGg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Nov 2020 04:06:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:52954 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbgKLJGd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 12 Nov 2020 04:06:33 -0500
IronPort-SDR: SiBdswN45h/+a1l/SdKRLpJ+tDSobuCm4y9/6q9oxnBI8lKF7a/zkL7Xc8XbRbcJM7+Xw6Vusu
 Cb2h5EwCfoxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="166773040"
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="166773040"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 01:06:33 -0800
IronPort-SDR: iVRFTIR6bSZk1bHUq0JddlsSKGSUMMqpwZBRIrME1vrE7k5CVXUL1z+WYPYe18QGrYWuvy77Z8
 HKTrYR/E0N3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="360911545"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by fmsmga002.fm.intel.com with ESMTP; 12 Nov 2020 01:06:31 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 05/15] dmaengine: dw-axi-dmac: Add device_config operation
Date:   Thu, 12 Nov 2020 16:49:43 +0800
Message-Id: <20201112084953.21629-6-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201112084953.21629-1-jee.heng.sia@intel.com>
References: <20201112084953.21629-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add device_config() callback function so that the device address
can be passed to the dma driver.

DMA clients use this interface to pass in the device address to the
AxiDMA. Without this interface, data transfer between device to memory
and memory to device would failed.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 11 +++++++++++
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 56b213211341..16e6934ae9a1 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -559,6 +559,16 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
 	return NULL;
 }
 
+static int dw_axi_dma_chan_slave_config(struct dma_chan *dchan,
+					struct dma_slave_config *config)
+{
+	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+
+	memcpy(&chan->config, config, sizeof(*config));
+
+	return 0;
+}
+
 static void axi_chan_dump_lli(struct axi_dma_chan *chan,
 			      struct axi_dma_hw_desc *desc)
 {
@@ -948,6 +958,7 @@ static int dw_probe(struct platform_device *pdev)
 
 	dw->dma.device_prep_dma_memcpy = dma_chan_prep_dma_memcpy;
 	dw->dma.device_synchronize = dw_axi_dma_synchronize;
+	dw->dma.device_config = dw_axi_dma_chan_slave_config;
 
 	platform_set_drvdata(pdev, chip);
 
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index f886b2bb75de..a75b921d6b1a 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -43,6 +43,7 @@ struct axi_dma_chan {
 	struct virt_dma_chan		vc;
 
 	struct axi_dma_desc		*desc;
+	struct dma_slave_config		config;
 	/* these other elements are all protected by vc.lock */
 	bool				is_paused;
 };
-- 
2.18.0

