Return-Path: <dmaengine+bounces-4984-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCCAA97F4C
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 08:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582143AB2FC
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 06:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1410B26739F;
	Wed, 23 Apr 2025 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DHyWfwIF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844F1268689;
	Wed, 23 Apr 2025 06:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389936; cv=none; b=NgXr/bJW+WyAmJGpgZv8cvKyLXmbUoS4zw1QUCOgQKdbR6FTbr2JTXT1n3hS1e/3lb/m8wh4ATfmslbURgDHqUt2jK5WuK5r62vQEDTdYdqbq8Dcfy05PolYmbQzzM/eoiYRgNJ497cNgQ1yCnT9/BFJXwXzqxkd8FgBsCQ3CLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389936; c=relaxed/simple;
	bh=PVGXUXtE8d1qb+b8lAAA2PKUmU56ghjTO95R7VAE/RM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4E7voWtljbp6yEVDIXg44juKJe7BDnGh88fb0WNRuJCvAW7gb8z/qc4ExAiC/kGngwjxwy/p2SMQr0MhCfOA4zo1AY4RKhkYUxZxXGTExIE+UMRrrmL15LJM+VH+1zbVGRUjSAvU0s1dU9SDsEYBoBUoY7HDvG7jQvdUQZUrdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DHyWfwIF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0iIYn008429;
	Wed, 23 Apr 2025 06:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bcHFm8yNDSGZczu0sjw4KJ0c
	ibsgQTVATZUMTGOeQyU=; b=DHyWfwIFl1oLThTk04/kjr3uTAaF2ZhlOK+XeU8a
	c4Ge/cpBmQOGgUPqDilVGP1iil54q2N1JRmlwtMkIAeTebjBIAWpPcsypdNUu2wT
	vPcK9iLzLcNYMzwMLZmQWAOmp+pRZLZARXOcumIFU0e+B/KsUvYZkRPRqBURQinP
	eFgttFXNctPDkjv3xa0PEf3abB7GP5REJgeM6F8qVzvFUiaaV+D/+MxKrPohTzvg
	UeCilEA8vmNCVsouh8G7igYnvBFDZiYIU73q/6lE1lX3ZnX2AqG9J18r02JJnmbm
	JgqxtCPgK4/hN1qZKg7gUB37ILNDCd77j9PWt/e2DiccUg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh593j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 06:32:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53N6W3h0024940
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 06:32:03 GMT
Received: from hu-kaushalk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Apr 2025 23:31:58 -0700
From: Kaushal Kumar <quic_kaushalk@quicinc.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <agross@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Kaushal Kumar <quic_kaushalk@quicinc.com>
Subject: [PATCH v3 5/5] arm64: dts: qcom: sdx75-idp: Enable QPIC BAM & QPIC NAND support
Date: Wed, 23 Apr 2025 12:00:54 +0530
Message-ID: <20250423063054.28795-6-quic_kaushalk@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250423063054.28795-1-quic_kaushalk@quicinc.com>
References: <20250423063054.28795-1-quic_kaushalk@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA0MyBTYWx0ZWRfX03T/LahjjIAp h1nFK5Ben5e4OSkLJO1ERkBFXIlBcWSL8wLKVJODjKiU/ks/EvIZC0OPUbT0tSAD23DkMc2RhvU WlZ7trHn704ZP+ZxnAkv7SEYg0qk/c7jdyEok4M6l0+mcSEZVcfHWiRlMX59i0nfuIY6yeovqn1
 AhmYswY7ysquU17A2lQvws1nTkEDfP11oLhNEzCbD2B2+rncj0PuiygEhTCOKmTp151TdalKXEr D4IdnVzQHro0ZlhdpXtciC7XaFKsHZqqDz8SwPqNZ/My/mngwC/U5yVu0OxrJzOxyiCNbkuinDi z0JW96lbUP478zbuVKu3oVANJ479jw8ei7QKWlD7bdV7mAZGjfDcK98rlRTkQZzMkhCMNieVNeJ
 xFiY8jAH68/Hfbu6SRGptZ1IdzByPVe8g9jlbIj2ybBKJ4dFNC5/j3B+2NAaUB5Brs0Il0vS
X-Proofpoint-GUID: fb-JNlm4kF-lnA90DBNCTb2SuLlPhs_F
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=68088964 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=If1_SzIGY1zK-Kd_n0kA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: fb-JNlm4kF-lnA90DBNCTb2SuLlPhs_F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_05,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=854
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230043

Enable QPIC BAM and QPIC NAND devicetree nodes for Qualcomm SDX75-IDP
board.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdx75-idp.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdx75-idp.dts b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
index f1bbe7ab01ab..06cacec3461f 100644
--- a/arch/arm64/boot/dts/qcom/sdx75-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
@@ -278,6 +278,24 @@
 	vdd3-supply = <&vreg_l10b_3p08>;
 };
 
+&qpic_bam {
+	status = "okay";
+};
+
+&qpic_nand {
+	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+
+		nand-ecc-strength = <8>;
+		nand-ecc-step-size = <512>;
+		nand-bus-width = <8>;
+		/* efs2 partition is secured */
+		secure-regions = /bits/ 64 <0x680000 0xb00000>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
-- 
2.17.1


