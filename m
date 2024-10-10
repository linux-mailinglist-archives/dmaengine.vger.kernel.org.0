Return-Path: <dmaengine+bounces-3316-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF9A9989FA
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 16:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE84C1C2434F
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 14:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13FB1E5707;
	Thu, 10 Oct 2024 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="X9xdoSGc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1411E501C;
	Thu, 10 Oct 2024 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570698; cv=none; b=ARicn7mP4cDN7yT/Z4q7oqDEaOu1toISxaorYMfJmyo/vMWYsAYW78M1iVNJdC4IYbHSPg69HZkRRxCh4KbuEfWwaPG70OSiF56QPB6KQE7wV9mnT11PnFOAF3dlZJ91OiieLPXRuHn5WHZl91HCbSkaXFU5q/CRGi8MmvE42TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570698; c=relaxed/simple;
	bh=3v6FjEfaz++4mLu4YmJye5IHpRVQYZ2nW5wvg/RaGVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BxdYa6lvEIFiUneP0u0bJeh6R6MDCnd7vrUUn9YDgrT9apToeq96T3uuUW/DkJn/egtK62yxEgilEMD0laHYzv+eSNswH6lFBL61wfKjqSajiBhV0xVXUBl5sGY0N4G/rWgA37YCmLF+elyxPxsBWFhS/2zKqAsP/HcLnQIAZGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=X9xdoSGc; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AEHIn5000480;
	Thu, 10 Oct 2024 16:31:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	8MPyclVKhT1SqE2t4XVJpyWaFLL2aGVzJRzqILZ09Yc=; b=X9xdoSGcd7v/ZGT8
	7LCp231hd5gwZRaeWLGEFnNIiJFny50VWdIJFqV2BaPX3lPRQ29ZbViFKYkroa2V
	9QLsC/6yz7/7u6PA62KAAqyJVwMNX7xzz0zjODPCF4OpkGLo9E0rP9ZA+oGWWYdB
	pQ9R0hfojWv6S/jFjOnl3Gt9EFlWTOA3S5BRLBCJm++2l8I/tnXSKFkMSmqA7YtQ
	QpiR9UU9QqmFGkaM0SvZZYrMf1cm7Fzh6ADi3riRwfAu/aPP285oSQOSWvFtVI+p
	VsL/nrjA/ZLN7D+Lh3oVBVgZYliXgg8r/lu47//YASh3Kn6Kebwjhe9hucPFbQ00
	UZBM0Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 423f117cxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 16:31:17 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CC97B40090;
	Thu, 10 Oct 2024 16:30:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6C6F12A2FD3;
	Thu, 10 Oct 2024 16:28:13 +0200 (CEST)
Received: from localhost (10.252.31.182) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 10 Oct
 2024 16:28:13 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Thu, 10 Oct 2024 16:27:59 +0200
Subject: [PATCH 09/11] arm64: dts: st: add DMA support on U(S)ART instances
 of stm32mp25
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241010-dma3-mp25-updates-v1-9-adf0633981ea@foss.st.com>
References: <20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com>
In-Reply-To: <20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add dmas and dma-names properties in u(s)art nodes of stm32mp251.dtsi to
enable DMA support.
RX channel requires to prevent pack/unpack feature of DMA to avoid losing
bytes when interrupting RX transfer, as it uses a cyclic buffer.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi     | 27 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 443cc8d6ae8e9e2bff1bb862b0921d9626bb78e1..02fcb9fcff87ba9d5c1ecab0385e3a57cde31e2e 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -269,6 +269,9 @@ usart2: serial@400e0000 {
 				reg = <0x400e0000 0x400>;
 				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&rcc CK_KER_USART2>;
+				dmas = <&hpdma 11 0x20 0x10012>,
+				       <&hpdma 12 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 32>;
 				status = "disabled";
 			};
@@ -278,6 +281,9 @@ usart3: serial@400f0000 {
 				reg = <0x400f0000 0x400>;
 				interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&rcc CK_KER_USART3>;
+				dmas = <&hpdma 13 0x20 0x10012>,
+				       <&hpdma 14 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 33>;
 				status = "disabled";
 			};
@@ -287,6 +293,9 @@ uart4: serial@40100000 {
 				reg = <0x40100000 0x400>;
 				interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&rcc CK_KER_UART4>;
+				dmas = <&hpdma 15 0x20 0x10012>,
+				       <&hpdma 16 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 34>;
 				status = "disabled";
 			};
@@ -296,6 +305,9 @@ uart5: serial@40110000 {
 				reg = <0x40110000 0x400>;
 				interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&rcc CK_KER_UART5>;
+				dmas = <&hpdma 17 0x20 0x10012>,
+				       <&hpdma 18 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 35>;
 				status = "disabled";
 			};
@@ -396,6 +408,9 @@ usart6: serial@40220000 {
 				reg = <0x40220000 0x400>;
 				interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&rcc CK_KER_USART6>;
+				dmas = <&hpdma 19 0x20 0x10012>,
+				       <&hpdma 20 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 36>;
 				status = "disabled";
 			};
@@ -441,6 +456,9 @@ uart9: serial@402c0000 {
 				reg = <0x402c0000 0x400>;
 				interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&rcc CK_KER_UART9>;
+				dmas = <&hpdma 25 0x20 0x10012>,
+				       <&hpdma 26 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 39>;
 				status = "disabled";
 			};
@@ -450,6 +468,9 @@ usart1: serial@40330000 {
 				reg = <0x40330000 0x400>;
 				interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&rcc CK_KER_USART1>;
+				dmas = <&hpdma 9 0x20 0x10012>,
+				       <&hpdma 10 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 31>;
 				status = "disabled";
 			};
@@ -483,6 +504,9 @@ uart7: serial@40370000 {
 				reg = <0x40370000 0x400>;
 				interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&rcc CK_KER_UART7>;
+				dmas = <&hpdma 21 0x20 0x10012>,
+				       <&hpdma 22 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 37>;
 				status = "disabled";
 			};
@@ -492,6 +516,9 @@ uart8: serial@40380000 {
 				reg = <0x40380000 0x400>;
 				interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&rcc CK_KER_UART8>;
+				dmas = <&hpdma 23 0x20 0x10012>,
+				       <&hpdma 24 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 38>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 214191a8322b81e7ae453503863b4465d9b625e0..d468dcbe849680de812a0ddd593f30cbf507f645 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -157,6 +157,8 @@ &usart2 {
 	pinctrl-0 = <&usart2_pins_a>;
 	pinctrl-1 = <&usart2_idle_pins_a>;
 	pinctrl-2 = <&usart2_sleep_pins_a>;
+	/delete-property/dmas;
+	/delete-property/dma-names;
 	status = "okay";
 };
 

-- 
2.25.1


