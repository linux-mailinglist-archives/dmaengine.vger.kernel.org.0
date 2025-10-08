Return-Path: <dmaengine+bounces-6785-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C78BC41D0
	for <lists+dmaengine@lfdr.de>; Wed, 08 Oct 2025 11:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72EF51897469
	for <lists+dmaengine@lfdr.de>; Wed,  8 Oct 2025 09:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2B82F7AD3;
	Wed,  8 Oct 2025 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g8AUvP7K"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467BB2F3C25;
	Wed,  8 Oct 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914327; cv=none; b=rq3jJVBbFaMQFAFHPIViv3N1bvX+/OJq9pzQBDk6C/FXGTcHsReVo1EqmgEkxzqGrXO6AR2g6WdBLjAmi6JqJdppt8yBojRS45WMWUGyWhWtyTerr2whQGc51cD2un5VydD86GRyqedJApfy5qJcfrzg3l5jbUuAX2+EtL8GDQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914327; c=relaxed/simple;
	bh=sgiyHIyZkgo86MDXHHpY5us+OKGYbWCsehGwfQKXFy4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cyjk6ZrCJX/qojmBP+sHsCM5NVItJbhl5c6g+PmNvg/2QyFHkHAIaATLnDDQkxiItk7xa1zn9b/LxS7p36xei1zqw1/RsSMS4LANroR45haBWFHqdYeNaYiXQBUOe5GmuCqDS4HLomP6fOPRLhMTGn739OQb3JjufgPHBxafKAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g8AUvP7K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890Oa5015802;
	Wed, 8 Oct 2025 09:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/mjT9kB47sUUbAip8Q2QMW6o50qb3GcX6CBaAVwcdgo=; b=g8AUvP7KZIlobV2h
	W+1PmOpHpDCiRNsq2MSMh3OoqFEgkfnXyAToqnF5mSfrQqF4rLD0zQOcxVZDP+r6
	J09pWiOK3tZXbeeLqg6xZBpv/ZsNmB2+dzmJlHpTlzrIQwRlbbhGybStwrblH618
	jqYyaRPeOdtbkO58BwKnNxIRN8tvDJtpQiVN4eD6xugi7ziLNQMDPEBC6paIf/DJ
	fJa4ZVNycu8IuO1S8vnzKKwe2yVTzt6mUQ1x9xlizn4fPEAroTjHz8wtoj+nkwNb
	rHXE7HExkupQuBROGMCdo01naPekE2eXm5Wq4IRE0mi5bj553QbV177Oxf3pi7R5
	CbwXJA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk71wra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:05:23 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59895AQj003272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Oct 2025 09:05:10 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 8 Oct 2025 02:05:05 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH v2 8/9] arm64: dts: qcom: ipq5424-rdp466: Remove eMMC support
Date: Wed, 8 Oct 2025 14:34:12 +0530
Message-ID: <20251008090413.458791-9-quic_mdalam@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfX8+dlOLnSIVI2
 lE/AXRe5pJzWTOc9xJ3+zktOA8LaoLDv1jenCz5uMKCX1NRsNAFKNGGu5A3016du34JopDQWr0L
 PEwbY5bMtSoTMHONd58WebKJNsGi6RoGrvVWJyZF5bX6HnXnfS9DFZnQ0N3euGXW0pDxEEssBey
 rjYAlOHXt9Ne+cG1gVu8FgoGRg2pJNh4kNU8Z26sDkJn7n4g0UeG6IMvCRyoCSPPB4965gIHVjV
 kE6znsocdD6xnGipwxmAu4niYo3T2Qy2fg7jN5wWuQNmgef9lLWp9Jdc2wUIcwXsnPAQLlJ0u4B
 pimH+jGr608l8Jv02svQtiYHE8wLEf615r90p+e8xCstRz+2Aurm1bLldLYQAmATiqV+BnAPMAf
 2OtSvzm47a7tmIsUZFzzmIgmB/peRw==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e62953 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=QIVe3DVYhI_-bwApSWIA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: LjxUKLrT5K0HLPD32uRwulQOrY6vd9bN
X-Proofpoint-ORIG-GUID: LjxUKLrT5K0HLPD32uRwulQOrY6vd9bN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017

Remove eMMC support from the IPQ5424 RDP466 board configuration to
resolve GPIO pin conflicts with SPI NAND interface.

The IPQ5424 RDP466 board is designed with NOR + NAND as the default boot
mode configuration. The eMMC controller and SPI NAND controller share
the same GPIO pins, creating a hardware conflict:

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

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


