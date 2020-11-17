Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA8B2B56E9
	for <lists+dmaengine@lfdr.de>; Tue, 17 Nov 2020 03:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgKQCjO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Nov 2020 21:39:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:52576 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbgKQCjN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Nov 2020 21:39:13 -0500
IronPort-SDR: Qt9v/5aQEBdpW1ZGxV0HSofoA98qmhePJ0+wGTJPSIgkUlTxAxAyzQWRTp/NAkcaLGaS2AEdTf
 9zu/lkyTPW+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="168274087"
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="168274087"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 18:39:09 -0800
IronPort-SDR: hHc9YKCt/iFsIyNoda4xjUL6hMSwl6SFP2vHWOpnvgmSJOW22UnREo4DMN0qLqbCp9IXXQGD+Y
 nuZgJ7XNGKYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="358706112"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by fmsmga004.fm.intel.com with ESMTP; 16 Nov 2020 18:39:07 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 10/15] dt-binding: dma: dw-axi-dmac: Add support for Intel KeemBay AxiDMA
Date:   Tue, 17 Nov 2020 10:22:10 +0800
Message-Id: <20201117022215.2461-11-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201117022215.2461-1-jee.heng.sia@intel.com>
References: <20201117022215.2461-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for Intel KeemBay AxiDMA to the dw-axi-dmac
Schemas DT binding.

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 .../bindings/dma/snps,dw-axi-dmac.yaml        | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 6c2e8e612af5..9e3ca9083814 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -8,6 +8,7 @@ title: Synopsys DesignWare AXI DMA Controller
 
 maintainers:
   - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com
+  - Jee Heng Sia <jee.heng.sia@intel.com>
 
 description: |
  Synopsys DesignWare AXI DMA Controller DT Binding
@@ -16,14 +17,18 @@ properties:
   compatible:
     enum:
       - snps,axi-dma-1.01a
+      - intel,kmb-axi-dma
 
   reg:
+    minItems: 1
     items:
       - description: Address range of the DMAC registers
+      - description: Address range of the DMAC APB registers
 
   reg-names:
     items:
       - const: axidma_ctrl_regs
+      - const: axidma_apb_regs
 
   interrupts:
     maxItems: 1
@@ -124,3 +129,25 @@ examples:
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
+         reg = <0x28000000 0x1000>, <0x20250000 0x24>;
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

