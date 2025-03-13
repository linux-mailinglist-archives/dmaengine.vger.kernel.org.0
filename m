Return-Path: <dmaengine+bounces-4728-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC415A5F58C
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 14:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E67907AEE02
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 13:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB84D26773B;
	Thu, 13 Mar 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J6573L8t"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD3326771E;
	Thu, 13 Mar 2025 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871421; cv=none; b=dA/yuqE2/Ce/dR+fqnpAUWS/Wq/2RcIFn2YEdzHeSRARLWuSR2ipZe01LVgmNxO5DeRU1sPrtKANgoAdfgVVOOeal96S9UA2U7NglrSHUw8Lm778AP12Te2maABK3CBee3bVw/7tHVYLIrlUsBwAtuxuEqaKB/mlWJoqvrHaLFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871421; c=relaxed/simple;
	bh=14UxnBBOdxVIvYcnpNQo6E1bNt66tSIcYtI6ERnfrKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6Vczh3xkW7X2u8r8533steOklElJC14lDpOQXVkraVd+ADoDriIhjqVNcNm+ynoklOGOH2wsYg/AmjYsiiEUZxvj82N2+vBxUoECI+yE/lCYc4fTyv/Wzg+FsWwdAgxcn1oNPTHGiSAh9BENBIu5KU3ODIhbN8Ki5N3y1blNMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J6573L8t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D9QmtC018360;
	Thu, 13 Mar 2025 13:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cCq4mm9nfwBjhGFIFKyftMnD
	zVl8pgrzNO9epZZFa7E=; b=J6573L8tn/G8GFOCwsBdeZ6vno06jqDqcLFbVvsB
	NtPEAbqLNwAbbzRO/oNL/ExiqllS1GsAm6dLvcJylFd8ypyLE8AbnUN3l5BnC2PD
	G+8vJslQF+rjNI730mt0DioEfeXONpkQnN5L2WD9eDNEhs+gdHAiKAws3RDcQ3sd
	uCflUh+lEnXXZTdw1+9ZzeKco4T8TuIPLn+Y4jmk0PEhqFtq4YcxkXKia1ODVb3l
	fUJx5aa09FQU/k935dlvlrEBio7uml9/q0ykV46q1ccimdYRLsd5uD9AZur6QMq/
	25KlGic0mf+/sRRExORwH/mi6cvalZk34h7MljVFrVBBlw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nx03x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 13:10:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52DDA9N7026434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 13:10:09 GMT
Received: from hu-kaushalk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Mar 2025 06:10:04 -0700
From: Kaushal Kumar <quic_kaushalk@quicinc.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <agross@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Kaushal Kumar <quic_kaushalk@quicinc.com>
Subject: [PATCH 2/6] dt-bindings: dma: qcom,bam: Document dma-coherent property
Date: Thu, 13 Mar 2025 18:39:14 +0530
Message-ID: <20250313130918.4238-3-quic_kaushalk@quicinc.com>
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
X-Proofpoint-GUID: HXvRCa-Czq1d6bhS_5UqtyQjW29IeWM-
X-Authority-Analysis: v=2.4 cv=Q4XS452a c=1 sm=1 tr=0 ts=67d2d932 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=s6VSgM3AptX_uwP4r18A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: HXvRCa-Czq1d6bhS_5UqtyQjW29IeWM-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=836 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1011 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130103

SDX75 BAM DMA controller has DMA-coherent support so define
it in the properties section, without which 'dtbs_check'
reports the following error:

  controller@1c9c000: 'dma-coherent' does not match any of the
  regexes: 'pinctrl-[0-9]+'

Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
---
 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index 3ad0d9b1fbc5..c4dd6a503964 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -39,6 +39,8 @@ properties:
   "#dma-cells":
     const: 1
 
+  dma-coherent: true
+
   interrupts:
     maxItems: 1
 
-- 
2.17.1


