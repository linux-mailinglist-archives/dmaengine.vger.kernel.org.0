Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219632DB90B
	for <lists+dmaengine@lfdr.de>; Wed, 16 Dec 2020 03:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgLPC2D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Dec 2020 21:28:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:26382 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgLPC2C (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Dec 2020 21:28:02 -0500
IronPort-SDR: r2wVOrtV3PgaU1AxP9his+xaACv8l+vV3bLCvlvJaRe1231TMwb6RRdYm8PiLJ1RAUbCC0G7EB
 933TGSECKK1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="259716467"
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="259716467"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 18:27:09 -0800
IronPort-SDR: p1bu+TNnzaIikxpv27R8G4XEQRpAe+nKuCxkjUd9mtgyIJrI2FXdpDNXTx90wTnHLDJqv6Dj4b
 jBnx78QJjV+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="557080804"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga005.jf.intel.com with ESMTP; 15 Dec 2020 18:27:07 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 10/16] dt-binding: dma: dw-axi-dmac: Add support for Intel KeemBay AxiDMA
Date:   Wed, 16 Dec 2020 10:09:57 +0800
Message-Id: <20201216021003.26911-11-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201216021003.26911-1-jee.heng.sia@intel.com>
References: <20201216021003.26911-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for Intel KeemBay AxiDMA to the dw-axi-dmac
Schemas DT binding.

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 3d2515463d56..79e241498e25 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -8,6 +8,7 @@ title: Synopsys DesignWare AXI DMA Controller
 
 maintainers:
   - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
+  - Jee Heng Sia <jee.heng.sia@intel.com>
 
 description:
   Synopsys DesignWare AXI DMA Controller DT Binding
@@ -19,14 +20,18 @@ properties:
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
-- 
2.18.0

