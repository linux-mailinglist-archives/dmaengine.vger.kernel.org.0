Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0956E2E6DE2
	for <lists+dmaengine@lfdr.de>; Tue, 29 Dec 2020 06:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgL2FFI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Dec 2020 00:05:08 -0500
Received: from mga03.intel.com ([134.134.136.65]:37340 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgL2FFI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 29 Dec 2020 00:05:08 -0500
IronPort-SDR: /RYxYH1usuR1R6CSGcDUG1v4XJw8WJNrEMlJSSwWHL8MlrLtSD4afmKV1OyH11v+K7+4ARvJIU
 vD1rbgT1Yn5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="176554699"
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="scan'208";a="176554699"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 21:04:21 -0800
IronPort-SDR: bkmAWB0OpGvs0ot5B3Fj+b9Fd5Lytl4MOEe3NFLunS5DFanph4YgUMa3FaGiBGuoqyRoH1RfQX
 t0FwLkAW6Zzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="scan'208";a="347249736"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by fmsmga008.fm.intel.com with ESMTP; 28 Dec 2020 21:04:19 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v8 04/16] dmaengine: dw-axi-dmac: Add device_synchronize() callback
Date:   Tue, 29 Dec 2020 12:47:01 +0800
Message-Id: <20201229044713.28464-5-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201229044713.28464-1-jee.heng.sia@intel.com>
References: <20201229044713.28464-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for device_synchronize() callback function to sync with
dmaengine_terminate_sync().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
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

