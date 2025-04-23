Return-Path: <dmaengine+bounces-4979-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF511A97F37
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 08:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E9016D023
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 06:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338C11F3FC3;
	Wed, 23 Apr 2025 06:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IaboBbS1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6CF158DA3;
	Wed, 23 Apr 2025 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389914; cv=none; b=g5tCLPG22DL9BMx0sQwd8Jj14EQ3rN+Dg1wbDlT+4DLeYH1oqbMe2CKnVbGwVgkbZJc52/NdmNlEmVIcTs5nQuuPvKjr3g29a0oyO4jOBUF5TlUOM6Jm4Anjf+IZxhziNj3bcHdgSFxT5LO41dsTHXLmzOE2KKNCsfHmGFLQCU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389914; c=relaxed/simple;
	bh=r9ExManz1A0r6sYsqtHhQZ4DG96cmggqeZkaMZKdsgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NAEIj0S9HUTiMWdgrDekYF5CIN7G2AvD7e82JwdFbDS88TD88Ya4jHSYFeXKuSYp2tYF6Akv7SsNAAVfCwIhuFQ2Qfxjr2Y29KS2GsnJHdhGCWowVh9tPqXFNOyRfz4l+X2sS+sL/W26k4k81TDasySbndqVlv+gQWYZieccuhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IaboBbS1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0i96A016294;
	Wed, 23 Apr 2025 06:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0YQNBAjlr064X1/5yt4rnDgv
	WKgjcQXurOIWhIT2fjc=; b=IaboBbS1E3qOPyWFduUgZM0fnSl1tl1d1JGHql40
	AO2qJTQHgkxeWQM05nVAMd8bz+WOTO2WXISlu3lFLC8UlIExNvC8hDsk1USx7Uxg
	JTUOQAKNiJ2Ho+0LuXG8EaOZEOMZZR+H9inz9J3WKKxqnX8FhimALvAR7N6Hw3kn
	hq28aH2XewmOAMmeE+EBvFiWKFN/MxmMGWi6xJGrQ/wACCrl3UYwOxl+cfnBlhEN
	DoREiJt4XsTOU6vWHAJ0OQr2BvyiMNq07Gr1RuJT4PGNG1wyptMS6jXZx27rw85K
	tAkYEUY/H0gAGnG4yyFvemF6iaKY6331Rvsns06QkCDJQA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh093x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 06:31:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53N6VhVn006678
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 06:31:43 GMT
Received: from hu-kaushalk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Apr 2025 23:31:38 -0700
From: Kaushal Kumar <quic_kaushalk@quicinc.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <agross@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Kaushal Kumar <quic_kaushalk@quicinc.com>
Subject: [PATCH v3 1/5] dt-bindings: mtd: qcom,nandc: Document the SDX75 NAND controller
Date: Wed, 23 Apr 2025 12:00:50 +0530
Message-ID: <20250423063054.28795-2-quic_kaushalk@quicinc.com>
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
X-Proofpoint-GUID: YCEGiSXAHRT3xrQNtpPg29sRlR7E5zlT
X-Proofpoint-ORIG-GUID: YCEGiSXAHRT3xrQNtpPg29sRlR7E5zlT
X-Authority-Analysis: v=2.4 cv=Fv0F/3rq c=1 sm=1 tr=0 ts=6808894f cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=T7SboCa-U_X_iRyOqw0A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA0MiBTYWx0ZWRfX6Ui+eBipH0ET n7n9tF2OEyHpq54UGijc9+VruKP/P+qcBHtqWAdhljjF3tDDi/zEKKj5bL+rpsjvJI6dUJlXOrH KfmBqw8Ob5jHipgfKS7SY8MU9ToixODb5+qDUnpobgQ9i3GpLckIaMnhHq3+5NFfeAE7IvAKPY9
 UtxajMB3vbd08ptW0CkN+BZ8Qfwe9eAkzb4+cYXvczaS72vwCbLGfH5fk4T/OinQpbWlMc2XC6Y D9d/tWzvj3SktyATJVNneCE9lUNfA/daSZISQtxRRMtTjVXGHuAa8nn1H4iTnsF5s6TgP5/dBbT OJT6Gmp7W9ncsUKQd9nUUYZFetgKeXgGMEBORfcNDYMd4/s9BeZQnOy7rjv99G3IX5TJHz02zj8
 kl3dMoj5bBeuLSY588/HC80TnGW38/HAKIxItzMEgbGa99kkXeWDDdfYb9UvcrkQvdf2BRba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_05,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230042

Add new compatible for the QPIC NAND controller v2.1.1 used for SDX75 SoC.

SDX75 NAND controller has iommu support so define it in the properties
section.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
---
 .../devicetree/bindings/mtd/qcom,nandc.yaml   | 30 +++++++++++++++----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
index 35b4206ea918..5511389960f0 100644
--- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
+++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
@@ -11,12 +11,18 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - qcom,ipq806x-nand
-      - qcom,ipq4019-nand
-      - qcom,ipq6018-nand
-      - qcom,ipq8074-nand
-      - qcom,sdx55-nand
+    oneOf:
+      - items:
+          - enum:
+              - qcom,sdx75-nand
+          - const: qcom,sdx55-nand
+      - items:
+          - enum:
+              - qcom,ipq806x-nand
+              - qcom,ipq4019-nand
+              - qcom,ipq6018-nand
+              - qcom,ipq8074-nand
+              - qcom,sdx55-nand
 
   reg:
     maxItems: 1
@@ -95,6 +101,18 @@ allOf:
           items:
             - const: rxtx
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdx75-nand
+
+    then:
+      properties:
+        iommus:
+          maxItems: 1
+
   - if:
       properties:
         compatible:
-- 
2.17.1


