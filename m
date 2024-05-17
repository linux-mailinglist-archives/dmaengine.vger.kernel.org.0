Return-Path: <dmaengine+bounces-2054-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1212D8C8479
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 12:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C7E284486
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 10:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353FB2C861;
	Fri, 17 May 2024 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="byicfLlG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAEB3A1B6;
	Fri, 17 May 2024 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715940283; cv=none; b=HseG/xemUVfS5MjvB4jL/bxXPeL86w/McsGspn2mzKCcMY5cMcxD+08WQZ9tUVeUtWEiBZaD7ZQWGWp6ALhope6zP7lNtqBW7Je8RHL0Nwj4pOd8sVKt71S2FnVx36EX0TWblKTfnWpsUfWm4Ucuh5l1pZCgzkHm8hGHSdt6avU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715940283; c=relaxed/simple;
	bh=He+2J8EvEfsDvU8JEd7AoI0gGzPsibEZfIB2WeViMGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fXJVW6CQ0tPRAzC0OvOGAfxwDobWD+znPYUw+pF5VGpzzWG6GzPVMR9RlWru5JNGV/COsJE5cUTdvARa7+jB+qb5H7WhMpx1uJ3xswQBmHJoMawVHDwSNNw+506IwTyPsE4X3XS3mf9MBjsoI37hC8rZXl7/wADTRZEaTglsXgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=byicfLlG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44H9goLo007753;
	Fri, 17 May 2024 10:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=NhU0J0G
	oQo14nqvwBbz+/so9Fkf2+MZRG9uSqbKFOMg=; b=byicfLlGGBSmw02Qm/FvEH0
	qqdroTCzvM7JLhHJ23QvzNoXZaobZHGL9t3tO0pg0bAMY1goEj764mqfGG/rZCTY
	seicy9CnbrcHVkeJ0mBcicUYPLmvieOTDTp3yKxY+USUY1UopJj2fQhnvLXA8UNJ
	HoWEYRhEx/GZuadfwa6VQ0kjkKgn3O2IAmG2HqKCtrInM0cLY5x37cDTMRXMfdLb
	t66eqqTBbNzck69vQEhS74m/RplMfZ8Nj4Ao9gxIh6n0RyDCc/UapnzY+kLq8uJU
	PzXEPeTdaf4SmZgtFzxWAy5iFMqv2wUBNWw8S3Ef2DctvjkZxnDmLjfRYyTr4Vg=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y51tumaj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 10:04:31 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44HA4Qmk007989;
	Fri, 17 May 2024 10:04:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3y5k8ap6c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 10:04:26 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44HA4P8f007978;
	Fri, 17 May 2024 10:04:26 GMT
Received: from hu-devc-hyd-u20-c-new.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.147.246.70])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 44HA4Pvj007973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 10:04:25 +0000
Received: by hu-devc-hyd-u20-c-new.qualcomm.com (Postfix, from userid 3970568)
	id 0437C210FD; Fri, 17 May 2024 15:34:25 +0530 (+0530)
From: Rohit Agarwal <quic_rohiagar@quicinc.com>
To: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: dma: qcom,gpi: document the SDX75 GPI DMA Engine
Date: Fri, 17 May 2024 15:34:22 +0530
Message-Id: <20240517100423.2006022-2-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240517100423.2006022-1-quic_rohiagar@quicinc.com>
References: <20240517100423.2006022-1-quic_rohiagar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: -sT7EZnnKpgIbY-DOqR3pHlHMgyeN1rA
X-Proofpoint-GUID: -sT7EZnnKpgIbY-DOqR3pHlHMgyeN1rA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_03,2024-05-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 mlxlogscore=966 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405170080

Document the GPI DMA Engine on the SDX75 Platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index deb64cb9ca3e..4df4e61895d2 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -27,6 +27,7 @@ properties:
               - qcom,qcm2290-gpi-dma
               - qcom,qdu1000-gpi-dma
               - qcom,sc7280-gpi-dma
+              - qcom,sdx75-gpi-dma
               - qcom,sm6115-gpi-dma
               - qcom,sm6375-gpi-dma
               - qcom,sm8350-gpi-dma
-- 
2.25.1


