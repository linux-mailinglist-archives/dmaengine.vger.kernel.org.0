Return-Path: <dmaengine+bounces-8778-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCVpIXq9hWmpFwQAu9opvQ
	(envelope-from <dmaengine+bounces-8778-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 11:07:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB40FC78F
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 11:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 380E230C91BE
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 10:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64649363C5F;
	Fri,  6 Feb 2026 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gesX7hPX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218713612EE;
	Fri,  6 Feb 2026 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372156; cv=none; b=m8QdgdEfIXVGACJ+cO0DiwvQIzabs6yOI1elGpquRaAmBYhcS+52SHgRAieLHwLTpGAARO/6tRMLDfz/QV+Ab02bichV2Ipm04Npab3ba/iMYky9m6ZttBRwWm0exGMUwMx+dRTASLyTl9QWN3oloYxMuRBpk/zGIAvr9Bv/jZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372156; c=relaxed/simple;
	bh=zyq93syQZQjNKLBLueAo3j+you7jZpvModlCJ86mZmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtUPUa057otkIBnOCGxxIUMhD6PAGjNHWDX9bjFvPe2FM/wlsWpd/6x3rH+WSKmjoRAGPrEivoxq/TNKSlVlYB7EBYgCOsuoPKENsiumN5psh5OEz5qMOn9gqgEt7prgea5x5IsIhAEi6GjCy9d62+6eSLKbAUffW0H+4mTh6VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gesX7hPX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6167bRp94041873;
	Fri, 6 Feb 2026 10:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ekwDiV4154yU8oMpy5VXfGY5kFz62mNuMsKVh0p3B5Y=; b=gesX7hPX5N4MLbds
	ugFLnk3IiYwyoY8WkMWHftdXhvxITZYNoUF3JaHO19I0zRs0ACXzsIqt+GvoINCs
	cy3aIpTRNQmDKR3TU8/6ZhAzIiYTkIllYBZXkLD5skfy2g2VT+buqvzkzJ7rkjWT
	MLws/uADMqTui5ZFSeHw/0r3Wv0SAPT5D6xQNGAW59IlAqgtr2SjDSgNWeMOxsTb
	GPgU/mwMU9r6r3N4LQsSrIpD4bV+80Di2nSM8WdzTWxBDzHC8kLaFtd3U8TayHJH
	TXqlSvTX+ykzKdY7OnbfGFqUuTc8xgXbXprvpUOatd8++oEO4RE53PYJjmy0VQsc
	tBPupg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5c2w0gf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 10:02:33 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 616A2XiV020266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Feb 2026 10:02:33 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 6 Feb 2026 02:02:28 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <Frank.Li@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v4 2/7] arm64: dts: qcom: ipq5424: Add QPIC SPI NAND controller support
Date: Fri, 6 Feb 2026 15:31:57 +0530
Message-ID: <20260206100202.413834-3-quic_mdalam@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA2NyBTYWx0ZWRfXwUZQwIQQzj34
 lbCgaNvTbJNXgJudt+Z9gf+mSrE+YX7c8kEjY3VpdIT7uCiuBKxaCm0Fe6yUM6RhA6F4Pck9xBS
 8DhwbdA+sNniSjoYYhfiR28tDRlmjmaRUWXfXu7KR1gW/s04X1AGlFXRLOD2vze4smFH+yPG6Wd
 qH0DmznIL9aN8DdnTLdV2lf1rB4NX9zMNNTVw9vwPHHUtwLopiqp/T5t+34pnypj9jz3CpnVyxl
 U7IKE4apm8pTVtSk1NXgqqTpmq9eS9wc++Y0bFrEZKcR9VNRmpk5aVs6BT+8dwFIVI9Xm/gg9et
 X4ZnU/T+twS51ACgfqgFjvUSWoAGRKxSgrX0V/90ekr2o5Iy3AxK93rEwtTFheI0lnnd98FYhJ0
 JqhMcuv3Zu6OXh/H3B7RmDkBVFWd2LpL/rlHAO3c8Klb5vmzuWCVLOWgosgjLkiri4QEXcAUi6W
 3o/qI6BypKiiIXYLreA==
X-Authority-Analysis: v=2.4 cv=Wtom8Nfv c=1 sm=1 tr=0 ts=6985bc39 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=6UWhdCim3U11iwMnUWwA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: S38bmlwW5QOQ3wpfjKMsNeOw1Ou_Z9q4
X-Proofpoint-ORIG-GUID: S38bmlwW5QOQ3wpfjKMsNeOw1Ou_Z9q4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_03,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060067
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[quicinc.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[quicinc.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[quic_mdalam@quicinc.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8778-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[quicinc.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,f200000:email,0.119.20.96:email,quicinc.com:email,quicinc.com:dkim,quicinc.com:mid,79b0000:email,0.121.211.128:email];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DCB40FC78F
X-Rspamd-Action: no action

Add device tree nodes for QPIC SPI NAND flash controller support
on IPQ5424 SoC.

The IPQ5424 SoC includes a QPIC controller that supports SPI NAND flash
devices with hardware ECC capabilities and DMA support through BAM
(Bus Access Manager).

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v4]

* No change

Change in [v3]

* Reformatted clocks, clock-names, dmas, and dma-names properties
  to one entry per line

Change in [v2]

* No change

Change in [v1]

* Added qpic_bam node to describe BAM DMA controller

* Added spi nand support for IPQ5424

 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 33 +++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index eb393f3fd728..f20cda429094 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
@@ -572,6 +572,39 @@ sdhc: mmc@7804000 {
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
 		intc: interrupt-controller@f200000 {
 			compatible = "arm,gic-v3";
 			reg = <0 0xf200000 0 0x10000>, /* GICD */
-- 
2.34.1


