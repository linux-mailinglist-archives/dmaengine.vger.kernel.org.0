Return-Path: <dmaengine+bounces-4894-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C22FA89518
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 09:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D79317E328
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 07:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30FD27FD72;
	Tue, 15 Apr 2025 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fjN5wUER"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FAD28151F;
	Tue, 15 Apr 2025 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702150; cv=none; b=LQugsoKEJujqPgGNQarQ56pecoJhCyEssrMLKx+HFYnfsVkwonQxaiLzps5MbLBi9QRnSzWbB6wTO1kPjiUFgDSeIz2iQ/8KpyIG6sbGWwuiZB+uTczG1nvCypXkJzi9FEoFGjv3PaLN6ez3WnE4MKO+bIZnR9fq+V/avz0PDmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702150; c=relaxed/simple;
	bh=KgIJ+bKN+oIV/Py9IXPCjWuXnUqYRGbp8lwisLb+jqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYwD8tfaOkJt+/CzPQLMaQMBcuj+WY9qc72TYJzUBM5xy3B6sKvyMt3/yY7VCd1E+/DM1AYkiaj5mdOkQn8tSJgcpwCSJ5iPffdZwqtGjBQ3uP03o6GlDjXb1p0BXYTHpgIqpfDlFAwWo/Kj9+Gnm6T0kfuhwQo8dTZrhwmrjyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fjN5wUER; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F15LY2020388;
	Tue, 15 Apr 2025 07:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=d9avIRiA25O8uzGJG1UGNF6h
	vjXDXPnhyx9AvxcUsxU=; b=fjN5wUERdLCZvInoy5yya3IYtQOMDB7MhdcHlmZo
	WxSyjs4VlzbuKJ2sxr1Mvc/zgcHDOu7YF0FWL5SfY7vRcLbeGrN9nFHnJgYGTRnm
	y2eMK5tEKg3RQyBq2D99ITO7LIIsil36LMOb0CG9RBjyY6KHVQB0sS1cVtVr40XF
	6MhvQ26vHyG2ZoK2/dtRRDm0+JJ5f34p4CNkX2QpwHWpz9L05dLsyw2ev6FLIEEQ
	E9JX1iXTtzCmtkVb973ewWh+wCXjHSjnUnZf+REj2tmwkB8s5smN3wXpeI9XLWk/
	Fkn2KQLtAry/CKdCajKpQvsn49j9FdOItJS+hY3rqEWw3Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygj971dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 07:28:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53F7SwmM000945
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 07:28:58 GMT
Received: from hu-kaushalk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Apr 2025 00:28:53 -0700
From: Kaushal Kumar <quic_kaushalk@quicinc.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <agross@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Kaushal Kumar <quic_kaushalk@quicinc.com>
Subject: [PATCH v2 5/5] arm64: dts: qcom: sdx75-idp: Enable QPIC BAM & QPIC NAND support
Date: Tue, 15 Apr 2025 12:57:56 +0530
Message-ID: <20250415072756.20046-6-quic_kaushalk@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250415072756.20046-1-quic_kaushalk@quicinc.com>
References: <20250415072756.20046-1-quic_kaushalk@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 9LcVZfinQL0iv283_qeB8gYMkDuXKLW8
X-Authority-Analysis: v=2.4 cv=PruTbxM3 c=1 sm=1 tr=0 ts=67fe0abb cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=If1_SzIGY1zK-Kd_n0kA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 9LcVZfinQL0iv283_qeB8gYMkDuXKLW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 mlxlogscore=818
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150050

Enable QPIC BAM and QPIC NAND devicetree nodes for Qualcomm SDX75-IDP
board.

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


