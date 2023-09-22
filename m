Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8937AAEB8
	for <lists+dmaengine@lfdr.de>; Fri, 22 Sep 2023 11:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjIVJuP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Sep 2023 05:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjIVJuO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Sep 2023 05:50:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE80291;
        Fri, 22 Sep 2023 02:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695376205; x=1726912205;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zeipEBhaXghXmN5oGpPDW5qjunGQZm56YlJ7LLJ5W1Q=;
  b=ErI2UfqrnnV+XETjH//ImB4B6Fbl8G56qm7WhmQXJtkF9Ma7fkx7Jl4x
   8MX2WBzGdi5OKOrAAJZxqnELWFYU34pQsekbyV5VeSFAQwG8Y/CThwaic
   /1UMQF+bFstHVcfa26ITgLhheh2qXey3uDJR/1vT93cRYVR/7FegEsWuL
   Z3EzuDjmJjfSmKI1BOA+ROAg1+bx5lKAMwfjRNc+FDRiCEq2WYeoDTLld
   hee0zCwetjGffmQ5H+j5qeX++5vVLGBDgBORAqb6La8EJqNy1yDBGBJWF
   iTLGnTx58ym7ryTiw8CWbGyAvMrNElM2UoWLcylUWeAOF7O26OThncKpV
   g==;
X-CSE-ConnectionGUID: fQsQIPFwSuS+RkzQs9lxqw==
X-CSE-MsgGUID: ce4PFu03SpK2T9raFQWtFg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="236602553"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2023 02:50:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 22 Sep 2023 02:49:57 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 22 Sep 2023 02:49:52 -0700
From:   shravan chippa <shravan.chippa@microchip.com>
To:     <green.wan@sifive.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <conor+dt@kernel.org>,
        <palmer@sifive.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasuresh.relli@microchip.com>, <praveen.kumar@microchip.com>,
        <shravan.chippa@microchip.com>
Subject: [PATCH v1 0/3] dma: sf-pdma: various sf-pdma updates for the mpfs platform
Date:   Fri, 22 Sep 2023 15:20:36 +0530
Message-ID: <20230922095039.74878-1-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

This series does the following
1. Adds a PolarFire SoC specific compatible and code to support for
out-of-order dma transfers 

2. Adds generic device tree bindings support by using 
of_dma_controller_register()

Shravan Chippa (3):
  dmaengine: sf-pdma: Support of_dma_controller_register()
  dt-bindings: dma: sf-pdma: add new compatible name
  dmaengine: sf-pdma: add mpfs-pdma compatible name

 .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 12 ++--
 drivers/dma/sf-pdma/sf-pdma.c                 | 68 ++++++++++++++++++-
 drivers/dma/sf-pdma/sf-pdma.h                 |  6 ++
 3 files changed, 79 insertions(+), 7 deletions(-)

-- 
2.34.1

