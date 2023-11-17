Return-Path: <dmaengine+bounces-138-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4BC7EF12B
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 11:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888FB2811B2
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 10:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0DA1A702;
	Fri, 17 Nov 2023 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="isHRkEh1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2C511D;
	Fri, 17 Nov 2023 02:57:26 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHAtT5s013510;
	Fri, 17 Nov 2023 10:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=zWLKFtv9YS9AEAg3cjF84kmOJJWZ0UNo/rnIyLs2CFk=;
 b=isHRkEh18CYAH70pgP94q1/c2LK7USOKwkW/uhn2Jk9aMwyNTFgHJUhDHpwFaHh5Z1Rh
 r9u7Wtl4VT4VSl/YcqxxbNmh1HR/GxoPjfl65invS5q7v1cgBtRjl6JTts/cYZTcP2lk
 3b9tJbgnlQDdqx5FnCO9MByyyN85PKQ/Tf9y8gq26hWeDi4DZFYLYMJhBWaj1Q9P2oSC
 lkxTNtHFMVWG9qgMXKBkpMtDgT1Ky5CBIQYsg1JSihvdMbthsb8V3PAg8Yzp+59I+oGV
 Lnj+sm9gXnvR9kv0P+A/0yh6ZYnQZOPRPEyAx6vwAPHDDQMGO0+IP4weOsMPyO6q2Wmp BA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ue2na0k6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Nov 2023 10:57:15 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AHAvEUi006976
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Nov 2023 10:57:14 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 17 Nov 2023 02:57:07 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC: <agross@kernel.org>, <vkoul@kernel.org>, <quic_gurus@quicinc.com>,
        <conor+dt@kernel.org>, <quic_rjendra@quicinc.com>,
        <abel.vesa@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <iommu@lists.linux.dev>,
        <quic_tsoni@quicinc.com>, <neil.armstrong@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V2 0/4] dt-bindings: Document gpi/pdc/scm/smmu for X1E80100
Date: Fri, 17 Nov 2023 16:26:31 +0530
Message-ID: <20231117105635.343-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0PBHcr-a0GRXMqqHlT8i1OYJz--X3KFK
X-Proofpoint-ORIG-GUID: 0PBHcr-a0GRXMqqHlT8i1OYJz--X3KFK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_08,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=804 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311170081

This series documents gpi/pdc/scm/smmu for the Qualcomm X1E80100 platform,
aka Snapdragon X Elite.

Our v1 post of the patchsets adding support for Snapdragon X Elite SoC had
the part number sc8380xp which is now updated to the new part number x1e80100
based on the new branding scheme and refers to the exact same SoC.

v2:
* Update the part number from sc8380xp to x1e80100.
* Document PDC bindings as well.
* List the interconnect requirements in bindings [Krzysztof].
* Pickup Rbs.

Rajendra Nayak (1):
  dt-bindings: arm-smmu: Add compatible for X1E80100 SoC

Sibi Sankar (3):
  dt-bindings: dma: qcom: gpi: add compatible for X1E80100
  dt-bindings: firmware: qcom,scm: document SCM on X1E80100 SoCs
  dt-bindings: interrupt-controller: qcom,pdc: document pdc on X1E80100

 Documentation/devicetree/bindings/dma/qcom,gpi.yaml             | 1 +
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml        | 2 ++
 .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml      | 1 +
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml           | 2 ++
 4 files changed, 6 insertions(+)

-- 
2.17.1


