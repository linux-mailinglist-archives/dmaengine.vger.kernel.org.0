Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AA822305A
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jul 2020 03:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGQBeD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jul 2020 21:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgGQBeD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jul 2020 21:34:03 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F46C061755
        for <dmaengine@vger.kernel.org>; Thu, 16 Jul 2020 18:34:03 -0700 (PDT)
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C01121027;
        Fri, 17 Jul 2020 03:33:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594949634;
        bh=xak74DmKv7tAKISbdXyZAbebmfILiJAsK6+garSD+jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otDFtAopSaJ7IkYbWJPG7EGjWLoHPoBH5Nrwvt5VoU7o7yQU++QJ0yrOGZYtcSICP
         CcK9Idj0DDesBnywghVPdCmxeGE11cUAPTOz99JOu5ViljbGp48Dg3OdIttRM0GYPa
         TNlq5mZ9Zla4qwsWZAMWiG2POiGP285z0EGQdGQM=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v7 5/5] arm64: dts: zynqmp: Add DPDMA node
Date:   Fri, 17 Jul 2020 04:33:37 +0300
Message-Id: <20200717013337.24122-6-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717013337.24122-1-laurent.pinchart@ideasonboard.com>
References: <20200717013337.24122-1-laurent.pinchart@ideasonboard.com>
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
index 9174ddc76bdc..d2554640db57 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -250,6 +250,16 @@ pmu@9000 {
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

