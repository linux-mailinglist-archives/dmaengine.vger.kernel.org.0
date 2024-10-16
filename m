Return-Path: <dmaengine+bounces-3383-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DE09A0A92
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2024 14:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C197B2992B
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2024 12:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7DE20C480;
	Wed, 16 Oct 2024 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="rCzgGH3r"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EBA208D63;
	Wed, 16 Oct 2024 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082598; cv=none; b=HSVy9XIXq5n8kErkQK0ZD9F4/acVGK4GRvmFEdbR7PwXzwXsu7n+y6bG2aaLwoUCBkTyRCMhJVd42myaQQhwxI71UWyVkzbCTnY3t+zjb7eO08CbJKNjpzK+COtCobKBMSUnIUBu+8vOCXH4BjD/sESu/rUOiTcjtkwHRFQfazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082598; c=relaxed/simple;
	bh=UbN/dByhvTSbSeoPfBiRX/vO2M0WLylvxyBrvYKBvzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Ym1g49BoQekDt1n70zVfx7aPLjiX+QIwm/KZsx5/V8JUj2MySSyTmtYBL1tkFacV4gboFZxjLiVCw324ZpN9aDgXM41dKMWklCBjL5PZbyeTUQgsfjKs3wHA6havucWuOoy58j4Y3zxa4Y55cgmPlEWone8Tmwp+c90OOiX3eFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=rCzgGH3r; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G8o7FK018075;
	Wed, 16 Oct 2024 14:42:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	QY3+4yFvEuS+q43fMZ7qPJn6kolc7ne5LyE/5i7vFNg=; b=rCzgGH3rbhpPvAeM
	9Ky4rLWql2K5YYqtqu0JoZnQ8Rp5U1twv1av2IW4gRe4aGrzq+A1J0TqkTDgGCNW
	umYdVobhgxSd62yPzlKUl9xMsZYFU+ZXB+p2zXsc5MBHzECyXKrmLAcDLLB0SJt/
	sDfABUmsndpwo+8GDfNuKr2GMkmAADPx6dAPR8TK8gzQE0x/d4y1WwgtOwkKWa5L
	/3JZCYvlVUy+CaCLqGMuxfBrHNpfWVGwJmWkaV425Wyy8etn0PG0HbBRRPmzFmZE
	MG6hvb0jq//hbFgeGTYBmjhVyh1c6RZeeWm87wPxtmpZVfVmSMrVLcVEyNZ7jWzG
	64867Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42842jfv5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 14:42:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 690A44004F;
	Wed, 16 Oct 2024 14:41:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4BC5323D403;
	Wed, 16 Oct 2024 14:40:27 +0200 (CEST)
Received: from localhost (10.252.17.239) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 16 Oct
 2024 14:40:27 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Wed, 16 Oct 2024 14:40:01 +0200
Subject: [PATCH v3 9/9] arm64: dts: st: add DMA support on SPI instances of
 stm32mp25
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241016-dma3-mp25-updates-v3-9-8311fe6f228d@foss.st.com>
References: <20241016-dma3-mp25-updates-v3-0-8311fe6f228d@foss.st.com>
In-Reply-To: <20241016-dma3-mp25-updates-v3-0-8311fe6f228d@foss.st.com>
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
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add dmas and dma-names properties in spi nodes of stm32mp251.dtsi to
enable DMA support.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index e166e2f1f1400faf7fb56ed07c5779c26cf80cdd..ed1d778ab441be3ebf2e53dea9fef484d41ab31a 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -245,6 +245,9 @@ spi2: spi@400b0000 {
 				interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&rcc CK_KER_SPI2>;
 				resets = <&rcc SPI2_R>;
+				dmas = <&hpdma 51 0x20 0x3012>,
+				       <&hpdma 52 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 23>;
 				status = "disabled";
 			};
@@ -257,6 +260,9 @@ spi3: spi@400c0000 {
 				interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&rcc CK_KER_SPI3>;
 				resets = <&rcc SPI3_R>;
+				dmas = <&hpdma 53 0x20 0x3012>,
+				       <&hpdma 54 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 24>;
 				status = "disabled";
 			};
@@ -441,6 +447,9 @@ spi1: spi@40230000 {
 				interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&rcc CK_KER_SPI1>;
 				resets = <&rcc SPI1_R>;
+				dmas = <&hpdma 49 0x20 0x3012>,
+				       <&hpdma 50 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 22>;
 				status = "disabled";
 			};
@@ -453,6 +462,9 @@ spi4: spi@40240000 {
 				interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&rcc CK_KER_SPI4>;
 				resets = <&rcc SPI4_R>;
+				dmas = <&hpdma 55 0x20 0x3012>,
+				       <&hpdma 56 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 25>;
 				status = "disabled";
 			};
@@ -465,6 +477,9 @@ spi5: spi@40280000 {
 				interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&rcc CK_KER_SPI5>;
 				resets = <&rcc SPI5_R>;
+				dmas = <&hpdma 57 0x20 0x3012>,
+				       <&hpdma 58 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 26>;
 				status = "disabled";
 			};
@@ -501,6 +516,9 @@ spi6: spi@40350000 {
 				interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&rcc CK_KER_SPI6>;
 				resets = <&rcc SPI6_R>;
+				dmas = <&hpdma 59 0x20 0x3012>,
+				       <&hpdma 60 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 27>;
 				status = "disabled";
 			};
@@ -513,6 +531,9 @@ spi7: spi@40360000 {
 				interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&rcc CK_KER_SPI7>;
 				resets = <&rcc SPI7_R>;
+				dmas = <&hpdma 61 0x20 0x3012>,
+				       <&hpdma 62 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 28>;
 				status = "disabled";
 			};
@@ -549,6 +570,9 @@ spi8: spi@46020000 {
 				interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&rcc CK_KER_SPI8>;
 				resets = <&rcc SPI8_R>;
+				dmas = <&hpdma 171 0x20 0x3012>,
+				       <&hpdma 172 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 29>;
 				status = "disabled";
 			};

-- 
2.25.1


