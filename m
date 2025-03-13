Return-Path: <dmaengine+bounces-4731-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C16A5F58D
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 14:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B58167B2C
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83EC267B94;
	Thu, 13 Mar 2025 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ORzem/zt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3CF267720;
	Thu, 13 Mar 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871432; cv=none; b=kI9SCk/6ygsnqiE+97S2CYbYLDPQPuCqsy3r6vgSwwreJ5QT+0XYwsusQs3764rkYT33fsLTeF3YBUIcQSuRXXeN3pt3j6EvQtSSwCAkeG93N0V+u9qoCQS9glnnpZKL3UbPWjSoBSG7Zs4bz2JBS3Wu3FGGorZAGSAK9/LTrfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871432; c=relaxed/simple;
	bh=8WhBiaDWGDodIP+7wVfQmmAUraShPb7LIesJS2qdlHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5zKACHMYW3Yh9uul8rNYqCHt1385dEARPlaCkVUYEPR1mmkSJ5TPlbXPSokXbJg7/36FKhYd9Csd0pG0VAPVht20rRXb8AORMVGbs3FVTRS7NhdvTYQVT4IErqbk6rFtAwEHV6c8GujKYYxOmWkmzBn8l6JmzbSXlwokvhrb2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ORzem/zt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D92oOL018573;
	Thu, 13 Mar 2025 13:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=n1N+OSu0dYnfCO91x9ETF1XE
	xqzUVw9cU/1q8uQ6hF0=; b=ORzem/ztTNbogNa124235vkaOR4Xe1oyEdZLQy5l
	wo2gmgWykkisFLMUE8ndz6DpgHBiQ2edLZBJLaauU87t9fBIOoIlv0W0mx00agln
	8rhF1Sa3wyYkVHCkDeNYMqQW02apAuE0CiV8jYFPNmkW67QsUdInUiO0eZhFyNKm
	qLXK4In4VVgdCnd6/XvBKBKGqtfr7gWDkwEEodsb5/XCTYm7uzoUKeek6wKL643O
	OwucWujV8Hdp6mzaU/lwWxh+JcYiPKhwSn7LL6NK/E7+YRVle+1Gv3OXS70quIgH
	YsgWiui5E1jeBnWl7IlzsvqmRfPlBle72Dmj1rLOqSm5Gg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nx04g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 13:10:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52DDAJjV026638
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 13:10:19 GMT
Received: from hu-kaushalk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Mar 2025 06:10:14 -0700
From: Kaushal Kumar <quic_kaushalk@quicinc.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <agross@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Kaushal Kumar <quic_kaushalk@quicinc.com>
Subject: [PATCH 4/6] ARM: dts: qcom: sdx75: Add QPIC NAND support
Date: Thu, 13 Mar 2025 18:39:16 +0530
Message-ID: <20250313130918.4238-5-quic_kaushalk@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250313130918.4238-1-quic_kaushalk@quicinc.com>
References: <20250313130918.4238-1-quic_kaushalk@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: llwNpGjssWlrA_wVgC-nalL_RIwbOYRa
X-Authority-Analysis: v=2.4 cv=Q4XS452a c=1 sm=1 tr=0 ts=67d2d93c cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=aSCKG8iKwtCOJjoOL2oA:9 a=fXBJl3N8H64iLEq10rD0:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: llwNpGjssWlrA_wVgC-nalL_RIwbOYRa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=900 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1011 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130103

Add devicetree node to enable support for QPIC
NAND controller on Qualcomm SDX75 platform.
Since there is no "aon" clock in SDX75, a dummy
clock is provided.

Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdx75.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index e3a0ee661c4a..9c43b14a0594 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -37,6 +37,12 @@
 			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
+
+		nand_clk_dummy: nand-clk-dummy {
+			compatible = "fixed-clock";
+			clock-frequency = <32764>;
+			#clock-cells = <0>;
+		};
 	};
 
 	cpus {
@@ -894,6 +900,24 @@
 			status = "disabled";
 		};
 
+		qpic_nand: nand-controller@1cc8000 {
+			compatible = "qcom,sdx75-nand", "qcom,sdx55-nand";
+			reg = <0x0 0x01cc8000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&rpmhcc RPMH_QPIC_CLK>,
+				 <&nand_clk_dummy>;
+			clock-names = "core", "aon";
+
+			dmas = <&qpic_bam 0>,
+			       <&qpic_bam 1>,
+			       <&qpic_bam 2>;
+			dma-names = "tx", "rx", "cmd";
+			iommus = <&apps_smmu 0x100 0x3>;
+			dma-coherent;
+			status = "disabled";
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x40000>;
-- 
2.17.1


