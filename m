Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F39021914F
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2020 22:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgGHUTU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Jul 2020 16:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgGHUTU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Jul 2020 16:19:20 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2753C061A0B
        for <dmaengine@vger.kernel.org>; Wed,  8 Jul 2020 13:19:19 -0700 (PDT)
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EED4298D;
        Wed,  8 Jul 2020 22:19:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594239556;
        bh=cpucIY7jody2CRvnutkZeEThx5BZUhRDM8Me+WqyTlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u9XulcWizt1+bXhryeJfm2QmNlpdkewS6h/zdBDLZLSAHCRbVosdZYoKp3Y1eL8OM
         tAN8+5z+GBx9AJ6aH4NoILAULTJqAxKAyakmnknmRHNtUx0SGoGeV+INwUhBPTqpnW
         m9ASWd8K6HKAIf5nEW//MdMe8IMnpBgETMWw9w3A=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v6 1/6] dt: bindings: dma: xilinx: dpdma: DT bindings for Xilinx DPDMA
Date:   Wed,  8 Jul 2020 23:19:01 +0300
Message-Id: <20200708201906.4546-2-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708201906.4546-1-laurent.pinchart@ideasonboard.com>
References: <20200708201906.4546-1-laurent.pinchart@ideasonboard.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since v2:

- Fix id URL
- Fix path to dma-controller.yaml
- Update license to GPL-2.0-only OR BSD-2-Clause

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
index 000000000000..5de510f8c88c
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/xilinx/xlnx,zynqmp-dpdma.yaml#
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
+  - $ref: "../dma-controller.yaml#"
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
index 68f21d46614c..fa52d4f9f8c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18852,6 +18852,14 @@ F:	Documentation/devicetree/bindings/media/xilinx/
 F:	drivers/media/platform/xilinx/
 F:	include/uapi/linux/xilinx-v4l2-controls.h
 
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

