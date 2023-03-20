Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362EB6C0BDF
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 09:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjCTIN0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 04:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjCTINY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 04:13:24 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E04B18B1F;
        Mon, 20 Mar 2023 01:13:13 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 32K7v6wg088828;
        Mon, 20 Mar 2023 15:57:06 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from Chiawei-PC03.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 20 Mar
 2023 16:11:38 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <pmenzel@molgen.mpg.de>,
        <ilpo.jarvinen@linux.intel.com>, <hdanton@sina.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <openbmc@lists.ozlabs.org>
Subject: [PATCH v3 2/5] dt-bindings: dmaengine: Add AST2600 UDMA bindings
Date:   Mon, 20 Mar 2023 16:11:30 +0800
Message-ID: <20230320081133.23655-3-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320081133.23655-1-chiawei_wang@aspeedtech.com>
References: <20230320081133.23655-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 32K7v6wg088828
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the dmaengine bindings for the UART DMA engine of Aspeed AST2600 SoC.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 .../bindings/dma/aspeed,ast2600-udma.yaml     | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml

diff --git a/Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml b/Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml
new file mode 100644
index 000000000000..4c0a5edf2168
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/aspeed,ast2600-udma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed AST2600 UART DMA controller
+
+maintainers:
+  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
+
+description:
+  The Aspeed AST2600 UDMA controller provides direct memory access capabilities
+  for the NS16550A-compatible UART devices inside AST2600 SoCs. UDMA supports 28
+  DMA channels and each UART device has its dedicated pair of TX and RX channels.
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    const: aspeed,ast2600-udma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#dma-cells":
+    const: 1
+
+  dma-channels:
+    maximum: 28
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#dma-cells"
+  - dma-channels
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    dma-controller@1e79e000 {
+        compatible = "aspeed,ast2600-udma";
+        reg = <0x1e79e000 0x1000>;
+        interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+        dma-channels = <28>;
+        #dma-cells = <1>;
+    };
+
+...
-- 
2.25.1

