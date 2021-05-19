Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E196438912C
	for <lists+dmaengine@lfdr.de>; Wed, 19 May 2021 16:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354176AbhESOi4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 May 2021 10:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354195AbhESOiy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 May 2021 10:38:54 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DA3C06138C
        for <dmaengine@vger.kernel.org>; Wed, 19 May 2021 07:37:31 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q6so7430131pjj.2
        for <dmaengine@vger.kernel.org>; Wed, 19 May 2021 07:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zG635xOID1k2/MXq+MKZASd8MAgolK42+7VgFHWsBrE=;
        b=BDOAaFFyisX6ZcapOca80pchy7MV6pvuLTVoq7tL9hVe78g3mtHX1u4KcxR+KS/l1F
         s0ICui7AisYvcrgn5Fq3pNlSOVTcwayGp0yzPvx0bsooNlS0I0qdQGX2pQ2m002mOxUd
         o7UY7FPxwVR20ym/34ykY6NYLAa4OBA1wmd56MPNLXZftzIajJSaJMz6Azog5/bb8gwW
         KFDGK2isep+R1PyWKl46dxch6UL+j2psBGeth0GeUAr0A/zN3owFojNwIGoQNaOLwBNc
         1yOlz+3iK/JtsVFBzNxTavo49bCr6crtZe0p8oGda7GXKp/m23Tt/FyHNsmfawzBrkY5
         XDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zG635xOID1k2/MXq+MKZASd8MAgolK42+7VgFHWsBrE=;
        b=Rs0eEEWS2+JY9RRniNe7YaT+1lHbAUdTP4735qKa2PzBolS6jXJeDkmp0ZsBjscB+P
         TpDGEW3PSnZev24rWpwcUdsD4s6DFskH9UojkOhxgZk3RVbpk75vYaXMgkHvE3ZoZmDM
         b433DX3uzSVgJjeZuf8bYWLJQMjd/IpRAFzBvJe3QmUzg+B43JVo6iyUpg7G701TfUFx
         s4b5fyKUQrC4ocy6k/0JhjeFt6R+hvexPQk5Ph0sWrcgWQW0iFDf4GKkM7LyzPNCKoTD
         fxSMZc+yetBc+GGz6HpuOfd9X0sOVvUTAcEpqmyAGGp0JYVfEsyZvk4hN3QO3u/t9dUq
         yRNA==
X-Gm-Message-State: AOAM530HqwGcIwHALEKQicHuCOmIBK4PtzlMv1tUGVB895kOAgy2K0/F
        cMmGl1KDnQyDarx7bxVAhnHiWA==
X-Google-Smtp-Source: ABdhPJzKbyM7GTDb3zd9dvjsR3+jQaQxL8QNti/wAyXdfzHXFw2mJreTEzc9H5+2zWBW1uYNWJ4mpA==
X-Received: by 2002:a17:902:8505:b029:ec:b451:71cd with SMTP id bj5-20020a1709028505b02900ecb45171cdmr11390479plb.23.1621435051224;
        Wed, 19 May 2021 07:37:31 -0700 (PDT)
Received: from localhost.localdomain.name ([122.177.135.250])
        by smtp.gmail.com with ESMTPSA id o24sm9239515pgl.55.2021.05.19.07.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:37:30 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: [PATCH v3 01/17] dt-bindings: qcom-bam: Convert binding to YAML
Date:   Wed, 19 May 2021 20:06:44 +0530
Message-Id: <20210519143700.27392-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert Qualcomm BAM DMA devicetree binding to YAML.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bhupesh.linux@gmail.com
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/dma/qcom_bam_dma.txt  | 50 ----------
 .../devicetree/bindings/dma/qcom_bam_dma.yaml | 91 +++++++++++++++++++
 2 files changed, 91 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
deleted file mode 100644
index cf5b9e44432c..000000000000
--- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
+++ /dev/null
@@ -1,50 +0,0 @@
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
diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
new file mode 100644
index 000000000000..173e4d7508a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/qcom_bam_dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QCOM BAM DMA controller binding
+
+maintainers:
+  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
+
+description: |
+  This document defines the binding for the BAM DMA controller
+  found on Qualcomm parts.
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - qcom,bam-v1.4.0
+      - qcom,bam-v1.3.0
+      - qcom,bam-v1.7.0
+
+  reg:
+    maxItems: 1
+    description: Address range of the DMA registers.
+
+  clocks:
+    minItems: 1
+    maxItems: 8
+
+  clock-names:
+    const: bam_clk
+
+  interrupts:
+    maxItems: 1
+    description: Single interrupt line shared by all channels.
+
+  num-channels:
+    maxItems: 31
+    description: |
+      Indicates supported number of DMA channels in a remotely controlled bam.
+
+  "#dma-cells":
+    const: 1
+    description: The single cell represents the channel index.
+
+  qcom,ee:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      Indicates the active Execution Environment identifier (0-7)
+      used in the secure world.
+    enum: [0, 1, 2, 3, 4, 5, 6, 7]
+
+  qcom,controlled-remotely:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates that the bam is controlled by remote proccessor i.e.
+      execution environment.
+
+  qcom,num-ees:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Indicates supported number of Execution Environments in a
+      remotely controlled bam.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - "#dma-cells"
+  - qcom,ee
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8974.h>
+    dma-controller@f9984000 {
+        compatible = "qcom,bam-v1.4.0";
+        reg = <0xf9984000 0x15000>;
+        interrupts = <0 94 0>;
+        clocks = <&gcc GCC_BAM_DMA_AHB_CLK>;
+        clock-names = "bam_clk";
+        #dma-cells = <1>;
+        qcom,ee = /bits/ 8 <0>;
+    };
-- 
2.31.1

