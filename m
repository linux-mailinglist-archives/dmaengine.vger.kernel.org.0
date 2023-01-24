Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F105F6792C1
	for <lists+dmaengine@lfdr.de>; Tue, 24 Jan 2023 09:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjAXIMB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Jan 2023 03:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjAXIL7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 Jan 2023 03:11:59 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C053F29E
        for <dmaengine@vger.kernel.org>; Tue, 24 Jan 2023 00:11:30 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso10732854wmn.5
        for <dmaengine@vger.kernel.org>; Tue, 24 Jan 2023 00:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dJMIdeh7gUIDCtKqXhsomSitFoJwzKoPZZBaRo8PmA0=;
        b=DFVw5yDTGtqhm8cDvw92tBgRCFIReN8WTiMBu+Kyl7BuiY52eDa9yvzb6di1VFILX8
         ant/LKMdtDIIBVtSWrekjWtNKTJs3/IekrS47No/+yhNDsqvlrbKKTAfXctRSwe4amOf
         vu+qw9jPcx3RSEf7YpvK5WjgQtQUqwrdBqqY45WZ8g+wlnv7FDqrUJMraSWxd5zgMz7n
         5QNjpJqXmL9tBx0c/DXPPOSZiTijYDABaI5uO6XJRqrly7R+MfjMCGQMz9E7r4oVk+YB
         iBD6zDQGj/Y2B1Cmbo6FjsXYOkpoXpnmRRMhQ09ijorANFcdwRrK2kxjNuYWZKCb3yCk
         XDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJMIdeh7gUIDCtKqXhsomSitFoJwzKoPZZBaRo8PmA0=;
        b=WhS/vp/Sz9Uxr+TNGEFew49vmIo0Vth2thmgAa/0YHUpH4fyN89Sv0L9a5yqDkTP62
         vICq7V6EMwHdhTvRwwyLZkxxR7TUcW8LnqQ7NCSVTAWIBIx00aQCIRhSaQ1Z1eWe2U6W
         qaF/Zfk4DKRv9+GTufcLUNvH5TLLZDVPJ/WoD3HJ35PbA+zPtG3SyRt0WGw3vZyJFduP
         hJrEn7NpvmRfxtPzu+UyTbI1CiF9i2IOkpYcqy8KFQZVj8jub2hJCrT9XtKLmTfwDoTb
         IQ9jRZM2fUSvmodOmOAF1Ww2gDbb22KMJe/LRZU/CiCXnmSrUq9vj7YHFeOR+BclrYDp
         WgNw==
X-Gm-Message-State: AFqh2kq+E8/cEZpZmNZH5etINJAPE5QOFB9Ve2MlgZD5z762Mu/g4QT5
        ZbXyhq0aRMDMftpdYsNkrqUIBg==
X-Google-Smtp-Source: AMrXdXv0DR2w9J1xBtCsI865Q0WjuNZPuC9tyU+oLnSNgH7tbVW9hTSFPkv5ml1XwCEOeyLt68Zp9Q==
X-Received: by 2002:a05:600c:13c8:b0:3db:3e8:feca with SMTP id e8-20020a05600c13c800b003db03e8fecamr26589510wmg.15.1674547884049;
        Tue, 24 Jan 2023 00:11:24 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c511100b003dc0d5b4fa6sm1387338wms.3.2023.01.24.00.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 00:11:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Olivier Dautricourt <olivierdautricourt@gmail.com>,
        Stefan Roese <sr@denx.de>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Green Wan <green.wan@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?q?=A1er?= <povik+lin@cutebit.org>,
        Peng Fan <peng.fan@nxp.com>,
        Paul Cercueil <paul@crapouillou.net>,
        - <chuanhua.lei@intel.com>, Long Cheng <long.cheng@mediatek.com>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Palmer Debbelt <palmer@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: dma: drop unneeded quotes
Date:   Tue, 24 Jan 2023 09:11:16 +0100
Message-Id: <20230124081117.31186-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Cleanup by removing unneeded quotes from refs and redundant blank lines.
No functional impact except adjusting to preferred coding style.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com> # mediatek
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Hector Martin <marcan@marcan.st> # apple
---
 .../devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml        | 2 +-
 .../devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml       | 2 +-
 .../devicetree/bindings/dma/allwinner,sun6i-a31-dma.yaml        | 2 +-
 Documentation/devicetree/bindings/dma/altr,msgdma.yaml          | 2 +-
 Documentation/devicetree/bindings/dma/apple,admac.yaml          | 2 +-
 Documentation/devicetree/bindings/dma/arm-pl08x.yaml            | 2 +-
 Documentation/devicetree/bindings/dma/dma-controller.yaml       | 2 +-
 Documentation/devicetree/bindings/dma/dma-router.yaml           | 2 +-
 Documentation/devicetree/bindings/dma/fsl,edma.yaml             | 2 +-
 Documentation/devicetree/bindings/dma/ingenic,dma.yaml          | 2 +-
 Documentation/devicetree/bindings/dma/intel,ldma.yaml           | 2 +-
 Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml    | 2 +-
 .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml        | 2 +-
 Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml | 2 +-
 Documentation/devicetree/bindings/dma/owl-dma.yaml              | 2 +-
 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml         | 2 +-
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml             | 2 +-
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml    | 2 +-
 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml      | 2 +-
 Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml  | 2 +-
 Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml     | 2 +-
 .../devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml         | 2 +-
 Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml   | 2 +-
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml     | 2 +-
 .../devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml    | 2 +-
 .../devicetree/bindings/dma/socionext,uniphier-xdmac.yaml       | 2 +-
 Documentation/devicetree/bindings/dma/st,stm32-dma.yaml         | 2 +-
 Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml      | 2 +-
 Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml        | 2 +-
 Documentation/devicetree/bindings/dma/stericsson,dma40.yaml     | 2 +-
 30 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
index 26d0d8ab7984..02d5bd035409 100644
--- a/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Maxime Ripard <mripard@kernel.org>
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   "#dma-cells":
diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
index bd599bda2653..ec2d7a789ffe 100644
--- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Maxime Ripard <mripard@kernel.org>
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   "#dma-cells":
diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun6i-a31-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun6i-a31-dma.yaml
index 344dc7e04931..5d554bcfab3d 100644
--- a/Documentation/devicetree/bindings/dma/allwinner,sun6i-a31-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/allwinner,sun6i-a31-dma.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Maxime Ripard <mripard@kernel.org>
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   "#dma-cells":
diff --git a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
index b53ac7631a76..391bf5838602 100644
--- a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
+++ b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
@@ -14,7 +14,7 @@ description: |
   intellectual property (IP)
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/apple,admac.yaml b/Documentation/devicetree/bindings/dma/apple,admac.yaml
index 97282469e4af..05163d124ec3 100644
--- a/Documentation/devicetree/bindings/dma/apple,admac.yaml
+++ b/Documentation/devicetree/bindings/dma/apple,admac.yaml
@@ -18,7 +18,7 @@ maintainers:
   - Martin Povišer <povik+lin@cutebit.org>
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/arm-pl08x.yaml b/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
index 9193b18fb75f..ab25ae63d2c3 100644
--- a/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
+++ b/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 allOf:
   - $ref: /schemas/arm/primecell.yaml#
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 # We need a select here so we don't match all nodes with 'arm,primecell'
 select:
diff --git a/Documentation/devicetree/bindings/dma/dma-controller.yaml b/Documentation/devicetree/bindings/dma/dma-controller.yaml
index 538ebadff652..04d150d4d15d 100644
--- a/Documentation/devicetree/bindings/dma/dma-controller.yaml
+++ b/Documentation/devicetree/bindings/dma/dma-controller.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Vinod Koul <vkoul@kernel.org>
 
 allOf:
-  - $ref: "dma-common.yaml#"
+  - $ref: dma-common.yaml#
 
 # Everything else is described in the common file
 properties:
diff --git a/Documentation/devicetree/bindings/dma/dma-router.yaml b/Documentation/devicetree/bindings/dma/dma-router.yaml
index f8d8c3c88bcc..346fe0fa4460 100644
--- a/Documentation/devicetree/bindings/dma/dma-router.yaml
+++ b/Documentation/devicetree/bindings/dma/dma-router.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Vinod Koul <vkoul@kernel.org>
 
 allOf:
-  - $ref: "dma-common.yaml#"
+  - $ref: dma-common.yaml#
 
 description:
   DMA routers are transparent IP blocks used to route DMA request
diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 050e6cd57727..5fd8fc604261 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -64,7 +64,7 @@ required:
   - dma-channels
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
index fd5b0a8eaed8..37400496e086 100644
--- a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
+++ b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Paul Cercueil <paul@crapouillou.net>
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
index a5c4be783593..d6bb553a2c6f 100644
--- a/Documentation/devicetree/bindings/dma/intel,ldma.yaml
+++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
@@ -11,7 +11,7 @@ maintainers:
   - mallikarjunax.reddy@intel.com
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
index 9ab4d81ead35..dab468a88942 100644
--- a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
@@ -14,7 +14,7 @@ description: |
   for the UART peripheral bus.
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
index 851bd50ee67f..a790e5687844 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -16,7 +16,7 @@ maintainers:
   - Rajesh Gumasta <rgumasta@nvidia.com>
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
index fef804565b88..4003dbe94940 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
@@ -14,7 +14,7 @@ maintainers:
   - Jon Hunter <jonathanh@nvidia.com>
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/owl-dma.yaml b/Documentation/devicetree/bindings/dma/owl-dma.yaml
index 93b4847554fb..ec8b3dc37ca4 100644
--- a/Documentation/devicetree/bindings/dma/owl-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/owl-dma.yaml
@@ -15,7 +15,7 @@ maintainers:
   - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index 003098caf709..f1ddcf672261 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Bjorn Andersson <andersson@kernel.org>
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 1dec506cd4f7..fc5de7b6f19e 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -14,7 +14,7 @@ description: |
   peripheral buses such as I2C, UART, and SPI.
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
index 89b591a05bce..03aa067b1229 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index 1e25c5b0fb4d..f638d3934e71 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Biju Das <biju.das.jz@bp.renesas.com>
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml b/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
index d83013b0dd74..ee9833dcc36c 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
 
 allOf:
-  - $ref: "dma-router.yaml#"
+  - $ref: dma-router.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml
index ab287c652b2c..17813599fccb 100644
--- a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
index 3271755787b4..a1af0b906365 100644
--- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -23,7 +23,7 @@ description: |
   https://static.dev.sifive.com/FU540-C000-v1.0.pdf
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
index c13649bf7f19..5da8291a7de0 100644
--- a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index ad107a4d3b33..2bedab1f74e0 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -13,7 +13,7 @@ description:
   Synopsys DesignWare AXI DMA Controller DT Binding
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml b/Documentation/devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml
index e7bf6dd7da29..23c8a7bf24de 100644
--- a/Documentation/devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml
@@ -14,7 +14,7 @@ maintainers:
   - Masahiro Yamada <yamada.masahiro@socionext.com>
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml b/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
index 371f18773198..da61d1ddc9c3 100644
--- a/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
+++ b/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
@@ -15,7 +15,7 @@ maintainers:
   - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml b/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
index 158c791d7caa..329847ef096a 100644
--- a/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
@@ -53,7 +53,7 @@ maintainers:
   - Amelie Delaunay <amelie.delaunay@foss.st.com>
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   "#dma-cells":
diff --git a/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml b/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
index 3e0b82d277ca..e722fbcd8a5f 100644
--- a/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
+++ b/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Amelie Delaunay <amelie.delaunay@foss.st.com>
 
 allOf:
-  - $ref: "dma-router.yaml#"
+  - $ref: dma-router.yaml#
 
 properties:
   "#dma-cells":
diff --git a/Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml b/Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml
index 08a59bd69a2f..3874544dfa74 100644
--- a/Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml
+++ b/Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml
@@ -53,7 +53,7 @@ maintainers:
   - Amelie Delaunay <amelie.delaunay@foss.st.com>
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   "#dma-cells":
diff --git a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
index 8bddfb3b6fa0..664ee61a00d8 100644
--- a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
+++ b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Linus Walleij <linus.walleij@linaro.org>
 
 allOf:
-  - $ref: "dma-controller.yaml#"
+  - $ref: dma-controller.yaml#
 
 properties:
   "#dma-cells":
-- 
2.34.1

