Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5269E29A506
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 07:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506991AbgJ0G4M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 02:56:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:5231 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506996AbgJ0G4L (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 27 Oct 2020 02:56:11 -0400
IronPort-SDR: dbwNbSoC/x+7ehNIkRXIxtnaCxVdGmkHyGnaY+aY7vvCSh6TjT5cAZPxR26yhgi4V1XSJY5m6Y
 U3BbaCQlU7IA==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="147890891"
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="147890891"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 23:56:11 -0700
IronPort-SDR: 9i3AVTxT+FQZP1jHv+OEXXcpnl1GrKuTpr9HZLb7Un01u7cTJWFNRCjOOGY3oLjT+DJCa14XSF
 ake+61telebw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="350175978"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga008.jf.intel.com with ESMTP; 26 Oct 2020 23:56:09 -0700
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/15] dt-binding: dma: dw-axi-dmac: Add support for Intel KeemBay AxiDMA
Date:   Tue, 27 Oct 2020 14:38:54 +0800
Message-Id: <20201027063858.4877-12-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201027063858.4877-1-jee.heng.sia@intel.com>
References: <20201027063858.4877-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for Intel KeemBay AxiDMA to the dw-axi-dmac
Schemas DT binding.

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 .../bindings/dma/snps,dw-axi-dmac.yaml        | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index e688d25864bc..0e9bc5553a36 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -8,6 +8,7 @@ title: Synopsys DesignWare AXI DMA Controller
 
 maintainers:
   - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com
+  - Sia, Jee Heng <jee.heng.sia@intel.com>
 
 description: |
  Synopsys DesignWare AXI DMA Controller DT Binding
@@ -16,6 +17,7 @@ properties:
   compatible:
     enum:
       - snps,axi-dma-1.01a
+      - intel,kmb-axi-dma
 
   reg:
     items:
@@ -24,6 +26,7 @@ properties:
   reg-names:
     items:
       - const: axidma_ctrl_regs
+      - const: axidma_apb_regs
 
   interrupts:
     maxItems: 1
@@ -122,3 +125,25 @@ examples:
          snps,priority = <0 1 2 3>;
          snps,axi-max-burst-len = <16>;
      };
+
+  - |
+     #include <dt-bindings/interrupt-controller/arm-gic.h>
+     #include <dt-bindings/interrupt-controller/irq.h>
+     /* example with intel,kmb-axi-dma */
+     #define KEEM_BAY_PSS_AXI_DMA
+     #define KEEM_BAY_PSS_APB_AXI_DMA
+     axi_dma: dma@28000000 {
+         compatible = "intel,kmb-axi-dma";
+         reg = <0x28000000 0x1000 0x20250000 0x24>;
+         reg-names = "axidma_ctrl_regs", "axidma_apb_regs";
+         interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+         clock-names = "core-clk", "cfgr-clk";
+         clocks = <&scmi_clk KEEM_BAY_PSS_AXI_DMA>, <&scmi_clk KEEM_BAY_PSS_APB_AXI_DMA>;
+         #dma-cells = <1>;
+         dma-channels = <8>;
+         snps,dma-masters = <1>;
+         snps,data-width = <4>;
+         snps,priority = <0 0 0 0 0 0 0 0>;
+         snps,block-size = <1024 1024 1024 1024 1024 1024 1024 1024>;
+         snps,axi-max-burst-len = <16>;
+     };
-- 
2.18.0

