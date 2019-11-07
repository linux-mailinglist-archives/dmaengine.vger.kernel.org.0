Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D6AF2510
	for <lists+dmaengine@lfdr.de>; Thu,  7 Nov 2019 03:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfKGCOQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Nov 2019 21:14:16 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:47154 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfKGCOQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Nov 2019 21:14:16 -0500
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 09AD171D;
        Thu,  7 Nov 2019 03:14:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1573092854;
        bh=S943AS8Ob1c2aizF9GpXR7oTAO4Kwu6nZZdaD86WIXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNsMLhJGn85VvpPcluDXOM7zSWAefZinqAVe+1IJoiwyc74U+Uy65PAP+ma4F//0K
         w7FVOlFtstRS4Nq6d6BlL47x+7hyhc2D5TolJAdeP00Mssytr+YowJOXQElf83EN2e
         3XCJiBr45NICjtNFNQsdTh3/gkI+6qID7ewuv8Xo=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/4] dt: bindings: dma: xilinx: dpdma: DT bindings for Xilinx DPDMA
Date:   Thu,  7 Nov 2019 04:13:57 +0200
Message-Id: <20191107021400.16474-2-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191107021400.16474-1-laurent.pinchart@ideasonboard.com>
References: <20191107021400.16474-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The ZynqMP includes the DisplayPort subsystem with its own DMA engine
called DPDMA. The DPDMA IP comes with 6 individual channels
(4 for display, 2 for audio). This documentation describes DT bindings
of DPDMA.

Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes since v1:

- Convert the DT bindings to YAML
- Drop the DT child nodes
---
 .../dma/xilinx/xlnx,zynqmp-dpdma.yaml         | 68 +++++++++++++++++++
 MAINTAINERS                                   |  8 +++
 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h   | 16 +++++
 3 files changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
 create mode 100644 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
new file mode 100644
index 000000000000..b677b2c4f302
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/xlnx,zynqmp-dpdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx ZynqMP DisplayPort DMA Controller Device Tree Bindings
+
+description: |
+  These bindings describe the DMA engine included in the Xilinx ZynqMP
+  DisplayPort Subsystem. The DMA engine supports up to 6 DMA channels (3
+  channels for a video stream, 1 channel for a graphics stream, and 2 channels
+  for an audio stream).
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  "#dma-cells":
+    const: 1
+    description: |
+      The cell is the DMA channel ID (see dt-bindings/dma/xlnx-zynqmp-dpdma.h
+      for a list of channel IDs).
+
+  compatible:
+    const: xlnx,zynqmp-dpdma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description: The AXI clock
+    maxItems: 1
+
+  clock-names:
+    const: axi_clk
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
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    dma: dma-controller@fd4c0000 {
+      compatible = "xlnx,zynqmp-dpdma";
+      reg = <0x0 0xfd4c0000 0x0 0x1000>;
+      interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-parent = <&gic>;
+      clocks = <&dpdma_clk>;
+      clock-names = "axi_clk";
+      #dma-cells = <1>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index cba1095547fd..457b39bc2320 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17898,6 +17898,14 @@ F:	drivers/misc/Kconfig
 F:	drivers/misc/Makefile
 F:	include/uapi/misc/xilinx_sdfec.h
 
+XILINX ZYNQMP DPDMA DRIVER
+M:	Hyun Kwon <hyun.kwon@xilinx.com>
+M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+L:	dmaengine@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
+F:	include/dt-bindings/dma/xlnx-zynqmp-dpdma.h
+
 XILLYBUS DRIVER
 M:	Eli Billauer <eli.billauer@gmail.com>
 L:	linux-kernel@vger.kernel.org
diff --git a/include/dt-bindings/dma/xlnx-zynqmp-dpdma.h b/include/dt-bindings/dma/xlnx-zynqmp-dpdma.h
new file mode 100644
index 000000000000..3719cda5679d
--- /dev/null
+++ b/include/dt-bindings/dma/xlnx-zynqmp-dpdma.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright 2019 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ */
+
+#ifndef __DT_BINDINGS_DMA_XLNX_ZYNQMP_DPDMA_H__
+#define __DT_BINDINGS_DMA_XLNX_ZYNQMP_DPDMA_H__
+
+#define ZYNQMP_DPDMA_VIDEO0		0
+#define ZYNQMP_DPDMA_VIDEO1		1
+#define ZYNQMP_DPDMA_VIDEO2		2
+#define ZYNQMP_DPDMA_GRAPHICS		3
+#define ZYNQMP_DPDMA_AUDIO0		4
+#define ZYNQMP_DPDMA_AUDIO1		5
+
+#endif /* __DT_BINDINGS_DMA_XLNX_ZYNQMP_DPDMA_H__ */
-- 
Regards,

Laurent Pinchart

