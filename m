Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CB82FE2C3
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jan 2021 07:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbhAUGZd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jan 2021 01:25:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:10404 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbhAUGPC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 21 Jan 2021 01:15:02 -0500
IronPort-SDR: 4k/9ZE9szqT4hK0sp9lBGmcTGSUtla2cwjcUfqTUpaDdtPoaUKEFCjgx5zRWeAwSs5z6hBcjqd
 jH107htuQDHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="175716773"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="175716773"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 22:14:21 -0800
IronPort-SDR: YOTV0CdxGP1HBGumHnGSmzDxPSbKaytsKzkqnW92MoOiwib2KC6MGE0fpIAXZi5qAw4ZvzE92m
 LZym/l2Y4H3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="427201347"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga001.jf.intel.com with ESMTP; 20 Jan 2021 22:14:18 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jee.heng.sia@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v10 05/16] dmaengine: dw-axi-dmac: Add device_config operation
Date:   Thu, 21 Jan 2021 13:56:30 +0800
Message-Id: <20210121055641.6307-6-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210121055641.6307-1-jee.heng.sia@intel.com>
References: <20210121055641.6307-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add device_config() callback function so that the device address
can be passed to the dma driver.

DMA clients use this interface to pass in the device address to the
AxiDMA. Without this interface, data transfer between device to memory
and memory to device would failed.

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Tested-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
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

