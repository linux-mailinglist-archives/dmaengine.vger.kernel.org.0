Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904635F1FBF
	for <lists+dmaengine@lfdr.de>; Sat,  1 Oct 2022 23:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJAVTu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Oct 2022 17:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJAVTr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Oct 2022 17:19:47 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623351056A;
        Sat,  1 Oct 2022 14:19:45 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id l127so3236804iof.12;
        Sat, 01 Oct 2022 14:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3gkovKwNaV5T+QMYSnqdWiKH0URvqosCR5B8+wjjDBc=;
        b=F7q64MO7jmVLbNxJrYU7/yoWWJP69Dg9MsoLd4DQrNALCDcOzDkBoWQUjvtk2k42Ho
         kPlHf++tlQpNZvO1WHqgf2l8mnazd1hDcu6wWAhZwXpcoRjEFW15Eg67bH21eIcVaoet
         D7YvSVlGHcNUrF058XIQ+Gev5IXgvbNzmx4MKaIYsBINLEB51R0h5QcDTGw+i6l5QXoM
         PBjvNa52eHzIzy6iYy+1A9haPAoEZeMJzZn7ig22K5+4iKtH1ncU2GF4p7w2gU9HqbOo
         JOYM6QY3gZCOYM8FjPA9zg0eo47lUlaokvTc/F77ZbW00LTj/N7GHFuPB+NBJG6uQOwb
         QOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3gkovKwNaV5T+QMYSnqdWiKH0URvqosCR5B8+wjjDBc=;
        b=bmTdPeeUkx0fwo82lL+CDdXlfgEp2Nw8Fh3qemYGirFd7FunKjk+oKdUTfjjdjga/o
         ZtB2stJ8U57W8r7Wcfi6Yge4n1D+VRZT5Bt2gel9tMbHFG9K4e+W/zCNjr2fdPV/AeDL
         U6pFqqiGIripn3mdZx55sv8ZonucbhDzyjNOnsyMYDxp+0XSlqgyVlswbhXfOB55Wt35
         ZJQ6x4RxA5psLF6IH9U2MFT9FiPlQvReNv9yQocJQWcMD7irs2cmX1q89iznSPzT3Aj+
         GG8x9S3XY4fK1c3g3vc0UF41pz/kGQGmRVO0/QYGUkeOC5IhU2PIaNDUChtdwnoLcMn8
         Eg1Q==
X-Gm-Message-State: ACrzQf3n1kk/MG1oP30iIbE0qiE51OKM7oU39HKjW5BJdbA6po082o4t
        VFt6ehWqNSElneZdmx+PJojI7/1XvbnM4Q==
X-Google-Smtp-Source: AMsMyM4JkTSZxaJWFiM/vW7T4ZelSzZLTX7F+E1QYhWIm64kDfG3Hg34bqww43/pGKtG89dQdAGmRw==
X-Received: by 2002:a6b:e003:0:b0:6a0:d55b:a3ae with SMTP id z3-20020a6be003000000b006a0d55ba3aemr6318386iog.167.1664659184576;
        Sat, 01 Oct 2022 14:19:44 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id t19-20020a02b193000000b00362c9a4a3a9sm95810jah.113.2022.10.01.14.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 14:19:44 -0700 (PDT)
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
Subject: [PATCH v4 3/4] arm64: dts: qcom: add gpi-dma fallback compatible
Date:   Sat,  1 Oct 2022 17:19:33 -0400
Message-Id: <20221001211934.62511-4-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001211934.62511-1-mailingradian@gmail.com>
References: <20221001211934.62511-1-mailingradian@gmail.com>
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

