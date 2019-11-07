Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02070F2514
	for <lists+dmaengine@lfdr.de>; Thu,  7 Nov 2019 03:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbfKGCOT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Nov 2019 21:14:19 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:47162 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbfKGCOT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Nov 2019 21:14:19 -0500
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E365ADBD;
        Thu,  7 Nov 2019 03:14:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1573092856;
        bh=bPx3dSeCqlEfmY2c2uuDUHPxqlmRfWW7Hl0Coe2S/PY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EaERo7RBIYsy9e6CwkE4St2p8bb9QxhKPccYrYs80t5axxeWXtDmL2fyROWR1Q3gs
         FZF42r/TgmqM284ZV77aDICxyitSrGn4QvWXXroJfWn00qvbYh0he6b03+i2NQXXm1
         L0OSD+gHUA0ozEY3OwQb1FbLAKLJCdCE3n+jgSP0=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: [PATCH v2 4/4] arm64: dts: zynqmp: Add DPDMA node
Date:   Thu,  7 Nov 2019 04:14:00 +0200
Message-Id: <20191107021400.16474-5-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191107021400.16474-1-laurent.pinchart@ideasonboard.com>
References: <20191107021400.16474-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a DT node for the DisplayPort DMA engine (DPDMA).

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi |  4 ++++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi     | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
index 306ad2157c98..2936e5f97f84 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
@@ -80,6 +80,10 @@
 	clocks = <&clk100 &clk100>;
 };
 
+&dpdma {
+	clocks = <&dpdma_clk>;
+};
+
 &fpd_dma_chan1 {
 	clocks = <&clk600>, <&clk100>;
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 9aa67340a4d8..25d13b2e9cbc 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -190,6 +190,16 @@
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

