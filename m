Return-Path: <dmaengine+bounces-7428-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F49FC9762F
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 13:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B93AD345DED
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 12:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A388130FC3D;
	Mon,  1 Dec 2025 12:50:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7D525485A;
	Mon,  1 Dec 2025 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764593439; cv=none; b=Q0fefOB0kcAe2CZn3wF2Xd/o2ma5UEM78TfzpAeA4tW/nVob7YTSvniYsy1U4vnJgoae4sp8Yf9rxDwDBxjRDFKTew1yTTmkxhBTOXOpCYbvVXCREZNquZbBJjfPZgN+NmfP1rXAXN/TWKHAuL9CAFO/OV7wANkmNX2sPuWRuNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764593439; c=relaxed/simple;
	bh=cRnvEf51K15FRWQUZ+UAmSDC2DtwCQ2cDp1eEF9GKgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3/I/GgRFEUaB1yC/TnS9g4VuB8sAOZZDBsWMggJjNsVR4/PslnSMwOxXNsqEHhO2ZxKb6UKHp30P9p13aT33qBQpx5OUpneOgmFQdpdAzXoBw6+ke4zlUuylpNpxnxCvyd7qyrdSSoW3IQObVcoyeu0TkCmzSbUHBPnV5E4R+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: lQEaD8+VRJi9x9I/ew6wrw==
X-CSE-MsgGUID: FSHxq62LS+mNV7x4wiE1wg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Dec 2025 21:50:36 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 58FBF42100DB;
	Mon,  1 Dec 2025 21:50:32 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Johan Hovold <johan@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 5/6] arm64: dts: renesas: r9a09g077: add DMAC support
Date: Mon,  1 Dec 2025 14:49:10 +0200
Message-ID: <20251201124911.572395-6-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201124911.572395-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251201124911.572395-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/T2H (R9A09G077) SoC has three instances of the DMAC IP.

Add support for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * remove notes

 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index 6812af127684..ee11efb68638 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -376,6 +376,96 @@ i2c2: i2c@81008000 {
 			status = "disabled";
 		};
 
+		dmac0: dma-controller@800c0000 {
+			compatible = "renesas,r9a09g077-dmac";
+			reg = <0 0x800c0000 0 0x1000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 33 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 40 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 41 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 42 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 43 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 44 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 45 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 46 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 47 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15";
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKH>;
+			power-domains = <&cpg>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+			renesas,icu = <&icu 0>;
+		};
+
+		dmac1: dma-controller@800c1000 {
+			compatible = "renesas,r9a09g077-dmac";
+			reg = <0 0x800c1000 0 0x1000>;
+			interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 49 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 51 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 52 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 53 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 54 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 55 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 56 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 57 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 58 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 59 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 60 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 61 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 62 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 63 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15";
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKH>;
+			power-domains = <&cpg>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+			renesas,icu = <&icu 1>;
+		};
+
+		dmac2: dma-controller@800c2000 {
+			compatible = "renesas,r9a09g077-dmac";
+			reg = <0 0x800c2000 0 0x1000>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 65 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 66 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 67 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 68 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 69 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 70 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 71 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 72 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 76 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 77 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15";
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKH>;
+			power-domains = <&cpg>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+			renesas,icu = <&icu 2>;
+		};
+
 		gmac0: ethernet@80100000 {
 			compatible = "renesas,r9a09g077-gbeth", "snps,dwmac-5.20";
 			reg = <0 0x80100000 0 0x10000>;
-- 
2.52.0

