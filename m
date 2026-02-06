Return-Path: <dmaengine+bounces-8780-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NvgKIW8hWmpFwQAu9opvQ
	(envelope-from <dmaengine+bounces-8780-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 11:03:49 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E67A0FC682
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 11:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74CAE3014920
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 10:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DB23644BF;
	Fri,  6 Feb 2026 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ECrZsbyb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FEC3612EC;
	Fri,  6 Feb 2026 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372167; cv=none; b=VJoT+bnWHw+S+d840qPppIrCswGLa6QW+NB9XfpCRVOVfyL3KuaPfG6V5pNscUEGtizvIXBRYTsBpG01qcoZuomGaIfo0Y33OSx8BAtF69Tk9EDu51pMrHFuyPOcKRjxacp1JY+/A4ZxLmPF+VhmmCoVFCOERHgUm5VdnYnxSUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372167; c=relaxed/simple;
	bh=Lj10sZocqyuc6ot+ZbVLj5YVSltO/hV2gJL6T1B9NOU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfFCLcM3XCytrU9sgbjwt/ugE1wwigD13s+poppakm+2gLLXunOjCqUfO/mXcFwrjPDGS9mKeTEio3gbD6GvuttkAsdUnP0BvfnwgmLyNMAFzFkguIqervh+XTA4A7cYHK/LK6kjcspfFC/G7UfInzhKxE9Z6Wpx57RnFr/1sQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ECrZsbyb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6168XidY694782;
	Fri, 6 Feb 2026 10:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NLsGzE6mXt8Ezs5W1FXZRfRf4DC2p53ycZR3Jc+r71E=; b=ECrZsbybiDiHqUvc
	B3d7oFPOw296JPdq0fTEnUaCNYPIZCNibXLZ1FWzDtRy63bqXe8R3j0goKzumFO5
	R/hKP1rszXjamSUOdvQes6Jef4VjAvV5N0OGAjjwBkYL24Uo7wtxmfgjd5+9ytM5
	GgBVJZ/UHjU+f8dvnPtvjirup40zgvdu2YNriFfLnGPi6TzyLqxi1x1xQp6Lrajc
	vGEz4IVu/1pGTme+kM+Gv/wfLiMS/i3IhBY0s8Os05QdGdw1Dtvr1XLBgsaElNq3
	B7c7Dl6Um+gq0CH+pihsLvB2/hgYky4uUI/+DP9nm1uZITV+44xDQVtIpLw7R36R
	yx0kmg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c53qva2gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 10:02:43 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 616A2gFQ020391
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Feb 2026 10:02:42 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 6 Feb 2026 02:02:37 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <Frank.Li@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v4 4/7] arm64: dts: qcom: ipq5424-rdp466: Enable QPIC SPI NAND support
Date: Fri, 6 Feb 2026 15:31:59 +0530
Message-ID: <20260206100202.413834-5-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260206100202.413834-1-quic_mdalam@quicinc.com>
References: <20260206100202.413834-1-quic_mdalam@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=TsPrRTXh c=1 sm=1 tr=0 ts=6985bc43 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=GMCKaWqv3SNeHD9qFv0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: hlQXLMbav4mSbez-z0cXMsvBJKwSYi10
X-Proofpoint-GUID: hlQXLMbav4mSbez-z0cXMsvBJKwSYi10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA2NyBTYWx0ZWRfXzoMhMFBXjybs
 EHXg6X+rcxYGIM670kzmYdZHYzU5k9zV8acsI0YtMDtkierQS8zNG3tcjomfzdsBs2X8rqRs2RP
 Ryztt3mJONxsCLx0Kl/6MgZ+YpS4T4JosVY1gsGnEcG90iHFjSeZIznHQBaDUvZhdbsjb60Q8yz
 1etmamTL6yy8Mjifd9U+eULHn1IfrGx2fUi/pnRJpm2CuwsPAqGP+wFQnLKBLmRPQRMNd3U0+Qm
 so6sZndf8uVJUOJvrFQzWyDVGth/Ess9kN2L9xZbZCzBn4Kra/SnHob58ZMoAjUX9xQlULjpyAt
 KAcDrqrV+YJLT9o+KQQyvCqcpo6ux0pH3zY7JDOCoOld7+aODCK/KL2vflAT5D/7q7yKG+gnmQJ
 UvtEjbBQSk8wuFzlJSxZrpmWeVgiYQD9EDyos8SQ+crmscekshxD/A1ExIR+4qyuEJOlw0BByDA
 OSUvdCHoDQUhkOPLNtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_03,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1011
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060067
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[quicinc.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[quicinc.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[quic_mdalam@quicinc.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8780-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,quicinc.com:email,quicinc.com:dkim,quicinc.com:mid];
	DBL_PROHIBIT(0.00)[0.0.0.0:email];
	DKIM_TRACE(0.00)[quicinc.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E67A0FC682
X-Rspamd-Action: no action

Enable QPIC SPI NAND flash controller support on the IPQ5424 RDP466
reference design platform.

The RDP466 board features a SPI NAND flash device connected to the QPIC
controller for primary storage. This patch enables the QPIC BAM DMA
controller and SPI NAND interface of QPIC, and configures the necessary
pin control settings for proper operation.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v4]

* No Change

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


