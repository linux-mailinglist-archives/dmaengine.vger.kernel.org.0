Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76A425D5AB
	for <lists+dmaengine@lfdr.de>; Fri,  4 Sep 2020 12:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgIDKH2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Sep 2020 06:07:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:2059 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729942AbgIDKH1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 4 Sep 2020 06:07:27 -0400
IronPort-SDR: bu3x2HJpP34LYGDk/SwwCvBycSafQJjc7EQHo3TyfDEUKBzlVXOQ9by+bnLBC+MMetu+ISxWKB
 FCPaC9YXikLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="158697582"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="158697582"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 03:07:27 -0700
IronPort-SDR: W41n90XDb6WLbwcMU+CW4y7G7kO9wGKw259qQCx0SBxoi2ExT90gT16hc6oEvGzpQbo40T9mv8
 Lun26Ww+G+RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="342143679"
Received: from unknown (HELO jsia-HP-Z620-Workstation.png.intel.com) ([10.221.118.135])
  by orsmga007.jf.intel.com with ESMTP; 04 Sep 2020 03:07:25 -0700
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     <dmaengine@vger.kernel.org>
Cc:     <vkoul@kernel.org>, <Eugeniy.Paltsev@synopsys.com>,
        <andriy.shevchenko@intel.com>, <jee.heng.sia@intel.com>
Subject: [PATCH 4/4] dmaengine: dw-axi-dmac: Add device_synchronize() callback
Date:   Fri,  4 Sep 2020 17:51:34 +0800
Message-Id: <1599213094-30144-5-git-send-email-jee.heng.sia@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1599213094-30144-1-git-send-email-jee.heng.sia@intel.com>
References: <1599213094-30144-1-git-send-email-jee.heng.sia@intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for device_synchronize() callback function to sync with
dmaengine_terminate_sync().

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
Reviewed-by: Shevchenko, Andriy <andriy.shevchenko@intel.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 46e2ba9..56b2132 100644
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
1.9.1

