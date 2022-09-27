Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322B65EB721
	for <lists+dmaengine@lfdr.de>; Tue, 27 Sep 2022 03:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiI0BtG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 21:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiI0BtF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 21:49:05 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC478A7ABC;
        Mon, 26 Sep 2022 18:49:04 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id y15so4448064ilq.4;
        Mon, 26 Sep 2022 18:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6nRaFKxbUdGw3hm7Pe+tUNPmJp2DkMg6lrcry+JF9NU=;
        b=Y89buaXfoy4pygUaDA7Xx3FMmwtnCNHOE9k/vH7KQ8FPOf2787RmaxyDmRDdvCvIye
         81QtH6S+BipIHxQdQHjvsTJjyvncD5KD3Lw3XrEoOKEqZEljM8brOQeo4GoNm1ihtOVX
         arnpDb+AXrjVRp/Qjn5zschU21wod+yyyMHeONOErZKrHWTbQaqTcH9caMSywcidWR3/
         2pcrNMzT+Relvx6rXZcbgkE3yFUz9i+Q1qPIhxUrT75A8LAlKb+2u0aq9Kiu+BxKBiHY
         i48ANfqGgfqng7/YE4BHOt9C2RxvhOR5jpse+NhgdRM3A6UHzVQvYCbt0Ht7iqyc9GDz
         Rv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6nRaFKxbUdGw3hm7Pe+tUNPmJp2DkMg6lrcry+JF9NU=;
        b=aMkiOMwWEyrJK0CIQvkDGWlgSlyRSk7gTmfDUF4aBJUmiULiLFU/6nysjdWYlGe3DO
         GCq4lJch2bzskhb/NORuXZnNh+Bqp76yqHFLf3UqXkp5d5XrqxgxiOgpzLrnO3Fsctug
         CSucjtlHueednXK77hpZxazCP3fuMAcHH7soAPYZrdyNUBsKqh3NgFkObkO4NkUq9rNS
         IKiNZtJvk+t+u76d8UVL2sLjo703Jt5wVBQBW0nmXvWtMQSNIIDJ4CEwfR7N68yqxneC
         LYQfMqOViGtZIJPmBjGMYfjsQCYBOJrNYFa0blhrpRsV5dvfxN+ujkuReHo0lmNwVQko
         /B8Q==
X-Gm-Message-State: ACrzQf1nJtvMeEaELGcrI60F8fpbk4a+pmmkp7ZeCyLuTfC0TrKNXHtP
        BLjKrY/Xp63WzYlCFauHNcOfxkuDbEI=
X-Google-Smtp-Source: AMsMyM5vc91kFMD47RTL+XEbnkQeTwWuEvDTRV2JjvEkXHAt7RLrM902OI8aX763m5qQvSlyklN8PA==
X-Received: by 2002:a05:6e02:dc3:b0:2ea:d7a4:a5f with SMTP id l3-20020a056e020dc300b002ead7a40a5fmr11533213ilj.308.1664243343896;
        Mon, 26 Sep 2022 18:49:03 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::ac99])
        by smtp.gmail.com with UTF8SMTPSA id bq13-20020a056638468d00b00358329bd6cbsm73693jab.122.2022.09.26.18.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 18:49:03 -0700 (PDT)
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
Subject: [PATCH v3 3/4] arm64: dts: qcom: add gpi-dma fallback compatible
Date:   Mon, 26 Sep 2022 21:48:45 -0400
Message-Id: <20220927014846.32892-4-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927014846.32892-1-mailingradian@gmail.com>
References: <20220927014846.32892-1-mailingradian@gmail.com>
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
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 6 +++---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index cef8c4f4f0ff..281d5109ac3b 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -887,7 +887,7 @@ gcc: clock-controller@100000 {
 		};
 
 		gpi_dma0: dma-controller@800000 {
-			compatible = "qcom,sm8150-gpi-dma";
+			compatible = "qcom,sm8150-gpi-dma", "qcom,sdm845-gpi-dma";
 			reg = <0 0x800000 0 0x60000>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
@@ -1222,7 +1222,7 @@ spi7: spi@89c000 {
 		};
 
 		gpi_dma1: dma-controller@a00000 {
-			compatible = "qcom,sm8150-gpi-dma";
+			compatible = "qcom,sm8150-gpi-dma", "qcom,sdm845-gpi-dma";
 			reg = <0 0xa00000 0 0x60000>;
 			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
@@ -1471,7 +1471,7 @@ spi16: spi@a94000 {
 		};
 
 		gpi_dma2: dma-controller@c00000 {
-			compatible = "qcom,sm8150-gpi-dma";
+			compatible = "qcom,sm8150-gpi-dma", "qcom,sdm845-gpi-dma";
 			reg = <0 0xc00000 0 0x60000>;
 			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a5b62cadb129..5d5de7eead08 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -936,7 +936,7 @@ rng: rng@793000 {
 		};
 
 		gpi_dma2: dma-controller@800000 {
-			compatible = "qcom,sm8250-gpi-dma";
+			compatible = "qcom,sm8250-gpi-dma", "qcom,sdm845-gpi-dma";
 			reg = <0 0x00800000 0 0x70000>;
 			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
@@ -1187,7 +1187,7 @@ spi19: spi@894000 {
 		};
 
 		gpi_dma0: dma-controller@900000 {
-			compatible = "qcom,sm8250-gpi-dma";
+			compatible = "qcom,sm8250-gpi-dma", "qcom,sdm845-gpi-dma";
 			reg = <0 0x00900000 0 0x70000>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
@@ -1505,7 +1505,7 @@ spi7: spi@99c000 {
 		};
 
 		gpi_dma1: dma-controller@a00000 {
-			compatible = "qcom,sm8250-gpi-dma";
+			compatible = "qcom,sm8250-gpi-dma", "qcom,sdm845-gpi-dma";
 			reg = <0 0x00a00000 0 0x70000>;
 			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.37.3

