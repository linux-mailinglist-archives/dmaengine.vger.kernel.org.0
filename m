Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B1F30206A
	for <lists+dmaengine@lfdr.de>; Mon, 25 Jan 2021 03:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbhAYC03 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 Jan 2021 21:26:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:4255 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbhAYBxJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 24 Jan 2021 20:53:09 -0500
IronPort-SDR: pflPTEGEQznmtV6Cl9UZX7mNZINbCLkc/y8OdznTH2JlDxXbPARjgYKRZ2EI+OCH6v2Zm69DIZ
 7vi1l3k8B/WQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="176137823"
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="176137823"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 17:50:51 -0800
IronPort-SDR: 2Y6I4I56eUkTwxGuWPpg22ZXIweafz98r+HMFkcCfOQ39AvJLkV8Ilt7dVc94Q3Pos1hmsVxDM
 0vuOYyFNj4uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="352795957"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2021 17:50:49 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jee.heng.sia@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v12 10/17] dt-binding: dma: dw-axi-dmac: Add support for Intel KeemBay AxiDMA
Date:   Mon, 25 Jan 2021 09:32:48 +0800
Message-Id: <20210125013255.25799-11-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210125013255.25799-1-jee.heng.sia@intel.com>
References: <20210125013255.25799-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for Intel KeemBay AxiDMA to the dw-axi-dmac
Schemas DT binding.

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
Reviewed-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
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

