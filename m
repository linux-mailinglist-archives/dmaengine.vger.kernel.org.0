Return-Path: <dmaengine+bounces-3686-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 874009BCACE
	for <lists+dmaengine@lfdr.de>; Tue,  5 Nov 2024 11:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 254CCB22406
	for <lists+dmaengine@lfdr.de>; Tue,  5 Nov 2024 10:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3111D2B22;
	Tue,  5 Nov 2024 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TKpsVR3j"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5475518DF89;
	Tue,  5 Nov 2024 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803693; cv=none; b=ku2o1v/2m2QC52hyIdPB3kcprJycutgnYQgoujHz4b0MXmkh7EtfL3MUCOOUeECS1FOxx/m/Xhliz1Xz4FnR6aTsuxCF/rg3UC74lofSDe9e4vk+VC3zksMLwJCSpOtcvCPrK4AISq/fbqAx8qJ1/QEWzr2SRNHyxj3npOkAsho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803693; c=relaxed/simple;
	bh=9nci4TTFpI29fccUZhsQ38CiKylvkkP9B3D45Yw8JhM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k3x1Clcm+FaEDF5uze3gu9XFmFx6Pu8V5W9X32pzHD3dvBQW0eFidXk+EOUtVGEjCT+USI6fsZPNkZz67hPmb9RnYNHMnBwU5LHqF/DQouAu6vwhyln3rNwJxCm+cAOVm0PfyhcK88fzUDxFz2xNTu/aecspcJdkyzHKg2RnlmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TKpsVR3j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A59eqB6005247;
	Tue, 5 Nov 2024 10:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=h1mQ3EIB/SODfCTJRZAJXrT+JUk0LmCmPS0
	9GnmsJtw=; b=TKpsVR3j/gxtwJb7Zu1fnl/pG66NcItF2tduqdH0FZpq01spxCX
	k1pq5eskAMzUh9n7FKUNbC9Ho8psoM7b+WqKYydm9Oi8mzas6UGlPUSlbPwle08y
	AY9qpgyk8MJrNb34v4UAFnWmC6N450CQ9A2y4C53lwO4BR4hbt/JcMjz+zpo1WwC
	gQwVW84NpVhRm5s/41MPjevXaNnZEROx60Og/yjB9Xk9Li067XYD51VCQfavLtSb
	otliEU/SHxabjVGjYqSQ8GKb7f+l8SxyehJED+ZmR2HDw6qT19R5OxJ99iZyxsm9
	e2HwcudkOHvFQbqphgr4oMFd5SfRYiiBMHw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ndc6yav6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 10:48:08 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5Am34C002819;
	Tue, 5 Nov 2024 10:48:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 42nd5kx4m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 10:48:03 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A5Am3xl002804;
	Tue, 5 Nov 2024 10:48:03 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com ([10.213.97.252])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4A5Am2w4002800
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 10:48:03 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4047106)
	id B7FD74D9; Tue,  5 Nov 2024 16:18:01 +0530 (+0530)
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
To: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [PATCH v1] dt-bindings: dma: qcom,gpi: Add QCS615 compatible
Date: Tue,  5 Nov 2024 16:17:59 +0530
Message-Id: <20241105104759.3775672-1-quic_vdadhani@quicinc.com>
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
X-Proofpoint-ORIG-GUID: wOsKnzbRCcUeUB24IZL1VwxgiPBuLMmX
X-Proofpoint-GUID: wOsKnzbRCcUeUB24IZL1VwxgiPBuLMmX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=790 adultscore=0 clxscore=1011 mlxscore=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050081

Document compatible for GPI DMA controller on QCS615 platform.

Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 4ad56a409b9c..8fc94c87c421 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -25,6 +25,7 @@ properties:
       - items:
           - enum:
               - qcom,qcm2290-gpi-dma
+              - qcom,qcs615-gpi-dma
               - qcom,qdu1000-gpi-dma
               - qcom,sar2130p-gpi-dma
               - qcom,sc7280-gpi-dma
-- 
2.34.1


