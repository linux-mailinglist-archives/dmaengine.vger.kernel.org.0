Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D59F4DA30C
	for <lists+dmaengine@lfdr.de>; Tue, 15 Mar 2022 20:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348394AbiCOTOV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Mar 2022 15:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245232AbiCOTOU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Mar 2022 15:14:20 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BC7CF0;
        Tue, 15 Mar 2022 12:13:03 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C9B99C0005;
        Tue, 15 Mar 2022 19:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647371582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dGdZ3v/UIIN/shvZ1IhmcrAqm0j6EVMRXCucqy7b3F8=;
        b=SO0l0tBMaIZ4tH4cajEEw2HV8TxkjQPVwzHD7JcbTZnwe+E1c8RohjUfZ3HOr9qRsVqxRg
        906LdlmYHqF7D/n+vlGq7EnFEKgJIME1Qh3OjppRLxJ8YG10gQi57AD8j5M16+/6mc/jZ+
        /anVyUVCL7J+I2gAOG+kfu4arp6EQnrMAqVxqdi1B6ofCZBtA/uJC3yN6qWnjYMC5SYUwV
        BBqLgBZGuB0aK+AuEgGC8fLf1yX6OStzelVwIKyrrWcgF8oQN56q3dxS1/9ANxCGEzpiDL
        rOsPaFEwK90a6sn1RZy+/N+o5YP2LWMwR0+++NXRYuiUwhnZ0xazO83PjPEkgQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Cc:     Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/8] dt-bindings: dmaengine: Introduce RZN1 dmamux bindings
Date:   Tue, 15 Mar 2022 20:12:48 +0100
Message-Id: <20220315191255.221473-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220315191255.221473-1-miquel.raynal@bootlin.com>
References: <20220315191255.221473-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index ea3e6c914384..c70c9c39a2f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18636,6 +18636,7 @@ SYNOPSYS DESIGNWARE DMAC DRIVER
 M:	Viresh Kumar <vireshk@kernel.org>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
 F:	Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
 F:	drivers/dma/dw/
 F:	include/dt-bindings/dma/dw-dmac.h
-- 
2.27.0

