Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B146546D6
	for <lists+dmaengine@lfdr.de>; Thu, 22 Dec 2022 20:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbiLVTqO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Dec 2022 14:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbiLVTqN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Dec 2022 14:46:13 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89581834F;
        Thu, 22 Dec 2022 11:46:12 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 025CC20230;
        Thu, 22 Dec 2022 20:46:10 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: dts: qcom: sm6125: Add GPI DMA nodes
Date:   Thu, 22 Dec 2022 20:46:00 +0100
Message-Id: <20221222194600.139854-3-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221222194600.139854-1-marijn.suijten@somainline.org>
References: <20221222194600.139854-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Martin Botka <martin.botka@somainline.org>

Add nodes for GPI DMA hosts on SM6125.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
[Marijn: reorder properties, use sdm845 fallback compatible, disable by
 default, use 3 instead of 5 dma cells]
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 37 ++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 7c326368e30d..6f9b56a937c6 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/clock/qcom,gcc-sm6125.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -510,6 +511,42 @@ sdhc_2: mmc@4784000 {
 			status = "disabled";
 		};
 
+		gpi_dma0: dma-controller@4a00000 {
+			compatible = "qcom,sm6125-gpi-dma", "qcom,sdm845-gpi-dma";
+			reg = <0x04a00000 0x60000>;
+			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <8>;
+			dma-channel-mask = <0x1f>;
+			iommus = <&apps_smmu 0x136 0x0>;
+			#dma-cells = <3>;
+			status = "disabled";
+		};
+
+		gpi_dma1: dma-controller@4c00000 {
+			compatible = "qcom,sm6125-gpi-dma", "qcom,sdm845-gpi-dma";
+			reg = <0x04c00000 0x60000>;
+			interrupts = <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <8>;
+			dma-channel-mask = <0x0f>;
+			iommus = <&apps_smmu 0x156 0x0>;
+			#dma-cells = <3>;
+			status = "disabled";
+		};
+
 		usb3: usb@4ef8800 {
 			compatible = "qcom,sm6125-dwc3", "qcom,dwc3";
 			reg = <0x04ef8800 0x400>;
-- 
2.39.0

