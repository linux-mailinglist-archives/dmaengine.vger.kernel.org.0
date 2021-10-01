Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A98441EF30
	for <lists+dmaengine@lfdr.de>; Fri,  1 Oct 2021 16:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354222AbhJAOOk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Oct 2021 10:14:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:11422 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353676AbhJAOOk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 1 Oct 2021 10:14:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="248005368"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="248005368"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 07:08:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="480470617"
Received: from coresw01.iind.intel.com ([10.106.46.194])
  by fmsmga007.fm.intel.com with ESMTP; 01 Oct 2021 07:08:20 -0700
From:   pandith.n@intel.com
To:     vkoul@kernel.org, eugeniy.paltsev@synopsys.com,
        dmaengine@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com,
        mallikarjunappa.sangannavar@intel.com, srikanth.thokala@intel.com,
        kenchappa.demakkanavar@intel.com, Pandith N <pandith.n@intel.com>
Subject: [PATCH V3 2/3] dmaengine: dw-axi-dmac: Hardware handshake configuration
Date:   Fri,  1 Oct 2021 19:38:11 +0530
Message-Id: <20211001140812.24977-3-pandith.n@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001140812.24977-1-pandith.n@intel.com>
References: <20211001140812.24977-1-pandith.n@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Pandith N <pandith.n@intel.com>

Added hardware handshake selection in channel config,
for mem2per and per2mem case.
The peripheral specific handshake interface needs to be
programmed in src_per, dst_per bits of CHx_CFG register.

Signed-off-by: Pandith N <pandith.n@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 9a8231244c42..f46fd9895a13 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -396,6 +396,8 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 				DWAXIDMAC_TT_FC_MEM_TO_PER_DMAC;
 		if (chan->chip->apb_regs)
 			config.dst_per = chan->id;
+		else
+			config.dst_per = chan->hw_handshake_num;
 		break;
 	case DMA_DEV_TO_MEM:
 		config.tt_fc = chan->config.device_fc ?
@@ -403,6 +405,8 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 				DWAXIDMAC_TT_FC_PER_TO_MEM_DMAC;
 		if (chan->chip->apb_regs)
 			config.src_per = chan->id;
+		else
+			config.src_per = chan->hw_handshake_num;
 		break;
 	default:
 		break;
-- 
2.17.1

