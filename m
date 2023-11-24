Return-Path: <dmaengine+bounces-207-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F7F7F70D7
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 11:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71810B21188
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEBD18046;
	Fri, 24 Nov 2023 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TfW3XNLB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE401AB;
	Fri, 24 Nov 2023 02:08:58 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AO6Gsli015529;
	Fri, 24 Nov 2023 10:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=8HF7zz6c/6H2uWG8LyrQ8lCHlmsf5iqtfWUT7ePKpBQ=;
 b=TfW3XNLBzCeI6C5lkqxv1yC/hokZickGP9zaJEljFt54Wn7P3jjL31CFegwA4jqC7911
 WfSAfCYikWR3QYerMkVyEWXZQsEuk2E5V/ciITLKQ+qTtq3awByEbaPAUVlRUG7aZuCR
 Zi8ndy+SDh87SRusW5ox0yUMFFcIw5Q8PT24J8/hDfOqMDzmNKAuYhdWOf5/QhOsRDmp
 fw7J2EPhhxcu8nz/7t/KjOsGOQbShmZkIQij5aZSFADLQ/bIhcyDNcR2HUTzSxrpzbjH
 EdoJCNozW8R2hrZo46dBgzCKgwHRDO3NeyJqaoUyeXdFL6vwidDzkTU+8PtMeuZG0YVT xw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj3ec2j0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 10:08:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOA8d8A021188
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 10:08:39 GMT
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 24 Nov 2023 02:08:33 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <agross@kernel.org>, <vkoul@kernel.org>, <quic_gurus@quicinc.com>,
        <quic_rjendra@quicinc.com>, <abel.vesa@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <iommu@lists.linux.dev>, <quic_tsoni@quicinc.com>,
        <neil.armstrong@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V3 0/5] dt-bindings: Document gpi/pdc/scm/smmu for X1E80100
Date: Fri, 24 Nov 2023 15:36:03 +0530
Message-ID: <20231124100608.29964-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
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
X-Proofpoint-ORIG-GUID: wm1OaCnBjO1Cq3NJ1TY86h4DIkLKDNvE
X-Proofpoint-GUID: wm1OaCnBjO1Cq3NJ1TY86h4DIkLKDNvE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=997 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240079

This series documents gpi/pdc/scm/smmu/soc for the Qualcomm X1E80100
platform, aka Snapdragon X Elite.

Our v1 post of the patchsets adding support for Snapdragon X Elite SoC had
the part number sc8380xp which is now updated to the new part number x1e80100
based on the new branding scheme and refers to the exact same SoC.

v3:
* Extend pattern matching support for the X1E platform. [Konrad]
* Rebased to the latest lnext. [Krzysztof]
* Pickup Rbs.

v2:
* Update the part number from sc8380xp to x1e80100.
* Document PDC bindings as well.
* List the interconnect requirements in bindings. [Krzysztof]
* Pickup Rbs.

Dependencies: https://lore.kernel.org/lkml/20231120100617.47156-1-krzysztof.kozlowski@linaro.org/
Release Link: https://www.qualcomm.com/news/releases/2023/10/qualcomm-unleashes-snapdragon-x-elite--the-ai-super-charged-plat

Rajendra Nayak (1):
  dt-bindings: arm-smmu: Add compatible for X1E80100 SoC

Sibi Sankar (4):
  dt-bindings: arm: qcom-soc: extend pattern matching for X1E80100 SoC
  dt-bindings: dma: qcom: gpi: add compatible for X1E80100
  dt-bindings: firmware: qcom,scm: document SCM on X1E80100 SoCs
  dt-bindings: interrupt-controller: qcom,pdc: document pdc on X1E80100

 Documentation/devicetree/bindings/arm/qcom-soc.yaml       | 8 ++++----
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml       | 1 +
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml  | 2 ++
 .../bindings/interrupt-controller/qcom,pdc.yaml           | 1 +
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml     | 2 ++
 5 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.17.1


