Return-Path: <dmaengine+bounces-6782-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E23E3BC4185
	for <lists+dmaengine@lfdr.de>; Wed, 08 Oct 2025 11:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972483C391F
	for <lists+dmaengine@lfdr.de>; Wed,  8 Oct 2025 09:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508602F6566;
	Wed,  8 Oct 2025 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YhqCSPqo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A52F5478;
	Wed,  8 Oct 2025 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914307; cv=none; b=td57XG5IYTqJcUKSU++m6GuvTdUwZ82KZzr0vVa4903g2kp8q4asq2ycv2aSfbKqZEskHdnk8FvvqsLTgHKXT5opYPA55J4vqq5VXK1gMMUsK+oOjJUJE6jKy5OrgRO031gtACc+BCd+iibiaEn6ITnbBLMOJT2QGtpe9ID5GSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914307; c=relaxed/simple;
	bh=461n82HmX7GJ0FAxHfJDSk4/yXBz8iL18Ba+6wIGtlk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUV7z54hqh0DgNIrAv4xbuLd8GwnuxFi4L8T1+wwX8baLfeVW107l+NFAcDvMxMZi9B3DBfMPnWuKiXiDwANaoTaf2ccXZajK5OMmU6s291fy9s3XXK5JCYJ9diP3D5ppeKmTwMtzvaFbIC1hNX5HE0VGR/RDeRSgT0oT2njT2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YhqCSPqo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890Px4014215;
	Wed, 8 Oct 2025 09:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rFhFJt03ODwKAwT11jezOJzq8xnYSNok6qD61we6204=; b=YhqCSPqop2k7Ouwq
	pBhdEIoFQvhsi9HQhWnwxSRqTIHPDsZenghxtWe/0J2cEH7CIPoFcQEmnvWqQIzd
	HiLzFUccVJnkQdk0azU1ZzIHqo3DDLm4kntpfVcDMGN6xGRjqvOGhMo+25Tvq8Gv
	fxp3LTBWNdrw7y0VvgkIkjWihbnDOAO+D0fSIVfpBw+sFjkXf9RTkwSPFAXwEPmR
	eGO36Be4dI8KPTLJ04xxQKuA6RIdFjrreex4ncmWihTE8GRA/BrO0CH+8D6177A3
	VbRtWhg+3ikqx23RFvSBfD7zgD+QEuGr72AyM/FCS7Os6Szdle4Wm5eMijxTd8KL
	qSDujA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mgd0nm7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:05:02 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 598951dY021593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Oct 2025 09:05:01 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 8 Oct 2025 02:04:56 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH v2 6/9] arm64: dts: qcom: ipq5424-rdp466: Enable QPIC SPI NAND support
Date: Wed, 8 Oct 2025 14:34:10 +0530
Message-ID: <20251008090413.458791-7-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251008090413.458791-1-quic_mdalam@quicinc.com>
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: IpWlOjjrqyYQLtwlD3ixxuhrXbR4xunK
X-Authority-Analysis: v=2.4 cv=T8aBjvKQ c=1 sm=1 tr=0 ts=68e6293e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=GMCKaWqv3SNeHD9qFv0A:9 a=TjNXssC_j7lpFel5tvFf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: IpWlOjjrqyYQLtwlD3ixxuhrXbR4xunK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEyMyBTYWx0ZWRfX6to9odKgyzIC
 3VCX30D8jrFKmsU8VHhlKane7uENmZJs6bh/8W5uMVtWJ1ai3YAzpg97NnylRvMNxa6niZbMWrE
 BSXI9UlhjoOEGu6ZPtOHBHUxEhvqxjCeio2nP/UYqV3FBdM9D69TxnhYx0SM0NzlS0l8A6x/TaC
 rrl0lmtEi7mzkCJxtovo19RioPgeomXh+9HQl826iyExrLbBRPY+hvY4oftVIFq4YtNZR+pUwQ2
 13vz8iba9qGhIujLWxyiID23uNkdrobn/BI1vsbU/XHsMTDX/ftplLV0jWq930BLMn3O8NChU6u
 yMzWXQ6JU0F+Cutslg+VJmJKdSTikFlwblDLnyk+QawFSkhCtvEHh8noSpAEqsJIGz+8UoS3XcF
 MbnraQLQ6wdj4jtn2FHgfZZVBed5VA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060123

Enable QPIC SPI NAND flash controller support on the IPQ5424 RDP466
reference design platform.

The RDP466 board features a SPI NAND flash device connected to the QPIC
controller for primary storage. This patch enables the QPIC BAM DMA
controller and SPI NAND interface of QPIC, and configures the necessary
pin control settings for proper operation.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

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


