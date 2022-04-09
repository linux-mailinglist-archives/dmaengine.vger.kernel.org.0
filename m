Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046A64FAA4F
	for <lists+dmaengine@lfdr.de>; Sat,  9 Apr 2022 20:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243031AbiDISoF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 9 Apr 2022 14:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243116AbiDISoA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 9 Apr 2022 14:44:00 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143981EA282;
        Sat,  9 Apr 2022 11:41:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id bx5so11495401pjb.3;
        Sat, 09 Apr 2022 11:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nr/u+ZwKEd/3qo8bgunaAebE8NIooSpd7ML7VX6zww8=;
        b=ORpVOFSr646Ql7vJ1+XFDYPaH7B//S/QTQFt2peAcDjG8NTWuujcwc1XQh/ZJyHCKz
         EUJRYfrNFf6tHJmfDfjZL3jv/5U49PsmpvVMe5nrtETSRks4zvmTV/95yk2ULrSWCmkd
         K7nd/Fs46vk6zjdJ100C3ebD++EdHwGhcryCGEG4BB1TNSjv9owxDPBYrKkoqKZ3mBVZ
         +9td/QosqwkFE/TiPULqnyhgD413YYaae9eqgaK3a3KoPqeyk3xJUP7HGC/WgEMeORHp
         42YGws9DymTA2NJfNFHbp62fqPy/8ASoeEvllCoZAYmKxJPbk5MMaa+MAmwVGEhQL+LJ
         iCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nr/u+ZwKEd/3qo8bgunaAebE8NIooSpd7ML7VX6zww8=;
        b=aEPjvV5S62/OBCB5pdNrZr1fQjjlHUD0clLuruA6kn5MycJMkw6Hq4rRPOst6CAjAO
         OpBkIuQqrUy5Hp2zjoD5QcAHfM6m9TMyAhYAfZWTSeZcXNCE6UDRrTC71DOUNWSOu0Th
         AjRdAixXccQ8nT15LPwwNbekSPAEXZBWSFm3OyT/Aqpt4OLjFaAs0v0BGfZ4L2OVwK3i
         ivOmNbJSW7DHocWRoK21gIGdkmwbPGdO2AzFUW9Xf2lqqnkkpSc79Oby8yFMC+0fVTgi
         SzJOb9yKo8u8pqx82YolJbODkfOfV90Lu0Ju2YDSjEZDOPbRrU79p5wKM+qv+CsBaNo1
         oKjw==
X-Gm-Message-State: AOAM531QFAn5pksilvkcthP+X5TQNHw+3oQflxXOjmvQgk7B7LHRoPpV
        78OYntHSz9bJ8aAl/HZPRnVeTEDMvqk=
X-Google-Smtp-Source: ABdhPJzja9LrsRzXqXNp8RFic/Yugyg703WRs0+shieU7z82s7cnwbYCZ+zAH6Ag6ZFgtTHNmgz4vQ==
X-Received: by 2002:a17:90b:1b4d:b0:1c6:bd9e:a63d with SMTP id nv13-20020a17090b1b4d00b001c6bd9ea63dmr28264713pjb.56.1649529706232;
        Sat, 09 Apr 2022 11:41:46 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id g3-20020a63ad03000000b003821d0f0ef4sm25813933pgf.71.2022.04.09.11.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 11:41:45 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 6/6] dt-bindings: dma: Convert Qualcomm BAM DMA binding to json format
Date:   Sun, 10 Apr 2022 00:11:15 +0530
Message-Id: <20220409184115.15612-7-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220409184115.15612-1-singh.kuldeep87k@gmail.com>
References: <20220409184115.15612-1-singh.kuldeep87k@gmail.com>
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
 .../devicetree/bindings/dma/qcom,bam-dma.yaml | 90 +++++++++++++++++++
 .../devicetree/bindings/dma/qcom_bam_dma.txt  | 52 -----------
 2 files changed, 90 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
new file mode 100644
index 000000000000..606c19f83db3
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -0,0 +1,90 @@
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
+  - $ref: dma-controller.yaml#
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
+  - interrupts
+  - reg
+
+unevaluatedProperties: false
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

