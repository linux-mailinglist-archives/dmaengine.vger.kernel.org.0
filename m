Return-Path: <dmaengine+bounces-3714-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E139C4DA7
	for <lists+dmaengine@lfdr.de>; Tue, 12 Nov 2024 05:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88411F21178
	for <lists+dmaengine@lfdr.de>; Tue, 12 Nov 2024 04:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71472207A3E;
	Tue, 12 Nov 2024 04:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DbuyqWa4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38DD1DFE4;
	Tue, 12 Nov 2024 04:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731384783; cv=none; b=sXSyMC88vR5xzqirsd4fAdbY65RytWuiMkiwJAnXEPyhxy5lbdGvES14oTDA3eFkaor3cy+taUOldfjEw1ABHCA/6wQJ783Opp5s16Ppqp8VZrGWrnauIdjY/ezKHNqCc4uEfJPtGvoUmOeXaOYjCfl8U1dYcsYCWdM0pGzmapg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731384783; c=relaxed/simple;
	bh=bod04bIz15PbMOHPnaFOteze34TvQOBL9jRIp/KXaIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=prBAwLDhfNq2TrOGtR+faMXlBG6C2H2gnyncRPtAs7yvfsJeikyG4Uph6c3lOnjOgZ+1XoZ0Q3cioi8+2/nLox85256k/uYSMWtG5WM8bkkiQShmTYyMxRfvXsanLt/UBarLC7vZj8dol+OdgfwqDqS1tizuQ7rvHy81Rx4qVoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DbuyqWa4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC1s27E031047;
	Tue, 12 Nov 2024 04:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=KBaqXWk6MxZ9pfru1EUYP2piHQcIQ5aHH5D
	GUgivxAY=; b=DbuyqWa4fP62sX94i+ikDzQ5n5SMnnHzm4CK1CJ0BR5S6yUWf7T
	cRrwtj4QFddkfo4Fpwi18OSl8ZHoFS/NRjN3qRsW4ABBfcYX0hyPoyfmHexkzHzR
	bRjGbQB0LkLFTruV3pM23LTwfTfUR9RPzhAPaPa0HaV1B22VEuDZ2A91ZnjlRgis
	3JmDl8EQJDvXoilqoc39A/XnPaQA/4LyCoPYokHscrTDDq/HpR8xMqv6G9SEwsjx
	azroLIUMDLfWXSBA6QPtgpeJ8MT1GmPPehR0h0dKNj/0I+6Y5ybFAt4l0pN8H+H9
	kEy3hV6UsHr/u1v/kS3wD7MxVuPPJtN/prw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42syy261vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 04:12:58 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC4CsMu021100;
	Tue, 12 Nov 2024 04:12:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 42t0tkt7mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 04:12:54 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AC4CsFn021095;
	Tue, 12 Nov 2024 04:12:54 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com ([10.213.97.252])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4AC4CsNl021094
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 04:12:54 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4047106)
	id B7A1A50D; Tue, 12 Nov 2024 09:42:53 +0530 (+0530)
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
To: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [PATCH v1] dt-bindings: dma: qcom,gpi: Add QCS8300 compatible
Date: Tue, 12 Nov 2024 09:42:51 +0530
Message-Id: <20241112041252.351266-1-quic_vdadhani@quicinc.com>
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
X-Proofpoint-GUID: xlb_VWympCZZUAkPV4scv77HaN8NIYu7
X-Proofpoint-ORIG-GUID: xlb_VWympCZZUAkPV4scv77HaN8NIYu7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=787 suspectscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120033

Document compatible for GPI DMA controller on QCS8300 platform.

Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 4ad56a409b9c..09243de49ae6 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -25,6 +25,7 @@ properties:
       - items:
           - enum:
               - qcom,qcm2290-gpi-dma
+              - qcom,qcs8300-gpi-dma
               - qcom,qdu1000-gpi-dma
               - qcom,sar2130p-gpi-dma
               - qcom,sc7280-gpi-dma
-- 
2.34.1


