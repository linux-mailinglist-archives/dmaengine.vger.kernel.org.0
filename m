Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23F53D00DA
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jul 2021 19:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhGTRGt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jul 2021 13:06:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:17000 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231579AbhGTRGr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Jul 2021 13:06:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="211016719"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="211016719"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 10:47:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="469847783"
Received: from coresw01.iind.intel.com ([10.223.252.64])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jul 2021 10:47:22 -0700
From:   pandith.n@intel.com
To:     Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com, kris.pan@intel.com,
        mallikarjunappa.sangannavar@intel.com, Srikanth.Thokala@intel.com,
        Pandith N <pandith.n@intel.com>
Subject: [PATCH V4 3/3] dmaengine: dw-axi-dmac: Burst length settings
Date:   Tue, 20 Jul 2021 23:17:13 +0530
Message-Id: <20210720174713.13282-4-pandith.n@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720174713.13282-1-pandith.n@intel.com>
References: <20210720174713.13282-1-pandith.n@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Pandith N <pandith.n@intel.com>

Burst length, DMA HW capability set in dt-binding is now used in driver.

Signed-off-by: Pandith N <pandith.n@intel.com>
Tested-by: Pan Kris <kris.pan@intel.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 2c9a3cc204e2..aace3751c56e 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1290,7 +1290,7 @@ static int parse_device_properties(struct axi_dma_chip *chip)
 			return -EINVAL;
 
 		chip->dw->hdata->restrict_axi_burst_len = true;
-		chip->dw->hdata->axi_rw_burst_len = tmp - 1;
+		chip->dw->hdata->axi_rw_burst_len = tmp;
 	}
 
 	return 0;
@@ -1379,6 +1379,7 @@ static int dw_probe(struct platform_device *pdev)
 
 	/* DMA capabilities */
 	dw->dma.chancnt = hdata->nr_channels;
+	dw->dma.max_burst = hdata->axi_rw_burst_len;
 	dw->dma.src_addr_widths = AXI_DMA_BUSWIDTHS;
 	dw->dma.dst_addr_widths = AXI_DMA_BUSWIDTHS;
 	dw->dma.directions = BIT(DMA_MEM_TO_MEM);
-- 
2.17.1

