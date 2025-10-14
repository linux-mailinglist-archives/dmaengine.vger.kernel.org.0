Return-Path: <dmaengine+bounces-6839-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D63BBD8E88
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 13:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DA014E842D
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 11:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201D930C63F;
	Tue, 14 Oct 2025 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VPhB4HGl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3930C602;
	Tue, 14 Oct 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439987; cv=none; b=rwB2jgX8veRX9yiX/25hDX+ZjglRNefbOUZqlBNajaA9XTH5lamJWfEo+XglQWZX6xB2wgz7OG0fAOfcM/CO2U+Y1hXOxJvks3Sr8eo7lvs2YIPbl4quwOImrFm6UdULKKBfOJX2PTSeog3sKj8h4t6VJuR/h8aDyvPZCa0sX3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439987; c=relaxed/simple;
	bh=DXjxqMOXrqJQz5zGWsu+qKdn6uCH66/Khsz/Q4txUmg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAxFvF0u9RjW1QLaV6nUc6Wk3DIWba5K0puiJ+oDv1dJSnj8oDBaoAXwtTdmqvqtzxEGr21Fxj1Q2E8aZme/yUkmQqq8xMVRBTBzL83U/RHI3EUOzZFv0mAWc74NF0UMxHykZuDCczi7UF2C6JP77bCDh86pe/1Q1bXeV22+a/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VPhB4HGl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87N5X001613;
	Tue, 14 Oct 2025 11:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pXyNVJRtqYxOBjy7AZBy0gpMObs6HhKijUPFyz21//o=; b=VPhB4HGl9NxTNfAz
	qiVVfahXOgXF2KMIfwdM/pHY76dZb+GUen+ZXMeQPUQdx4AtGuvuYBl36KMGtYt5
	hNydaaC+VxdIOfm0jV14bbCshlNOdJciWliL95+ycQ3u+kmmPTz7KeBTnUT5Omli
	dzrl1D8gjtecqHtp2q/eejJ8a81Sog9Yl/qbj94OHc5K44xwvz70YkarrrZtck3M
	I9rD6kDsBv4wHr7FETxQEnOlidsfach22y5Zi00G8FLR8ZewXynkAHtn4d+Bgf8N
	4v55964Vd1cK43iCDNI4yT862qW2Lwz3Gk2aQEwVHEKjH7Mr2Wp4ftC2CK+EhpgE
	GO35LA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdk8578-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 11:06:21 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59EB6KX2032642
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 11:06:20 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 14 Oct 2025 04:06:16 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH v3 6/9] arm64: dts: qcom: ipq5424-rdp466: Enable QPIC SPI NAND support
Date: Tue, 14 Oct 2025 16:35:31 +0530
Message-ID: <20251014110534.480518-7-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 0BDt5Hk8CMAPaLFdZtR3iuUG3wec5Lj6
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68ee2ead cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=GMCKaWqv3SNeHD9qFv0A:9
 a=TjNXssC_j7lpFel5tvFf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 0BDt5Hk8CMAPaLFdZtR3iuUG3wec5Lj6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX/Gb4N+w/50q8
 bda3M4PJcg+csru4XJ3hjs/0t9Tbx8gj0XpxSjmsgeVoH5A5LhAKhxKyrxCXVpoQposYFrt/vWy
 HgNDUNafnBkiBnq89Xz7RtkC3hsC2sYGNlRj5E6sZXZXHjB6tuKO0RXCgyITo4GP7O6EwJjYSZ+
 o0iezl2OzdPn0ID15+3uQwu3xOEnBvhSM4EtTetJVHcvrA7Jatrty+gR0Edq8eI6h5mFOLQM5wa
 7vEyy5TLfHHtspzi+XZZuOmfXApiMtVHzobWkWd33IECGNbNshWdlC2tDo6usVmeOyfPwMIF4EF
 vOVmdNdV2JxDwse+nuDDtaM6YzD1pPtTShelxMv/THlTuS/V7lg7CZMhNUG9KsAB9W6j7cXjG9T
 AA7m7/t0hDN9m9HAF69FPvzN1q13BA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Enable QPIC SPI NAND flash controller support on the IPQ5424 RDP466
reference design platform.

The RDP466 board features a SPI NAND flash device connected to the QPIC
controller for primary storage. This patch enables the QPIC BAM DMA
controller and SPI NAND interface of QPIC, and configures the necessary
pin control settings for proper operation.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v3]

* No Change

Change in [v2]

* Added Reviewed-by tag

* Added \n before status in qpic_nand node

Change in [v1]

* Enable bam and spi nand for ipq5424

 arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts | 44 +++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
index 738618551203..7c32fb8f9f73 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
@@ -224,6 +224,29 @@ data-pins {
 		};
 	};
 
+	qpic_snand_default_state: qpic-snand-default-state {
+		clock-pins {
+			pins = "gpio5";
+			function = "qspi_clk";
+			drive-strength = <8>;
+			bias-pull-down;
+		};
+
+		cs-pins {
+			pins = "gpio4";
+			function = "qspi_cs";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		data-pins {
+			pins = "gpio0", "gpio1", "gpio2", "gpio3";
+			function = "qspi_data";
+			drive-strength = <8>;
+			bias-pull-down;
+		};
+	};
+
 	uart0_pins: uart0-default-state {
 		pins = "gpio10", "gpio11", "gpio12", "gpio13";
 		function = "uart0";
@@ -246,6 +269,27 @@ pcie3_default_state: pcie3-default-state {
 	};
 };
 
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
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_pins>;
 	pinctrl-names = "default";
-- 
2.34.1


