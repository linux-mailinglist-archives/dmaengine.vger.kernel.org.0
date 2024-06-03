Return-Path: <dmaengine+bounces-2248-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D122A8D87A0
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jun 2024 19:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587991F22CFB
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jun 2024 17:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24E4136E00;
	Mon,  3 Jun 2024 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FdADIN2e"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A91D1369A0;
	Mon,  3 Jun 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434414; cv=none; b=Kbmos2Fy8SS60F8jWCGghIoyFvefXU7XoaQ7vhx7H7M44ORWrGPaV+oVeNJtzL+5VVthibKlvMHGyYq+36dXzV4vHEH9OlqqbTIR9a4pJVu9lX+BD/Nw79EXN8THVp+fYVy7PVa9RX49PenDdte+LmjPQH3vGJeJ2rIaJ0CQe0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434414; c=relaxed/simple;
	bh=RY1WYN6cyHnotKNU1hXoCr5Ce/KAlfwP7sNSVgTCxCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=XHV7KM2jAoMUlXNWPunwNZersBuZd2rOf7IKTnRyP2lPKRjFM4wnnTszVnXLXJ/OFEctWKhxP/NN37DEc3W2iv7757V/65R7/oFbMcvhB3vb7QUClkrOTF5i2ymklh6FDsiX5XlXi1D68Ra5jL874sJPbLYpkZ/0lQoMlyyRkJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FdADIN2e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4539eufJ024997;
	Mon, 3 Jun 2024 17:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ICMf/9JLkxi/FO5S6Y9Y6a
	BSw70Y8KV0kSaF/eUypwg=; b=FdADIN2eDIIzMUPtXb81R/V4yD/FZHlkkb+XtC
	VYbzH6AX1Z6WNPKBp/zisQBM/rN0l08OVHRbBCU8sR3RXn260qCcsS641l1J6R1W
	6Iucg3A5FzkXWoA8HEu7oaejNRBT+Z+MS6GMW8A2HTGeU+mvyzHaUJ4yVzfsS6lW
	7r+AotnFW1PxuwMTCjpRo+8g+e6QsKAoXA6UupJLBxYdg3SRawvrAjS9d0kCl97V
	KwRbJB+9ztGEKcXf4urcarE0PuikjN3AJ56XAQ2zPlunpQ8fMFFaQkJBdExNG5sR
	EtIXBH1zPKTzeG/0U3s2aort4dQjl7iC6GC/c9Ku4FkU0i7g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw5wmghq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 17:06:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453H6ksa020553
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 17:06:46 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 10:06:43 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 3 Jun 2024 10:06:42 -0700
Subject: [PATCH] dmaengine: qcom: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240603-md-drivers-dma-qcom-v1-1-d1bd919352bf@quicinc.com>
X-B4-Tracking: v=1; b=H4sIACH4XWYC/32OSw6CMBCGr0K6dkwLDYgr72FYlHaQSaTIFBoM4
 e4WDuDyy//cREAmDOKebYIxUqDRJ1CXTNje+BcCucQil7mWpVQwOHBMETmAGwxMdhzA1lLdtHa
 VlIVIyQ9jR+vZ+mwStyYgtGy87Y+uN/llhcGEGfmw9xTmkb/nh6iO0P+5qEBBnRdO6aLtSqwe0
 0KWvL0mVTT7vv8AT17EXtcAAAA=
To: Sinan Kaya <okaya@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        <kernel@quicinc.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nImHPoARgubnAwgl6cSF-eCJZzlNA07P
X-Proofpoint-ORIG-GUID: nImHPoARgubnAwgl6cSF-eCJZzlNA07P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030141

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/qcom/hdma_mgmt.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/qcom/hdma.o

Add the missing invocations of the MODULE_DESCRIPTION() macro, using
the descriptions from the associated Kconfig items.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/dma/qcom/hidma.c      | 1 +
 drivers/dma/qcom/hidma_mgmt.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 721b4ac0857a..4d2cd8d9ec74 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -957,4 +957,5 @@ static struct platform_driver hidma_driver = {
 };
 
 module_platform_driver(hidma_driver);
+MODULE_DESCRIPTION("Qualcomm Technologies HIDMA Channel support");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index bb883e138ebf..4805ce390ffa 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -331,4 +331,5 @@ static struct platform_driver hidma_mgmt_driver = {
 };
 
 module_platform_driver(hidma_mgmt_driver);
+MODULE_DESCRIPTION("Qualcomm Technologies HIDMA DMA engine interface");
 MODULE_LICENSE("GPL v2");

---
base-commit: 83814698cf48ce3aadc5d88a3f577f04482ff92a
change-id: 20240601-md-drivers-dma-qcom-c901844d7003


