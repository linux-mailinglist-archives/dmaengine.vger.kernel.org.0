Return-Path: <dmaengine+bounces-8781-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMCTHIC8hWmpFwQAu9opvQ
	(envelope-from <dmaengine+bounces-8781-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 11:03:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F531FC67A
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 11:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B67E9301870D
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 10:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD4936403D;
	Fri,  6 Feb 2026 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gkQJtqpE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1413612EC;
	Fri,  6 Feb 2026 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372172; cv=none; b=X1HuLKiWEK7IsiKfYM5n0PcrLJ8oU9kPi9oMlLWSGIGy3sk5FQ+5eHUygUkYIxJ7rcGh1hPS/Tz9bb3RFKiPy/z81+42OA5hob3p9UyliUOZDXhT9PeggID4ay6z8VODOxbeVWWPI0W7LZJwb8CTH6yneNGH661PPuafU+FXp1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372172; c=relaxed/simple;
	bh=PrUtWxceBsKgptMIwVKvAd2dVIlBx67lwULySl4tJGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/anL+pfJ5l/jL0E6PdZFv6oTGggd7IQpPk+glsOTT6sqvuoGTQMZMfZqxonxUlcyRf+zgVOrkIMX0BX41V0Z0lYJvn97+5rBT6PLykPiWJHJT4p2w6wcAq+BO+h4nFBFAeZaIYontdOzI0KceifynePzXIv7neEzhwEBttt88o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gkQJtqpE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6168Zj5x1420290;
	Fri, 6 Feb 2026 10:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eZREohOSfOfV7XhcN0vaX3HPmlNgKTMqsk/RRqiSB/U=; b=gkQJtqpE72qMrgoh
	pa5E93g0lI3j5s5y1MTvlUZ4ke5B0y3BWg7Q6waBqQBN5NUZ7TrqVOO1qlYbSIy7
	fnijrqE1fWuyqVsztNDHlt0xXHf54k4XLiB216Gyzz+cqGK1WLA2Ll9OC4Ga/y3l
	l5gx+n4Axo+u+3DONt1HAi64uiM/Qy8Cnk/jMOtTMHkAvTwFxskJmLO5Uy3xm3nf
	GjO+qWhw+OR4e/zS2oTExuac0B9jiv10EFfBeQddX73UopnXeElSEmYY6kjGRniM
	ZOxAR9ytEgpOmrzD8QbubmlFo/Vd5llz8uqQCarwEFG0nyQ6wTyyqLmPOE84W9qT
	hDPCtg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c50a9au58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 10:02:48 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 616A2kmW027120
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Feb 2026 10:02:46 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 6 Feb 2026 02:02:42 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <Frank.Li@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v4 5/7] arm64: dts: qcom: pq5332-rdp-common: Enable QPIC SPI NAND support
Date: Fri, 6 Feb 2026 15:32:00 +0530
Message-ID: <20260206100202.413834-6-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: 0RH_Cp3YBIo2C7f0j985XCpIVG0kiIWF
X-Proofpoint-ORIG-GUID: 0RH_Cp3YBIo2C7f0j985XCpIVG0kiIWF
X-Authority-Analysis: v=2.4 cv=e6ALiKp/ c=1 sm=1 tr=0 ts=6985bc48 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=ApJ5WhRBqtmdY_byfOgA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA2NyBTYWx0ZWRfXzNbIBvD/txGE
 lDiLplBmVyCe3Zc9/rYzDSOu4mx//Zf3Ju4JOaeJrT3Q+iAzmIL6A9Uqj1D1wLIdWV+AON16Zpr
 YetR3acRVJ80hkENXgnqCEKy2/X9vWo42a8QljHemqF71If+CPUIWBPkgsOSZQ5VoHk2qz+XuAY
 m5y5mlE8Gno0nDJytBv/aLIiIImxklYi39suyounG55pc5cMM/ElVdBYMxJEcwZBSazZP87FeAD
 afZ8XVy6QqqcIjDeGb6l9h3BV6iBGmIrTobteXsOsn5gbf71ueZ86LAel7WKdUzcqbnLERqxio2
 +l4+OGXv35Kn7035dzOO564DuGvZLX3NIzoLWzQ0ATRd2oGOmqhxo1FHiTbNjyPUiRHzJfWAI2b
 sd2J9lr53PXlX5s5BNAd66HH7zmncQSBSTQbD68LdQ+wvYjZCNL/PZn2KTB1Me+1fmEZkdBPCmP
 gtEhv3eZYXh3hSKXuaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_03,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
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
	TAGGED_FROM(0.00)[bounces-8781-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,quicinc.com:email,quicinc.com:dkim,quicinc.com:mid,qualcomm.com:email];
	DBL_PROHIBIT(0.00)[0.0.0.0:email];
	DKIM_TRACE(0.00)[quicinc.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1F531FC67A
X-Rspamd-Action: no action

Enable QPIC SPI NAND flash controller support on the IPQ5332 reference
design platform.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v4]

* No change

Change in [v3]

* Added Reviewed-by tag

Change in [v2]

* No change

Change in [v1]

* Enable bam and spi nand for ipq5332

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


