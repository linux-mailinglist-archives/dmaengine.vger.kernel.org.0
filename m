Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732414FAF68
	for <lists+dmaengine@lfdr.de>; Sun, 10 Apr 2022 19:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243806AbiDJRxi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 10 Apr 2022 13:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243809AbiDJRxe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 10 Apr 2022 13:53:34 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D5361A02;
        Sun, 10 Apr 2022 10:51:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so851091pjb.2;
        Sun, 10 Apr 2022 10:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKoymIM/fv7AleuSvT3RBW6zEuHK660DiNK/eKFXaF0=;
        b=QHVNydOQkI6aJW7lLFWCnArJGaCLIt5Pk+1OiDKlhZw4sN2hOJEUQxhnH7Mbm9YF8P
         umsoGfEp8khqN3ofctT97x1oxHn9n5LS8LFGAgjPQ4AlgJKHLiet8U/tj3eo+933pYbC
         jAfKUX0xSWlS8VRRgXM7f1N9olvFDKtHNhynv3Z6v5THDmRrGU3F5Webb2/pd/dqpOYF
         NJiq7orFaEYKzrddfVbT4xRRTmLljdMeOpG/r72eZ1UqaF0c1R20N6D2+WQo4inBR/uf
         nRhMED/vknuQWe/1qlS00NbVIZYFXCkI61m6G9YikUucWqQ3NRvhLOKqfvPqXNOyxaa2
         TdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKoymIM/fv7AleuSvT3RBW6zEuHK660DiNK/eKFXaF0=;
        b=KtZPDvBAgEq7bKf83jDmh8aE+BLISdB5HFncVuqIkOWbSeBPKUq49jvi4LYaw+PIMG
         W65wTxqnxxDpjYR5ccAETc0+PH/FiyZpdd5DvnO+9UqB7UQKaKZ879byhDXg0Ldwhu3d
         gUPjK3SiLwxl08NLsbxhKPEXIHmDuRtxX0EGiOr296hLyK1Wl78l1osdhyf4S+Lj0I2R
         v0IKHfyiuraeTWFGuuAe8NX7Vrl6ruVKUOH5w447eP6iJ4rYTePFnQNl0nSiZvRdFhd6
         vv3j9zUslAIG8iptz4xLeZaYoCJtlA3DF/4xafQPNJWjt5pXurlkCUhXDMGF1W8cZWbv
         J1EA==
X-Gm-Message-State: AOAM533ZmwRvZeYq0IWx8RyymPwX+bEASoC/e+JsVxW2BRJ62szdAu6x
        vPgks7XuGNMJh17demJm2ScNEfK7CDA=
X-Google-Smtp-Source: ABdhPJwobXiEtfPGnmEmn8BhKBHcBuSI84rTe8ZQjsNKE7W3yi5x3sUfAYGc6BYv0Ei9kdBclowQWg==
X-Received: by 2002:a17:90b:4a4b:b0:1c6:4398:523c with SMTP id lb11-20020a17090b4a4b00b001c64398523cmr32397815pjb.50.1649613081672;
        Sun, 10 Apr 2022 10:51:21 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id l4-20020a056a0016c400b004f79504ef9csm32283286pfc.3.2022.04.10.10.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 10:51:21 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v2 6/6] dt-bindings: dma: Convert Qualcomm BAM DMA binding to json format
Date:   Sun, 10 Apr 2022 23:20:56 +0530
Message-Id: <20220410175056.79330-7-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
References: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
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
 .../devicetree/bindings/dma/qcom,bam-dma.yaml | 94 +++++++++++++++++++
 .../devicetree/bindings/dma/qcom_bam_dma.txt  | 52 ----------
 2 files changed, 94 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
new file mode 100644
index 000000000000..b32175d54dca
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -0,0 +1,94 @@
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
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates that the bam is controlled by remote proccessor i.e. execution
+      environment.
+
+  qcom,ee:
+    $ref: /schemas/types.yaml#/definitions/uint32
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
+    $ref: /schemas/types.yaml#/definitions/flag
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

