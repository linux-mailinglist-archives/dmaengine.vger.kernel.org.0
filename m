Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27E15639E0
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 21:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiGATYB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 15:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiGATX5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 15:23:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6180713F99;
        Fri,  1 Jul 2022 12:23:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A6ACB831A8;
        Fri,  1 Jul 2022 19:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517FFC341CE;
        Fri,  1 Jul 2022 19:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656703433;
        bh=PaUGtcrodBz7cVrUAdibJxD+PRt1hlUM+hA+PXjxU8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Je8h/uG7xfWrk9MLPW2Xnpf37EarLuFl14M28FPgEPIJczfy1L/IzO9y0dLdg4Jqz
         14b8/4D5h1zVGpBTS0DU2jaW0TUXZFJC+B0A0d3uNoFXhw3iiISl0h7MQn1YNY3bCy
         TkRQtPSmYIMuB9KM6Foa5xNlbHe+NltkTeDJtHiel3wCUwWaC+3J7l8DE/1oYrA/R1
         H7BtEzuCJqoVoZS8zOTUHWMR4HgfQ1z25E3GhKYrlaLSQc/AtK48svzo5+6whxXbfA
         dhEhHVMTyLGUwiL8MMAG3Td7vbuZx/MtZ/weEDzZxNTqJOMrrmL8O5ZUs8y1Wpx3mQ
         0aUYPDIEq/Zbw==
From:   Conor Dooley <conor@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-riscv@lists.infradead.org
Subject: [PATCH v4 03/14] ASoC: dt-bindings: convert designware-i2s to dt-schema
Date:   Fri,  1 Jul 2022 20:22:49 +0100
Message-Id: <20220701192300.2293643-4-conor@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220701192300.2293643-1-conor@kernel.org>
References: <20220701192300.2293643-1-conor@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Convert the Synopsys DesignWare I2S controller binding to dt-schema.
There was no listed maintainer but Jose Abreu was the last editor of the
txt binding so add him as maintainer.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/sound/designware-i2s.txt         | 35 -------
 .../bindings/sound/snps,designware-i2s.yaml   | 94 +++++++++++++++++++
 2 files changed, 94 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/designware-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/designware-i2s.txt b/Documentation/devicetree/bindings/sound/designware-i2s.txt
deleted file mode 100644
index 6a536d570e29..000000000000
--- a/Documentation/devicetree/bindings/sound/designware-i2s.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-DesignWare I2S controller
-
-Required properties:
- - compatible : Must be "snps,designware-i2s"
- - reg : Must contain the I2S core's registers location and length
- - clocks : Pairs of phandle and specifier referencing the controller's
-   clocks. The controller expects one clock: the clock used as the sampling
-   rate reference clock sample.
- - clock-names : "i2sclk" for the sample rate reference clock.
- - dmas: Pairs of phandle and specifier for the DMA channels that are used by
-   the core. The core expects one or two dma channels: one for transmit and
-   one for receive.
- - dma-names : "tx" for the transmit channel, "rx" for the receive channel.
-
-Optional properties:
- - interrupts: The interrupt line number for the I2S controller. Add this
-   parameter if the I2S controller that you are using does not support DMA.
-
-For more details on the 'dma', 'dma-names', 'clock' and 'clock-names'
-properties please check:
-	* resource-names.txt
-	* clock/clock-bindings.txt
-	* dma/dma.txt
-
-Example:
-
-	soc_i2s: i2s@7ff90000 {
-		compatible = "snps,designware-i2s";
-		reg = <0x0 0x7ff90000 0x0 0x1000>;
-		clocks = <&scpi_i2sclk 0>;
-		clock-names = "i2sclk";
-		#sound-dai-cells = <0>;
-		dmas = <&dma0 5>;
-		dma-names = "tx";
-	};
diff --git a/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml b/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
new file mode 100644
index 000000000000..4b0795819064
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/snps,designware-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DesignWare I2S controller
+
+maintainers:
+  - Jose Abreu <joabreu@synopsys.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: canaan,k210-i2s
+          - const: snps,designware-i2s
+      - enum:
+          - snps,designware-i2s
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      The interrupt line number for the I2S controller. Add this
+      parameter if the I2S controller that you are using does not
+      support DMA.
+    maxItems: 1
+
+  clocks:
+    description: Sampling rate reference clock
+    maxItems: 1
+
+  clock-names:
+    const: i2sclk
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    items:
+      - description: TX DMA Channel
+      - description: RX DMA Channel
+    minItems: 1
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+    minItems: 1
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: canaan,k210-i2s
+
+then:
+  properties:
+    "#sound-dai-cells":
+      const: 1
+
+else:
+  properties:
+    "#sound-dai-cells":
+      const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+oneOf:
+  - required:
+      - dmas
+      - dma-names
+  - required:
+      - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    soc_i2s: i2s@7ff90000 {
+      compatible = "snps,designware-i2s";
+      reg = <0x7ff90000 0x1000>;
+      clocks = <&scpi_i2sclk 0>;
+      clock-names = "i2sclk";
+      #sound-dai-cells = <0>;
+      dmas = <&dma0 5>;
+      dma-names = "tx";
+    };
-- 
2.37.0

