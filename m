Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB84603655
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 01:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJRXEQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Oct 2022 19:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJRXEI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Oct 2022 19:04:08 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A4ED2CFF
        for <dmaengine@vger.kernel.org>; Tue, 18 Oct 2022 16:04:03 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id h10so10307428qvq.7
        for <dmaengine@vger.kernel.org>; Tue, 18 Oct 2022 16:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5onxALWPECvEQDbcc1fJ7WbhZUDY/4v0hgNP7t4FyY=;
        b=uuC5cdGZPruoYSQCrJao34nCJk7xGMr5lItBdzuAKncJM5qZFaEtPqF9dAVEuDckDu
         p6yHAcJbD7ufXcArqgAFJbe65sgJywCblw1tuPel3OWZt3sE+CdoEW4MrQMbGGBHL++A
         C7oP/UDmLY3zXMid9PROm0ctwsMvm3LuFtsNUSnsrktdmj0p0GsCi23sNn1mIaA8KIGK
         gmruarPDwwdQPR/EVQ5/m07KMv6tG6OYc3wYCLMUSDBUGgX5uACGL8pJVntjuW853bNv
         duX1VNKrjvEpydcptjRQWN200asq7DOPoAEAFWhhiqm8NFRrPm6bIEnndBWiXrDHiZsP
         PlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5onxALWPECvEQDbcc1fJ7WbhZUDY/4v0hgNP7t4FyY=;
        b=2LQc5CE6gx+0QgFNlyJMP4rJDJ31bzCe5BejzH8/hRpbtcCQRZhODTaWjC7Xb8GDyo
         5xcOLY83O7oKVhGXb9+JJV273udb9GNT7lQzaP7x6uKAZYkPF7BtLE0j4nj+3dS+swUJ
         PafAsycgrBHcpkYkxCrlotntJTwb2WXmGZ37xqzfwolNGUcH2wQmRYwadZWPD1uV3ZpV
         IwliaMwu/LK6w4iikqTeV9rMGedsTMCbIq1aFk2f3bd/nrrP0TCD4DN8CgOSzDMPz4A1
         uEB2h44zzqh04aqw5LZsQWNHD7/+OrygJ1zi1cY6+KlwGfTK8sYTp/bG2BRboQOvSltf
         GW5A==
X-Gm-Message-State: ACrzQf3hcaEXmyNARQLL6Y0S/OKikIO4rE1bBOa+C1mF9TMAtFdGNIUP
        8qhU6DUy8uTPtk2ZklalRbVzDQ==
X-Google-Smtp-Source: AMsMyM6Q3AYdLg49yo6eXDgSEVL7g3/Syin8kl9+zJaWS0odmGgUQ5IYHT0z3rqloxzxIYSrTeTqeg==
X-Received: by 2002:a05:6214:e49:b0:4b3:f24e:91ac with SMTP id o9-20020a0562140e4900b004b3f24e91acmr4064637qvc.41.1666134242891;
        Tue, 18 Oct 2022 16:04:02 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id 134-20020a370a8c000000b006cbcdc6efedsm3279010qkk.41.2022.10.18.16.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 16:04:02 -0700 (PDT)
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
Subject: [PATCH v2 5/5] arm64: dts: qcom: sm8450: Add GPI DMA compatible fallback
Date:   Tue, 18 Oct 2022 19:03:52 -0400
Message-Id: <20221018230352.1238479-6-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index d32f08df743d..e01a019d8b23 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -730,7 +730,7 @@ gcc: clock-controller@100000 {
 		};
 
 		gpi_dma2: dma-controller@800000 {
-			compatible = "qcom,sm8450-gpi-dma";
+			compatible = "qcom,sm8450-gpi-dma", "qcom,sm6350-gpi-dma";
 			#dma-cells = <3>;
 			reg = <0 0x800000 0 0x60000>;
 			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
@@ -1058,7 +1058,7 @@ spi21: spi@898000 {
 		};
 
 		gpi_dma0: dma-controller@900000 {
-			compatible = "qcom,sm8450-gpi-dma";
+			compatible = "qcom,sm8450-gpi-dma", "qcom,sm6350-gpi-dma";
 			#dma-cells = <3>;
 			reg = <0 0x900000 0 0x60000>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
@@ -1394,7 +1394,7 @@ uart7: serial@99c000 {
 		};
 
 		gpi_dma1: dma-controller@a00000 {
-			compatible = "qcom,sm8450-gpi-dma";
+			compatible = "qcom,sm8450-gpi-dma", "qcom,sm6350-gpi-dma";
 			#dma-cells = <3>;
 			reg = <0 0xa00000 0 0x60000>;
 			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.34.1

