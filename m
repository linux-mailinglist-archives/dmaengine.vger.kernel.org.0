Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7840A167779
	for <lists+dmaengine@lfdr.de>; Fri, 21 Feb 2020 09:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgBUHwj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Feb 2020 02:52:39 -0500
Received: from mx.socionext.com ([202.248.49.38]:51003 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729929AbgBUHwi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 Feb 2020 02:52:38 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 21 Feb 2020 16:52:37 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 04C8D18008C;
        Fri, 21 Feb 2020 16:52:38 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 21 Feb 2020 16:52:37 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 45B2F1A01BB;
        Fri, 21 Feb 2020 16:52:37 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [RESEND PATCH v4 1/2] dt-bindings: dmaengine: Add UniPhier external DMA controller bindings
Date:   Fri, 21 Feb 2020 16:52:29 +0900
Message-Id: <1582271550-3403-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582271550-3403-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1582271550-3403-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add devicetree binding documentation for external DMA controller
implemented on Socionext UniPhier SOCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/dma/socionext,uniphier-xdmac.yaml     | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml

diff --git a/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml b/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
new file mode 100644
index 00000000..86cfb59
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/socionext,uniphier-xdmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier external DMA controller
+
+description: |
+  This describes the devicetree bindings for an external DMA engine to perform
+  memory-to-memory or peripheral-to-memory data transfer capable of supporting
+  16 channels, implemented in Socionext UniPhier SoCs.
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    const: socionext,uniphier-xdmac
+
+  reg:
+    items:
+      - description: XDMAC base register region (offset and length)
+      - description: XDMAC extension register region (offset and length)
+
+  interrupts:
+    maxItems: 1
+
+  "#dma-cells":
+    const: 2
+    description: |
+      DMA request from clients consists of 2 cells:
+        1. Channel index
+        2. Transfer request factor number, If no transfer factor, use 0.
+           The number is SoC-specific, and this should be specified with
+           relation to the device to use the DMA controller.
+
+  dma-channels:
+    minimum: 1
+    maximum: 16
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#dma-cells"
+
+examples:
+  - |
+    xdmac: dma-controller@5fc10000 {
+        compatible = "socionext,uniphier-xdmac";
+        reg = <0x5fc10000 0x1000>, <0x5fc20000 0x800>;
+        interrupts = <0 188 4>;
+        #dma-cells = <2>;
+        dma-channels = <16>;
+    };
+
+...
-- 
2.7.4

