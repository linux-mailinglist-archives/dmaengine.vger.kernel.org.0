Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE80362DFC
	for <lists+dmaengine@lfdr.de>; Sat, 17 Apr 2021 08:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhDQGU2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Apr 2021 02:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhDQGU1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 17 Apr 2021 02:20:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B5E7611CC;
        Sat, 17 Apr 2021 06:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618640402;
        bh=VqdogCP7wTnHnRGHkbpRtPUBLzH6ZBsybgn1QsFXNnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YTtyIo1NNPqSMaEI76IwKhhdZAz0zm12DnUQZ9PMPZPtgMV3W0icJ5nxIsThjMbes
         cfUEAo35uQA8V7dY6O34vqc9XqGxyiog7hgRV7j+6U7ZYIIl+PtYEE9CdterxgNHgo
         salzMV0BrfhGDJTNTwAUwvWppv/n7XoMMvuR9Os2dgUb6JjiGk7sfEOsCgLq0yNATj
         2XWFEf+z86KNlAIVxo0CohcmmV9gEoLl25FeCQiqrrivJENWsm+rSpy9nhY4vbLRwn
         PdHWpEygucc+GfgKz7au/WW1erH0BQE7nWUX00fZn+eG/jXF+HUWTN+AVS6CAnCO3e
         UsvSPJbnWhlaA==
From:   Felipe Balbi <balbi@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Felipe Balbi <felipe.balbi@microsoft.com>
Subject: [PATCH v2 2/2] arm64: boot: dts: qcom: sm8150: Add DMA nodes
Date:   Sat, 17 Apr 2021 09:19:51 +0300
Message-Id: <20210417061951.2105530-3-balbi@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210417061951.2105530-1-balbi@kernel.org>
References: <20210417061951.2105530-1-balbi@kernel.org>
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

Changes since v1:

	- Remove dmas property from spi0 (will be added later as a
          separate patch

	- Correct dma unit name to dma-controller

	- Correct binding order (compatible, reg, dma-cells at the end)

 arch/arm64/boot/dts/qcom/sm8150.dtsi | 70 ++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index c563f381a138..d2324c38fd73 100644
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
 
+		gpi_dma0: dma-controller@800000 {
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
+			#dma-cells = <3>;
+			status = "disabled";
+		};
+
 		qupv3_id_0: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x008c0000 0x0 0x6000>;
@@ -814,6 +838,29 @@ spi7: spi@89c000 {
 			};
 		};
 
+		gpi_dma1: dma-controller@a00000 {
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
+			#dma-cells = <3>;
+			status = "disabled";
+		};
+
 		qupv3_id_1: geniqup@ac0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x00ac0000 0x0 0x6000>;
@@ -1004,6 +1051,29 @@ spi16: spi@a94000 {
 			};
 		};
 
+		gpi_dma2: dma-controller@c00000 {
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
+			#dma-cells = <3>;
+			status = "disabled";
+		};
+
 		qupv3_id_2: geniqup@cc0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x00cc0000 0x0 0x6000>;
-- 
2.31.1

