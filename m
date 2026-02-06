Return-Path: <dmaengine+bounces-8783-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDdKCty9hWnEFwQAu9opvQ
	(envelope-from <dmaengine+bounces-8783-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 11:09:32 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE55FC82C
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 11:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE94F3094A66
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 10:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA93E3644BF;
	Fri,  6 Feb 2026 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X8c1woaA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B813612EC;
	Fri,  6 Feb 2026 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372180; cv=none; b=Ubbn+Xz8KnywJ1ujgemoqMnGXruwGndPLMFsjr1SbjbNCGmQdg4o2kAbXUCikyXJLnJl+aBJsqHMFIZHY798bQWuUneSDan1KiJeHFYboW8i8n1tkms03tJm5GlERUjUGqjfNBKnjIzC8evkFPTwIzn7TY1ST3bMlinjstFhs4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372180; c=relaxed/simple;
	bh=jkYB8BssoioRYHyuCDt6FyexN3rHFQ1cQ8BB4b+UjBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3f52jnm1DPP3ZEXQ9OUXvrYZqlIBUOf7xbjUpRIRdbsj+fZtp/JngbbRS0Rmy6vnLbRubHeRtn4/4peSkoK7N5kV9SNfTtnAYXZ/Eln5OMnOeiPcyyhb8ZG6por8HRiDCLDRV5G5sTiBCKvhS1EBrj1RYtxqbPBAfKDKrOxthI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X8c1woaA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6168ZCr71988468;
	Fri, 6 Feb 2026 10:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rKRJafa6ySD1hTQ3NhRNuellFDiTNtgs02y1e/7E/rA=; b=X8c1woaAPilEjcqj
	lsKIroJuiDZqcz4hL5eqL10DYqJZiSyYeGM1ijPCYPlHkSHjUj5sCHPt/KdBm3Dv
	mM75kfyrX8atle3F5pt36K3ldPBhxgyCgOg+PlIrXj7LzmFDTR8zlQioHam90mRG
	g4TXYB8hDEcRBuZH3QFMCJtKwBJeWHlM1h6RrJPQDE2rJMRz312ih3wnvrW1hV3Y
	piviMLh4jYudOHdsbQpV4WAJdKHA6mR3Dik9+GpWtA7xqhAhoKU1dYgaRFV8taGc
	EjGHj3LitTjdXsAKqB6wJzQ7VOWt8owq52Z4Lbz2Dy6P2Sp4mJmtdTeLzk98xp5N
	riTY+Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4t0p4508-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 10:02:56 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 616A2tT3028748
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Feb 2026 10:02:56 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 6 Feb 2026 02:02:51 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <Frank.Li@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v4 7/7] arm64: dts: qcom: ipq5332-rdp442: Remove eMMC support
Date: Fri, 6 Feb 2026 15:32:02 +0530
Message-ID: <20260206100202.413834-8-quic_mdalam@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=ItITsb/g c=1 sm=1 tr=0 ts=6985bc51 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=fuWxvNZPvO_ztXA3lyEA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Ds6UkQn9OTMPbkBvPaoEELMhIICb0VNI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA2NyBTYWx0ZWRfX8O1HltXhNcqd
 dwhqsY38+nhv+HqGTvbAsAzKGp8xfNlrCE9+AoaK9iDmsezmvrlQSkRL8k2eNu4ADHyWr8ET75M
 FM1+9P5lyZ6n4oit6HPh5U5njMvoHch8ZtzSyFo736lRvd00Co+3qr+M1jry4x3ImVgWO4IuSfZ
 8GSm2Xaa+GOeUAN0NtYKDywHg02kxYDwxJDCnz79xyYYo1L50rtF1wiKkjBCTy3jltNRbpeEEve
 HWnR6pM8d84bMq84dOjT6NID69syJdhsVxFw/tinis/lFsWIdW82Kuw06FmFMWciXQxpatB9Wmo
 ESDSwNEBSLC/v5M6Tg9O6ObiV/W0YtvNBiQJb0IraNrqlj97vjEIorfOoShDdDsAyDBp9dJYLaK
 Pjq7p796plldOwV6Bn24giaYvrx0lrE9gEEwhU0qAoxbAPZz9T1chmVUlWU0HMpzuXd3V/DwhYT
 0hO6LSovUZ9d++748kQ==
X-Proofpoint-GUID: Ds6UkQn9OTMPbkBvPaoEELMhIICb0VNI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_03,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0
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
	TAGGED_FROM(0.00)[bounces-8783-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[quicinc.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,quicinc.com:email,quicinc.com:dkim,quicinc.com:mid];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7BE55FC82C
X-Rspamd-Action: no action

Remove eMMC support from the IPQ5332 RDP442 board configuration to
align with the board's default NOR+NAND boot mode design.

The IPQ5332 RDP442 board is designed with NOR+NAND as the default boot
mode configuration. The eMMC and SPI NAND interface share
same GPIO

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

 arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts | 34 ---------------------
 1 file changed, 34 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
index ed8a54eb95c0..6e2abde9ed89 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
@@ -35,17 +35,6 @@ flash@0 {
 	};
 };
 
-&sdhc {
-	bus-width = <4>;
-	max-frequency = <192000000>;
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	non-removable;
-	pinctrl-0 = <&sdc_default_state>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
 &tlmm {
 	i2c_1_pins: i2c-1-state {
 		pins = "gpio29", "gpio30";
@@ -54,29 +43,6 @@ i2c_1_pins: i2c-1-state {
 		bias-pull-up;
 	};
 
-	sdc_default_state: sdc-default-state {
-		clk-pins {
-			pins = "gpio13";
-			function = "sdc_clk";
-			drive-strength = <8>;
-			bias-disable;
-		};
-
-		cmd-pins {
-			pins = "gpio12";
-			function = "sdc_cmd";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-
-		data-pins {
-			pins = "gpio8", "gpio9", "gpio10", "gpio11";
-			function = "sdc_data";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-	};
-
 	spi_0_data_clk_pins: spi-0-data-clk-state {
 		pins = "gpio14", "gpio15", "gpio16";
 		function = "blsp0_spi";
-- 
2.34.1


