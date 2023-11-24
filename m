Return-Path: <dmaengine+bounces-211-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B48007F70E7
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 11:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C324281B0B
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 10:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C88218AEB;
	Fri, 24 Nov 2023 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X8esr26V"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB87F91;
	Fri, 24 Nov 2023 02:09:28 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AO5vlhp019617;
	Fri, 24 Nov 2023 10:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=fVkoT2YuDKLcjtzUuLJbRu0kxGDktAKf6KCx0ofIpp0=;
 b=X8esr26VvgMFz3U0sZgrnE8MWOvyxhmK4IC2mwJnoXJt8NQCjUZx7WIdagphwvQTrkSe
 Eq22vpY1Wjgoam8GBwSpX2POUShnzgnLE4gUOvhmNq1O2fInRvautVfqBpxj94b1akPq
 xgSNqWB4UGREXuzNq+VXxdMrvTwBm4On02OZsij+rMKuGwn3q31Uw4XifjKMtHiyfbBM
 qy09nny0hc+Bj1VFqk8lUqbOMLZDlu+DcLcg5PlIWJ6Jzts3Zl6grICxuR7BVV+HZYjj
 UOtlw3dEpae3e8zn21ZZou/7/Y8jXTT0AbvnTT1gFZaCs/Ox5tyEGem2gH6Os3u9J90O cw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj25t2pvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 10:09:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOA8xbG021414
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 10:08:59 GMT
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 24 Nov 2023 02:08:52 -0800
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
Subject: [PATCH V3 3/5] dt-bindings: dma: qcom: gpi: add compatible for X1E80100
Date: Fri, 24 Nov 2023 15:36:06 +0530
Message-ID: <20231124100608.29964-4-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231124100608.29964-1-quic_sibis@quicinc.com>
References: <20231124100608.29964-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: LM5Sss9lGVZxnLz2hUAUQDYiD8hGVjMf
X-Proofpoint-ORIG-GUID: LM5Sss9lGVZxnLz2hUAUQDYiD8hGVjMf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=871
 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240080

The Qualcomm X1E80100 uses GPI DMA for its GENI interface. Add a compatible
string for it in the documentation by using the SM6350 as fallback.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 88d0de3d1b46..d06db2cc931e 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -32,6 +32,7 @@ properties:
               - qcom,sm8350-gpi-dma
               - qcom,sm8450-gpi-dma
               - qcom,sm8550-gpi-dma
+              - qcom,x1e80100-gpi-dma
           - const: qcom,sm6350-gpi-dma
       - items:
           - enum:
-- 
2.17.1


