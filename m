Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B4A48C6E9
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jan 2022 16:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354489AbiALPP6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jan 2022 10:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354491AbiALPPu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jan 2022 10:15:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D842AC06175E
        for <dmaengine@vger.kernel.org>; Wed, 12 Jan 2022 07:15:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1n7fLj-00031L-QU; Wed, 12 Jan 2022 16:15:44 +0100
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mtr@pengutronix.de>)
        id 1n7fLj-009ufS-ES; Wed, 12 Jan 2022 16:15:42 +0100
Received: from mtr by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mtr@pengutronix.de>)
        id 1n7fLh-005Zfx-HO; Wed, 12 Jan 2022 16:15:41 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com,
        m.tretter@pengutronix.de, kernel@pengutronix.de
Subject: [PATCH 1/3] dt-bindings: dmaengine: zynqmp_dma: convert to yaml
Date:   Wed, 12 Jan 2022 16:15:39 +0100
Message-Id: <20220112151541.1328732-2-m.tretter@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220112151541.1328732-1-m.tretter@pengutronix.de>
References: <20220112151541.1328732-1-m.tretter@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the Xilinx ZynqMP DMA engine bindings to Yaml.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 .../dma/xilinx/xlnx,zynqmp-dma-1.0.yaml       | 85 +++++++++++++++++++
 .../bindings/dma/xilinx/zynqmp_dma.txt        | 26 ------
 2 files changed, 85 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
new file mode 100644
index 000000000000..c0a1408b12ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx ZynqMP DMA Engine
+
+description: |
+  The Xilinx ZynqMP DMA engine supports memory to memory transfers,
+  memory to device and device to memory transfers. It also has flow
+  control and rate control support for slave/peripheral dma access.
+
+maintainers:
+  - Michael Tretter <m.tretter@pengutronix.de>
+
+allOf:
+  - $ref: "../dma-controller.yaml#"
+
+properties:
+  "#dma-cells":
+    const: 1
+
+  compatible:
+    const: xlnx,zynqmp-dma-1.0
+
+  reg:
+    description: memory map for gdma/adma module access
+    maxItems: 1
+
+  interrupts:
+    description: DMA channel interrupt
+    maxItems: 1
+
+  clocks:
+    description: input clocks
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: clk_main
+      - const: clk_apb
+
+  xlnx,bus-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 64
+      - 128
+    description: AXI bus width in bits
+
+  iommus:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  dma-coherent:
+    description: present if dma operations are coherent
+
+required:
+  - "#dma-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
+
+    fpd_dma_chan1: dma-controller@fd500000 {
+      compatible = "xlnx,zynqmp-dma-1.0";
+      reg = <0xfd500000 0x1000>;
+      interrupt-parent = <&gic>;
+      interrupts = <0 117 0x4>;
+      #dma-cells = <1>;
+      clock-names = "clk_main", "clk_apb";
+      clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
+      xlnx,bus-width = <128>;
+      dma-coherent;
+    };
diff --git a/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
deleted file mode 100644
index 07a5a7aa9ea0..000000000000
--- a/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Xilinx ZynqMP DMA engine, it does support memory to memory transfers,
-memory to device and device to memory transfers. It also has flow
-control and rate control support for slave/peripheral dma access.
-
-Required properties:
-- compatible		: Should be "xlnx,zynqmp-dma-1.0"
-- reg			: Memory map for gdma/adma module access.
-- interrupts		: Should contain DMA channel interrupt.
-- xlnx,bus-width	: Axi buswidth in bits. Should contain 128 or 64
-- clock-names		: List of input clocks "clk_main", "clk_apb"
-			  (see clock bindings for details)
-
-Optional properties:
-- dma-coherent		: Present if dma operations are coherent.
-
-Example:
-++++++++
-fpd_dma_chan1: dma@fd500000 {
-	compatible = "xlnx,zynqmp-dma-1.0";
-	reg = <0x0 0xFD500000 0x1000>;
-	interrupt-parent = <&gic>;
-	interrupts = <0 117 4>;
-	clock-names = "clk_main", "clk_apb";
-	xlnx,bus-width = <128>;
-	dma-coherent;
-};
-- 
2.30.2

