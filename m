Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B7B3C9D97
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 13:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241139AbhGOLQ4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Jul 2021 07:16:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:17800 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240870AbhGOLQz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Jul 2021 07:16:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="232348422"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="232348422"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 04:14:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="452381259"
Received: from coresw01.iind.intel.com ([10.223.252.64])
  by orsmga007.jf.intel.com with ESMTP; 15 Jul 2021 04:14:00 -0700
From:   pandith.n@intel.com
To:     Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com, kris.pan@intel.com,
        mallikarjunappa.sangannavar@intel.com, Srikanth.Thokala@intel.com,
        Pandith N <pandith.n@intel.com>
Subject: [PATCH V3 2/3] dmaengine: dw-axi-dmac: support parallel memory <--> peripheral transfers
Date:   Thu, 15 Jul 2021 16:43:53 +0530
Message-Id: <20210715111354.16979-3-pandith.n@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715111354.16979-1-pandith.n@intel.com>
References: <20210715111354.16979-1-pandith.n@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Pandith N <pandith.n@intel.com>

Added support for multiple DMA_MEM_TO_DEV, DMA_DEV_TO_MEM transfers in
parallel. This is required for peripherals using DMA for transmit and
receive operations at the same time. APB slot number needs to be
programmed in channel hardware handshaking interface

Signed-off-by: Pandith N <pandith.n@intel.com>
Tested-by: Pan Kris <kris.pan@intel.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 4 ++++
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 6b871e20ae27..2c9a3cc204e2 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -363,12 +363,16 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 			DWAXIDMAC_TT_FC_MEM_TO_PER_DST :
 			DWAXIDMAC_TT_FC_MEM_TO_PER_DMAC)
 			<< CH_CFG_H_TT_FC_POS;
+		if (chan->chip->apb_regs)
+			reg |= (chan->id << CH_CFG_H_DST_PER_POS);
 		break;
 	case DMA_DEV_TO_MEM:
 		reg |= (chan->config.device_fc ?
 			DWAXIDMAC_TT_FC_PER_TO_MEM_SRC :
 			DWAXIDMAC_TT_FC_PER_TO_MEM_DMAC)
 			<< CH_CFG_H_TT_FC_POS;
+		if (chan->chip->apb_regs)
+			reg |= (chan->id << CH_CFG_H_SRC_PER_POS);
 		break;
 	default:
 		break;
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 358f553cafe9..380005afde16 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -258,6 +258,8 @@ enum {
 
 /* CH_CFG_H */
 #define CH_CFG_H_PRIORITY_POS		17
+#define CH_CFG_H_DST_PER_POS		12
+#define CH_CFG_H_SRC_PER_POS		7
 #define CH_CFG_H_HS_SEL_DST_POS		4
 #define CH_CFG_H_HS_SEL_SRC_POS		3
 enum {
-- 
2.17.1

