Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A704030200C
	for <lists+dmaengine@lfdr.de>; Mon, 25 Jan 2021 02:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbhAYBv5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 Jan 2021 20:51:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:4250 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbhAYBvd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 24 Jan 2021 20:51:33 -0500
IronPort-SDR: JnkMvwN+f20t5ewsa8huu9MviNmZeDBqXV+CfuqgbH//EPpj1Im17GvTCaipGUIhI+vWIgNQ2F
 fIZ51sYBEGpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="176137800"
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="176137800"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 17:50:32 -0800
IronPort-SDR: IK4HLAKb8M+tL7rVEWNY/jZp/5xn27+U16Lh+STqg/lOUERIJ0/Q0tdUf0UaXsiQdG8O0TS2oq
 zth1wjQ46tLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="352795905"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2021 17:50:30 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jee.heng.sia@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v12 04/17] dmaengine: dw-axi-dmac: Add device_synchronize() callback
Date:   Mon, 25 Jan 2021 09:32:42 +0800
Message-Id: <20210125013255.25799-5-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210125013255.25799-1-jee.heng.sia@intel.com>
References: <20210125013255.25799-1-jee.heng.sia@intel.com>
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

