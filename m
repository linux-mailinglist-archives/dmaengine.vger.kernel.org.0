Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016212E6DE5
	for <lists+dmaengine@lfdr.de>; Tue, 29 Dec 2020 06:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgL2FFM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Dec 2020 00:05:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:37344 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgL2FFM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 29 Dec 2020 00:05:12 -0500
IronPort-SDR: cGw2P4cQ7nzTVzYVII9YY6Ow+ihhikkuwy7ykxRmFdvMwqA9uEOrp0jTfaOe+sTCu5kZqxtwX/
 PHhn0ZLvbqLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="176554702"
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="scan'208";a="176554702"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 21:04:24 -0800
IronPort-SDR: uGtMd/7B0KeFLsACJAKDOBMvbW7beyWFpTtVCT+xSDD4lOBbEw/Sy5l8MX7RZAib6MfPJ//TIg
 RxLC/pjsizwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="scan'208";a="347249769"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by fmsmga008.fm.intel.com with ESMTP; 28 Dec 2020 21:04:22 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v8 05/16] dmaengine: dw-axi-dmac: Add device_config operation
Date:   Tue, 29 Dec 2020 12:47:02 +0800
Message-Id: <20201229044713.28464-6-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201229044713.28464-1-jee.heng.sia@intel.com>
References: <20201229044713.28464-1-jee.heng.sia@intel.com>
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
index 241ab7a24e2a..eaa7c4c404ca 100644
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

