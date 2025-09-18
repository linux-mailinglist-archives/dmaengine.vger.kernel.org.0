Return-Path: <dmaengine+bounces-6618-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23157B83D51
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 11:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74C61BC37C6
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 09:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AB627AC4C;
	Thu, 18 Sep 2025 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mOkN3dLF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EF21D9663;
	Thu, 18 Sep 2025 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188475; cv=none; b=vF88A94Zt6TsjCLS1Ny6g/bEUTpiWfgTib9CgbgnkhAgFTXLQgKneiazkNw4pciTBPC0KsE+KEvHEJmzajH77K+v/R3C6rA6RdF00BnNuO1y05Zj8I9FjsY1X9WG9X9Xrt8jCViNkkqy4aZaXnVY3yO6ox5MSPgNIjyynJ0ACX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188475; c=relaxed/simple;
	bh=ixkdTPvFUCxFE95etiwcgzZUrptGeYMATeqD3qe54l8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJR5kZ3ETPAzgzs0Afqb4k1DOADc2/NLnIJ1PeyS9+AsXspOyCSYtxBvIWmmRvPZwvoVBpg/ncKksPKs247bMWhziN2YmXbzFrJfFU4uLGNTSH3fdT2Kku86l9+EwVSQZnMaYZjxXBpSN6Lb2Uu6tdu0Cpgy+0sycPPPtxoNaU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mOkN3dLF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I8BBRf007486;
	Thu, 18 Sep 2025 09:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6SUqQPxDgyxQKMxp0CuYLZT1/B9YWizmbnY5cZquSxs=; b=mOkN3dLFRLcVIq9b
	p4OgbGeh9IXe8Jw7GTbdSyIPfQJ2pMGlsBobCfNTJAIHgxDsmVluUzu+RKNoTyPR
	aSDTWPy4wDxWNlIJ/TCBx94DPTJCslhkjkfrbbjtQlGgixu+j2tflHx2osJw2oGG
	glBHBhgD0zc5aEGcm6hUU3jqMidf6hVDo3KJ6mZgJA2bO6uS7nu2rcGzLG7CElGF
	BaaWrCtbJjDFdzKeSrFxJP25TrwsCQwsqiyIv14Zp/7a71z2PfASM81OktPMPIdj
	3aiSkYVV5yZaDfPfTaBfAhsfmKgYhM6ezeYoezWngyUtVnY+3bDzN1SlRSnqVkoa
	8gZuUQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 498eber9jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58I9f8gj029124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:09 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 18 Sep 2025 02:40:51 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH 4/9] arm64: dts: qcom: ipq5424: Add QPIC SPI NAND controller support
Date: Thu, 18 Sep 2025 15:10:12 +0530
Message-ID: <20250918094017.3844338-5-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UpztV1MAUS40zeBxrkZgweRycFLAogfL
X-Authority-Analysis: v=2.4 cv=H6/bw/Yi c=1 sm=1 tr=0 ts=68cbd3b5 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=6UWhdCim3U11iwMnUWwA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: UpztV1MAUS40zeBxrkZgweRycFLAogfL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA3NCBTYWx0ZWRfX5UD0+dg1imQu
 Gc6HXXFbaR3ISgvtF7cQcCs4q7Z6o0w+NRXCMVL3WbmR3Pwxn4yMLDWJu1DpUmaSKEuRg5XgoL3
 VX4VOdBUboLy+zdLkYEcEWzxNiL18icJHlnkTHjPqqpW/IjXQRMvYiRqVpGEraFtey34CPTkjqu
 96sybM6JhBp+xYp/2Htt8rvNFb5DBuMLFcLbmfkx+h4pNgQsGVv1RiZXc5N9v9kPMlweodE2vLC
 wSue42xIhT4W0DdQ0NxbIoHAEraZgsdEFe77OO5c5pvmxR8zI/hMB10Sfii3F1L09qKJeAMTlZU
 vUS8ag/KeCGA6hacEtbTz4npsTiQk2dRV06V0HJ8rP0LgUwOByh3OWdn3TK2I1J2P8a5BZrWeZQ
 WCBlWqML
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180074

Add device tree nodes for QPIC SPI NAND flash controller support
on IPQ5424 SoC.

The IPQ5424 SoC includes a QPIC controller that supports SPI NAND flash
devices with hardware ECC capabilities and DMA support through BAM
(Bus Access Manager).

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index ef2b52f3597d..81f133568bb6 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
@@ -567,6 +567,33 @@ sdhc: mmc@7804000 {
 			status = "disabled";
 		};
 
+		qpic_bam: dma-controller@7984000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0x0 0x07984000 0x0 0x1c000>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_QPIC_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			status = "disabled";
+		};
+
+		qpic_nand: spi@79b0000 {
+			compatible = "qcom,ipq5424-snand", "qcom,ipq9574-snand";
+			reg = <0x0 0x079b0000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&gcc GCC_QPIC_CLK>,
+				 <&gcc GCC_QPIC_AHB_CLK>,
+				 <&gcc GCC_QPIC_IO_MACRO_CLK>;
+			clock-names = "core", "aon", "iom";
+			dmas = <&qpic_bam 0>,
+			       <&qpic_bam 1>,
+			       <&qpic_bam 2>;
+			dma-names = "tx", "rx", "cmd";
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@f200000 {
 			compatible = "arm,gic-v3";
 			reg = <0 0xf200000 0 0x10000>, /* GICD */
-- 
2.34.1


