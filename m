Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBA62D6D03
	for <lists+dmaengine@lfdr.de>; Fri, 11 Dec 2020 02:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394149AbgLKBGC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Dec 2020 20:06:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:12004 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394247AbgLKBFh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 10 Dec 2020 20:05:37 -0500
IronPort-SDR: RZ/3l2udMze6BkyFefRTE0IOgscc6SUKXnDVD28eHKmFDsyKNr35rhjqePaDbkdGGMME/BcR2z
 IS9OjWrSV4Ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="173596129"
X-IronPort-AV: E=Sophos;i="5.78,409,1599548400"; 
   d="scan'208";a="173596129"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 17:04:44 -0800
IronPort-SDR: khEew5XA5X/50Kyz3IhmxKPDyGDLjUXwFwB3tZzWQNCWTkYNRqnt9qytJI08e8s4/5xvALfCoo
 2qNXHlVy4F4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,409,1599548400"; 
   d="scan'208";a="320965853"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by fmsmga007.fm.intel.com with ESMTP; 10 Dec 2020 17:04:42 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 10/16] dt-binding: dma: dw-axi-dmac: Add support for Intel KeemBay AxiDMA
Date:   Fri, 11 Dec 2020 08:46:36 +0800
Message-Id: <20201211004642.25393-11-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201211004642.25393-1-jee.heng.sia@intel.com>
References: <20201211004642.25393-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for Intel KeemBay AxiDMA to the dw-axi-dmac
Schemas DT binding.

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 61ad37a3f559..6f6791238673 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -8,6 +8,7 @@ title: Synopsys DesignWare AXI DMA Controller
 
 maintainers:
   - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
+  - Jee Heng Sia <jee.heng.sia@intel.com>
 
 description:
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
-- 
2.18.0

