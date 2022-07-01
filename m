Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061245639F9
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 21:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiGATXo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 15:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGATXn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 15:23:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D814913F7B;
        Fri,  1 Jul 2022 12:23:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7335F61F5A;
        Fri,  1 Jul 2022 19:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B5AC341CF;
        Fri,  1 Jul 2022 19:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656703421;
        bh=1yg6g6Dt75IP1Wz+MvEhKMC/hFgjUrx+vobCiTAxcA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGEFwfazLXWdnjF7RfZu70c+iyAMNhheupFJDlre0rMUFX7dgNHtIyrKzW0qbgjrP
         JD4dj8j8Jr9h1lyw7bXiA7krq0lPFTJybbSiz00+BHkPGLU7LH4effDGs3223Rq29k
         9vP8iw1sy2jXyx9bdjH+5ym1oQ9gKiNMvnYJjkJJrE3HsihQOWKscB6lftTFkMkK4f
         seaPjeUJMiO5EVvE+HjLNATOJ7kwwOhr37S6dd3DlyghozH0wBRd6eNUJumyA/1qow
         iAJ6zxAOMlbJflV/t+AAKihjgWPjg8tkvPz9vJkFAFuw6LCDXdD/1j5tP68epptPtr
         mssqwzdKe+niQ==
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
        alsa-devel@alsa-project.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 01/14] dt-bindings: display: convert ilitek,ili9341.txt to dt-schema
Date:   Fri,  1 Jul 2022 20:22:47 +0100
Message-Id: <20220701192300.2293643-2-conor@kernel.org>
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

A dt-schema binding for the Ilitek ili9341 was created as
panel/ilitek,ili9341.yaml but the txt binding was ignored in the
process. Move the remaining items in the txt binding to the yaml one &
delete it.

The example in the txt binding has a spi-max-frequency which disagrees
with the yaml replacement (and its own documentation) so change that to
conform with the binding. There are no users in tree of the Adafruit
yx240qv29 to check against.

Link: https://cdn-learn.adafruit.com/assets/assets/000/046/879/original/SPEC-YX240QV29-T_Rev.A__1_.pdf
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/display/ilitek,ili9341.txt       | 27 -----------
 .../display/panel/ilitek,ili9341.yaml         | 48 +++++++++++++------
 2 files changed, 34 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/ilitek,ili9341.txt

diff --git a/Documentation/devicetree/bindings/display/ilitek,ili9341.txt b/Documentation/devicetree/bindings/display/ilitek,ili9341.txt
deleted file mode 100644
index 169b32e4ee4e..000000000000
--- a/Documentation/devicetree/bindings/display/ilitek,ili9341.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Ilitek ILI9341 display panels
-
-This binding is for display panels using an Ilitek ILI9341 controller in SPI
-mode.
-
-Required properties:
-- compatible:	"adafruit,yx240qv29", "ilitek,ili9341"
-- dc-gpios:	D/C pin
-- reset-gpios:	Reset pin
-
-The node for this driver must be a child node of a SPI controller, hence
-all mandatory properties described in ../spi/spi-bus.txt must be specified.
-
-Optional properties:
-- rotation:	panel rotation in degrees counter clockwise (0,90,180,270)
-- backlight:	phandle of the backlight device attached to the panel
-
-Example:
-	display@0{
-		compatible = "adafruit,yx240qv29", "ilitek,ili9341";
-		reg = <0>;
-		spi-max-frequency = <32000000>;
-		dc-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
-		rotation = <270>;
-		backlight = <&backlight>;
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
index 6058948a9764..c5571391ca28 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
@@ -21,6 +21,7 @@ properties:
   compatible:
     items:
       - enum:
+          - adafruit,yx240qv29
           # ili9341 240*320 Color on stm32f429-disco board
           - st,sf-tc240t-9370-t
       - const: ilitek,ili9341
@@ -47,31 +48,50 @@ properties:
   vddi-led-supply:
     description: Voltage supply for the LED driver (1.65 .. 3.3 V)
 
-additionalProperties: false
+unevaluatedProperties: false
 
 required:
   - compatible
   - reg
   - dc-gpios
-  - port
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - st,sf-tc240t-9370-t
+then:
+  required:
+    - port
 
 examples:
   - |+
+    #include <dt-bindings/gpio/gpio.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
         panel: display@0 {
-                 compatible = "st,sf-tc240t-9370-t",
-                              "ilitek,ili9341";
-                 reg = <0>;
-                 spi-3wire;
-                 spi-max-frequency = <10000000>;
-                 dc-gpios = <&gpiod 13 0>;
-                 port {
-                         panel_in: endpoint {
-                           remote-endpoint = <&display_out>;
-                      };
-                 };
-             };
+            compatible = "st,sf-tc240t-9370-t",
+                         "ilitek,ili9341";
+            reg = <0>;
+            spi-3wire;
+            spi-max-frequency = <10000000>;
+            dc-gpios = <&gpiod 13 0>;
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&display_out>;
+                };
+            };
+        };
+        display@1{
+            compatible = "adafruit,yx240qv29", "ilitek,ili9341";
+            reg = <1>;
+            spi-max-frequency = <10000000>;
+            dc-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
+            rotation = <270>;
+            backlight = <&backlight>;
         };
+    };
 ...
-- 
2.37.0

