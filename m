Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27FF602008
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 02:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJRA6D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 20:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiJRA57 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 20:57:59 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A68E1F2E4;
        Mon, 17 Oct 2022 17:57:57 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id i65so10621157ioa.0;
        Mon, 17 Oct 2022 17:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHb659dRKjS34iRpN5S8qZLZW/bi4pJGRDjrLJdy9vk=;
        b=VjW7wk4V3SledJo6tEBA2pMqF7mJc6ceo/2UI/f2HIWEk69GtoFBWrRTW+LqlidubS
         uACP/gsGI9rFljsBg1atTvhDN8tdSQ1Iw7BAvzOU5gZ/oKQ+9OpkV5Fjv8NYU8BbPRuM
         7ZFfCtU296/VXi5cNalxql9l4BkqjSj47ViwrsvB+f7W03z9r9MwbbBn8Rls7vqNPphU
         TAmJsi4HGpQf7/IQabmh8rie6IgWSnRBz9+pglKHmi7mx8quDBhHxIC40sIMIum0+A0b
         Cuf8TVsl839lsvYq4CapDIqT+pOY5trF8N9gbTe7y5lQKDZXqIw8XD4BSeCG49Vpnf0+
         KyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHb659dRKjS34iRpN5S8qZLZW/bi4pJGRDjrLJdy9vk=;
        b=r6X79Lqck5+NmKx+IwBF2Db9sxgfB54+aQnXlvIZAiQpf85jqIYlJWQZRK/QGuUgwo
         YQy0NT7xaSu8yvJveEW6BuH6408bo763Nga6k4aYi5Hm/DO4VuAN4HtHwXNCUnlMG/Cv
         apaIOxVlNI0t7qlTqpwfP8NWaeviSlcDhCVevljHSKBDyui+gKjz45BHDcLsAP5H5iii
         v4oo61hXs0DptAuF/RbrCIAENQDqguaCUoeLMgp5beuHF3DkSIoH+WOh+2O0JE6yiM4/
         WgjXVMRAlH0SKMryPRPlNNX6ry9Ew5i//ENutXVg5gMFwRUr5Xa4z8MX/KtLWUk55lXD
         Ke/g==
X-Gm-Message-State: ACrzQf38xcch7aC0FMfPCj/g/sTU/pA7PII6Y5rqWqia01ONKCh87O6V
        WyUu2lHx+ittfDarkjJhSI8xwFNMHP8RPg==
X-Google-Smtp-Source: AMsMyM4PZIvevqllKuvN+/G0+w9IG1UsFQbK9f1L4BQ1h1y2Rm3yL6ySEf/iCRXR8UQqtzKLgsyI/w==
X-Received: by 2002:a05:6602:2b06:b0:67f:fdf6:ffc2 with SMTP id p6-20020a0566022b0600b0067ffdf6ffc2mr527019iov.111.1666054676328;
        Mon, 17 Oct 2022 17:57:56 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4a89])
        by smtp.gmail.com with UTF8SMTPSA id x95-20020a0294e8000000b00363b5d4e701sm497480jah.167.2022.10.17.17.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 17:57:55 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 4/4] arm64: dts: qcom: add gpi-dma fallback compatible
Date:   Mon, 17 Oct 2022 20:57:40 -0400
Message-Id: <20221018005740.23952-5-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018005740.23952-1-mailingradian@gmail.com>
References: <20221018005740.23952-1-mailingradian@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
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
2.38.0

