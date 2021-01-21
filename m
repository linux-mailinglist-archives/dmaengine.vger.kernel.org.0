Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6A92FE2C8
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jan 2021 07:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbhAUGZ5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jan 2021 01:25:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:10401 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbhAUGPB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 21 Jan 2021 01:15:01 -0500
IronPort-SDR: ezR3XJn0fhAnALUxHDqa2s+dAGnw4Qy5zeMzvQqumpTOcyISZJmJFbWyNvc3zRcufDPzi0AfPV
 A7YsS4pD09Fg==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="175716769"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="175716769"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 22:14:18 -0800
IronPort-SDR: YswP6qZzM9kKFwoiXwybtdzTE4pjqC/tUrjM4OFyAo0vzAGOvXyo6hUNYQyZKZ5WWlFyHrN/5p
 7g6g9911IbTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="427201336"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga001.jf.intel.com with ESMTP; 20 Jan 2021 22:14:15 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jee.heng.sia@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v10 04/16] dmaengine: dw-axi-dmac: Add device_synchronize() callback
Date:   Thu, 21 Jan 2021 13:56:29 +0800
Message-Id: <20210121055641.6307-5-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210121055641.6307-1-jee.heng.sia@intel.com>
References: <20210121055641.6307-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for device_synchronize() callback function to sync with
dmaengine_terminate_sync().

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Tested-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 3737e1c3c793..241ab7a24e2a 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -347,6 +347,13 @@ static void dma_chan_issue_pending(struct dma_chan *dchan)
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
 
+static void dw_axi_dma_synchronize(struct dma_chan *dchan)
+{
+	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+
+	vchan_synchronize(&chan->vc);
+}
+
 static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
@@ -940,6 +947,7 @@ static int dw_probe(struct platform_device *pdev)
 	dw->dma.device_free_chan_resources = dma_chan_free_chan_resources;
 
 	dw->dma.device_prep_dma_memcpy = dma_chan_prep_dma_memcpy;
+	dw->dma.device_synchronize = dw_axi_dma_synchronize;
 
 	platform_set_drvdata(pdev, chip);
 
-- 
2.18.0

