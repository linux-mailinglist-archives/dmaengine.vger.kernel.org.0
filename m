Return-Path: <dmaengine+bounces-2301-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3548FF59A
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2024 22:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C84281993
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2024 20:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C9461FE2;
	Thu,  6 Jun 2024 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SVVG3Zkx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C978347F6C;
	Thu,  6 Jun 2024 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717704017; cv=none; b=X8C+2l3AWmUoV13C/ffZXv3qZ6en8sGnQsd1q8nHUc52mD2VHI5G4kNpJCSNupy/l3K/f+TRM5Pg0w5jpmJg50ZJoRJf1qZ6Mb/Zleho43/vPBYTBw9Fl3E0MG4USF+y/l+ceGdYxcxZcKt+7HCDtMPKrMnyU9TjhE2Qqhoo0uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717704017; c=relaxed/simple;
	bh=r0HycEYtsjvfDnG31XB6I1WnxKmQ18iLPI5NxGMDrHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=hfggioW8uS6NuKocn3m7u7X3a8gHlLQ/m1/ANyfNyLyzUDO/LZqssxM0Vtn9+b/NXwrdfivrd4db82cPLni1hsE/SuZO43ZoLv8w2Me1r0j3o5s24dHnwIV9YxeqFdQJfFwK1SMlTmRN7Ioat/nUDv3v2XpqoODBWQWauGBnoYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SVVG3Zkx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456Akb3J026749;
	Thu, 6 Jun 2024 20:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Km97lP73CsYhkQfOtqG4O7
	VDuPXW2wmATbHUzQ//8iI=; b=SVVG3ZkxJ+vpP+ySoqlQ4fItnOnwOBjUXBi76Y
	dLsrnQGS3pLdr2Y4yeZ09cruUOiURG9C7QHuJhSnPnKnCvXSD2N2r3hlcjX3R1ji
	T64A8vnG6FpSkBvsAEgor3UOC1hc5VHB02bJqwloEAwWzpaVOhRGHtR4nTtMAfIk
	QbuGsdGlpqawlQKp2w5qa/D6jyQK2k4WfI5hFA3AdwCyhzkuCJzyn79K1eqcSTPr
	GJ2hZiYKY4gQSSVAhKKYEKVmvSxLuuORFUkgrqYuepPYSMHh2+RUDzLBpn7H+Xs7
	0J/qxbWFb+tk7h9s2VwcJhJGzZzoZ/z+Ta5024/RtF5tlmfA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjq2tm1kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 20:00:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 456K08WS001766
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 20:00:08 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 13:00:02 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 6 Jun 2024 13:00:01 -0700
Subject: [PATCH v2] dmaengine: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240606-md-drivers-dma-v2-1-0770dfdf74dd@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAEAVYmYC/3WNyw6CMBBFf4V07ZhSeURX/odh0ccgk9iiU2gwh
 H+3sHd5knvPWUVEJoziVqyCMVGkMWRQp0LYQYcnArnMQklVyUbW4B04poQcwXkNqpS1aU3Tq+o
 i8unN2NNyCB9dZqMjgmEd7LBrXhTmBbyOE/I+HyhOI3+PfCr3099SKqEEY43t3dViK5v7ZyZLw
 Z7t6EW3bdsP2aB2Xs0AAAA=
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
X-Proofpoint-GUID: 6E180usvlq6nDlfgIwMRz4EmPFCT9INs
X-Proofpoint-ORIG-GUID: 6E180usvlq6nDlfgIwMRz4EmPFCT9INs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_16,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406060138

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/idxd/idxd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ti/omap-dma.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/dmatest.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ioat/ioatdma.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Acked-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- Updated drivers/dma/idxd/init.c with description from Dave Jiang
- Updated drivers/dma/ti/omap-dma.c with description from Péter Ujfalusi
- Link to v1: https://lore.kernel.org/r/20240605-md-drivers-dma-v1-1-bcbcfd9ce706@quicinc.com
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
index a7295943fa22..e37faa709d9b 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -22,6 +22,7 @@
 #include "perfmon.h"
 
 MODULE_VERSION(IDXD_DRIVER_VERSION);
+MODULE_DESCRIPTION("Intel Data Streaming Accelerator and In-Memory Analytics Accelerator common driver");
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
index b9e0e22383b7..7e6c04afbe89 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1950,4 +1950,5 @@ static void __exit omap_dma_exit(void)
 module_exit(omap_dma_exit);
 
 MODULE_AUTHOR("Russell King");
+MODULE_DESCRIPTION("Texas Instruments sDMA DMAengine support");
 MODULE_LICENSE("GPL");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240605-md-drivers-dma-2105b7b6f243


