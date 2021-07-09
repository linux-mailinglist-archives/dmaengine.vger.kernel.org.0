Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1793C21D1
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jul 2021 11:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhGIJxq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Jul 2021 05:53:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:54426 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhGIJxq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 9 Jul 2021 05:53:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="295316489"
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="295316489"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 02:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="498856267"
Received: from coresw01.iind.intel.com ([10.223.252.64])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jul 2021 02:51:00 -0700
From:   pandith.n@intel.com
To:     Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com, kris.pan@intel.com,
        mallikarjunappa.sangannavar@intel.com, Srikanth.Thokala@intel.com,
        Pandith N <pandith.n@intel.com>
Subject: [linux-drivers-review] [PATCH V2 0/1] dmaengine: dw-axi-dmac: support parallel memory <--> peripheral transfers
Date:   Fri,  9 Jul 2021 15:20:59 +0530
Message-Id: <20210709095059.26805-1-pandith.n@intel.com>
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
src_per/dst_per of CHx_CFG register.

The changes are validated with parallel SPI transmit and receive
transfers in dma mode.

Pandith N (1):
  dmaengine: dw-axi-dmac: support parallel memory <--> peripheral
    transfers

 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 56 +++++++++----------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  4 ++
 2 files changed, 29 insertions(+), 31 deletions(-)

-- 
2.17.1

