Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD82B54D58A
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 01:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbiFOXyF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jun 2022 19:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbiFOXyF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jun 2022 19:54:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149B23DA4C;
        Wed, 15 Jun 2022 16:54:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q9so52977wrd.8;
        Wed, 15 Jun 2022 16:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cEyb0MCcln4/+tJlggVbn7/rat/Zppm0BDFZFg8DfUQ=;
        b=APPzjAGIC9jMqrLXLawLPcKEQQgeSUcq56kbUCQ4GasDxWBWmdoXMB/YGnM7QjKZu+
         vYbqu7IE018GUI5aznn+lYzQGIM7rVkyzDzRTv00y71QShHpO98HMu2DAwmOfQrnkSt+
         dYBAQMhrNe7koPrVO/NkW7O6NRPqr5lENxy2SK7B+tmG2sPkRZqYZc4VxhMvM01CsaxR
         IsLJcXGj0RMlCu69CYq83hbZpG0A4fkHa6Ut/onfkmOlEn9As75nu0AICD/4CfNfiSP9
         sc987ZT/Q2Hq5no0b0DDNOlEidm3xPRQ6238VGiybttu8bYGIndeuRYMDYHpDzTVfZiq
         fv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cEyb0MCcln4/+tJlggVbn7/rat/Zppm0BDFZFg8DfUQ=;
        b=FcNpw6tBxHSbpGte8Nak9X3EbJ0p2ixj0wF0iFHWrLUYsvfCae79Td+9AUTR201mn7
         IyenZ1DK9B+4UMsd3/TwdSHrWAhrGx+WkwOUYN/N4WAl2cjb87Rks6yJqtHWU3eXR2M2
         RgRXt1rKEqWfAwZR5xfXOeAwy+yT4wL8rj9AwOcbPE0+tH1FKNOtFm3tQuEFAb8Dc2iw
         rPJ1NnD2icm6qN/X760vw6vs2pQfdbN3JBq7J2R8y7BWDZyQFWqq513sa/BLyXMMUbwq
         +Tnk6JkSOkzylIsbzOYZQDWWUYQyb71KKyFupYG41dlKkIloWvH4CnA1gBNAcqFap5ku
         ZGQw==
X-Gm-Message-State: AJIora/MgAaT+dQ1KVBwzC5Jv9iiAdOnhGxqWvcVa8IgeNZP4SHoPZbv
        c1Q41QJdseYYFUezBu42IeA=
X-Google-Smtp-Source: AGRyM1uhwQ3S8E2baOqZmAHNM9kzk7+kk49TzmqyqzwrVzL6jCCTBWy00QO29euSnLdNvcKnrJjWEA==
X-Received: by 2002:adf:b358:0:b0:216:508c:e0bf with SMTP id k24-20020adfb358000000b00216508ce0bfmr2095552wrd.204.1655337242384;
        Wed, 15 Jun 2022 16:54:02 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id x1-20020adff0c1000000b002103cfd2fbasm268116wro.65.2022.06.15.16.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 16:54:01 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: dma: rework qcom,adm Documentation to yaml schema
Date:   Thu, 16 Jun 2022 01:54:03 +0200
Message-Id: <20220615235404.3457-1-ansuelsmth@gmail.com>
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

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
v2:
- Change Sob to Christian Marangi
- Add Bjorn in the maintainers list

 .../devicetree/bindings/dma/qcom,adm.yaml     | 96 +++++++++++++++++++
 .../devicetree/bindings/dma/qcom_adm.txt      | 61 ------------
 2 files changed, 96 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom,adm.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/qcom_adm.txt

diff --git a/Documentation/devicetree/bindings/dma/qcom,adm.yaml b/Documentation/devicetree/bindings/dma/qcom,adm.yaml
new file mode 100644
index 000000000000..6c08245bf5d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/qcom,adm.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/qcom,adm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm ADM DMA Controller
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
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

