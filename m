Return-Path: <dmaengine+bounces-4729-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE57A5F593
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 14:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7114880C83
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBD9267B04;
	Thu, 13 Mar 2025 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YwUBfItw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E1F267736;
	Thu, 13 Mar 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871423; cv=none; b=T10fsEV9V4S3oY2KGy3Sl6grcYEBsaZHQ1AgQOBtLXI8JpBRIXwhD+YmopJCGQdSWPNeq23mx3PQfBfNNKV3n0WROGnJeTqiZvwRrKNYjjgLFY6LS4uneNw5lkCWxVXWPiB5Hj1hMnez0sKNNiZCd6bf+/RMf1Dbi75WElkedus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871423; c=relaxed/simple;
	bh=LGt/3PZOQJxDABsJnxLQTmPOeXQYHr4bek/Pex6YkNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIizmUyvfJTL29Odtn9mur7sV0MmDsOTRcMouPYJ1aMCraRt6w29UKdYEPRBBBs3DUBluSwoEXTnWii4VwJX3vITDLPJrs1XfxV5JG0I5DaLIEzdOR2IIwnBhlM7HTOu+zY4WCd8d8ynbODeNvL02aIlBFVqOvxVyockJYPHBCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YwUBfItw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D7CAr8019811;
	Thu, 13 Mar 2025 13:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rTMvJt4YNktuNBdJQjA3KpK3
	NAKX+jVF+/XcM5yga1o=; b=YwUBfItwxMJmvv9vGJ93gl/9ESVKg8aEnnUq47Yg
	YKjvyPE5gqm6Z3pQaR13aXrCBbxSrEcy4nEPN0ed1COSA115p4N8gHntQapWGOAS
	xDwSl7diFf0kWyFWZtxTvTDvtDlBkXC0q8EoIUI+OETHCNaw1sKql0bjGz0UWthu
	hMjtrQ1QpTmhBWA1bIVgHn75zrskld+D8zOf+MCGVmAjQA/OD1V4W2prWkIY6nMn
	8jB7takgdCcJUHePWTaWSjlgnzEwF1eG+2FK+VC70F8DJbrphUc3JMFZHh464GNg
	fQvZUX8W5Df/OijauLwX+yC5w81yb5UWZiyvHXAc66+Kgw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bts0h0ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 13:10:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52DDA3la029846
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 13:10:03 GMT
Received: from hu-kaushalk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Mar 2025 06:09:58 -0700
From: Kaushal Kumar <quic_kaushalk@quicinc.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <agross@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Kaushal Kumar <quic_kaushalk@quicinc.com>
Subject: [PATCH 1/6] dt-bindings: mtd: qcom,nandc: Document the SDX75 NAND
Date: Thu, 13 Mar 2025 18:39:13 +0530
Message-ID: <20250313130918.4238-2-quic_kaushalk@quicinc.com>
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
X-Proofpoint-ORIG-GUID: rfgKCddoWgJMhbTu7oN301xM7z9HAIbj
X-Authority-Analysis: v=2.4 cv=DNSP4zNb c=1 sm=1 tr=0 ts=67d2d92d cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=Kq_rJIWMMWslwROvJEYA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: rfgKCddoWgJMhbTu7oN301xM7z9HAIbj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130103

Document the QPIC NAND controller v2.1.1 being used in
SDX75 SoC and it uses BAM DMA.

SDX75 NAND controller has DMA-coherent and iommu support
so define them in the properties section, without which
'dtbs_check' reports the following error:

  nand-controller@1cc8000: Unevaluated properties are not
  allowed ('dma-coherent', 'iommus' were unexpected)

Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
---
 .../devicetree/bindings/mtd/qcom,nandc.yaml   | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
index 35b4206ea918..8b77e8837205 100644
--- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
+++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
@@ -11,12 +11,17 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - qcom,ipq806x-nand
-      - qcom,ipq4019-nand
-      - qcom,ipq6018-nand
-      - qcom,ipq8074-nand
-      - qcom,sdx55-nand
+    OneOf:
+      - items:
+          - enum:
+              - qcom,sdx75-nand
+          - const: qcom,sdx55-nand
+      - items:
+          - const: qcom,ipq806x-nand
+          - const: qcom,ipq4019-nand
+          - const: qcom,ipq6018-nand
+          - const: qcom,ipq8074-nand
+          - const: qcom,sdx55-nand
 
   reg:
     maxItems: 1
@@ -31,6 +36,12 @@ properties:
       - const: core
       - const: aon
 
+  dma-coherent: true
+
+  iommus:
+    minItems: 1
+    maxItems: 3
+
   qcom,cmd-crci:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.17.1


