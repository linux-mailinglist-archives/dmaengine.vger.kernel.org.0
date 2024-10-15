Return-Path: <dmaengine+bounces-3366-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F9399E975
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2024 14:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075CC282857
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2024 12:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEF11F706B;
	Tue, 15 Oct 2024 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="6W+V/D1K"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F931EC018;
	Tue, 15 Oct 2024 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994602; cv=none; b=spm7YAm7BGXqGpoJoQl3bjte6u3azvsnsHiUmepS1xONLM22msg1pgl5/mtt/SCX9rou/kxtiHZ4H2CRouliG9GSxKBmQ8CFXcVbdTGIcwCyhrezgBzD0L+erxNCIL0j5Pcn2vG+VKq11CDCfhHDE9olb+RFeugihhY57m3SLzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994602; c=relaxed/simple;
	bh=pMLifARUAOLNBr01/ck65XhIQfScdJTCO8DMrbIsXwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OLcxtiOV3aG4Rgn9cVy6jgbWDZee5B9cLg3xkt3fjGpcY9fBdczUeZfeM/x2JP+JmwqN3UznsOba6u1RTOz660Lwf2+aEjabM6IQ3cRfILPES3HZmUQ1mh9LZTjArZdWabLu+m4r9KAoPQmYkyKvVtHCgvSvodiGmgg3EVbgF6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=6W+V/D1K; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F8TXQx021314;
	Tue, 15 Oct 2024 14:16:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	K4/ZRiFK4NnnLcdcmxWLGfjaF+7bw9tWCL81XtmyrjQ=; b=6W+V/D1KM6uoodKF
	FFXZvvtdxP9J/7SKWyEHury6hGcPx1/EvSrM13j21sKNxfU0evpYvnw5v+sx5ZEw
	rQcFy4G8XjFRXoxeK8OFs8an3AXwK2Y/wcCX26urnOJWu9v+RJW1ENlwvQon/ntg
	dQLUpO+O+1GwNYRvQySyZbGb7846PthXn9riyK4/sfClh4KpGJmTkWXoGXx9li89
	NG7RFH5Go0PromGIy4vg4Z4zZvTckAms957b3xLX+RedUH3kCXsOro4xPR/dDsG/
	1g4VetRqs/P6WP4Vw7GO/I7bVf2TJhdMabC/4/4xqZZ2zYhqKGz8lQpzHHmeR4fi
	Szis9A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 427g0bn2k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:16:29 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9BBAA40070;
	Tue, 15 Oct 2024 14:15:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4179F223669;
	Tue, 15 Oct 2024 14:14:52 +0200 (CEST)
Received: from localhost (10.48.87.35) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 15 Oct
 2024 14:14:51 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Tue, 15 Oct 2024 14:14:44 +0200
Subject: [PATCH v2 8/9] arm64: dts: st: add DMA support on I2C instances of
 stm32mp25
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241015-dma3-mp25-updates-v2-8-b63e21556ec8@foss.st.com>
References: <20241015-dma3-mp25-updates-v2-0-b63e21556ec8@foss.st.com>
In-Reply-To: <20241015-dma3-mp25-updates-v2-0-b63e21556ec8@foss.st.com>
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

Add dmas and dma-names properties in i2c nodes of stm32mp251.dtsi to
enable DMA support.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 9035fc7ba4857ca98a1a86246d7d0250196b2a13..e166e2f1f1400faf7fb56ed07c5779c26cf80cdd 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -318,6 +318,9 @@ i2c1: i2c@40120000 {
 				resets = <&rcc I2C1_R>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&hpdma 27 0x20 0x3012>,
+				       <&hpdma 28 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 41>;
 				status = "disabled";
 			};
@@ -331,6 +334,9 @@ i2c2: i2c@40130000 {
 				resets = <&rcc I2C2_R>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&hpdma 30 0x20 0x3012>,
+				       <&hpdma 31 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 42>;
 				status = "disabled";
 			};
@@ -344,6 +350,9 @@ i2c3: i2c@40140000 {
 				resets = <&rcc I2C3_R>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&hpdma 33 0x20 0x3012>,
+				       <&hpdma 34 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 43>;
 				status = "disabled";
 			};
@@ -357,6 +366,9 @@ i2c4: i2c@40150000 {
 				resets = <&rcc I2C4_R>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&hpdma 36 0x20 0x3012>,
+				       <&hpdma 37 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 44>;
 				status = "disabled";
 			};
@@ -370,6 +382,9 @@ i2c5: i2c@40160000 {
 				resets = <&rcc I2C5_R>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&hpdma 39 0x20 0x3012>,
+				       <&hpdma 40 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 45>;
 				status = "disabled";
 			};
@@ -383,6 +398,9 @@ i2c6: i2c@40170000 {
 				resets = <&rcc I2C6_R>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&hpdma 42 0x20 0x3012>,
+				       <&hpdma 43 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 46>;
 				status = "disabled";
 			};
@@ -396,6 +414,9 @@ i2c7: i2c@40180000 {
 				resets = <&rcc I2C7_R>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&hpdma 45 0x20 0x3012>,
+				       <&hpdma 46 0x20 0x3021>;
+				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 47>;
 				status = "disabled";
 			};
@@ -541,6 +562,9 @@ i2c8: i2c@46040000 {
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


