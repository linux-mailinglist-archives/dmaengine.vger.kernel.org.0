Return-Path: <dmaengine+bounces-3317-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB67E998A00
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 16:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7E81C24B19
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 14:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C00E1F706E;
	Thu, 10 Oct 2024 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="nSA93HAX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4471CF285;
	Thu, 10 Oct 2024 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570704; cv=none; b=bX6N34wOLV6C4osMYDflA9MZXHk5I9XfCh3BLp2YkVev86uapqLvW+OvuIrWr4voPxuz28v3UHD4hIPoGTwXHXxgE78n3eFXNPyeEqTbSPz9Ms315LrUyRGqL7rvey/HsHZ8IR/1GVQ144MQb62iVqsiD5yFSw3hpF78VVXZVws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570704; c=relaxed/simple;
	bh=K3X7oiSCcT8hUzV633V8iq+iIATr9PhSk/pOdFOaKsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fLkpE5Fpm1oVplCD/J9LFgbZAG9eEMDHCdI5tTjpeSOubejtUlrSsZpLwHRwfneYnf5Efi+QyQWT/SlwK0o2Z9SEgkU4STQvc4NLlrauRNQypavzkNADsiPRxDha63VA23h0tN9MnLWAueP25k+GNF2Dljw4UWxckBh6Oye8RM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=nSA93HAX; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A92Fas006182;
	Thu, 10 Oct 2024 16:31:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	KH8nP8o/qes/Z0lwN5BroWJF926mtTX7phjDCx9kS2E=; b=nSA93HAXkZWV5JM1
	mT/sIvf83NaqDEfXZwfXkVlaS0VPBAAKgM5b6C49KNzrJxGIusadiCktEkkNXnnG
	oWYdBhSmLFhGFQdveS1QRQroHWa5jsvVivsa4mkWr5reUZPyjAdQk4YSr+P3E+sQ
	q851FJWbc7A4cK80EChr5i0L+R9zPKuqK80aKafNpWIIQMPEl1j/NtMWAjvrTU+g
	lWETU+iRKgaYsCNFcrEkmRw/yqSUI1x18/rsaCqU2lChgT+4UNFkTR7LmSj8cjXk
	b4mJVjwGvAyBuvCBY02weTTxZ65mZpo6SE7q3icvbKgZ/Rr/EHXqjtowEsO95tGv
	N7yx/Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 425w7xmw4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 16:31:23 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 570244005B;
	Thu, 10 Oct 2024 16:30:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36FC12A2FDD;
	Thu, 10 Oct 2024 16:28:14 +0200 (CEST)
Received: from localhost (10.252.31.182) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 10 Oct
 2024 16:28:13 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Thu, 10 Oct 2024 16:28:00 +0200
Subject: [PATCH 10/11] arm64: dts: st: add DMA support on I2C instances of
 stm32mp25
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241010-dma3-mp25-updates-v1-10-adf0633981ea@foss.st.com>
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

Add dmas and dma-names properties in i2c nodes of stm32mp251.dtsi to
enable DMA support.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 02fcb9fcff87ba9d5c1ecab0385e3a57cde31e2e..033da03d05a72c557dd81547fffa54eefed1e9cd 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -321,6 +321,9 @@ i2c1: i2c@40120000 {
 				resets = <&rcc I2C1_R>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&hpdma 27 0x20 0x3012>,
+				       <&hpdma 28 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 41>;
 				status = "disabled";
 			};
@@ -334,6 +337,9 @@ i2c2: i2c@40130000 {
 				resets = <&rcc I2C2_R>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&hpdma 30 0x20 0x3012>,
+				       <&hpdma 31 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 42>;
 				status = "disabled";
 			};
@@ -347,6 +353,9 @@ i2c3: i2c@40140000 {
 				resets = <&rcc I2C3_R>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&hpdma 33 0x20 0x3012>,
+				       <&hpdma 34 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 43>;
 				status = "disabled";
 			};
@@ -360,6 +369,9 @@ i2c4: i2c@40150000 {
 				resets = <&rcc I2C4_R>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&hpdma 36 0x20 0x3012>,
+				       <&hpdma 37 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 44>;
 				status = "disabled";
 			};
@@ -373,6 +385,9 @@ i2c5: i2c@40160000 {
 				resets = <&rcc I2C5_R>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&hpdma 39 0x20 0x3012>,
+				       <&hpdma 40 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 45>;
 				status = "disabled";
 			};
@@ -386,6 +401,9 @@ i2c6: i2c@40170000 {
 				resets = <&rcc I2C6_R>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&hpdma 42 0x20 0x3012>,
+				       <&hpdma 43 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 46>;
 				status = "disabled";
 			};
@@ -399,6 +417,9 @@ i2c7: i2c@40180000 {
 				resets = <&rcc I2C7_R>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&hpdma 45 0x20 0x3012>,
+				       <&hpdma 46 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 47>;
 				status = "disabled";
 			};
@@ -544,6 +565,9 @@ i2c8: i2c@46040000 {
 				resets = <&rcc I2C8_R>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&hpdma 168 0x20 0x3012>,
+				       <&hpdma 169 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 48>;
 				status = "disabled";
 			};

-- 
2.25.1


