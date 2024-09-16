Return-Path: <dmaengine+bounces-3173-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7589497A745
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 20:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219391F216E2
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 18:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD8A158545;
	Mon, 16 Sep 2024 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hcTaswU4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24B1757D;
	Mon, 16 Sep 2024 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726511036; cv=none; b=jTejQ3l6qrpUH7iTZAmvw+OCoCvbiMOzjubHkdror/mR8IGLCoTYiQq1yEvqfpkO/b0tP9YBmhcnQ/JtmhpzP/pqEpUx0F0jYOixRZs5IJoldrPSGx3gRDmBXdC+TowZUXouiHEaFDULbMRX22ik96vPrtqDx69nmOqlr92+M4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726511036; c=relaxed/simple;
	bh=lvG7GKZGlAtbIh7LO1HbNQHCIqQDmvFvHfX5CH6r8ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AYUaCTUPPSPFLzAT/i/xe1tq1AlyvCWv4oeWCwVYHmn5bu2wQVqKTZNbl4soJiA9uwKuIvmL/OU2WbVISCtgYQYBbePL4l8Ohs8Mqqi2Mj4ZNHvSKJ8gwgbE5lXGptaoot4gHcboEw9maOfu7BJlsa+y68CpYrd8b8DznV7s/rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hcTaswU4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GEMYhU030175;
	Mon, 16 Sep 2024 18:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=GLRHOEqG7Q7gtr
	JcCO7ITSfTUx6B8imW3hvbaVdUOnQ=; b=hcTaswU42iyygXfAx2SP7klBqh33xb
	o/R3/cMKf7qPutA976cfY3zOXb0w88Upok1h5d0zM7j7hhGyziP3VJ5Zh8nLWUiZ
	DmF7VqOsHUjamQyzf+eN8qIYrO6xhsINXW+pJlkkSpcclpyK6Fi+3biFkuYD9dzE
	RwNhtnGUJBfRRKWQPF2vhSQTOakZL6Lv4vN6al9oiWDZ2sC9NZHEnIRkMC7EwQ+/
	QXMS3AfHHNAsVEVZXNG2RaHL0e3wIstfmgIspTWa3cXpiH/t4eo6JYsVpWJe//J9
	QeFEAwwBMi+2v3cj2UpBHMk/k7Va1oHhTZDZk9dDMzdDbhusXKTAk6XA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3n3c4q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 18:23:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48GGWfXa017899;
	Mon, 16 Sep 2024 18:23:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nycvpye6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 18:23:41 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48GIN8ib000333;
	Mon, 16 Sep 2024 18:23:40 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41nycvpyds-1;
	Mon, 16 Sep 2024 18:23:40 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Vinod Koul <vkoul@kernel.org>, Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] dmaengine: ep93xx: Fix NULL vs IS_ERR() check in ep93xx_dma_probe()
Date: Mon, 16 Sep 2024 11:23:37 -0700
Message-ID: <20240916182337.1986380-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_14,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409160123
X-Proofpoint-GUID: x1HgqPN8Iuz8wE03qSc3AmQkG-X1VSBv
X-Proofpoint-ORIG-GUID: x1HgqPN8Iuz8wE03qSc3AmQkG-X1VSBv

ep93xx_dma_of_probe() returns error pointers on error. Change the NULL
check to IS_ERR() check instead.

Fixes: 5313a72f7e11 ("dmaengine: cirrus: Convert to DT for Cirrus EP93xx")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis with Smatch
---
 drivers/dma/ep93xx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index d084bd123c1c..ca86b2b5a913 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -1504,7 +1504,7 @@ static int ep93xx_dma_probe(struct platform_device *pdev)
 	int ret;
 
 	edma = ep93xx_dma_of_probe(pdev);
-	if (!edma)
+	if (IS_ERR(edma))
 		return PTR_ERR(edma);
 
 	dma_dev = &edma->dma_dev;
-- 
2.39.3


