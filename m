Return-Path: <dmaengine+bounces-8782-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE40Do+8hWmOFgQAu9opvQ
	(envelope-from <dmaengine+bounces-8782-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 11:03:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5566FC699
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 11:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2757B3019D5B
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 10:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18889366559;
	Fri,  6 Feb 2026 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Uj+hcb2K"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42203612EC;
	Fri,  6 Feb 2026 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372176; cv=none; b=kxHdT4Z+FrjjshoY4FL6mojGH5Hkm6K1MUdyUrVuWD/5U6GaJP2UCOIaadvRpra9jJiFcXrJjnkN5bp2q7HrWSz3DCAXyvUt4UbrOEzSvHW7bDhsJfy1eEGkfO36EgugHO3JxX0iFyJQ7w8gFNY8y/Ep8GecVYa9Dp9r2m2F060=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372176; c=relaxed/simple;
	bh=S3k4BjRlS5wP4pujErKb7ZWGChsCGkt3VLlMXaO22Ww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcNv0z3EoeIkRN4SUxFvr1pZEXNS6aaSC4EGPQqMuXUdtYFHYF6HomOtv1wGb1xKMGGr+3tIqYtcOINZ7bc77qORR7N6qXQvpOZmgsDOzoapy3jw/4XYU9skAAgpW/d2UPdHuwe88Zqd2mhuNI/MXHBfFke3lyHDNENR3bvOoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Uj+hcb2K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6168IqiE1419630;
	Fri, 6 Feb 2026 10:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2pWTG0gCQWUbaDz24Q3iEGRr8yV3I2tnk7zTONXjsdw=; b=Uj+hcb2K5xMaayeg
	KOCKum+NMvCRzkv2GJSWUDbDuH3pJyynsCRsuv4buQbNa8RCfWMK1oIVbs7ljEAg
	4gqkvBqPKOgY3uzI+xKwL0FhFLoMStgcrQMBWEGj6JtM2yr/QA2wch13QWvRyZ+N
	ccDb/P0BPrlTSBIhSX0Ra0zHOZkbRSwqtC5Im0i2vHGHf0RwQ14bCbKAx7lVvq0B
	l1kgo5lGdHZ+Z9HuSDgIe+e1W7k0Ne2TqefX53YZcdmCtkqVlGKiQ+1MZaswn7LQ
	xMgFnv65BkuqSvD/2rKo+jYjsaXx05gjHg+nfx6xlYS6P0RjUFHaWQtImAzxpqXK
	AL+nMw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c50a9au5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 10:02:52 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 616A2pGb002631
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Feb 2026 10:02:51 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 6 Feb 2026 02:02:46 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <Frank.Li@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v4 6/7] arm64: dts: qcom: ipq5424-rdp466: Remove eMMC support
Date: Fri, 6 Feb 2026 15:32:01 +0530
Message-ID: <20260206100202.413834-7-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: MmbQq33jDw1a6boqC1AVSbe_kqdAPmE-
X-Proofpoint-ORIG-GUID: MmbQq33jDw1a6boqC1AVSbe_kqdAPmE-
X-Authority-Analysis: v=2.4 cv=e6ALiKp/ c=1 sm=1 tr=0 ts=6985bc4c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=QIVe3DVYhI_-bwApSWIA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA2NyBTYWx0ZWRfX+LvTLJOg5FA0
 EUWDq8U6zMdhSYsc8YUaaNOnSIpPPmZ6RyWvH9imF4rz0PMuUQmm6O72zQ9mWvVEqAHZFNQKB8L
 mfMIbehaeK/YRktEPM12hOgJtdA9tHrbPMc2RzgTWn7/lN1EfSe0hF6L/pLLIQQngddOYtmqT7r
 mQbbYKCCs1XN7U8aKsa8uNMm03Sz0zWsSHLpRnNNAGLny5V12goBL4evERRjbXjH1CxggtxGqb4
 3SUaWK+kVbJw5XzgKIfFOTHJlTvsxh2Kt3m3jw2UtgKYmYnZJ4G3XgMuUoL1C2hWDAIvfn+6Lzn
 oQg+6eEsxpNkB2hGqP0e9oLvJTsIv+VMlt5l0YKxRRHDVGrmBnJggyPqso8LSO04HPFKqEi4jnK
 n8XTNWykjdjUj4BqM59Kk4Sj8ny7qPs6AVj4Qaaqhd/n27A/A+UgqEzUIAMhoADU2xTuyEo6sPz
 bZ6/UxYGkDYCooG+Shw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_03,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[quic_mdalam@quicinc.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8782-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[quicinc.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,quicinc.com:email,quicinc.com:dkim,quicinc.com:mid];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D5566FC699
X-Rspamd-Action: no action

Remove eMMC support from the IPQ5424 RDP466 board configuration to
resolve GPIO pin conflicts with SPI NAND interface.

The IPQ5424 RDP466 board is designed with NOR + NAND as the default boot
mode configuration. The eMMC controller and SPI NAND controller share
the same GPIO pins, creating a hardware conflict:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v4]

* No change

Change in [v3]

* Added Reviewed-by tag

Change in [v2]

* updated board name commit message header

Change in [v1]

* Removed eMMC node

 arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts | 30 ---------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
index 7c32fb8f9f73..de71b72ae6dc 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
@@ -124,13 +124,6 @@ &qusb_phy_1 {
 	status = "okay";
 };
 
-&sdhc {
-	pinctrl-0 = <&sdc_default_state>;
-	pinctrl-names = "default";
-
-	status = "okay";
-};
-
 &sleep_clk {
 	clock-frequency = <32000>;
 };
@@ -201,29 +194,6 @@ mosi-pins {
 		};
 	};
 
-	sdc_default_state: sdc-default-state {
-		clk-pins {
-			pins = "gpio5";
-			function = "sdc_clk";
-			drive-strength = <8>;
-			bias-disable;
-		};
-
-		cmd-pins {
-			pins = "gpio4";
-			function = "sdc_cmd";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-
-		data-pins {
-			pins = "gpio0", "gpio1", "gpio2", "gpio3";
-			function = "sdc_data";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-	};
-
 	qpic_snand_default_state: qpic-snand-default-state {
 		clock-pins {
 			pins = "gpio5";
-- 
2.34.1


