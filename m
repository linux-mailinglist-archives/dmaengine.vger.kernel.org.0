Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FE13620FC
	for <lists+dmaengine@lfdr.de>; Fri, 16 Apr 2021 15:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243976AbhDPNcL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Apr 2021 09:32:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235011AbhDPNcJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 16 Apr 2021 09:32:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4ED9B611AB;
        Fri, 16 Apr 2021 13:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618579904;
        bh=+ixLBXsOQJbJhcO4SAHjGAMGE+PG5w0UMyRTyWbfUW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RkQoER3ROwKwtIfeNG4gzDVgxV/cdgdMFzjPes8ZQA3vllFVAeFdTn84ELK2W7s1y
         ddt7UcSvgfBcSkZTCd7Iz8JigS/vBdE/PHEpd8uX6hOYuh1/65KvuhqodyD6B0Jzbb
         ++e+lWNIDSCb3rB8hdsje0cn+1VqIbakmJI9ka9F06yh8gOpr/DdAkdnC60vJIoRIl
         xZfvechAVBVjc081CJ7y5E+6QG/1x3L7J9vDXX4Ew02sLVLVjMgI5eOKl/FEA3S9GE
         3z7+5w7DDLgR3OHbL2ivqJQ8tZJ5SCBFrrfegwgQ7biR19Lx/wI1f/LFAWqCHw8h+T
         3p6VnMnzZipig==
From:   Felipe Balbi <balbi@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Felipe Balbi <felipe.balbi@microsoft.com>
Subject: [PATCH 2/2] arm64: boot: dts: qcom: sm8150: Add DMA nodes
Date:   Fri, 16 Apr 2021 16:31:33 +0300
Message-Id: <20210416133133.2067467-3-balbi@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416133133.2067467-1-balbi@kernel.org>
References: <20210416133133.2067467-1-balbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Felipe Balbi <felipe.balbi@microsoft.com>

With this patch, DMA has a chance of probing and doing something
useful.

Signed-off-by: Felipe Balbi <felipe.balbi@microsoft.com>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 72 ++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index c563f381a138..b426e935a36b 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -4,6 +4,7 @@
  * Copyright (c) 2019, Linaro Limited
  */
 
+#include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-aoss-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -577,6 +578,29 @@ gcc: clock-controller@100000 {
 				 <&sleep_clk>;
 		};
 
+		gpi_dma0: qcom,gpi-dma@800000 {
+			#dma-cells = <3>;
+			compatible = "qcom,sm8150-gpi-dma";
+			reg = <0 0x800000 0 0x60000>;
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
+			dma-channels = <13>;
+			dma-channel-mask = <0xfa>;
+			iommus = <&apps_smmu 0x00d6 0x0>;
+			status = "disabled";
+		};
+
 		qupv3_id_0: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x008c0000 0x0 0x6000>;
@@ -612,6 +636,8 @@ spi0: spi@880000 {
 				pinctrl-0 = <&qup_spi0_default>;
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				spi-max-frequency = <50000000>;
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -814,6 +840,29 @@ spi7: spi@89c000 {
 			};
 		};
 
+		gpi_dma1: qcom,gpi-dma@a00000 {
+			#dma-cells = <3>;
+			compatible = "qcom,sm8150-gpi-dma";
+			reg = <0 0xa00000 0 0x60000>;
+			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 296 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <13>;
+			dma-channel-mask = <0xfa>;
+			iommus = <&apps_smmu 0x0616 0x0>;
+			status = "disabled";
+		};
+
 		qupv3_id_1: geniqup@ac0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x00ac0000 0x0 0x6000>;
@@ -1004,6 +1053,29 @@ spi16: spi@a94000 {
 			};
 		};
 
+		gpi_dma2: qcom,gpi-dma@c00000 {
+			#dma-cells = <3>;
+			compatible = "qcom,sm8150-gpi-dma";
+			reg = <0 0xc00000 0 0x60000>;
+			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 590 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 593 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 596 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 599 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 600 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <13>;
+			dma-channel-mask = <0xfa>;
+			iommus = <&apps_smmu 0x07b6 0x0>;
+			status = "disabled";
+		};
+
 		qupv3_id_2: geniqup@cc0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x00cc0000 0x0 0x6000>;
-- 
2.31.1

