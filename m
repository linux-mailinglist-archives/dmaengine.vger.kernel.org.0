Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6168125D5A7
	for <lists+dmaengine@lfdr.de>; Fri,  4 Sep 2020 12:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgIDKHR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Sep 2020 06:07:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:2059 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgIDKHR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 4 Sep 2020 06:07:17 -0400
IronPort-SDR: ugMWwF+rjaP/W5iWME3C2UBnA5PpvPAVWdpdNj6qqQ+rJrnsk9+eiOyNBVnUB1tZ8FOe1lGlmI
 +ockzZwJ0rTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="158697555"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="158697555"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 03:07:15 -0700
IronPort-SDR: Aekxys7MSOZd6zoweqMQPc1mPvTRDw3UM6uMCAuArjRWlObFpnoddiPYb02Nyc99ZaRdX+Mxi1
 kfwIzbtwY0MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="342143640"
Received: from unknown (HELO jsia-HP-Z620-Workstation.png.intel.com) ([10.221.118.135])
  by orsmga007.jf.intel.com with ESMTP; 04 Sep 2020 03:07:13 -0700
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     <dmaengine@vger.kernel.org>
Cc:     <vkoul@kernel.org>, <Eugeniy.Paltsev@synopsys.com>,
        <andriy.shevchenko@intel.com>, <jee.heng.sia@intel.com>
Subject: [PATCH 0/4] dmaengine: dw-axi-dmac: Refactor descriptor and channel management
Date:   Fri,  4 Sep 2020 17:51:30 +0800
Message-Id: <1599213094-30144-1-git-send-email-jee.heng.sia@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The below patch series are to support AxiDMA running on Intel KeemBay SoC.
The base driver is dw-axi-dmac but code refactoring is needed to improve
the descriptor management by replacing Linked List Item (LLI) with
virtual descriptor management, only allocate hardware LLI memories from
DMA memory pool, manage DMA memory pool alloc/destroy based on channel
activity and to support device_sync callback.

Note: Intel KeemBay AxiDMA related changes and other DMA features are
to be submitted as we need to get the fundamental changes approved first
prior to add additional DMA features on top.

This patch series are tested on Intel KeemBay platform.

Sia Jee Heng (4):
  dt-bindings: dma: Add YAML schemas for dw-axi-dmac
  dmaengine: dw-axi-dmac: simplify descriptor management
  dmaengine: dw-axi-dmac: move dma_pool_create() to
    alloc_chan_resources()
  dmaengine: dw-axi-dmac: Add device_synchronize() callback

 .../devicetree/bindings/dma/snps,dw-axi-dmac.txt   |  39 -----
 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml  | 124 ++++++++++++++
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     | 190 ++++++++++++---------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h              |  11 +-
 4 files changed, 245 insertions(+), 119 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
 create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml

-- 
1.9.1

