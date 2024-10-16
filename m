Return-Path: <dmaengine+bounces-3378-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8420C9A0A84
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2024 14:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38D91C27FE6
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2024 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C8C209F21;
	Wed, 16 Oct 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NB5u3abH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E5320821B;
	Wed, 16 Oct 2024 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082596; cv=none; b=fK7ZgnlGVptIwHJTh8k4LrdF8A0NoOnJn7Mc0BLnUpYh9S8bvhgDvBCwjM5Umh2HNYwqDUSGNzudkj/ZuOGm/ygp3vY6fH1k2gcxqxRIcQSTFNQ3tKiGk6aCNuJpLmxqPPc50E/mWU2WGNFxOBND8oDCqwwIuzKqg73YK5B8a6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082596; c=relaxed/simple;
	bh=pMLifARUAOLNBr01/ck65XhIQfScdJTCO8DMrbIsXwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LDaTqqkrIRxnILKbS2BajWBGhaW4roQb1bmdkaoWXd9dm1rmmrobY6yyj6uCtNb/mvHS6ynrodc8Y64aDpy7XDAyK9bDFJG0jXMp4Bdy6pk/YbFG7YyB1M/He0sTDWKuqMtZTXImzftN6nNMzm1LkdM6ClHRm1GnUhrPYxlKoqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NB5u3abH; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GAo8tP018560;
	Wed, 16 Oct 2024 14:42:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	K4/ZRiFK4NnnLcdcmxWLGfjaF+7bw9tWCL81XtmyrjQ=; b=NB5u3abHVOU2NxN0
	hg6/W5fAKTRC23+gGhg0oQEAjx/jyXj/7DiNTBglAtQ1zbfFA8TylxJJTXAffwSx
	QMNae6Fo7w+pJ5dOX63uB1UFgPWaTziIImGn0sPrUVVVwyWL/5vvTEB+jyDNcGMd
	IgZYBkG3x7XI+fE1dCrTo924bUT5nXMwROQt8QSjKTVyeDvL/6E0yw8UFGwHvdb0
	O/6XBIooqzpw8DsWfsftog3EY/T00OfkeiLaiXd+ZST38Gvm+J4dTQQZJ9SHgnDs
	S9CHSUmevhYNHHmh7qQRZVJpFyeU9bdGbNqfkcOr4VTokHNDgX81+N4BrkXHWrlo
	EGV5HQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42a8mv9uvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 14:42:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6E23240055;
	Wed, 16 Oct 2024 14:41:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7EB1823CED5;
	Wed, 16 Oct 2024 14:40:26 +0200 (CEST)
Received: from localhost (10.252.17.239) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 16 Oct
 2024 14:40:26 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Wed, 16 Oct 2024 14:40:00 +0200
Subject: [PATCH v3 8/9] arm64: dts: st: add DMA support on I2C instances of
 stm32mp25
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241016-dma3-mp25-updates-v3-8-8311fe6f228d@foss.st.com>
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


