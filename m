Return-Path: <dmaengine+bounces-6620-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCEAB83D6C
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 11:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0C1163212
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 09:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C7D2D9EDC;
	Thu, 18 Sep 2025 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Yn08jwkk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D4527702E;
	Thu, 18 Sep 2025 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188476; cv=none; b=UhYzDuHS/rrE40WXM0MedGwPG8vGApPkjfqd2yoG/Y2AJVR8TWDXvaxxycSsuc2PuT/VpwxkIBJN5Lzboo1vWTChrM8DfBiFKGFbz2qQv4HSCLXpDgR3a3NW2JjdMKUHpR918tgDziFvOLtKyBS9d5bvpf+9np200HJWQ0DCgEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188476; c=relaxed/simple;
	bh=GdIawdYm26NiWvNqC/6Mzf0Zllp4flNHtojVY8vxhGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dzba1BVw2jgycnrg7CEIt0xA3EA8sEM5Abzi1sUmiemO9mwm3cot+nWwqNNB3MQJ2K9LC1BXTnKVkrWamgVagsIzG6JnSc+vzN3TIn7jQ2uJ85bG8ixMYVPuyQkNOWFGY1kw8PNZ6CCNUoX2FUnDriUcSsq/SwSSYf5BMnUw/ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Yn08jwkk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3JTBI026824;
	Thu, 18 Sep 2025 09:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gnxxj/Wqeu3R498OoaefKrX9zq+9d1MmqtbSJpdZUnY=; b=Yn08jwkkaWzspKqF
	h4xYWLQDTXTuI66QUocyEoP6nSs2xk5rtK8aFChK/2vRqlmKkHrTsvW6lctPr5Hu
	EM6HXV5QmCjQv6GtSIfTO9lOsi/+4UwyQQy1lteqDfH2wKFL3iwtJfq8fzMtpeZV
	rlu0/nM4uqTY7pdD8ERf7tLdKdBkz/hilX7vobETjHwHN0HvhfUJTprawpRO5wzS
	WtkmqoIF939T6N+00QJeuJjrJXPKNpbzvmwwxbEQjOW5JZE+MNiGno5Csy3Bk2hj
	YbvzwjHF5RC3L313yy3MFYK+/Jpo4EL2ORGIC/I+3sG454HsigieQ51HM30mqjl6
	KavP9A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxt5tv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58I9f8gl029124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:09 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 18 Sep 2025 02:40:59 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH 6/9] arm64: dts: qcom: ipq5424: Enable QPIC SPI NAND support
Date: Thu, 18 Sep 2025 15:10:14 +0530
Message-ID: <20250918094017.3844338-7-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: 3tsq-qkibFaazz5v4fln1qj8o65S4Hq1
X-Authority-Analysis: v=2.4 cv=bIMWIO+Z c=1 sm=1 tr=0 ts=68cbd3b5 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=ywn8sjW2YVwPcYj5yiIA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX5TLQiih/fI1P
 ghid7Uxqu83UDwkEjcpBSr/iDG/juilkShgq35Maa5BI5fp1SnL1urcxK+keSQcXtARgLevisfw
 s7gGnWpnnLwtRYECoNVzKdIu3+DUlOem5/fYraNZ0OEcbOMIJEao8Z0K9FyMRrA/eajYXFwaS6o
 PQwCs94oqNS1KBnPXVYD30/IdcoOSjdyCRv1hf0Zs7hPyMvKL4Lb89eBRr9c4Ch6X7vhUEuvRiJ
 N5b7U8HTdvRfZPWg3RaV4TINyiHoVMiyG0dPGl/kqQJEM9cipDB9VoK+ROYY7TAvxWHGyMNSjiY
 g+tqB1FzC+AFRMC/Bqn57NSEYe3YYjZLdWvLpfVLsGb0WZsFpRxOEZ6l+FijG7gq/rmy0RhEDmz
 SNTktfHu
X-Proofpoint-ORIG-GUID: 3tsq-qkibFaazz5v4fln1qj8o65S4Hq1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

Enable QPIC SPI NAND flash controller support on the IPQ5424 RDP466
reference design platform.

The RDP466 board features a SPI NAND flash device connected to the QPIC
controller for primary storage. This patch enables the QPIC BAM DMA
controller and SPI NAND interface of QPIC, and configures the necessary
pin control settings for proper operation.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts | 43 +++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
index 738618551203..accb15b0d742 100644
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
@@ -246,6 +269,26 @@ pcie3_default_state: pcie3-default-state {
 	};
 };
 
+&qpic_bam {
+	status = "okay";
+};
+
+&qpic_nand {
+	pinctrl-0 = <&qpic_snand_default_state>;
+	pinctrl-names = "default";
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


