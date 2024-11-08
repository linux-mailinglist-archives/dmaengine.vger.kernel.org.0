Return-Path: <dmaengine+bounces-3695-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C659C271C
	for <lists+dmaengine@lfdr.de>; Fri,  8 Nov 2024 22:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D090B22CC3
	for <lists+dmaengine@lfdr.de>; Fri,  8 Nov 2024 21:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7BD1F582B;
	Fri,  8 Nov 2024 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpBzAIux"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2E21F4FB6;
	Fri,  8 Nov 2024 21:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102090; cv=none; b=MFS9/fCFQfK056T9P62IFMt9KozFwacnTaU2E+zSTrwu7vLThmxT+4p652yGjckN5ih9hhMiLPan83Nr4APnbW/UruQF2A8LxkrCT844LBxjEaNZPcHcrtYKO42Xy//oOUKGam3vo5dkZV0oRGa/oDTY38GOjVSbbKSHguq9Twg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102090; c=relaxed/simple;
	bh=XC1oBE+/8s+hMkWru/3TnQAGvSGZE4ay9tNeo7gN8Dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r5NbyXwyUoMi4PIi+Ow5Ve4/0dkfv+GpnDhuWQFEI1L0KN6bvtJ1lgkM4iR6pmn9diYrQmwvO4dUWPXqJpx9ZcYA5AW3gfMjXqRufcoG3XrgtCxtMiVerT/RrMjX2eaH/y8qQuZFQpNmMY4ilnV+YnVq/DWkmpuu6NFCponkn3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpBzAIux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E327EC4CED2;
	Fri,  8 Nov 2024 21:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731102089;
	bh=XC1oBE+/8s+hMkWru/3TnQAGvSGZE4ay9tNeo7gN8Dw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LpBzAIux41ykPNnKzDyHp2j1eamNnE5o7U94nakNR+NmERh0/7+PeoF3KUSXQYKm2
	 zetuUwcytcbLZIpME8CU12P8y8JZC7XoFf7ZJC261tRDdFkQqL4Ow9OKR+A/2XRGrp
	 jLNIDrC/ywabAyRxJRoGLeLZM8tKVK7yyTxim+K8qyQwju4riTJOCxElV5fYdwT9Bi
	 cgw/Y0CuM+v9EADwU75enxSuxfZspHtbljNiq/ki2Cea9s6kxQH16CiQtDyz2SIAnE
	 9WYAFKOlo5PK/Lx1ylnmO5jlsQA8Aak87cIKBQSu24F/xbrfAEH2nD4TM94z8UOYeq
	 B/K1qa1tJIFog==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 08 Nov 2024 22:41:18 +0100
Subject: [PATCH 2/2] arm64: dts: qcom: sa8775p: Use a SoC-specific
 compatible for GPI DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-topic-sa8775_dma2-v1-2-1d3b0d08d153@oss.qualcomm.com>
References: <20241108-topic-sa8775_dma2-v1-0-1d3b0d08d153@oss.qualcomm.com>
In-Reply-To: <20241108-topic-sa8775_dma2-v1-0-1d3b0d08d153@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731102079; l=1998;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=SXMXA8JLFw+Ep7/JwUsd3TgXMmVTVSwYZFpkJtR6VWo=;
 b=lB4YU3B87LMEqngP1I5M8r5qygxJFztkOXiYFIKRLjFnkX8S0SGng46QpGGo76NfsMXdHT+Nf
 zKAkzysnkECCOwZkVJjz0wPBFiHyCIt9i0lfqDJ8/kxc3cN1Nnu7Z4k
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

The commit adding these nodes did not use a SoC-specific node, fix that
to comply with bindings guidelines.

Fixes: 34d17ccb5db8 ("arm64: dts: qcom: sa8775p: Add GPI configuration")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index ebfa049515c63a0f1a333315dd370e6f78501129..f99edbdd8314af20283e206e1228052a060f7d34 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -855,7 +855,7 @@ ipcc: mailbox@408000 {
 		};
 
 		gpi_dma2: dma-controller@800000  {
-			compatible = "qcom,sm6350-gpi-dma";
+			compatible = "qcom,sa8775p-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0x0 0x00800000 0x0 0x60000>;
 			#dma-cells = <3>;
 			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
@@ -1346,7 +1346,7 @@ &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 		};
 
 		gpi_dma0: dma-controller@900000  {
-			compatible = "qcom,sm6350-gpi-dma";
+			compatible = "qcom,sa8775p-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0x0 0x00900000 0x0 0x60000>;
 			#dma-cells = <3>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
@@ -1771,7 +1771,7 @@ &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 		};
 
 		gpi_dma1: dma-controller@a00000  {
-			compatible = "qcom,sm6350-gpi-dma";
+			compatible = "qcom,sa8775p-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0x0 0x00a00000 0x0 0x60000>;
 			#dma-cells = <3>;
 			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
@@ -2226,7 +2226,7 @@ &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>,
 		};
 
 		gpi_dma3: dma-controller@b00000  {
-			compatible = "qcom,sm6350-gpi-dma";
+			compatible = "qcom,sa8775p-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0x0 0x00b00000 0x0 0x58000>;
 			#dma-cells = <3>;
 			interrupts = <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>,

-- 
2.47.0


