Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B513A72C0
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jun 2021 01:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhFOABj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Jun 2021 20:01:39 -0400
Received: from relay08.th.seeweb.it ([5.144.164.169]:40985 "EHLO
        relay08.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhFOABj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Jun 2021 20:01:39 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jun 2021 20:01:39 EDT
Received: from localhost.localdomain (83.6.168.161.neoplus.adsl.tpnet.pl [83.6.168.161])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 837B03F31D;
        Tue, 15 Jun 2021 01:54:18 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: sm8250: Add GPI DMA nodes
Date:   Tue, 15 Jun 2021 01:53:58 +0200
Message-Id: <20210614235358.444834-3-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614235358.444834-1-konrad.dybcio@somainline.org>
References: <20210614235358.444834-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add and configure GPI DMA nodes to enable the way for peripherals to make
DMA transfers.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 64 ++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index d45b6aa6fd05..e41d64c6ca56 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,gcc-sm8250.h>
 #include <dt-bindings/clock/qcom,gpucc-sm8250.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sm8250.h>
@@ -520,6 +521,26 @@ opp-120000000 {
 			};
 		};
 
+		gpi_dma2: dma-controller@800000 {
+			compatible = "qcom,sdm845-gpi-dma";
+			reg = <0 0x00800000 0 0x70000>;
+			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 590 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 593 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 596 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <10>;
+			dma-channel-mask = <0x3f>;
+			iommus = <&apps_smmu 0x76 0x0>;
+			#dma-cells = <3>;
+			status = "disabled";
+		};
+
 		qupv3_id_2: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x008c0000 0x0 0x6000>;
@@ -715,6 +736,29 @@ spi19: spi@894000 {
 			};
 		};
 
+		gpi_dma0: dma-controller@900000 {
+			compatible = "qcom,sdm845-gpi-dma";
+			reg = <0 0x00900000 0 0x70000>;
+			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <15>;
+			dma-channel-mask = <0x7ff>;
+			iommus = <&apps_smmu 0x5b6 0x0>;
+			#dma-cells = <3>;
+			status = "disabled";
+		};
+
 		qupv3_id_0: geniqup@9c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x009c0000 0x0 0x6000>;
@@ -962,6 +1006,26 @@ spi7: spi@99c000 {
 			};
 		};
 
+		gpi_dma1: dma-controller@a00000 {
+			compatible = "qcom,sdm845-gpi-dma";
+			reg = <0 0x00a00000 0 0x70000>;
+			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 296 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <10>;
+			dma-channel-mask = <0x3f>;
+			iommus = <&apps_smmu 0x56 0x0>;
+			#dma-cells = <3>;
+			status = "disabled";
+		};
+
 		qupv3_id_1: geniqup@ac0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x00ac0000 0x0 0x6000>;
-- 
2.32.0

