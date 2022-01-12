Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B7C48C6E7
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jan 2022 16:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354501AbiALPP4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jan 2022 10:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354488AbiALPPt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jan 2022 10:15:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60680C06175B
        for <dmaengine@vger.kernel.org>; Wed, 12 Jan 2022 07:15:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1n7fLj-00031H-Qm; Wed, 12 Jan 2022 16:15:43 +0100
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mtr@pengutronix.de>)
        id 1n7fLi-009ufN-Vt; Wed, 12 Jan 2022 16:15:42 +0100
Received: from mtr by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mtr@pengutronix.de>)
        id 1n7fLh-005Zg0-Hy; Wed, 12 Jan 2022 16:15:41 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com,
        m.tretter@pengutronix.de, kernel@pengutronix.de
Subject: [PATCH 2/3] arm64: zynqmp: Add missing #dma-cells property
Date:   Wed, 12 Jan 2022 16:15:40 +0100
Message-Id: <20220112151541.1328732-3-m.tretter@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220112151541.1328732-1-m.tretter@pengutronix.de>
References: <20220112151541.1328732-1-m.tretter@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Requesting the dma controllers fails if #dma-cells is not defined. Add
the missing property.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 493719f71fb5..6d96b6b99f84 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -261,6 +261,7 @@ fpd_dma_chan1: dma@fd500000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 124 4>;
 			clock-names = "clk_main", "clk_apb";
+			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
 			iommus = <&smmu 0x14e8>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
@@ -273,6 +274,7 @@ fpd_dma_chan2: dma@fd510000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 125 4>;
 			clock-names = "clk_main", "clk_apb";
+			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
 			iommus = <&smmu 0x14e9>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
@@ -285,6 +287,7 @@ fpd_dma_chan3: dma@fd520000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 126 4>;
 			clock-names = "clk_main", "clk_apb";
+			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
 			iommus = <&smmu 0x14ea>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
@@ -297,6 +300,7 @@ fpd_dma_chan4: dma@fd530000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 127 4>;
 			clock-names = "clk_main", "clk_apb";
+			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
 			iommus = <&smmu 0x14eb>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
@@ -309,6 +313,7 @@ fpd_dma_chan5: dma@fd540000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 128 4>;
 			clock-names = "clk_main", "clk_apb";
+			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
 			iommus = <&smmu 0x14ec>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
@@ -321,6 +326,7 @@ fpd_dma_chan6: dma@fd550000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 129 4>;
 			clock-names = "clk_main", "clk_apb";
+			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
 			iommus = <&smmu 0x14ed>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
@@ -333,6 +339,7 @@ fpd_dma_chan7: dma@fd560000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 130 4>;
 			clock-names = "clk_main", "clk_apb";
+			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
 			iommus = <&smmu 0x14ee>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
@@ -345,6 +352,7 @@ fpd_dma_chan8: dma@fd570000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 131 4>;
 			clock-names = "clk_main", "clk_apb";
+			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
 			iommus = <&smmu 0x14ef>;
 			power-domains = <&zynqmp_firmware PD_GDMA>;
@@ -374,6 +382,7 @@ lpd_dma_chan1: dma@ffa80000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 77 4>;
 			clock-names = "clk_main", "clk_apb";
+			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
 			iommus = <&smmu 0x868>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
@@ -386,6 +395,7 @@ lpd_dma_chan2: dma@ffa90000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 78 4>;
 			clock-names = "clk_main", "clk_apb";
+			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
 			iommus = <&smmu 0x869>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
@@ -398,6 +408,7 @@ lpd_dma_chan3: dma@ffaa0000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 79 4>;
 			clock-names = "clk_main", "clk_apb";
+			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
 			iommus = <&smmu 0x86a>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
@@ -410,6 +421,7 @@ lpd_dma_chan4: dma@ffab0000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 80 4>;
 			clock-names = "clk_main", "clk_apb";
+			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
 			iommus = <&smmu 0x86b>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
@@ -422,6 +434,7 @@ lpd_dma_chan5: dma@ffac0000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 81 4>;
 			clock-names = "clk_main", "clk_apb";
+			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
 			iommus = <&smmu 0x86c>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
@@ -434,6 +447,7 @@ lpd_dma_chan6: dma@ffad0000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 82 4>;
 			clock-names = "clk_main", "clk_apb";
+			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
 			iommus = <&smmu 0x86d>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
@@ -446,6 +460,7 @@ lpd_dma_chan7: dma@ffae0000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 83 4>;
 			clock-names = "clk_main", "clk_apb";
+			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
 			iommus = <&smmu 0x86e>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
@@ -458,6 +473,7 @@ lpd_dma_chan8: dma@ffaf0000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 84 4>;
 			clock-names = "clk_main", "clk_apb";
+			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
 			iommus = <&smmu 0x86f>;
 			power-domains = <&zynqmp_firmware PD_ADMA>;
-- 
2.30.2

