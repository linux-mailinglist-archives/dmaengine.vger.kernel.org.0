Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C58C48C6E8
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jan 2022 16:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354488AbiALPP5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jan 2022 10:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354489AbiALPPt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jan 2022 10:15:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8AEC06175C
        for <dmaengine@vger.kernel.org>; Wed, 12 Jan 2022 07:15:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1n7fLj-00031N-QU; Wed, 12 Jan 2022 16:15:43 +0100
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mtr@pengutronix.de>)
        id 1n7fLj-009ufV-KL; Wed, 12 Jan 2022 16:15:42 +0100
Received: from mtr by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mtr@pengutronix.de>)
        id 1n7fLh-005Zg3-Ib; Wed, 12 Jan 2022 16:15:41 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com,
        m.tretter@pengutronix.de, kernel@pengutronix.de
Subject: [PATCH 3/3] arm64: zynqmp: Rename dma to dma-controller
Date:   Wed, 12 Jan 2022 16:15:41 +0100
Message-Id: <20220112151541.1328732-4-m.tretter@pengutronix.de>
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

The ZynqMP dma engines are actually dma-controllers as specified by the
device tree binding. Rename the device tree nodes accordingly.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 32 +++++++++++++-------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 6d96b6b99f84..3e15391e5b37 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -254,7 +254,7 @@ pmu@9000 {
 		};
 
 		/* GDMA */
-		fpd_dma_chan1: dma@fd500000 {
+		fpd_dma_chan1: dma-controller@fd500000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd500000 0x0 0x1000>;
@@ -267,7 +267,7 @@ fpd_dma_chan1: dma@fd500000 {
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
-		fpd_dma_chan2: dma@fd510000 {
+		fpd_dma_chan2: dma-controller@fd510000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd510000 0x0 0x1000>;
@@ -280,7 +280,7 @@ fpd_dma_chan2: dma@fd510000 {
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
-		fpd_dma_chan3: dma@fd520000 {
+		fpd_dma_chan3: dma-controller@fd520000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd520000 0x0 0x1000>;
@@ -293,7 +293,7 @@ fpd_dma_chan3: dma@fd520000 {
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
-		fpd_dma_chan4: dma@fd530000 {
+		fpd_dma_chan4: dma-controller@fd530000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd530000 0x0 0x1000>;
@@ -306,7 +306,7 @@ fpd_dma_chan4: dma@fd530000 {
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
-		fpd_dma_chan5: dma@fd540000 {
+		fpd_dma_chan5: dma-controller@fd540000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd540000 0x0 0x1000>;
@@ -319,7 +319,7 @@ fpd_dma_chan5: dma@fd540000 {
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
-		fpd_dma_chan6: dma@fd550000 {
+		fpd_dma_chan6: dma-controller@fd550000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd550000 0x0 0x1000>;
@@ -332,7 +332,7 @@ fpd_dma_chan6: dma@fd550000 {
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
-		fpd_dma_chan7: dma@fd560000 {
+		fpd_dma_chan7: dma-controller@fd560000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd560000 0x0 0x1000>;
@@ -345,7 +345,7 @@ fpd_dma_chan7: dma@fd560000 {
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
-		fpd_dma_chan8: dma@fd570000 {
+		fpd_dma_chan8: dma-controller@fd570000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd570000 0x0 0x1000>;
@@ -375,7 +375,7 @@ gic: interrupt-controller@f9010000 {
 		 * These dma channels, Users should ensure that these dma
 		 * Channels are allowed for non secure access.
 		 */
-		lpd_dma_chan1: dma@ffa80000 {
+		lpd_dma_chan1: dma-controller@ffa80000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffa80000 0x0 0x1000>;
@@ -388,7 +388,7 @@ lpd_dma_chan1: dma@ffa80000 {
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
-		lpd_dma_chan2: dma@ffa90000 {
+		lpd_dma_chan2: dma-controller@ffa90000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffa90000 0x0 0x1000>;
@@ -401,7 +401,7 @@ lpd_dma_chan2: dma@ffa90000 {
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
-		lpd_dma_chan3: dma@ffaa0000 {
+		lpd_dma_chan3: dma-controller@ffaa0000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffaa0000 0x0 0x1000>;
@@ -414,7 +414,7 @@ lpd_dma_chan3: dma@ffaa0000 {
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
-		lpd_dma_chan4: dma@ffab0000 {
+		lpd_dma_chan4: dma-controller@ffab0000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffab0000 0x0 0x1000>;
@@ -427,7 +427,7 @@ lpd_dma_chan4: dma@ffab0000 {
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
-		lpd_dma_chan5: dma@ffac0000 {
+		lpd_dma_chan5: dma-controller@ffac0000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffac0000 0x0 0x1000>;
@@ -440,7 +440,7 @@ lpd_dma_chan5: dma@ffac0000 {
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
-		lpd_dma_chan6: dma@ffad0000 {
+		lpd_dma_chan6: dma-controller@ffad0000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffad0000 0x0 0x1000>;
@@ -453,7 +453,7 @@ lpd_dma_chan6: dma@ffad0000 {
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
-		lpd_dma_chan7: dma@ffae0000 {
+		lpd_dma_chan7: dma-controller@ffae0000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffae0000 0x0 0x1000>;
@@ -466,7 +466,7 @@ lpd_dma_chan7: dma@ffae0000 {
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
-		lpd_dma_chan8: dma@ffaf0000 {
+		lpd_dma_chan8: dma-controller@ffaf0000 {
 			status = "disabled";
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffaf0000 0x0 0x1000>;
-- 
2.30.2

