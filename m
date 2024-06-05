Return-Path: <dmaengine+bounces-2291-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C0D8FD671
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 21:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C633B209DE
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 19:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAC914EC48;
	Wed,  5 Jun 2024 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T5dCY/Y+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4425EFBFD;
	Wed,  5 Jun 2024 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615721; cv=none; b=iWnyAI7PU6jjSDc9Svyc6O6J3hR7XQcNzFJdFPOQjnq0VN85ZEvKsKp+TEMK58dCXaaytjiKUXyM2odnEdG00ME/AkdqC+siuOEtx4ViZl7B48l+ZUulbUHK+gSna/rmb9LHp+B3DqkbtnV558r9BhVIvWaw1t1Bdq031YqrD3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615721; c=relaxed/simple;
	bh=GD3iYdT5XOGRVE0Nem0zYe1P7mRbAjWzmTkIUhIrUvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=fkcu6TmYunV5BvPCRN4AENxSCznLjRa+g129T1BIVUQ4PC7l3fyWYFPavFsInCkV7j+qwD8gAvALulGVPEhgToh7Q8PPLOhIojFFBY4LmPFuQdyBVS9S5BipHJu67TEfcUdXTCp4eYXFuQazvIzi5IfGl1j6GLpSKt7NDLnXFbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T5dCY/Y+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455B1xFr007540;
	Wed, 5 Jun 2024 19:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jB4zfOV96DE2gLWkDr4+0m
	sPz53+wnI51vMQ1wHOUds=; b=T5dCY/Y+Ol1Kx03LJRghiCPp6XMs0/cbn4FJ4C
	yp3aUmxRQNen0SAptsY5/bKmwlyTbkW/vO9UMEvqmY8oIix7zPanITr5cQ7Z15yQ
	stBJdfqRdFGfVu/k0WNZOA/eIlVlWSiSgB0EYaMhVqYdj1gmVgCCOe0kK5wPT/+n
	wxuud1OjscUNP/Dm25RqIn6VlAJbjghROzNL4MIkZX/IH0RkrPpSG5xr6c2tqjtb
	eSp01GWbfpWf87dCRlVCMpBBnPCh9BQneuUWhxHz2fNTkxynBvKQM4kIVsN4OzCD
	06l+ElRjBlib4mzg5rtB0qlMqrmuL2/TqAhNaoO/8hMPp6Kg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yj7urb3c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 19:28:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 455JSXLT027353
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Jun 2024 19:28:33 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 5 Jun 2024
 12:28:33 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 5 Jun 2024 12:28:31 -0700
Subject: [PATCH] dmaengine: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240605-md-drivers-dma-v1-1-bcbcfd9ce706@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAF68YGYC/x3MTQqDQAxA4atI1g2M40+hV5EuMk6sgc5UEhVBv
 HunXX6L904wVmGDR3WC8i4mn1xQ3yoYZ8ovRonF4J1vXe86TBGjys5qGBOhr10X7qGffNtAiRb
 lSY7/cHgWBzLGoJTH+bd5S94OTGQrK1zXFwL6yPl/AAAA
To: Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        "Dave
 Jiang" <dave.jiang@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UG0TkUCYGWMH8kPhLlpoQy3M5oFk0U-h
X-Proofpoint-GUID: UG0TkUCYGWMH8kPhLlpoQy3M5oFk0U-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406050147

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/idxd/idxd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ti/omap-dma.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/dmatest.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ioat/ioatdma.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/dma/dmatest.c     | 1 +
 drivers/dma/idxd/init.c   | 1 +
 drivers/dma/ioat/init.c   | 1 +
 drivers/dma/ti/omap-dma.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index a4f608837849..1f201a542b37 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -1372,4 +1372,5 @@ static void __exit dmatest_exit(void)
 module_exit(dmatest_exit);
 
 MODULE_AUTHOR("Haavard Skinnemoen (Atmel)");
+MODULE_DESCRIPTION("DMA Engine test module");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index a7295943fa22..cb5f9748f54a 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -22,6 +22,7 @@
 #include "perfmon.h"
 
 MODULE_VERSION(IDXD_DRIVER_VERSION);
+MODULE_DESCRIPTION("Intel Data Accelerators support");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Intel Corporation");
 MODULE_IMPORT_NS(IDXD);
diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 9c364e92cb82..d84d95321f43 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -23,6 +23,7 @@
 #include "../dmaengine.h"
 
 MODULE_VERSION(IOAT_DMA_VERSION);
+MODULE_DESCRIPTION("Intel I/OAT DMA Linux driver");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Intel Corporation");
 
diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index b9e0e22383b7..5b994c325b41 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1950,4 +1950,5 @@ static void __exit omap_dma_exit(void)
 module_exit(omap_dma_exit);
 
 MODULE_AUTHOR("Russell King");
+MODULE_DESCRIPTION("OMAP DMAengine support");
 MODULE_LICENSE("GPL");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240605-md-drivers-dma-2105b7b6f243


