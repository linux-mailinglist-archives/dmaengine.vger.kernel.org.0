Return-Path: <dmaengine+bounces-6838-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9158ABD8E82
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 13:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF9D425897
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 11:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCB130C61D;
	Tue, 14 Oct 2025 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dXHkK8Dg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08430C378;
	Tue, 14 Oct 2025 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439982; cv=none; b=OtLoyalZOCPX9r9+Q2dnoKMMlXYBU2BV8TzKuqdZsEV1PA6KgYOP9Gf0UQ8G4iFHc32tdcwA39jqZA6tgAXB5gNMa5sZbSPNhaeeMD2lGHt6B3vzkYfux2unZ515E3tpS43NBPOP+R2qfV+beUDS7SdWCP5UO/T3oEIaokVM5/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439982; c=relaxed/simple;
	bh=2wTJ8ee2YUpBUVA8IIBWl9dDcutgCIO7C4b8tEohmrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnaNBUNjxeivzAUydnH++m9ZAMenAhk4hE1yjkN2/LGyGAgzwPjqcHjNsWcm+fAMfDfwl9CsrEHb2jpFHccyBnxahX6hIiWBB1xVnJOmkul7++eIXHdOe3vfAQnHVg/WQCXWKKnzAaq+fUirrV6a+wQJ7eSTVcUqjUxKt6WpoMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dXHkK8Dg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87cVt002027;
	Tue, 14 Oct 2025 11:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dFI4TSnzAhOPJf8avqd/cwCz0IJRJLvWsuJ8tcOxf/s=; b=dXHkK8DgzRB0RZdo
	sHgI02n8rpHaC7Cmm5bCUpPguvb08brNd4OwHnHFAOZRdG45WrzzSy3PIYodNLh5
	XGY+namngSDUEBO23bn/5LaNHcYG93VHAGMs+5a06oyye0JpnXitW0AaZI+VBOCy
	qi6n3/rdzxqJRDHd4VWG+cGe32VXgnwBeLQrZRk1A9Pzlzv/BdnQ1CBKYzmdLP6o
	15IHB/iFNRBrsTEKIBVeK9LD9JF5MLNjXfRwe7mndu35p8aKtigbtqiNrBjxLMo0
	Bh6n6JvV2vkaS6r3KCxF10iWhgipqDYPcRNFB2utVyA88JDzg7y7kHtmdYbSUfsT
	pHLkjw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdk8573-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 11:06:17 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59EB6GMT027949
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 11:06:16 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 14 Oct 2025 04:06:12 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH v3 5/9] arm64: dts: qcom: ipq5332: Add QPIC SPI NAND controller support
Date: Tue, 14 Oct 2025 16:35:30 +0530
Message-ID: <20251014110534.480518-6-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014110534.480518-1-quic_mdalam@quicinc.com>
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IQ5sX_FT4KXid5rf5R1upIOcQfFnbMRw
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68ee2ea9 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=hZ-JTpYKhHfbfY6Hf6sA:9 a=TjNXssC_j7lpFel5tvFf:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: IQ5sX_FT4KXid5rf5R1upIOcQfFnbMRw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX6+ef6A88/axZ
 N5EaG7pm/27wOYqM12TGcaA4T0c9BJDsmnpo8HhwnPA9OGpv/mFMqwvba07JFVzVvE5TmbqvlUu
 XsSouKg8IKK6ZkQ+u5Jm+9OW91ag/Q2mih+DZEJnWbusEgj23o+WDwFT2kJ49i+5DZBUtwhSBmL
 Oohoiomrbi4dIHbQMcBqHy3soFuzOIrdLQ3CkhTGEu68jzjTCHsU6M2skwaFYPi1/4HQxAgQpid
 XrbsJpMhSAgBOKHeGaQ9ccNQtV+Ejjr2LYuTdoa3gsTXQuChjAEQLn0z0ILTgMQlSP71dmzLKCS
 Rn95HR3G7+Ekep5VhcbTDF1W9Ahq+ngNVLgTQrXwbTNLcupRXXoLNqaAnh11UgUyTY5UsTnMbYg
 GiKj6MK870KBWsHToFP0Lr5Pm3I95A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Add device tree nodes for QPIC SPI NAND flash controller support
on IPQ5332 SoC.

The IPQ5332 SoC includes a QPIC controller that supports SPI NAND flash
devices with hardware ECC capabilities and DMA support through BAM
(Bus Access Manager).

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v3]

* Reformatted clocks, clock-names, dmas, and dma-names properties
  to one entry per line

Change in [v2]

* No change

Change in [v1]

* Added qpic_bam node to describe BAM DMA controller

* Added spi nand support for IPQ5332

 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 33 +++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 45fc512a3bab..e227730d99a6 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -423,6 +423,39 @@ blsp1_spi2: spi@78b7000 {
 			status = "disabled";
 		};
 
+		qpic_bam: dma-controller@7984000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0x07984000 0x1c000>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_QPIC_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			status = "disabled";
+		};
+
+		qpic_nand: spi@79b0000 {
+			compatible = "qcom,ipq5332-snand", "qcom,ipq9574-snand";
+			reg = <0x079b0000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&gcc GCC_QPIC_CLK>,
+				 <&gcc GCC_QPIC_AHB_CLK>,
+				 <&gcc GCC_QPIC_IO_MACRO_CLK>;
+			clock-names = "core",
+				      "aon",
+				      "iom";
+
+			dmas = <&qpic_bam 0>,
+			       <&qpic_bam 1>,
+			       <&qpic_bam 2>;
+			dma-names = "tx",
+				    "rx",
+				    "cmd";
+
+			status = "disabled";
+		};
+
 		usb: usb@8af8800 {
 			compatible = "qcom,ipq5332-dwc3", "qcom,dwc3";
 			reg = <0x08af8800 0x400>;
-- 
2.34.1


