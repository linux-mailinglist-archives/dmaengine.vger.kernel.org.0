Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3088C2BFE55
	for <lists+dmaengine@lfdr.de>; Mon, 23 Nov 2020 03:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgKWCvr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 22 Nov 2020 21:51:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:60192 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbgKWCvr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 22 Nov 2020 21:51:47 -0500
IronPort-SDR: yMj0zVFBsN1cKim3USwf3/yWwdT1B8kkNeN3QPQ47CzUYucPZx8p+n62tJ73Mxq9qNhbMmqjME
 SWxp5O8wzQ9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="159459989"
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="159459989"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 18:51:46 -0800
IronPort-SDR: P5gCjFM88jEvQ6fPxQ1+APIO9NfUP2BTMRs7CLENOFas3R2W8N/DUi0Sl793tsFMJY6wmDpMR9
 WXA9p/mzmg6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="369879860"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Nov 2020 18:51:45 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 05/16] dmaengine: dw-axi-dmac: Add device_config operation
Date:   Mon, 23 Nov 2020 10:34:41 +0800
Message-Id: <20201123023452.7894-6-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201123023452.7894-1-jee.heng.sia@intel.com>
References: <20201123023452.7894-1-jee.heng.sia@intel.com>
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

