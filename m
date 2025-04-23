Return-Path: <dmaengine+bounces-4981-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D901A97F3E
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 08:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818281897D15
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 06:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B90C264602;
	Wed, 23 Apr 2025 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LTw7wWp+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51701DFE20;
	Wed, 23 Apr 2025 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389928; cv=none; b=ROZS7tF3LCg7ZBNionNgNuc3ItA+dPydEowd6VP/DHNIY8ftuL8TJi9oDUw7CgNPYrJMxwai7a6MAnq3xd1Qnyj1qqM/jyMQVT/FOHn90xLDAcrvYDQpUr99SVxa9W9vTDr27CgWO9bc1sMmWkC3FdJziRff5HlV11oDOJCCwWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389928; c=relaxed/simple;
	bh=2k7OBYmTWtbftUYVNQuC4efbkcmCSxi7NmAymPqdF8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+MULXy9w+lykz4z7wV0tTdOkAvkoe0kwdX5nqRyBoFCZAbpHTNqSDtbSK5eYEBcmOsi+hNTS7hZGkFqLYhNCor+a6C1bW7ePp0SFh8b4RqlbUoeATE7GyvHuMUgAd6FNKmQTMCELMOBBYl6jzkPBbUv5/QE+LyXLGSDQLSqpo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LTw7wWp+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0i7cY016800;
	Wed, 23 Apr 2025 06:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=V7S70dp14c15cpZzwHjjn8rD
	l7ku/WQWo7T9YgP2qnA=; b=LTw7wWp+EHnV/gDgLbd2O6jrYn4AwXvFJ1cTFLtG
	mXGYZ8Np7lXnzsDaMql4t/MnskLlZRf3rhPUPbZt5O+5OdzHWaMg77eUBlIKXude
	t3x01lzzLL/ARB4juMBRRP51h0M2FvapLGkNQw6KSGKAYqglAXUwavEoOXJ7y99K
	f//Ztcl8DlQoA6N0qR1Ua9VwHfhuSewUMOR/0q0gpWSnfCh/gh6HPWYK+NsicB7J
	qF+VlAgNokbEv1T7ghWpiOPrDMc/x0mT12tfrv3zrcuYENrNwpiC/IfYvYftjx3v
	tfbohadZ7+E06Ca2vR4WS43xQkI1wvNBEKmbi1XLBp5pJQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh013xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 06:31:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53N6VmfO025615
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 06:31:48 GMT
Received: from hu-kaushalk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Apr 2025 23:31:43 -0700
From: Kaushal Kumar <quic_kaushalk@quicinc.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <agross@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Kaushal Kumar <quic_kaushalk@quicinc.com>
Subject: [PATCH v3 2/5] dt-bindings: dma: qcom,bam: Document dma-coherent property
Date: Wed, 23 Apr 2025 12:00:51 +0530
Message-ID: <20250423063054.28795-3-quic_kaushalk@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA0MyBTYWx0ZWRfX1SU7JBSrp9JS A4dAJLYytlGkrvr4FnD1qMvU2fafqlP+Kn8zaKfSA3eKAiU3AWfHwSD8mq0vfG0Bhf28SU56jqH DIzu1ylb06xVVP06Utm/wAVULkOjcM0E/aXMLP+1SIJVwLuAS02AFjYICRdHJ4S+/UBC/OO/cIS
 NfbdO3JFAtkW2AOomVr+jBvq3KNUVJOy/Eze4i329fPbznZihgsm/vF6MUchOlqCHVn//HcS5De if0H0g7lpeZvQgA/Qnhm7Xu39UozvuRSoo2APlDfg5AxbArxhYkf4/6icD+TMrzPrar4v1ridhm fpK3sTwgB4t/ykX0rWefOeOTyf8BikYGxOVqytm1zhopj0WNGRNDpO8p5OY+c88rWt1NXWH7rLb
 dTaJKO7noUnuDDjYwcUEOp8r+AIcC3ZRJlhOBk5QuzURVOqOz8Vzhj6WHgyOcHCVllq/EBIi
X-Proofpoint-GUID: Kp8AEuM4oq0ahRF5JW7Vefvbetu96Im_
X-Authority-Analysis: v=2.4 cv=ZuTtK87G c=1 sm=1 tr=0 ts=68088955 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=s6VSgM3AptX_uwP4r18A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Kp8AEuM4oq0ahRF5JW7Vefvbetu96Im_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_05,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=860 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230043

Qualcomm BAM DMA controller has DMA-coherent support so define it in the
properties section.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
---
 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index 3ad0d9b1fbc5..f2f87f0f545b 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -42,6 +42,8 @@ properties:
   interrupts:
     maxItems: 1
 
+  dma-coherent: true
+
   iommus:
     minItems: 1
     maxItems: 6
-- 
2.17.1


