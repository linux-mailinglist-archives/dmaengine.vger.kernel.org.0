Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12BE22A417
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jul 2020 03:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbgGWA7X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jul 2020 20:59:23 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60862 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387457AbgGWA66 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jul 2020 20:58:58 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 3F9AA8030816;
        Thu, 23 Jul 2020 00:58:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Yf9c7L0uX4Av; Thu, 23 Jul 2020 03:58:50 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v8 01/10] dt-bindings: dma: dw: Convert DW DMAC to DT binding
Date:   Thu, 23 Jul 2020 03:58:39 +0300
Message-ID: <20200723005848.31907-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200723005848.31907-1-Sergey.Semin@baikalelectronics.ru>
References: <20200723005848.31907-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Modern device tree bindings are supposed to be created as YAML-files
in accordance with dt-schema. This commit replaces the Synopsis
Designware DMA controller legacy bare text bindings with YAML file.
The only required prorties are "compatible", "reg", "#dma-cells" and
"interrupts", which will be used by the driver to correctly find the
controller memory region and handle its events. The rest of the properties
are optional, since in case if either "dma-channels" or "dma-masters" isn't
specified, the driver will attempt to auto-detect the IP core
configuration.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

---

Changelog v2:
- Rearrange SoBs.
- Move $ref to the root level of the properties. So do do with the
  constraints.
- Discard default settings defined out of the property enum constraint.
- Replace "additionalProperties: false" with "unevaluatedProperties: false"
  property.
- Remove a label definition from the binding example.
---
 .../bindings/dma/snps,dma-spear1340.yaml      | 161 ++++++++++++++++++
 .../devicetree/bindings/dma/snps-dma.txt      |  69 --------
 2 files changed, 161 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/snps-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
new file mode 100644
index 000000000000..e7611840a7cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
@@ -0,0 +1,161 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/snps,dma-spear1340.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys Designware DMA Controller
+
+maintainers:
+  - Viresh Kumar <vireshk@kernel.org>
+  - Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    const: snps,dma-spear1340
+
+  "#dma-cells":
+    const: 3
+    description: |
+      First cell is a phandle pointing to the DMA controller. Second one is
+      the DMA request line number. Third cell is the memory master identifier
+      for transfers on dynamically allocated channel. Fourth cell is the
+      peripheral master identifier for transfers on an allocated channel.
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    description: AHB interface reference clock.
+    const: hclk
+
+  dma-channels:
+    description: |
+      Number of DMA channels supported by the controller. In case if
+      not specified the driver will try to auto-detect this and
+      the rest of the optional parameters.
+    minimum: 1
+    maximum: 8
+
+  dma-requests:
+    minimum: 1
+    maximum: 16
+
+  dma-masters:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description: |
+      Number of DMA masters supported by the controller. In case if
+      not specified the driver will try to auto-detect this and
+      the rest of the optional parameters.
+    minimum: 1
+    maximum: 4
+
+  chan_allocation_order:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description: |
+      DMA channels allocation order specifier. Zero means ascending order
+      (first free allocated), while one - descending (last free allocated).
+    default: 0
+    enum: [0, 1]
+
+  chan_priority:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description: |
+      DMA channels priority order. Zero means ascending channels priority
+      so the very first channel has the highest priority. While 1 means
+      descending priority (the last channel has the highest priority).
+    default: 0
+    enum: [0, 1]
+
+  block_size:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description: Maximum block size supported by the DMA controller.
+    enum: [3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095]
+
+  data-width:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: Data bus width per each DMA master in bytes.
+    items:
+      maxItems: 4
+      items:
+        enum: [4, 8, 16, 32]
+
+  data_width:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    deprecated: true
+    description: |
+      Data bus width per each DMA master in (2^n * 8) bits. This property is
+      deprecated. It' usage is discouraged in favor of data-width one. Moreover
+      the property incorrectly permits to define data-bus width of 8 and 16
+      bits, which is impossible in accordance with DW DMAC IP-core data book.
+    items:
+      maxItems: 4
+      items:
+        enum:
+          - 0 # 8 bits
+          - 1 # 16 bits
+          - 2 # 32 bits
+          - 3 # 64 bits
+          - 4 # 128 bits
+          - 5 # 256 bits
+        default: 0
+
+  multi-block:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      LLP-based multi-block transfer supported by hardware per
+      each DMA channel.
+    items:
+      maxItems: 8
+      items:
+        enum: [0, 1]
+        default: 1
+
+  snps,dma-protection-control:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description: |
+      Bits one-to-one passed to the AHB HPROT[3:1] bus. Each bit setting
+      indicates the following features: bit 0 - privileged mode,
+      bit 1 - DMA is bufferable, bit 2 - DMA is cacheable.
+    default: 0
+    minimum: 0
+    maximum: 7
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - "#dma-cells"
+  - reg
+  - interrupts
+
+examples:
+  - |
+    dma-controller@fc000000 {
+      compatible = "snps,dma-spear1340";
+      reg = <0xfc000000 0x1000>;
+      interrupt-parent = <&vic1>;
+      interrupts = <12>;
+
+      dma-channels = <8>;
+      dma-requests = <16>;
+      dma-masters = <4>;
+      #dma-cells = <3>;
+
+      chan_allocation_order = <1>;
+      chan_priority = <1>;
+      block_size = <0xfff>;
+      data-width = <8 8>;
+      multi-block = <0 0 0 0 0 0 0 0>;
+      snps,max-burst-len = <16 16 4 4 4 4 4 4>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/dma/snps-dma.txt b/Documentation/devicetree/bindings/dma/snps-dma.txt
deleted file mode 100644
index 0bedceed1963..000000000000
--- a/Documentation/devicetree/bindings/dma/snps-dma.txt
+++ /dev/null
@@ -1,69 +0,0 @@
-* Synopsys Designware DMA Controller
-
-Required properties:
-- compatible: "snps,dma-spear1340"
-- reg: Address range of the DMAC registers
-- interrupt: Should contain the DMAC interrupt number
-- dma-channels: Number of channels supported by hardware
-- dma-requests: Number of DMA request lines supported, up to 16
-- dma-masters: Number of AHB masters supported by the controller
-- #dma-cells: must be <3>
-- chan_allocation_order: order of allocation of channel, 0 (default): ascending,
-  1: descending
-- chan_priority: priority of channels. 0 (default): increase from chan 0->n, 1:
-  increase from chan n->0
-- block_size: Maximum block size supported by the controller
-- data-width: Maximum data width supported by hardware per AHB master
-  (in bytes, power of 2)
-
-
-Deprecated properties:
-- data_width: Maximum data width supported by hardware per AHB master
-  (0 - 8bits, 1 - 16bits, ..., 5 - 256bits)
-
-
-Optional properties:
-- multi-block: Multi block transfers supported by hardware. Array property with
-  one cell per channel. 0: not supported, 1 (default): supported.
-- snps,dma-protection-control: AHB HPROT[3:1] protection setting.
-  The default value is 0 (for non-cacheable, non-buffered,
-  unprivileged data access).
-  Refer to include/dt-bindings/dma/dw-dmac.h for possible values.
-
-Example:
-
-	dmahost: dma@fc000000 {
-		compatible = "snps,dma-spear1340";
-		reg = <0xfc000000 0x1000>;
-		interrupt-parent = <&vic1>;
-		interrupts = <12>;
-
-		dma-channels = <8>;
-		dma-requests = <16>;
-		dma-masters = <2>;
-		#dma-cells = <3>;
-		chan_allocation_order = <1>;
-		chan_priority = <1>;
-		block_size = <0xfff>;
-		data-width = <8 8>;
-	};
-
-DMA clients connected to the Designware DMA controller must use the format
-described in the dma.txt file, using a four-cell specifier for each channel.
-The four cells in order are:
-
-1. A phandle pointing to the DMA controller
-2. The DMA request line number
-3. Memory master for transfers on allocated channel
-4. Peripheral master for transfers on allocated channel
-
-Example:
-	
-	serial@e0000000 {
-		compatible = "arm,pl011", "arm,primecell";
-		reg = <0xe0000000 0x1000>;
-		interrupts = <0 35 0x4>;
-		dmas = <&dmahost 12 0 1>,
-			<&dmahost 13 1 0>;
-		dma-names = "rx", "rx";
-	};
-- 
2.26.2

