Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C233D00D6
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jul 2021 19:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhGTRGm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jul 2021 13:06:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:17000 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231493AbhGTRGk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Jul 2021 13:06:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="211016680"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="211016680"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 10:47:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="469847757"
Received: from coresw01.iind.intel.com ([10.223.252.64])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jul 2021 10:47:14 -0700
From:   pandith.n@intel.com
To:     Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com, kris.pan@intel.com,
        mallikarjunappa.sangannavar@intel.com, Srikanth.Thokala@intel.com,
        Pandith N <pandith.n@intel.com>
Subject: [PATCH V4 0/3] dmaengine: dw-axi-dmac: support parallel memory <--> peripheral transfers
Date:   Tue, 20 Jul 2021 23:17:10 +0530
Message-Id: <20210720174713.13282-1-pandith.n@intel.com>
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

Changes in v3:
Patch 1: Added description for hardware handshake settings

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

