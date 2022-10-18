Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8630E603658
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 01:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJRXER (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Oct 2022 19:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJRXEI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Oct 2022 19:04:08 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B746BE2E1
        for <dmaengine@vger.kernel.org>; Tue, 18 Oct 2022 16:04:02 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id y10so10292893qvo.11
        for <dmaengine@vger.kernel.org>; Tue, 18 Oct 2022 16:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SKk0pUCgLwhfjypSgrxLtxlJmX8JgawfBhUMDt+ICk=;
        b=rx7VVK5ft2n8lkM2P4qqZRQd1rQS+I7yjKxd7JiSZSiV0LG88/MztFwwdaluywnpeS
         8re6JNhf4LBDetzpO5hy7aDBnIoa3yG/2ChqAyr2MTXOfySxWA/0ywm1ru+ou42zQXss
         QWbhmmD5jct0slMbOVIRQf1yudylF6zbJwPzWc9m2d1iX0NLAWj2BVQppVQcVAmopkfl
         1Mvuh6QcLv6kAlV1GgvGKmv+PeMeIhcxdGExslomIUpxT8jthlzJoinLwQA/5STsR9tw
         bwrV8DzhE6ngC09Qv3JMMlBhQSBqxJW8rBv31Ol5inBThCFMiT0XlE8OKvOZ1XFDzoq2
         zr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SKk0pUCgLwhfjypSgrxLtxlJmX8JgawfBhUMDt+ICk=;
        b=t7R5afnO4fbOz1hHttmYkY8TCuDy2IBZoLytMOSoDDq20hc2wtb7zyYnhg+jG4+eTN
         vIxy3FDLc+4hgFN29GduXctYq1IpXe2JKuGTEWH5j9fNNR/L81iwMehETcTTfu5hXqUf
         r81uPFUflM9I94xdLr9sHw7Tf+ulUWw41nloHp7FQa2bGIS6+eh2x6/ilMyfFJpk1OZF
         g1urW8wpBihjvuGlOjCJIjuHWD1eNkU81UdIxRtQSySqvjMKxRRtxY8WGHgP/ktY2uSb
         svBaL6/M13iE5osuqETSVP27uY+gPdh0sUaEbmUtpTNus7PXPjqVYzi++WESTG6Ntu61
         Gtag==
X-Gm-Message-State: ACrzQf0yM8Bt7oKTjvyKglXudc0wHUUg9QZUN3C7kPVzsdKTzHLVlIs+
        v44q0/9IWUdHsN7obrAvcCYGIg==
X-Google-Smtp-Source: AMsMyM698ltExeKoStVUihmZuHnd3N0x3PJZiOL7qQ+N+7HYSg3kLCbhvGf4ExcA4ZeAn2Y5BHdffg==
X-Received: by 2002:a05:6214:29eb:b0:4af:b287:8ff6 with SMTP id jv11-20020a05621429eb00b004afb2878ff6mr4365906qvb.65.1666134240416;
        Tue, 18 Oct 2022 16:04:00 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id 134-20020a370a8c000000b006cbcdc6efedsm3279010qkk.41.2022.10.18.16.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 16:03:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 4/5] arm64: dts: qcom: sm8350: Add GPI DMA compatible fallback
Date:   Tue, 18 Oct 2022 19:03:51 -0400
Message-Id: <20221018230352.1238479-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018230352.1238479-1-krzysztof.kozlowski@linaro.org>
References: <20221018230352.1238479-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
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

Use SM6350 as fallback for GPI DMA, to indicate devices are compatible
and that drivers can bind with only one compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index a86d9ea93b9d..aa08c0e065c7 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -678,7 +678,7 @@ ipcc: mailbox@408000 {
 		};
 
 		gpi_dma2: dma-controller@800000 {
-			compatible = "qcom,sm8350-gpi-dma";
+			compatible = "qcom,sm8350-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0 0x00800000 0 0x60000>;
 			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
@@ -904,7 +904,7 @@ spi19: spi@894000 {
 		};
 
 		gpi_dma0: dma-controller@900000 {
-			compatible = "qcom,sm8350-gpi-dma";
+			compatible = "qcom,sm8350-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0 0x09800000 0 0x60000>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
@@ -1209,7 +1209,7 @@ spi7: spi@99c000 {
 		};
 
 		gpi_dma1: dma-controller@a00000 {
-			compatible = "qcom,sm8350-gpi-dma";
+			compatible = "qcom,sm8350-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0 0x00a00000 0 0x60000>;
 			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.34.1

