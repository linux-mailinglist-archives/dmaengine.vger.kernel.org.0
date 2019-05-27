Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34E2B2B09F
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 10:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfE0IuL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 04:50:11 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35790 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfE0IuK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 May 2019 04:50:10 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 562AF1A0B51;
        Mon, 27 May 2019 10:50:07 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6AAFD1A0B6C;
        Mon, 27 May 2019 10:50:01 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F31E1402FF;
        Mon, 27 May 2019 16:49:53 +0800 (SGT)
From:   yibin.gong@nxp.com
To:     robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, mark.rutland@arm.com, vkoul@kernel.org,
        dan.j.williams@intel.com
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 5/7] dt-bindings: dma: fsl-edma: add new i.mx7ulp-edma
Date:   Mon, 27 May 2019 16:51:16 +0800
Message-Id: <20190527085118.40423-6-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527085118.40423-1-yibin.gong@nxp.com>
References: <20190527085118.40423-1-yibin.gong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

More channel interrupts, one more clock, and only one
dmamux on i.mx7ulp-edma.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl-edma.txt | 44 +++++++++++++++++++---
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl-edma.txt b/Documentation/devicetree/bindings/dma/fsl-edma.txt
index 97e213e..29dd3cc 100644
--- a/Documentation/devicetree/bindings/dma/fsl-edma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-edma.txt
@@ -9,15 +9,16 @@ group, DMAMUX0 or DMAMUX1, but not both.
 Required properties:
 - compatible :
 	- "fsl,vf610-edma" for eDMA used similar to that on Vybrid vf610 SoC
+	- "fsl,imx7ulp-edma" for eDMA2 used similar to that on i.mx7ulp
 - reg : Specifies base physical address(s) and size of the eDMA registers.
 	The 1st region is eDMA control register's address and size.
 	The 2nd and the 3rd regions are programmable channel multiplexing
 	control register's address and size.
 - interrupts : A list of interrupt-specifiers, one for each entry in
-	interrupt-names.
-- interrupt-names : Should contain:
-	"edma-tx" - the transmission interrupt
-	"edma-err" - the error interrupt
+	interrupt-names on vf610 similar SoC. But for i.mx7ulp per channel
+	per transmission interrupt, total 16 channel interrupt and 1
+	error interrupt(located in the last), no interrupt-names list on
+	i.mx7ulp for clean on dts.
 - #dma-cells : Must be <2>.
 	The 1st cell specifies the DMAMUX(0 for DMAMUX0 and 1 for DMAMUX1).
 	Specific request source can only be multiplexed by specific channels
@@ -28,6 +29,7 @@ Required properties:
 - clock-names : A list of channel group clock names. Should contain:
 	"dmamux0" - clock name of mux0 group
 	"dmamux1" - clock name of mux1 group
+	Note: No dmamux0 on i.mx7ulp, but another 'dma' clk added on i.mx7ulp.
 - clocks : A list of phandle and clock-specifier pairs, one for each entry in
 	clock-names.
 
@@ -35,6 +37,10 @@ Optional properties:
 - big-endian: If present registers and hardware scatter/gather descriptors
 	of the eDMA are implemented in big endian mode, otherwise in little
 	mode.
+- interrupt-names : Should contain the below on vf610 similar SoC but not used
+	on i.mx7ulp similar SoC:
+	"edma-tx" - the transmission interrupt
+	"edma-err" - the error interrupt
 
 
 Examples:
@@ -52,8 +58,36 @@ edma0: dma-controller@40018000 {
 	clock-names = "dmamux0", "dmamux1";
 	clocks = <&clks VF610_CLK_DMAMUX0>,
 		<&clks VF610_CLK_DMAMUX1>;
-};
+}; /* vf610 */
 
+edma1: dma-controller@40080000 {
+	#dma-cells = <2>;
+	compatible = "fsl,imx7ulp-edma";
+	reg = <0x40080000 0x2000>,
+		<0x40210000 0x1000>;
+	dma-channels = <32>;
+	interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+		     /* last is eDMA2-ERR interrupt */
+		     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+	clock-names = "dma", "dmamux0";
+	clocks = <&pcc2 IMX7ULP_CLK_DMA1>,
+		 <&pcc2 IMX7ULP_CLK_DMA_MUX1>;
+}; /* i.mx7ulp */
 
 * DMA clients
 DMA client drivers that uses the DMA function must use the format described
-- 
2.7.4

