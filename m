Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEAA2B01AD
	for <lists+dmaengine@lfdr.de>; Thu, 12 Nov 2020 10:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgKLJHm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Nov 2020 04:07:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:53006 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbgKLJHG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 12 Nov 2020 04:07:06 -0500
IronPort-SDR: Vs4DCp9DHQqemVuk52JSlwvgunoUw9UsSX/pxaA0z1a1daigf/nQ56w+9WnSRg+tsZLn9rk31E
 /rOXOjHzAmXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="166773091"
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="166773091"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 01:06:50 -0800
IronPort-SDR: YTie2YsUR/34PBBfu7jwrjyyaDUt75n3gxIYSt2IhqaTtvdREuwZSVCkyskJAI52gRQb19cxnm
 tYwm20PPaU3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="360911709"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by fmsmga002.fm.intel.com with ESMTP; 12 Nov 2020 01:06:48 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 10/15] dt-binding: dma: dw-axi-dmac: Add support for Intel KeemBay AxiDMA
Date:   Thu, 12 Nov 2020 16:49:48 +0800
Message-Id: <20201112084953.21629-11-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201112084953.21629-1-jee.heng.sia@intel.com>
References: <20201112084953.21629-1-jee.heng.sia@intel.com>
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
index 481ef0dacf5f..18e9422095bb 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -8,6 +8,7 @@ title: Synopsys DesignWare AXI DMA Controller
 
 maintainers:
   - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com
+  - Jee Heng Sia <jee.heng.sia@intel.com>
 
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
@@ -124,3 +127,25 @@ examples:
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

