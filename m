Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2062F54D115
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jun 2022 20:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349421AbiFOSpV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jun 2022 14:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244809AbiFOSpT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jun 2022 14:45:19 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949D035DDA;
        Wed, 15 Jun 2022 11:45:15 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so1635693wma.4;
        Wed, 15 Jun 2022 11:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tr3miiyF7BVRw2aPmWuoc4u2d/PlTJcxehRwtRTtco4=;
        b=VvngoXmOhycMICB54rdUiaFNcA9rYu4zGRxNqv6KqzdAtdVppDJ12C1dFJwssBoArJ
         5S1HO1sD/WYml+OJB2w9jjV+Y5b+owbmW5YCxX+lrkpLovNv3gYd64cJe2d7/ZADSexi
         AfjrfdpdIfRCrUwTiu8H+NUgfrSWxYWkjDeI+40Eu94fDCiZQ7Q/bjlhxfkEA4PefOIT
         Dl9MMNvhg9dgawxD5AScB6wy2G/UEartKm+V/C7eYi6LWs1rYgB59QedeKAnnsjc0ATv
         OCr4Lw7IGPE6kSM13Bn8/8csVt6UgIf1LuSoStkqpUjagtHbQtus9tNn7WzJjiWYYg9Q
         d2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tr3miiyF7BVRw2aPmWuoc4u2d/PlTJcxehRwtRTtco4=;
        b=73JhWDgzB+TVOBhuylkGv9oKc2W2hzoqPpEUGEae62zGnAswQEZ/oSMq0fhWLW0VTn
         yEgF2tLOJPyfey2ZaMNyvKSMxcIOjrJB7zM3uDTD5+i6szrZl88Y7uds5Kjgnn5Dw5WB
         Y3CSvv+J0A1Fgydyiq0koeFAcOyKOevQSgIgYP7mpahEiXLsy9o8tL+1cPbF93GSihhd
         Hgu5bZwVPKhyuzm8X/xQR68qerH14+JEXiCoSo6mkb7sLzsHAFevKio/ksvKj+l3penK
         utghzJAPWIv855bByFEzkWnseRwsHDYcK2AwqhMvLIWRa+RaHPb3piXy0Xm+G2U5QEV9
         7gSA==
X-Gm-Message-State: AJIora96OOrJV2Z8RkGfpB7W2rsvLEmuz0fM9WmBaxWTBG4TkORj0e9V
        6B4XCuDOY1ttridrUhnY+X8=
X-Google-Smtp-Source: AGRyM1vm0S2iwoYbhKv+pgYBIyLJnj+T7nEM3h+BBn+rr2Ueupjw/Q9ScOYIrIbpml+Zke1u7tKZFQ==
X-Received: by 2002:a05:600c:3655:b0:39c:6745:ec53 with SMTP id y21-20020a05600c365500b0039c6745ec53mr846583wmq.186.1655318713982;
        Wed, 15 Jun 2022 11:45:13 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id j13-20020a5d618d000000b002167efdd549sm3393095wru.38.2022.06.15.11.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 11:45:13 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] dt-bindings: dma: rework qcom,adm Documentation to yaml schema
Date:   Wed, 15 Jun 2022 19:50:43 +0200
Message-Id: <20220615175043.20166-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Rework the qcom,adm Documentation to yaml schema.
This is not a pure conversion since originally the driver has changed
implementation for the #dma-cells and was wrong from the start.
Also the driver now handles the common DMA clients implementation with
the first cell that denotes the channel number and nothing else since
the client will have to provide the crci information via other means.

Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/dma/qcom,adm.yaml     | 95 +++++++++++++++++++
 .../devicetree/bindings/dma/qcom_adm.txt      | 61 ------------
 2 files changed, 95 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom,adm.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/qcom_adm.txt

diff --git a/Documentation/devicetree/bindings/dma/qcom,adm.yaml b/Documentation/devicetree/bindings/dma/qcom,adm.yaml
new file mode 100644
index 000000000000..77096a7c9405
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/qcom,adm.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/qcom,adm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm ADM DMA Controller
+
+maintainers:
+  - Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
+
+description: |
+  QCOM ADM DMA controller provides DMA capabilities for
+  peripheral buses such as NAND and SPI.
+
+properties:
+  compatible:
+    const: qcom,adm
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
+  clocks:
+    items:
+      - description: phandle to the core clock
+      - description: phandle to the iface clock
+
+  clock-names:
+    items:
+      - const: core
+      - const: iface
+
+  resets:
+    items:
+      - description: phandle to the clk reset
+      - description: phandle to the c0 reset
+      - description: phandle to the c1 reset
+      - description: phandle to the c2 reset
+
+  reset-names:
+    items:
+      - const: clk
+      - const: c0
+      - const: c1
+      - const: c2
+
+  qcom,ee:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: indicates the security domain identifier used in the secure world.
+    minimum: 0
+    maximum: 255
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#dma-cells"
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - qcom,ee
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
+    #include <dt-bindings/reset/qcom,gcc-ipq806x.h>
+
+    adm_dma: dma-controller@18300000 {
+        compatible = "qcom,adm";
+        reg = <0x18300000 0x100000>;
+        interrupts = <0 170 0>;
+        #dma-cells = <1>;
+
+        clocks = <&gcc ADM0_CLK>,
+                  <&gcc ADM0_PBUS_CLK>;
+        clock-names = "core", "iface";
+
+        resets = <&gcc ADM0_RESET>,
+                  <&gcc ADM0_C0_RESET>,
+                  <&gcc ADM0_C1_RESET>,
+                  <&gcc ADM0_C2_RESET>;
+        reset-names = "clk", "c0", "c1", "c2";
+        qcom,ee = <0>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/dma/qcom_adm.txt b/Documentation/devicetree/bindings/dma/qcom_adm.txt
deleted file mode 100644
index 9d3b2f917b7b..000000000000
--- a/Documentation/devicetree/bindings/dma/qcom_adm.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-QCOM ADM DMA Controller
-
-Required properties:
-- compatible: must contain "qcom,adm" for IPQ/APQ8064 and MSM8960
-- reg: Address range for DMA registers
-- interrupts: Should contain one interrupt shared by all channels
-- #dma-cells: must be <2>.  First cell denotes the channel number.  Second cell
-  denotes CRCI (client rate control interface) flow control assignment.
-- clocks: Should contain the core clock and interface clock.
-- clock-names: Must contain "core" for the core clock and "iface" for the
-  interface clock.
-- resets: Must contain an entry for each entry in reset names.
-- reset-names: Must include the following entries:
-  - clk
-  - c0
-  - c1
-  - c2
-- qcom,ee: indicates the security domain identifier used in the secure world.
-
-Example:
-		adm_dma: dma@18300000 {
-			compatible = "qcom,adm";
-			reg = <0x18300000 0x100000>;
-			interrupts = <0 170 0>;
-			#dma-cells = <2>;
-
-			clocks = <&gcc ADM0_CLK>, <&gcc ADM0_PBUS_CLK>;
-			clock-names = "core", "iface";
-
-			resets = <&gcc ADM0_RESET>,
-				<&gcc ADM0_C0_RESET>,
-				<&gcc ADM0_C1_RESET>,
-				<&gcc ADM0_C2_RESET>;
-			reset-names = "clk", "c0", "c1", "c2";
-			qcom,ee = <0>;
-		};
-
-DMA clients must use the format descripted in the dma.txt file, using a three
-cell specifier for each channel.
-
-Each dmas request consists of 3 cells:
- 1. phandle pointing to the DMA controller
- 2. channel number
- 3. CRCI assignment, if applicable.  If no CRCI flow control is required, use 0.
-    The CRCI is used for flow control.  It identifies the peripheral device that
-    is the source/destination for the transferred data.
-
-Example:
-
-	spi4: spi@1a280000 {
-		spi-max-frequency = <50000000>;
-
-		pinctrl-0 = <&spi_pins>;
-		pinctrl-names = "default";
-
-		cs-gpios = <&qcom_pinmux 20 0>;
-
-		dmas = <&adm_dma 6 9>,
-			<&adm_dma 5 10>;
-		dma-names = "rx", "tx";
-	};
-- 
2.36.1

