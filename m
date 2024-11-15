Return-Path: <dmaengine+bounces-3736-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F289CDB90
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2024 10:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A55E3B22ADB
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2024 09:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C2418FC7E;
	Fri, 15 Nov 2024 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VfJbMWv8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EB618D621;
	Fri, 15 Nov 2024 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662948; cv=none; b=REFTpdRX/Vkc4JYK+ibrHiar2sIZUokZDjKYm6AvnFRU4gcl9jl45V9RQBSPB9iycBMhFiMqsUSrglidFJnyLo4wtZSWtc26BTExRdZTe5sa/288ZNiXzltArjzIjGUJxheIIQI/uSSfuxWEKWrvTZL81r13X6cBLZsqzoo9bak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662948; c=relaxed/simple;
	bh=OOl8zpA9VmmfLYjhOm2wTJr80yoUXfn7wCMmgddFXXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l8k5Eey4LThrznFK6Niihu8vvRDgW4jBp2inDJwyL5+p7EhI+RTa8Mm+YoW45j7D/ZS2pCy+LcTn/SVelyz7KZtdh+3ft+fLrD56xENeXssbOkKEXRFzm2eouHGRiHOomom4eSLNRfTp7/xjZ9aNiYILmZyJmsloduOHUlNpE4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VfJbMWv8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF8OCYT016914;
	Fri, 15 Nov 2024 09:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Il6luNQrobN9uZHmmMmoSE0/2nEe/kI9KTy
	45GOdevA=; b=VfJbMWv8smnH3SES6zfw+bCxx9HxnUAhGxp1j0Lgb7jNDxESypv
	78fSETSs9mb8K8VdTsW3iUEUQqHiSzWkRskv8dNgzIJiQASpZlJdzkrJ3Q2+TrwD
	MTA3NiOYSpPY17pGe9aQGd3yQHcxIt99dkwYFcRkIUzXZZxiHy0ZGGXXsV8qLEA9
	UKJ/imCycwBPfL2U3VveTINRPorml1WSF5ewnmGjw5a9agoPAUmlXWqtwUsHAtLF
	B4I3sBjXcF3ptywPr86x5m4hfMQMxUZVSc9GICKkSyUpw2dEEhh+Pem16fC7YFRo
	fSf3dswGjC1qnP7LudFR2QpbIZLe+YtWIMg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42wm75tk61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 09:29:02 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF9PdOl017888;
	Fri, 15 Nov 2024 09:28:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 42t0tmh91v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 09:28:58 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AF9SwUF020537;
	Fri, 15 Nov 2024 09:28:58 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com ([10.213.97.252])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4AF9Swj2020536
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 09:28:58 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4047106)
	id 2074853B; Fri, 15 Nov 2024 14:58:57 +0530 (+0530)
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
To: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: dma: qcom,gpi: Add QCS615 compatible
Date: Fri, 15 Nov 2024 14:58:54 +0530
Message-Id: <20241115092854.1877369-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t17pynm3WZOYHogvOHc_wGzE5eaeJX1b
X-Proofpoint-ORIG-GUID: t17pynm3WZOYHogvOHc_wGzE5eaeJX1b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150080

Document compatible for GPI DMA controller on QCS615 platform.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
---
v1 -> v2:

- Move qcs615 entry to sdm845 enum as it requries ee_offset equal to 0x0.
- Add Acked-by tag.

v1 Link: https://lore.kernel.org/r/linux-devicetree/20241105104759.3775672-1-quic_vdadhani@quicinc.com/
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 4ad56a409b9c..58c7863c5f41 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -39,6 +39,7 @@ properties:
           - const: qcom,sm6350-gpi-dma
       - items:
           - enum:
+              - qcom,qcs615-gpi-dma
               - qcom,sdm670-gpi-dma
               - qcom,sm6125-gpi-dma
               - qcom,sm8150-gpi-dma
-- 
2.34.1


