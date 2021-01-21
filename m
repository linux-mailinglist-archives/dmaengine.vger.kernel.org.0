Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C102FE7F2
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jan 2021 11:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbhAUKr4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jan 2021 05:47:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:36494 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729686AbhAUKrn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 21 Jan 2021 05:47:43 -0500
IronPort-SDR: kICdwxpuVQ+VF2GHSSK+uILdcEGahdNiyM6LckO+lb35Hg/vgqBE8dt+/HJN+IOoeI6M1ssMv9
 YA2Y4N1JIOXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="240790294"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="240790294"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 02:45:21 -0800
IronPort-SDR: OaukLqXi0Ng6gM6iSUUedcoC/5le/aTTARURJ03x2bH2CP1qBMlLnHbW2nyh4LF1zlja4zP77+
 pg0CVYJlbg5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="356417670"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jan 2021 02:45:18 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jee.heng.sia@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v11 10/16] dt-binding: dma: dw-axi-dmac: Add support for Intel KeemBay AxiDMA
Date:   Thu, 21 Jan 2021 18:27:20 +0800
Message-Id: <20210121102726.22805-11-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210121102726.22805-1-jee.heng.sia@intel.com>
References: <20210121102726.22805-1-jee.heng.sia@intel.com>
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

