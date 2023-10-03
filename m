Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99A97B5FCD
	for <lists+dmaengine@lfdr.de>; Tue,  3 Oct 2023 06:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbjJCEV5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Oct 2023 00:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239033AbjJCEV4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Oct 2023 00:21:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3AECC;
        Mon,  2 Oct 2023 21:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696306915; x=1727842915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oGnYDVYlhxSOhgTr4iUbpKBCV4C+XeuVk7jPWfYQ5Os=;
  b=l3EqC9q5UkcflsMCFPMdOEQMzv2tspleMy1ex3ERDpAhBJZeJ1MPi/T8
   dc9hfjqcW4BU+7RD3bewxYnR3gBXCtGlB9GbXG+fWVNndU2RdV6/Sq+ey
   lMdDzptcqjFZ5lMh8w9ifB0m9Eel6eIZUBWv3f91j5rt+ZOWw13wQF1un
   lEAshkwIZu0HGN0FYXiSKNmBri871mPz74QPf0u1w+B682JyR3j0XS6bh
   HCfd2qQ7v9pxT+3bLhCCyVx8WISz7iTLZEy3PQoA+BK8s2JpDNiCHsRxA
   sNvilyg89aOw3ekJp89AUtOoMmWMTBRBOqnutJ2qd80wpscTvd+pVzsfZ
   g==;
X-CSE-ConnectionGUID: vej+VRO8Q1y2r3o3Bac/dQ==
X-CSE-MsgGUID: 5Ei/Ysn1Q1mgStJD23Cb0A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="238350717"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2023 21:21:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 2 Oct 2023 21:21:29 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 2 Oct 2023 21:21:24 -0700
From:   shravan chippa <shravan.chippa@microchip.com>
To:     <green.wan@sifive.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <conor+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasuresh.relli@microchip.com>, <praveen.kumar@microchip.com>,
        <shravan.chippa@microchip.com>
Subject: [PATCH v2 4/4] riscv: dts: microchip: add specific compatible for mpfs' pdma
Date:   Tue, 3 Oct 2023 09:52:15 +0530
Message-ID: <20231003042215.142678-5-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003042215.142678-1-shravan.chippa@microchip.com>
References: <20231003042215.142678-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

Add specific compatible for PolarFire SoC for The SiFive PDMA driver

Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 104504352e99..05525d5c2c82 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -221,7 +221,7 @@ plic: interrupt-controller@c000000 {
 		};
 
 		pdma: dma-controller@3000000 {
-			compatible = "sifive,fu540-c000-pdma", "sifive,pdma0";
+			compatible = "microchip,mpfs-pdma", "sifive,fu540-c000-pdma";
 			reg = <0x0 0x3000000 0x0 0x8000>;
 			interrupt-parent = <&plic>;
 			interrupts = <5 6>, <7 8>, <9 10>, <11 12>;
-- 
2.34.1

