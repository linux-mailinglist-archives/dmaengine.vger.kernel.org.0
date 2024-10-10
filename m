Return-Path: <dmaengine+bounces-3318-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FC4998A20
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 16:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17FFCB2B8D5
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 14:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBC31F7070;
	Thu, 10 Oct 2024 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="nJaX0eR7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DBF1F7069;
	Thu, 10 Oct 2024 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570704; cv=none; b=PatlWkgc1rtMr7Hb6/ZffKKQ+i+1mES9ATcLrlEroykgOMjp8L2oQjI61zwWxaXvORR7+48rVWTRglRG2Wgt84uRizAZN/d67bttmp0Nq5nD23/IRiX3D3I7i4ROXoNdcspn3ElDMAMq4+C3ZFXRpv3xWcdBjyGnTfuP5JYzGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570704; c=relaxed/simple;
	bh=KoQGSnpOs6ieXxEnyHHrxeA6S2VnsBKxUAdaTMFg/9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IuR9rTpmz4K3R3X/ZkCbDrJMerWrgpM0llI9ddn4YQ0lxokoX114iSAGxtFKFSe+A3E0LtEKFLiu/GLjFTenjvQGLbWmrRYkKNDmlI71ViM7bDSTcd4IUtYcoVCvO5ojH40igV50aJD1Q8upd5RkKkfOFa5ax+SnDfvM2Hvsbto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=nJaX0eR7; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AE3xWM004150;
	Thu, 10 Oct 2024 16:31:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	O41xSOzJv31DX5Er3+Tj267w66tdT1K/Yy2IS+3r0fM=; b=nJaX0eR7Z/4Ss7Ld
	drCUwepSIpU3l3EmEE/katOm4AnSDO+Gajt8JFTpsehTbpyFhysmeFeXK5Id31hJ
	Mnf5GqvjP/4xZFdyxNGZSTjCsCjK9tojvn+bsW+gwtW7XV2M3DBWWTsrlv+Vnh9f
	pKcUVZpQXbsHtshyamo9s3gZMfBY9SuVQRADEZH7E2CvjJ3QuFMbKmpvvnEPVqpu
	k/cC1GURyEil+gb42/WX7zay7qsywXm/VFzPsg5CN4OtS1NlRATidRZ6KIu0AFB7
	2IWhlFXf5ny5biXr1ufcZ9J7U59xQk/G6m//NHffWNhe+hK+60eNOg6+17nOJa6v
	7Pe8TA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 425w7xmw4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 16:31:17 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C7C254005D;
	Thu, 10 Oct 2024 16:30:24 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A36D129F351;
	Thu, 10 Oct 2024 16:28:12 +0200 (CEST)
Received: from localhost (10.252.31.182) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 10 Oct
 2024 16:28:12 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Thu, 10 Oct 2024 16:27:58 +0200
Subject: [PATCH 08/11] arm64: dts: st: limit axi burst length in dma nodes
 of stm32mp25
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241010-dma3-mp25-updates-v1-8-adf0633981ea@foss.st.com>
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

As stated in STM32MP2 Reference Manual [1], chapter "HPDMA allowed AXI
maximum length", "The maximum allowed AXI burst length is limited to 16.".

To apply this limitation on STM32MP25, add "st,axi-max-burst-len" property
in DMA controllers nodes in stm32mp251.dtsi.

[1] https://www.st.com/resource/en/reference_manual/rm0457-stm32mp2325xx-advanced-armbased-3264bit-mpus-stmicroelectronics.pdf

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 1167cf63d7e87aaa15c5c1ed70a9f6511fd818d4..443cc8d6ae8e9e2bff1bb862b0921d9626bb78e1 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -181,6 +181,7 @@ hpdma: dma-controller@40400000 {
 				     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&scmi_clk CK_SCMI_HPDMA1>;
 			#dma-cells = <3>;
+			st,axi-max-burst-len = <16>;
 		};
 
 		hpdma2: dma-controller@40410000 {
@@ -204,6 +205,7 @@ hpdma2: dma-controller@40410000 {
 				     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&scmi_clk CK_SCMI_HPDMA2>;
 			#dma-cells = <3>;
+			st,axi-max-burst-len = <16>;
 		};
 
 		hpdma3: dma-controller@40420000 {
@@ -227,6 +229,7 @@ hpdma3: dma-controller@40420000 {
 				     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&scmi_clk CK_SCMI_HPDMA3>;
 			#dma-cells = <3>;
+			st,axi-max-burst-len = <16>;
 		};
 
 		rifsc: bus@42080000 {

-- 
2.25.1


