Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0DA1D1BBC
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 19:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389774AbgEMRAI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 13:00:08 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:37070 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389737AbgEMRAH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 May 2020 13:00:07 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9A64A541;
        Wed, 13 May 2020 18:59:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1589389197;
        bh=d86I8h51jiII3xcIn18ERGpWQLVSCnutBQHUsB1wT3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SKzUfPz1R9dM8zPbFOqQRKZORbWBfjyjS0wvkmjMCbIIzNtRZ5Jwep2copC0h2JV2
         3hMG73rYsDQep2PkP2tLzzfLmb6ZrhAk6vVt7PzgMc9XVhIOZbOtJEB3xnWMjLrnxh
         GXXhB5YdW1T1ZIrQKly5W0fR7mtDPUw6z+dDbTgg=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 6/6] arm64: dts: zynqmp: Add DPDMA node
Date:   Wed, 13 May 2020 19:59:43 +0300
Message-Id: <20200513165943.25120-7-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513165943.25120-1-laurent.pinchart@ideasonboard.com>
References: <20200513165943.25120-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a DT node for the DisplayPort DMA engine (DPDMA).

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  4 ++++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi         | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index 9868ca15dfc5..32c4914738d9 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -57,6 +57,10 @@ &cpu0 {
 	clocks = <&zynqmp_clk ACPU>;
 };
 
+&dpdma {
+	clocks = <&zynqmp_clk DPDMA_REF>;
+};
+
 &fpd_dma_chan1 {
 	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 26d926eb1431..2e284eb8d3c1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -246,6 +246,16 @@ pmu@9000 {
 			};
 		};
 
+		dpdma: dma-controller@fd4c0000 {
+			compatible = "xlnx,zynqmp-dpdma";
+			status = "disabled";
+			reg = <0x0 0xfd4c0000 0x0 0x1000>;
+			interrupts = <0 122 4>;
+			interrupt-parent = <&gic>;
+			clock-names = "axi_clk";
+			#dma-cells = <1>;
+		};
+
 		/* GDMA */
 		fpd_dma_chan1: dma@fd500000 {
 			status = "disabled";
-- 
Regards,

Laurent Pinchart

