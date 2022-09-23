Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793B35E84A3
	for <lists+dmaengine@lfdr.de>; Fri, 23 Sep 2022 23:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiIWVJw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Sep 2022 17:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiIWVJt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Sep 2022 17:09:49 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489FA165A0;
        Fri, 23 Sep 2022 14:09:45 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id g6so785552ild.6;
        Fri, 23 Sep 2022 14:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NJALo8J8jVjWQmWHKIzl4pcA87KcMhIrHPBZn5IomZg=;
        b=JcPSRXYGvIQS5Lol/r21PNQLKXLtnC5dbmVAoiNmz1fY/JxbfblrRg4M105aU51LVE
         V3dbc8KmAo4gKmcEaDsbrr5iuTk38wo+ec9tbfWzeAvg1VjTUXSFnvoscwmlQI63yBTY
         9GDtUcghC+ya/hWeAzhCamagbSORSTEPE4EHAc61ReYKz+rwk4546PtL98cYk/KJCSHr
         QtcKRTdFz8Yij6lZt26Bw7D6CgnfDI2VJSSRBN90xNzlRrerx0h1KLLiWmJSUJWU3Xxj
         arEkhcvxBn2bhnVpM/lY+xGYTjBqTsnsh35dVsf2VoeTH+borEfyMAv4Gyj7F5+6FKrs
         Rfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NJALo8J8jVjWQmWHKIzl4pcA87KcMhIrHPBZn5IomZg=;
        b=e9jlpqETrl9PRg1yiXA5RBtITi07K7d5LYd/U8igkhdn7dThGPnWxDgxOw7BP12A26
         c0UTgfhDyWw12PX86zK4zmu0O0gbFBN5lUxprOjh/KNGvvF5PJ25OhZvAvsDI9TaZd0M
         VQ8W+JvrJRWwMMqUk+Ufbh5A3HKxlxjJ57qJF8+G08a2ctTKrtl1ZvLmA0XEIjKpP9qh
         y7/v7os7uK0+yL5hhMFM5522fU/Q6Wk85L6jTsrPB2zwrhuQhvjJ6APr1/qCJOdxZEsY
         eNyZsnaK5z1UIvIrvHNmpAS7ppYNjjQp06wKL1VyuuQ8Zpo9kqQq8NJczBSvG4xLdBOt
         dsUg==
X-Gm-Message-State: ACrzQf32hgLyI3YhiSW3x12uNocOYLyERBXln2/7iNxMTjhKHgRX97xR
        2J62rzhmDgxemJYlawHz4xyncFROXHA=
X-Google-Smtp-Source: AMsMyM4Cry6q6PiSfiKd3dUmYBVWRug5l1n5C99Fil+BdvDMkRj4Xd8GCwPkk42hzfuw8C8DkBlr/A==
X-Received: by 2002:a05:6e02:1a8c:b0:2f6:4364:345f with SMTP id k12-20020a056e021a8c00b002f64364345fmr4955583ilv.242.1663967384470;
        Fri, 23 Sep 2022 14:09:44 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id m21-20020a026d15000000b00355d1d555b6sm3710533jac.116.2022.09.23.14.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 14:09:43 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 3/4] arm64: dts: qcom: add gpi-dma fallback compatible
Date:   Fri, 23 Sep 2022 17:09:33 -0400
Message-Id: <20220923210934.280034-4-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220923210934.280034-1-mailingradian@gmail.com>
References: <20220923210934.280034-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The dt schema for gpi-dma has been updated with a new fallback
compatible string. Add the compatible strings to existing device trees.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 6 +++---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 6 +++---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 6 +++---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 6 +++---
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 8d807b7bf66a..4f8728958898 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -919,7 +919,7 @@ opp-384000000 {
 
 		gpi_dma0: dma-controller@900000 {
 			#dma-cells = <3>;
-			compatible = "qcom,sc7280-gpi-dma";
+			compatible = "qcom,sc7280-gpi-dma", "qcom,gpi-dma";
 			reg = <0 0x00900000 0 0x60000>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
@@ -1418,7 +1418,7 @@ uart7: serial@99c000 {
 
 		gpi_dma1: dma-controller@a00000 {
 			#dma-cells = <3>;
-			compatible = "qcom,sc7280-gpi-dma";
+			compatible = "qcom,sc7280-gpi-dma", "qcom,gpi-dma";
 			reg = <0 0x00a00000 0 0x60000>;
 			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d761da47220d..741b4f200bd0 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1151,7 +1151,7 @@ opp-128000000 {
 
 		gpi_dma0: dma-controller@800000 {
 			#dma-cells = <3>;
-			compatible = "qcom,sdm845-gpi-dma";
+			compatible = "qcom,sdm845-gpi-dma", "qcom,gpi-dma";
 			reg = <0 0x00800000 0 0x60000>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
@@ -1638,7 +1638,7 @@ uart7: serial@89c000 {
 
 		gpi_dma1: dma-controller@0xa00000 {
 			#dma-cells = <3>;
-			compatible = "qcom,sdm845-gpi-dma";
+			compatible = "qcom,sdm845-gpi-dma", "qcom,gpi-dma";
 			reg = <0 0x00a00000 0 0x60000>;
 			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index c39de7d3ace0..346775610ef9 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -521,7 +521,7 @@ opp-384000000 {
 		};
 
 		gpi_dma0: dma-controller@800000 {
-			compatible = "qcom,sm6350-gpi-dma";
+			compatible = "qcom,sm6350-gpi-dma", "qcom,gpi-dma";
 			reg = <0 0x00800000 0 0x60000>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
@@ -594,7 +594,7 @@ i2c2: i2c@888000 {
 		};
 
 		gpi_dma1: dma-controller@900000 {
-			compatible = "qcom,sm6350-gpi-dma";
+			compatible = "qcom,sm6350-gpi-dma", "qcom,gpi-dma";
 			reg = <0 0x00900000 0 0x60000>;
 			interrupts = <GIC_SPI 645 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 646 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index cef8c4f4f0ff..0eea0e6f6611 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -887,7 +887,7 @@ gcc: clock-controller@100000 {
 		};
 
 		gpi_dma0: dma-controller@800000 {
-			compatible = "qcom,sm8150-gpi-dma";
+			compatible = "qcom,sm8150-gpi-dma", "qcom,gpi-dma";
 			reg = <0 0x800000 0 0x60000>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
@@ -1222,7 +1222,7 @@ spi7: spi@89c000 {
 		};
 
 		gpi_dma1: dma-controller@a00000 {
-			compatible = "qcom,sm8150-gpi-dma";
+			compatible = "qcom,sm8150-gpi-dma", "qcom,gpi-dma";
 			reg = <0 0xa00000 0 0x60000>;
 			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
@@ -1471,7 +1471,7 @@ spi16: spi@a94000 {
 		};
 
 		gpi_dma2: dma-controller@c00000 {
-			compatible = "qcom,sm8150-gpi-dma";
+			compatible = "qcom,sm8150-gpi-dma", "qcom,gpi-dma";
 			reg = <0 0xc00000 0 0x60000>;
 			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a5b62cadb129..8b42f7cf289b 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -936,7 +936,7 @@ rng: rng@793000 {
 		};
 
 		gpi_dma2: dma-controller@800000 {
-			compatible = "qcom,sm8250-gpi-dma";
+			compatible = "qcom,sm8250-gpi-dma", "qcom,gpi-dma";
 			reg = <0 0x00800000 0 0x70000>;
 			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
@@ -1187,7 +1187,7 @@ spi19: spi@894000 {
 		};
 
 		gpi_dma0: dma-controller@900000 {
-			compatible = "qcom,sm8250-gpi-dma";
+			compatible = "qcom,sm8250-gpi-dma", "qcom,gpi-dma";
 			reg = <0 0x00900000 0 0x70000>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
@@ -1505,7 +1505,7 @@ spi7: spi@99c000 {
 		};
 
 		gpi_dma1: dma-controller@a00000 {
-			compatible = "qcom,sm8250-gpi-dma";
+			compatible = "qcom,sm8250-gpi-dma", "qcom,gpi-dma";
 			reg = <0 0x00a00000 0 0x70000>;
 			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index cd5503642a23..82d97e5607ad 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -678,7 +678,7 @@ ipcc: mailbox@408000 {
 		};
 
 		gpi_dma2: dma-controller@800000 {
-			compatible = "qcom,sm8350-gpi-dma";
+			compatible = "qcom,sm8350-gpi-dma", "qcom,gpi-dma";
 			reg = <0 0x00800000 0 0x60000>;
 			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
@@ -904,7 +904,7 @@ spi19: spi@894000 {
 		};
 
 		gpi_dma0: dma-controller@900000 {
-			compatible = "qcom,sm8350-gpi-dma";
+			compatible = "qcom,sm8350-gpi-dma", "qcom,gpi-dma";
 			reg = <0 0x09800000 0 0x60000>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
@@ -1209,7 +1209,7 @@ spi7: spi@99c000 {
 		};
 
 		gpi_dma1: dma-controller@a00000 {
-			compatible = "qcom,sm8350-gpi-dma";
+			compatible = "qcom,sm8350-gpi-dma", "qcom,gpi-dma";
 			reg = <0 0x00a00000 0 0x60000>;
 			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index d32f08df743d..10f1655a4626 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -730,7 +730,7 @@ gcc: clock-controller@100000 {
 		};
 
 		gpi_dma2: dma-controller@800000 {
-			compatible = "qcom,sm8450-gpi-dma";
+			compatible = "qcom,sm8450-gpi-dma", "qcom,gpi-dma";
 			#dma-cells = <3>;
 			reg = <0 0x800000 0 0x60000>;
 			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
@@ -1058,7 +1058,7 @@ spi21: spi@898000 {
 		};
 
 		gpi_dma0: dma-controller@900000 {
-			compatible = "qcom,sm8450-gpi-dma";
+			compatible = "qcom,sm8450-gpi-dma", "qcom,gpi-dma";
 			#dma-cells = <3>;
 			reg = <0 0x900000 0 0x60000>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
@@ -1394,7 +1394,7 @@ uart7: serial@99c000 {
 		};
 
 		gpi_dma1: dma-controller@a00000 {
-			compatible = "qcom,sm8450-gpi-dma";
+			compatible = "qcom,sm8450-gpi-dma", "qcom,gpi-dma";
 			#dma-cells = <3>;
 			reg = <0 0xa00000 0 0x60000>;
 			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.37.3

