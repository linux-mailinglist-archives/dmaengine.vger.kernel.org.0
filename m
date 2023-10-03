Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAA77B5FCA
	for <lists+dmaengine@lfdr.de>; Tue,  3 Oct 2023 06:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjJCEVr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Oct 2023 00:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239033AbjJCEVq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Oct 2023 00:21:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D44BE0;
        Mon,  2 Oct 2023 21:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696306903; x=1727842903;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yt9kur5BOK9zz99nEWYdw3rGi4a4apiDmhvaQ22Y6sY=;
  b=lOF4gZ4PxuCNQm/C1OCbMTBK8PKTlIHwFAShl3y0FLHO1dFI4WehDM2Z
   yhltPYF0vutz0tBtR0pqXykuZhHhRmPZtyGJEh3a0Rqx2qH0suXP2hpk9
   Kn8b4LGuvLkrX7+gi2TvtQ3RjIsCYIb6wS5X9HHydDjvHr/6sZAelQxmF
   xEKzLm6RJ6vDcEDWAvDMLOP9mKWWkdWE+HIYrKip5diz3vkTireTQsMwH
   3L4GmmIaa7IaTCiKrktTubr2g86Rx+06nZR8wEtkp+Orse7WLRl5MNeY4
   yNMobi5jvkKALs16AkQgBJZGY1OHcgD6YspK3EZdNrPQJXFZwSbMQmnsE
   w==;
X-CSE-ConnectionGUID: TaAzhFjkR5qC5aGoP7QXJg==
X-CSE-MsgGUID: zqmCeQghSHe8/3PhYhlj8A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="7783646"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2023 21:21:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 2 Oct 2023 21:21:00 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 2 Oct 2023 21:20:55 -0700
From:   shravan chippa <shravan.chippa@microchip.com>
To:     <green.wan@sifive.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <conor+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasuresh.relli@microchip.com>, <praveen.kumar@microchip.com>,
        <shravan.chippa@microchip.com>
Subject: [PATCH v2 0/4] dma: sf-pdma: various sf-pdma updates for the mpfs platform
Date:   Tue, 3 Oct 2023 09:52:11 +0530
Message-ID: <20231003042215.142678-1-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

Changes from V1 -> V2:

Removed internal review tags
Commit massages modified.
Added devicetree patch with new compatible name for mpfs platform
Added of_dma_controller_free() clenup call in sf_pdma_remove() function


V1:

This series does the following
1. Adds a PolarFire SoC specific compatible and code to support for
out-of-order dma transfers 

2. Adds generic device tree bindings support by using 
of_dma_controller_register()

Shravan Chippa (4):
  dmaengine: sf-pdma: Support of_dma_controller_register()
  dt-bindings: dma: sf-pdma: add new compatible name
  dmaengine: sf-pdma: add mpfs-pdma compatible name
  riscv: dts: microchip: add specific compatible for mpfs' pdma

 .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 12 ++--
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |  2 +-
 drivers/dma/sf-pdma/sf-pdma.c                 | 71 ++++++++++++++++++-
 drivers/dma/sf-pdma/sf-pdma.h                 |  6 ++
 4 files changed, 83 insertions(+), 8 deletions(-)

-- 
2.34.1

