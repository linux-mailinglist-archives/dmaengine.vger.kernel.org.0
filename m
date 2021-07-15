Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051983C9D95
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 13:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241822AbhGOLQv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Jul 2021 07:16:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:17800 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241139AbhGOLQu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Jul 2021 07:16:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="232348410"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="232348410"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 04:13:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="452381223"
Received: from coresw01.iind.intel.com ([10.223.252.64])
  by orsmga007.jf.intel.com with ESMTP; 15 Jul 2021 04:13:54 -0700
From:   pandith.n@intel.com
To:     Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com, kris.pan@intel.com,
        mallikarjunappa.sangannavar@intel.com, Srikanth.Thokala@intel.com,
        Pandith N <pandith.n@intel.com>
Subject: [PATCH V3 0/3] dmaengine: dw-axi-dmac: support parallel memory <--> peripheral transfers
Date:   Thu, 15 Jul 2021 16:43:51 +0530
Message-Id: <20210715111354.16979-1-pandith.n@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Pandith N <pandith.n@intel.com>

Added support for multiple DMA_MEM_TO_DEV, DMA_DEV_TO_MEM transfers in
parallel. Peripherals can use DMA for both transmit and receive
operations in parallel.
To setup DMA handshaking, the peripheral source number to be programmed
in respective channel select slot of AXIDMA_CTRL_DMA_HS_SEL. No need to
check for free slot in dw_axi_dma_set_hw_channel().

The channel slot used in AXIDMA_CTRL_DMA_HS_SEL needs to be set in
src_per/dst_per of CHx_CFG register

Burst length, DMA HW capability set in dt-binding is now used in driver.

Changes since v1:
Added new macro, magic mask for HW handshake select.
Typos in commit message are corrected

Changes since v2:
Split the patch as follows
Patch 1: Remove free slot check algorithm in dw_axi_dma_set_hw_channel()
Patch 2: The channel slot used needs to be set in CHx_CFG src/dst_per
Patch 3: Usage of burst length HW capability

Pandith N (3):
  dmaengine: dw-axi-dmac: Remove free slot check algorithm in
    dw_axi_dma_set_hw_channel
  dmaengine: dw-axi-dmac: support parallel memory <--> peripheral
    transfers
  dmaengine: dw-axi-dmac: Burst length settings

 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 56 +++++++++----------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  4 ++
 2 files changed, 29 insertions(+), 31 deletions(-)

-- 
2.17.1

