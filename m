Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5023B51155A
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 13:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiD0K4s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 06:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiD0K4q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 06:56:46 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFB928CCFE;
        Wed, 27 Apr 2022 03:32:47 -0700 (PDT)
Received: from relay12.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::232])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id DA3D1CC428;
        Wed, 27 Apr 2022 09:57:38 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A316B200006;
        Wed, 27 Apr 2022 09:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651053418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xGKyCMtEO66T6iVLrz94Fbq22pR8kP+j3m28Y7p/DGQ=;
        b=R3IGtgpyLTIwZXil/fGcslnztLt0cZc9J+bU9Fm9vZFbm3p9c2w0M1K/ZtHpe9kCsNgy1X
        GraK5UyMjTD0G+GYOphQ6nFMA/HOj8AhRv5iqY8+C3dQAdXrw5UFD8b1c8fk7Py/67Fqij
        D5eYTwWoz0n2p2/EPlcOr6cctTvEKCLSpZQsAYWbgXw+zOdyothg+KXeNUSMxlkwJkk3eM
        G2uPx17LLrUB+NGpcWq25+rzqwoV8GXftDDfE/RXy1v/KO/AGQkjPYTCeSrsPHjInefxfB
        KUSCw8eYq0hwVV2uQdZPYCGR3ksM4y5VkD6hBBIWiuOvSnK6go74539FeN1kiA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v12 1/9] dt-bindings: dmaengine: Introduce RZN1 dmamux bindings
Date:   Wed, 27 Apr 2022 11:56:45 +0200
Message-Id: <20220427095653.91804-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220427095653.91804-1-miquel.raynal@bootlin.com>
References: <20220427095653.91804-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
dmamux register located in the system control area which can take up to
32 requests (16 per DMA controller). Each DMA channel can be wired to
two different peripherals.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-By: Vinod Koul <vkoul@kernel.org>
---
 .../bindings/dma/renesas,rzn1-dmamux.yaml     | 51 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml

diff --git a/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml b/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
new file mode 100644
index 000000000000..d83013b0dd74
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/renesas,rzn1-dmamux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/N1 DMA mux
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+allOf:
+  - $ref: "dma-router.yaml#"
+
+properties:
+  compatible:
+    const: renesas,rzn1-dmamux
+
+  reg:
+    maxItems: 1
+    description: DMA mux first register offset within the system control parent.
+
+  '#dma-cells':
+    const: 6
+    description:
+      The first four cells are dedicated to the master DMA controller. The fifth
+      cell gives the DMA mux bit index that must be set starting from 0. The
+      sixth cell gives the binary value that must be written there, ie. 0 or 1.
+
+  dma-masters:
+    minItems: 1
+    maxItems: 2
+
+  dma-requests:
+    const: 32
+
+required:
+  - reg
+  - dma-requests
+
+additionalProperties: false
+
+examples:
+  - |
+    dma-router@a0 {
+      compatible = "renesas,rzn1-dmamux";
+      reg = <0xa0 4>;
+      #dma-cells = <6>;
+      dma-masters = <&dma0 &dma1>;
+      dma-requests = <32>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9f495c02da10..9cf74e4eacce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19036,6 +19036,7 @@ SYNOPSYS DESIGNWARE DMAC DRIVER
 M:	Viresh Kumar <vireshk@kernel.org>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
 F:	Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
 F:	drivers/dma/dw/
 F:	include/dt-bindings/dma/dw-dmac.h
-- 
2.27.0

