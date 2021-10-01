Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D3841EF2D
	for <lists+dmaengine@lfdr.de>; Fri,  1 Oct 2021 16:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhJAOOf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Oct 2021 10:14:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:11422 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231438AbhJAOOe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 1 Oct 2021 10:14:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="248005302"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="248005302"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 07:08:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="480470550"
Received: from coresw01.iind.intel.com ([10.106.46.194])
  by fmsmga007.fm.intel.com with ESMTP; 01 Oct 2021 07:08:13 -0700
From:   pandith.n@intel.com
To:     vkoul@kernel.org, eugeniy.paltsev@synopsys.com,
        dmaengine@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com,
        mallikarjunappa.sangannavar@intel.com, srikanth.thokala@intel.com,
        kenchappa.demakkanavar@intel.com, Pandith N <pandith.n@intel.com>
Subject: [PATCH V3 0/3] Add DMA support for transfers in multiple cases
Date:   Fri,  1 Oct 2021 19:38:09 +0530
Message-Id: <20211001140812.24977-1-pandith.n@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Pandith N <pandith.n@intel.com>

This series adds dma support in following transfers
mem2mem: set dma coherent mask
mem2per: memory to peripheral with hardware handshake control, when APB
register extension is not provided.
per2mem: peripheral to memory with hardware handshake control, when APB
register extnesion is not provided

Support DMAX_NUM_CHANNELS > 8
--------------------------------------------
Depending on number of channels the register map changes in DMAC.
DMA driver now supports both register maps based of number of
channels used in platform.

Setting hardware handshake for peripheral transfers
-----------------------------------------------------------------------
mem2per and per2mem transfers are supported with hardware handshake
control, without apb register extension.

setting dma coherent mask
--------------------------------------------------
Added 64-bit dma coherent mask setting

Pandith N (3):
  dmaengine: dw-axi-dmac: support DMAX_NUM_CHANNELS > 8
  dmaengine: dw-axi-dmac: Hardware handshake configuration
  dmaengine: dw-axi-dmac: set coherent mask

 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 113 +++++++++++++-----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  35 +++++-
 2 files changed, 117 insertions(+), 31 deletions(-)

-- 
2.17.1

