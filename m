Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056D141EF31
	for <lists+dmaengine@lfdr.de>; Fri,  1 Oct 2021 16:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354209AbhJAOOn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Oct 2021 10:14:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:11422 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353676AbhJAOOn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 1 Oct 2021 10:14:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="248005391"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="248005391"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 07:08:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="480470649"
Received: from coresw01.iind.intel.com ([10.106.46.194])
  by fmsmga007.fm.intel.com with ESMTP; 01 Oct 2021 07:08:25 -0700
From:   pandith.n@intel.com
To:     vkoul@kernel.org, eugeniy.paltsev@synopsys.com,
        dmaengine@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com,
        mallikarjunappa.sangannavar@intel.com, srikanth.thokala@intel.com,
        kenchappa.demakkanavar@intel.com, Pandith N <pandith.n@intel.com>
Subject: [PATCH V3 3/3] dmaengine: dw-axi-dmac: set coherent mask
Date:   Fri,  1 Oct 2021 19:38:12 +0530
Message-Id: <20211001140812.24977-4-pandith.n@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001140812.24977-1-pandith.n@intel.com>
References: <20211001140812.24977-1-pandith.n@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Pandith N <pandith.n@intel.com>

Add support for setting dma coherent mask, dma mask is set to 64 bit

Signed-off-by: Pandith N <pandith.n@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---

Changes from v1->v2:
Removed dt-binding to set coherent_bit_mask value.
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index f46fd9895a13..79572ec532ef 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -212,12 +212,16 @@ static inline bool axi_chan_is_hw_enable(struct axi_dma_chan *chan)
 
 static void axi_dma_hw_init(struct axi_dma_chip *chip)
 {
+	int ret;
 	u32 i;
 
 	for (i = 0; i < chip->dw->hdata->nr_channels; i++) {
 		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
 		axi_chan_disable(&chip->dw->chan[i]);
 	}
+	ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
+	if (ret)
+		dev_warn(chip->dev, "Unable to set coherent mask\n");
 }
 
 static u32 axi_chan_get_xfer_width(struct axi_dma_chan *chan, dma_addr_t src,
-- 
2.17.1

