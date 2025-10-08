Return-Path: <dmaengine+bounces-6784-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A09DBC41DA
	for <lists+dmaengine@lfdr.de>; Wed, 08 Oct 2025 11:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95A0E4F96E3
	for <lists+dmaengine@lfdr.de>; Wed,  8 Oct 2025 09:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593752F549B;
	Wed,  8 Oct 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V+fOwSP5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB81A2F291D;
	Wed,  8 Oct 2025 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914322; cv=none; b=TTxj4JDH4wis/RPjJoDuOjxe7M9KDOLMCK37+fEr7+YAPwa8+g+VjASaBafhfUVW9KxQCAtCK2Xk+F84nYmWorhXYxNEp3gIA7FyAC/JSPvotrUatspLKGquerihxIUWJ1/mWI1yVQh0oOSDrdKSRqPNnmC3yudp0lskJr0cT60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914322; c=relaxed/simple;
	bh=zG2SFgAnMTvX66JU4U3aOYt1Khpl+xBXFVeSii48E0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGvGH+EGhaozZkN/w8qf7bF7cU6rL7uW1XmoZbrskyd/Zokq+/X4QiI5T0C2MkH7BaVY/uyxoY80A/Bz6LNLlEeF7W6cyR6SIkE0hwh2r4c9ixs+Ir3p9g1qoUkmuYjEy1QaYjBXzpquR9d8V9la1RrLw/7awJjmha6N/tuffLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V+fOwSP5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890NNj009328;
	Wed, 8 Oct 2025 09:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ya5YD8J5ZfX8Sq9ehJaERVblUtQVWIBl5djuMxZL1Kk=; b=V+fOwSP5DosBlZOA
	5YGUaC/GyFnDY3KwPhW+Z/folGaIDxq2ZCDDv4aPNbeDDDDlnRBgEBGJC1jCvPSi
	5yrvSQipG3R/bKCNV9z5ssS6rAi6n6MXcY2ITX3yk4lhY5V1TRup5bgIZ1BFMfct
	W282U/kKTn1JMsgaxcemReKgLaIPhR5W5qeROodaynEVYmtWpKmwxsYeEq/2UX/o
	HjthsS5buBoXKHVedGX1MbrVL7Y+lUKYvj3b603kvvHJeHGyBHYZgQ4ngKWkxusl
	p63G7gPKbJLgrdZlF6wFMACN6+zUWK1CwRY7/e5+HtLqxQ0ZhzhohwcwrW4/yj9D
	Ifb2Gw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junu9vym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:05:17 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59895F1S011846
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Oct 2025 09:05:15 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 8 Oct 2025 02:05:10 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH v2 9/9] arm64: dts: qcom: ipq5332-rdp442: Remove eMMC support
Date: Wed, 8 Oct 2025 14:34:13 +0530
Message-ID: <20251008090413.458791-10-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Kraq27VDwgEbpSjrNyordR9aADVuwCjK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfX+JVdjiAOsGT1
 4ZGI/4H1Dk5MG2R5+gyw85a7kvF+ZcYpKdQBZ22/amd+/ab5odLg5y4u8CM5PjR1Agg2FsnVFZe
 2OEqOQ/6lsd6hPGGmMmBzC5DiTwvk/8q5/chLQvMXzXcnbTmnPtCEwXnMPSgJes79HyKQgFiv1g
 6zLJhgminLkds/MbyJye0QnhfobuY/ewJya8/kQ2Nw5AbBV/e3/GcwDnsit01NLFHon1Cv4w67s
 vhSDJOeJuhy3ONfUH1Zdf19hwwtPmwvCQw907r0lcyZjIhSv3wUcLNt/fBTnT0IQNHjnwVEFY/x
 ToQI1ClV9mUQ3GeCwRl6Y7FiUcHF6PVQWcX6F8KF072XNbFp4W1sSl0umMx2cwMRE7mYu+UVtr9
 QJ+zPqUlzIczYNkg48JHR5OYGKDxCQ==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e6294d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=fuWxvNZPvO_ztXA3lyEA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Kraq27VDwgEbpSjrNyordR9aADVuwCjK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023

Remove eMMC support from the IPQ5332 RDP442 board configuration to
align with the board's default NOR+NAND boot mode design.

The IPQ5332 RDP442 board is designed with NOR+NAND as the default boot
mode configuration. The eMMC and SPI NAND interface share
same GPIO

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

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


