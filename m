Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5A31E543C
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 04:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgE1Cw7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 May 2020 22:52:59 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58408 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgE1Cw7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 May 2020 22:52:59 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DF1AC595;
        Thu, 28 May 2020 04:52:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1590634374;
        bh=1atq98ED4TgczS7rdkWotepviHl/zEpCj2MnCfQHfX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dV8j84kHKHasmTLW7U6/l1fYrmF8R9g0+jdehQmXnjEkTRROHQObg9UAlWI2aZ+6S
         jH45GE5hGeorxCOQxGTnB8ZBdj/A9bm3JuxbP7rULccBODabIxKaG/UbdfBHSpMiDv
         xiAtlmEwEY1zka6lFQKrzUoIh4/j3HMieOeSaCug=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v5 6/6] arm64: dts: zynqmp: Add DPDMA node
Date:   Thu, 28 May 2020 05:52:28 +0300
Message-Id: <20200528025228.31638-7-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528025228.31638-1-laurent.pinchart@ideasonboard.com>
References: <20200528025228.31638-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a DT node for the DisplayPort DMA engine (DPDMA).

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
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

