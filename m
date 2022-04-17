Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D4250498D
	for <lists+dmaengine@lfdr.de>; Sun, 17 Apr 2022 23:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbiDQVHw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 17 Apr 2022 17:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbiDQVHr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 17 Apr 2022 17:07:47 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A857653;
        Sun, 17 Apr 2022 14:05:03 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r66so15484990pgr.3;
        Sun, 17 Apr 2022 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x9kWFTq3CIJUv8wX3+465yt0Y7IgXQrtQnbzACvQaUs=;
        b=piQvr9H55AJ8vqV3cy0mQZGrxYbX/nKAAmY9n7ED0n4vNlxwANQWY7MUlYj5jt1pPY
         9Q+z2feA+UIk+9xe1jq3azikObb2ZyAxPTbiaMfMGDe/Cu8iJwjlJEJRUMo9EUOC4ynH
         4TLgsMWGgPVY8tH+9q7PbwYh5qCckkQFTkCYP5s9BFQD6KZ/L4WCUCHZpYzTs5lB3a8Q
         /lR1OQLf4nDlEWf2hBHk6qLU8jFUNxcEkvYIDGnF+V0u22ZdWIVwwPM0rwJEw2ssSKhb
         ZDeWNNna1ksqqEcs9P/CFanEijk74ucMF6Ql0qXOv/SM6RHNO+cD76tTNNAFVAFx+bRP
         wpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x9kWFTq3CIJUv8wX3+465yt0Y7IgXQrtQnbzACvQaUs=;
        b=FpzDMTEoeaedtu07qD3LqJPuLNKyCUTOf06p3+Apoo05qE57dgpNQTwrnjI4HLxIkX
         EYz6eB0YDTvIOXsqJ3c2foYosleka7kYmzWIeuq07XwAw7NBlE5ZBce/zA5jKQBwBMVh
         TzQ7hzVCjbwf5kvvJJ6eQk3A4uzG6vf7iUk+LCJkGiRxo8LCuSz0PSWhQ6HR5Ns6/r0t
         T1JxlyycI7LWNuCwiz20V3StkakSoiL+8lwnBiWeBpcTWdeZ2PnVC2dfms5yH9ZB6Tda
         PPfuRMx77CSHqIomB0a3xOlyjqwg7Q/zDf2/ENAsxu60uhDHUcLy5lTkeuYz1MS/YHzh
         3q2g==
X-Gm-Message-State: AOAM532OFkaEiWDTj4qzBWpZ8g89Mi1+WnYsbhz5qTYGLoIMNLuZofH8
        VRkz99+j8sD06J/1Mx2e9TM09S/IDII=
X-Google-Smtp-Source: ABdhPJz4dzxf/w7ytI/n40YuIx3v5mKi7RAAzSU1wMhOaYOGSw2vzVpK7kHpp0OpBdUzQx487gKSBw==
X-Received: by 2002:a63:4613:0:b0:39c:ef73:1080 with SMTP id t19-20020a634613000000b0039cef731080mr7468320pga.446.1650229502495;
        Sun, 17 Apr 2022 14:05:02 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id 137-20020a63078f000000b0039d9c13cd39sm10547711pgh.67.2022.04.17.14.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 14:05:02 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v3 6/6] dt-bindings: dma: Convert Qualcomm BAM DMA binding to json format
Date:   Mon, 18 Apr 2022 02:34:36 +0530
Message-Id: <20220417210436.6203-7-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220417210436.6203-1-singh.kuldeep87k@gmail.com>
References: <20220417210436.6203-1-singh.kuldeep87k@gmail.com>
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

Convert Qualcomm BAM DMA controller binding to DT schema format using
json schema.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
v3:
- Address Krzysztof Comments
- qcom,ee as required property
- Use boolean type instead of flag
- Add min/max to qcom,ee
- skip clocks, as it's users are not fixed
---
v2:
- Use dma-cells
- Set additionalProperties to false
---
 .../devicetree/bindings/dma/qcom,bam-dma.yaml | 97 +++++++++++++++++++
 .../devicetree/bindings/dma/qcom_bam_dma.txt  | 52 ----------
 2 files changed, 97 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
new file mode 100644
index 000000000000..02393ec2eedd
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/qcom,bam-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies Inc BAM DMA controller
+
+maintainers:
+  - Andy Gross <agross@kernel.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - qcom,bam-v1.3.0
+      - qcom,bam-v1.4.0
+      - qcom,bam-v1.7.0
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: bam_clk
+
+  "#dma-cells":
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+  iommus:
+    minItems: 1
+    maxItems: 4
+
+  num-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Indicates supported number of DMA channels in a remotely controlled bam.
+
+  qcom,controlled-remotely:
+    type: boolean
+    description:
+      Indicates that the bam is controlled by remote proccessor i.e. execution
+      environment.
+
+  qcom,ee:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    description:
+      Indicates the active Execution Environment identifier (0-7) used in the
+      secure world.
+
+  qcom,num-ees:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Indicates supported number of Execution Environments in a remotely
+      controlled bam.
+
+  qcom,powered-remotely:
+    type: boolean
+    description:
+      Indicates that the bam is powered up by a remote processor but must be
+      initialized by the local processor.
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#dma-cells"
+  - interrupts
+  - qcom,ee
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,gcc-msm8974.h>
+
+    dma-controller@f9944000 {
+        compatible = "qcom,bam-v1.4.0";
+        reg = <0xf9944000 0x15000>;
+        interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&gcc GCC_BLSP2_AHB_CLK>;
+        clock-names = "bam_clk";
+        #dma-cells = <1>;
+        qcom,ee = <0>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
deleted file mode 100644
index 6e9a5497b3f2..000000000000
--- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-QCOM BAM DMA controller
-
-Required properties:
-- compatible: must be one of the following:
- * "qcom,bam-v1.4.0" for MSM8974, APQ8074 and APQ8084
- * "qcom,bam-v1.3.0" for APQ8064, IPQ8064 and MSM8960
- * "qcom,bam-v1.7.0" for MSM8916
-- reg: Address range for DMA registers
-- interrupts: Should contain the one interrupt shared by all channels
-- #dma-cells: must be <1>, the cell in the dmas property of the client device
-  represents the channel number
-- clocks: required clock
-- clock-names: must contain "bam_clk" entry
-- qcom,ee : indicates the active Execution Environment identifier (0-7) used in
-  the secure world.
-- qcom,controlled-remotely : optional, indicates that the bam is controlled by
-  remote proccessor i.e. execution environment.
-- qcom,powered-remotely : optional, indicates that the bam is powered up by
-  a remote processor but must be initialized by the local processor.
-- num-channels : optional, indicates supported number of DMA channels in a
-  remotely controlled bam.
-- qcom,num-ees : optional, indicates supported number of Execution Environments
-  in a remotely controlled bam.
-
-Example:
-
-	uart-bam: dma@f9984000 = {
-		compatible = "qcom,bam-v1.4.0";
-		reg = <0xf9984000 0x15000>;
-		interrupts = <0 94 0>;
-		clocks = <&gcc GCC_BAM_DMA_AHB_CLK>;
-		clock-names = "bam_clk";
-		#dma-cells = <1>;
-		qcom,ee = <0>;
-	};
-
-DMA clients must use the format described in the dma.txt file, using a two cell
-specifier for each channel.
-
-Example:
-	serial@f991e000 {
-		compatible = "qcom,msm-uart";
-		reg = <0xf991e000 0x1000>
-			<0xf9944000 0x19000>;
-		interrupts = <0 108 0>;
-		clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
-			<&gcc GCC_BLSP1_AHB_CLK>;
-		clock-names = "core", "iface";
-
-		dmas = <&uart-bam 0>, <&uart-bam 1>;
-		dma-names = "rx", "tx";
-	};
-- 
2.25.1

