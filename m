Return-Path: <dmaengine+bounces-2364-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB278907C93
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2024 21:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5831C22626
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2024 19:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A4414D457;
	Thu, 13 Jun 2024 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GHNO8nXf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A22414B064;
	Thu, 13 Jun 2024 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306849; cv=none; b=f+btv+2dvaxX8kkgKIzYHGzKtRrC4bLMZLaVcpXgk/wJpAxg10zvaJE9TwUmnfE3bbjdWD/rgJDsUqijf2dTnr51t97nGVBTwrDE2YeCa0B90/8JiKjMRdovTlU2+0vVhjxQ+zjU+RY2sdY8Y3DIxbNK+zON7p1gMUrH1wUFS9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306849; c=relaxed/simple;
	bh=xgxJS2sUBQxYIKfT1iWWx4e+Kx66SGSjdDm98PRpCpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=FbnkwP+eMnUhhmatLLr/E8ukGBP+rxlx31jzaHPkdbzn870tuJb+VO0e8C/NEUKJNDpTseDN7e2REmytsyrZwyeWGzWF95gJErTD1QINLeW6KqDZaefDd1DhntwcGTy8lNtK/WiclKl5o4tNq/ZBzBhjQkjBW0hGpUdMTfB7b50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GHNO8nXf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DJGLLN030260;
	Thu, 13 Jun 2024 19:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vHWnZwlbStXdCQrfa85iAH
	P+E6m/g3vqpk6xjZYbADI=; b=GHNO8nXfFF5DvkiC97GJJrwyskL6bvp7a8+Fhs
	zXnIV2ZDvp/5khg9Evo3IZBYWnhMJEVjn2ri2kVKPgFD/ODUPjUX7JICeI9xx1UO
	/WAw0e4Oj/iIhkbIXMklH24W9yqIkmSJFvoISaxJ6m5TOxJO81+NjivjmXWsDxuT
	hUqIJAhfNhHO8hr6Zi54nbxZO+/iWeZGt70i8yymp3EPGqsCYZE59Vi/+s4tCYe4
	N/1cXs7LHVxzfkIiSdGw6RUT9K4fBHuB240JtPwZCk7dqqObNfAW1cqapPwNu6U+
	pGiBtaGK18HkjCajEniUr07WstrEaIInohTgSxrNgXp90ldg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yr6q4010k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 19:27:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45DJRN5d007248
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 19:27:23 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 12:27:23 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 13 Jun 2024 12:27:22 -0700
Subject: [PATCH] dmaengine: ti: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240613-md-arm64-drivers-dma-ti-v1-1-b1154603f341@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABlIa2YC/x3MTQrCQAxA4auUrA30ZxjQq4iLTJPagDNK0pZC6
 d0dXX6L9w5wMRWHW3OAyaau71LRXRoYZypPQeVq6Ns+tLEbMDOS5RiQTTcxR86EiyIPUShRCtc
 0Qa0/JpPu//P9UZ3IBZNRGeff76Vl3TGTL2Jwnl9RWd9+iAAAAA==
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6F9gXzxjXHwiEmd79l12S8XKuUmV6uI2
X-Proofpoint-ORIG-GUID: 6F9gXzxjXHwiEmd79l12S8XKuUmV6uI2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_12,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130138

With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ti/k3-udma.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ti/k3-udma-glue.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ti/k3-psil-lib.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/dma/ti/k3-psil.c      | 1 +
 drivers/dma/ti/k3-udma-glue.c | 1 +
 drivers/dma/ti/k3-udma.c      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index 25148d952472..c4b6f0df4686 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -106,4 +106,5 @@ int psil_set_new_ep_config(struct device *dev, const char *name,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(psil_set_new_ep_config);
+MODULE_DESCRIPTION("K3 PSI-L endpoint configuration");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index c9b93055dc9d..5348797d7a94 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -1574,4 +1574,5 @@ static int __init k3_udma_glue_class_init(void)
 }
 
 module_init(k3_udma_glue_class_init);
+MODULE_DESCRIPTION("TI K3 NAVSS DMA glue interface");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 6400d06588a2..dc7ff1e74fd0 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5621,6 +5621,7 @@ static struct platform_driver udma_driver = {
 };
 
 module_platform_driver(udma_driver);
+MODULE_DESCRIPTION("Texas Instruments UDMA support");
 MODULE_LICENSE("GPL v2");
 
 /* Private interfaces to UDMA */

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240613-md-arm64-drivers-dma-ti-d36eabab49bf


