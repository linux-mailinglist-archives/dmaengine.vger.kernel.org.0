Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8E44BBF1B
	for <lists+dmaengine@lfdr.de>; Fri, 18 Feb 2022 19:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239011AbiBRSMw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Feb 2022 13:12:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239010AbiBRSMw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Feb 2022 13:12:52 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1946836300;
        Fri, 18 Feb 2022 10:12:33 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D612020003;
        Fri, 18 Feb 2022 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645207950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EGwulRQWUdeID+R0ltPV+hvVeG6IiTvELdB/8Uiez8g=;
        b=fMvtuvzDTQhJpik9Y3P03fMAIWHf+3oSPDDqzrvFd9cWhkXN1WB/7vhONcNwSb8h76PHKW
        Jj3YsSSiQOPVZSlnwdA6XtKv/H7AefRCSnItsBGtvtcein7WhM1qSMecGcbL/cnjX2pQJd
        6p+Ns04xgUddG1qBtBcZv5rafOAMHkF+P6tye8HOSqV1yqdTDe4C4qp67n43tsMyzoNGYh
        3yTVAmuEvvVs6cTRMjpfkY8KFVbUvo/jns/bfgX7rZ+zQPoYyc82eo9kf0WNI7acKhMROA
        gbml0rUJqR/4mwK66e/djDRIKvaZCltAxvTeoSkkB+xiij4fOoEgbXx4FIjcXQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 1/8] dt-bindings: dma: Introduce RZN1 dmamux bindings
Date:   Fri, 18 Feb 2022 19:12:19 +0100
Message-Id: <20220218181226.431098-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220218181226.431098-1-miquel.raynal@bootlin.com>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The Renesas RZN1 DMA IP is a based on a DW core, with eg. an additional
dmamux register located in the system control area which can take up to
32 requests (16 per DMA controller). Each DMA channel can be wired to
two different peripherals.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/dma/renesas,rzn1-dmamux.yaml     | 42 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml

diff --git a/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml b/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
new file mode 100644
index 000000000000..e2c82e43b8b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
@@ -0,0 +1,42 @@
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
+additionalProperties: false
+
+examples:
+  - |
+    dma-router {
+      compatible = "renesas,rzn1-dmamux";
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

