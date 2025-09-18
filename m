Return-Path: <dmaengine+bounces-6622-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA66B83D86
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 11:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF7E4853AA
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 09:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DC82E4278;
	Thu, 18 Sep 2025 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lGlC1pPk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1DC28643F;
	Thu, 18 Sep 2025 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188477; cv=none; b=fD/szEkyuVrKq/9/qB4X8I5NliIEugNt5M4/mYUy1D7a6ESRhUBFNLpjhSsqcy/iPajwR3/qYhlINkyrTcApxZQjMtByVJokaHOzSF9c3VT0F4vqZfBanGAEYBpIuNUB9nT3ROCWtxnmN+IwVK67V4WMnm6n4Gwa6glk++dKkKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188477; c=relaxed/simple;
	bh=bZOFeI+tgiydr02k5oInUVlewhDtZNbtikXr8HJD8f0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4ZNfi9BCEST3ORMH7H+13fSt5Y9d8V/6geTQ/Qn2IDSIdT5+n+y18Uwiych8mLrg9HfxD6+UuEL6T5o4N1PuPyge48WTG/cFPfOovxYIncbSCjey7tPiD06KDGv0/S+s4tKfLu41dOKafsl3aoKO0xPTIoK/OMTk9y7wRrA168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lGlC1pPk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I8B5tT007399;
	Thu, 18 Sep 2025 09:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rqJuREo4RtkoUe/m1/LcLzLkp9wLhAs6xBueZgBOw5k=; b=lGlC1pPketWlWsmw
	/SUFmY5MiaoAxZ2nOOlGXn+Ve7X21/mwAEfwFyIRHu7ly0tbQtcBVAM3VsKkIouX
	v0NrrSywZQA8jdUY10N1AxrdObUrc5pV8SbP5RGQ5Q776gtSjNS0suP9clsTV2/X
	2fBCcpm9YG74EW7qbBkBrbQgDJOm2++31AZA+XFEWBZ/YSZv2QlqV0oNQOTVsNPi
	7/hg6A1/5vkZAJzByB5si72nJ79Qaw7UeBkyXelqsMed+2cKtGRL8XyY7xOnzygD
	ELacFmHFBuW9CNKSag1RAdA4RXVQcYUaMYGjJYqmT70oBzqvz16khoJt3pXnJp5g
	xqeEWw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 498eber9jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58I9f8gm029124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:09 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 18 Sep 2025 02:41:03 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH 7/9] arm64: dts: qcom: ipq5332: Enable QPIC SPI NAND support
Date: Thu, 18 Sep 2025 15:10:15 +0530
Message-ID: <20250918094017.3844338-8-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: fPR-B7IuSnmdX3ZpOsiNj305ScrJs_da
X-Authority-Analysis: v=2.4 cv=H6/bw/Yi c=1 sm=1 tr=0 ts=68cbd3b5 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=CMiZffgOyvHcZSL99bQA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: fPR-B7IuSnmdX3ZpOsiNj305ScrJs_da
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA3NCBTYWx0ZWRfX6lQZYJBgdzm4
 Im7ooUkzhzCTps7CkOD2tne6clBHu4BtuvaXJYNotGMy309njK7vRneXYSlkOuZOKITGo+MTr68
 ZYz8iDF70x2EKCRRdjfS5Kryf+U+4AGFXB+7rM7sEM3hjqv6RnATkyWAspxVnbkDsl5OS6pPZG5
 eppZp7z4nhKXEQIbi6gfv7QZbltEr5ZhaEf9MzEz/wzK/jDav0VPjGWKHND2TQil7fwicQDNb0L
 ZPJ5DJY+BYJF2fMaMuSG+ZZ/ORiCYQ59SS3oGGbXXT6jNLemGtDPq11RbKQRWNMMf+X6gGEZX7d
 Q56X7ZNhPPVTMNHd7ANPLkOTVF+zO3GUiMBVm0BFa0gKss4TKJgBK+/pb7vW3fNHsyeQs2ZKuuh
 CwE8qebq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180074

Enable QPIC SPI NAND flash controller support on the IPQ5332 reference
design platform.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 .../boot/dts/qcom/ipq5332-rdp-common.dtsi     | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
index b37ae7749083..8967861be5fd 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
@@ -78,4 +78,48 @@ gpio_leds_default: gpio-leds-default-state {
 		drive-strength = <8>;
 		bias-pull-down;
 	};
+
+	qpic_snand_default_state: qpic-snand-default-state {
+		clock-pins {
+			pins = "gpio13";
+			function = "qspi_clk";
+			drive-strength = <8>;
+			bias-disable;
+		};
+
+		cs-pins {
+			pins = "gpio12";
+			function = "qspi_cs";
+			drive-strength = <8>;
+			bias-disable;
+		};
+
+		data-pins {
+			pins = "gpio8", "gpio9", "gpio10", "gpio11";
+			function = "qspi_data";
+			drive-strength = <8>;
+			bias-disable;
+		};
+	};
+};
+
+&qpic_bam {
+	status = "okay";
+};
+
+&qpic_nand {
+	pinctrl-0 = <&qpic_snand_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	flash@0 {
+		compatible = "spi-nand";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		nand-ecc-engine = <&qpic_nand>;
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+	};
 };
-- 
2.34.1


