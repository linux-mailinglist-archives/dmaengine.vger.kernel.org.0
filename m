Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6035B89DA
	for <lists+dmaengine@lfdr.de>; Wed, 14 Sep 2022 16:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiINOGE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Sep 2022 10:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiINOFr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Sep 2022 10:05:47 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEAC17E0D;
        Wed, 14 Sep 2022 07:04:38 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id q21so22419311edc.9;
        Wed, 14 Sep 2022 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=wEDzTwxrIye6DBQ+Z+6xLzRtJPWeUjIxeMng9yTZ0WM=;
        b=CZUMo++y40L5CbP+Qh1y1NT9yhiPyJu8hefUewe+RWgwkir4KMgyFfNeeCPNb1B7Vw
         kFBp2cZraSbb/mG0Xw/YvC6HuoqrL5JDk7qAO3pVVACplBOCSLxlJ9Gocbwz5Pfe/FzW
         2gt05etS3cWJqNUh4eJ5gXJd9Qj7CvZ2jH6myu+abExaHpRQO/R9YAhlskwfApC+1O+o
         reUYq1oJxJ4/6qGHsfuG5coTMCoUAtbfzrUbtPR2etEGx+jiGrr7BF594TDkAuRhWTNW
         AZCTndKR4hLtxzd0cMMloJJhnjC/Rr9dAct7DMVER/9UA8zY4tn2rNuZQtAlF4LOPd20
         RZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=wEDzTwxrIye6DBQ+Z+6xLzRtJPWeUjIxeMng9yTZ0WM=;
        b=N+C3sPvIdz822ugSQva0sZ1xvXC1+DdCMbduUPZLyiR/GKwhQb2sVHNW0rRXVB7260
         AAA6Cyu8fSE4B0OQjDf6pFZyNGn328TF0PDa8i/jZWQicYwS6uZK9GVaGLcnqrg3jn5K
         FxrV/6qTemHw5Y9YqjrOTKMveFwoXH0u0tT2BETDiyIBzM8vXFy9AVAU4VXwh0GKYLLm
         SDG44tMttOUbctqHvD0W8ryJRZhkilGLZQTEGlVrr0JVrQwmjAuRgJgAnVAE4Pi/zBPI
         kMVDthiFMU3lya3z0nL9NHE1efaxeRNkTfxSYnp49rHVzLKaOmldIbISGTaiwApnE/mH
         MlKg==
X-Gm-Message-State: ACgBeo2gI6tje/ROt0zwxSj4P4NImpRwoWLe6njf56MUD4ISKUkNkiMF
        z5cqCMqJG4PYLPlcjndF8jA=
X-Google-Smtp-Source: AA6agR64r/xDMqGRQPE1UGGL1HVms7d/KPO2FeA5gQDKAead2Pf5q9urlAC3QDO6Mz5fZYQOugxSJw==
X-Received: by 2002:aa7:cada:0:b0:452:5b04:efd9 with SMTP id l26-20020aa7cada000000b004525b04efd9mr7217530edt.84.1663164275929;
        Wed, 14 Sep 2022 07:04:35 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.googlemail.com with ESMTPSA id i10-20020a1709061e4a00b0073dba2d9f99sm7560296ejj.128.2022.09.14.07.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:04:35 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: dma: rework qcom,adm Documentation to yaml schema
Date:   Wed, 14 Sep 2022 16:04:25 +0200
Message-Id: <20220914140426.7609-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
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
2.37.2

