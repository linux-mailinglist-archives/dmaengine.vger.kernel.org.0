Return-Path: <dmaengine+bounces-2915-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC9995748B
	for <lists+dmaengine@lfdr.de>; Mon, 19 Aug 2024 21:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384B6285BB6
	for <lists+dmaengine@lfdr.de>; Mon, 19 Aug 2024 19:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229A0186E56;
	Mon, 19 Aug 2024 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iyT8C1zi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873D99460;
	Mon, 19 Aug 2024 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096220; cv=none; b=h8sQFvLKsD2++8XUXWDMlfXnaWJjy1WMDW4Erie63+o8TaOayR7ESn7yFQdvquE31W3Dlnp/c4IExt2rv0M7bTzdBT2y/mp26hV2MxcrrWh3wl1il2VEwLkTSV6FaL1JmLn0KHCIW4VK95xZHmbPcB+3XXS2v7PttcSUvt74oNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096220; c=relaxed/simple;
	bh=uaT8W2cHmWPSMhnMFf+mMks8PU0cfLZOZSsqLBMc8Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qAq0wYy/oNAIhk8jIbvr3eCnel+y6b3JL4xF2wL00NLwy0Y0cYY+IbvONgoyj1w1RONfc5UsRcZLxHs8WJb6W6rOZTOeJCqWdWp945dZjXekMdvaVXIQAyjApGF5kMr4uH+0vKqUjNZx8Z4kzzeG5gXyEBZTyfiIjSrp6+Qoe4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iyT8C1zi; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JIJvXc011235;
	Mon, 19 Aug 2024 19:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=WfSDpCVRbLP2gF
	yi+ViQVJY/cDfBP//dv0SZ/0dh2Ew=; b=iyT8C1zioEdqJU1S0f2AT8UnAExgef
	xOIQqk18ORGGSyFwycSO0E9GwVsNEi5gCSMDJnmum2oC/Am82/hivFobk6zV8w3H
	x5yfthR5GiId40c5h4njPzV5Mtiovnnzh+YlMcX+CSOT3vVXAnxVAGWy+vYJzD1d
	ENDkS16xMBBBzygvK14JmMxGcFDNGk4qS/WgWtfb47IiMa3oToCHJfuu4VGHmk3M
	KuiDQeJlUeWMEuEO30Yheul4LZJG9ggTYzY4wl6XjInbDXIUqLsyxgrf/jgWk7kY
	t4ln1zWI4zqmf59FyDIsJMtoQeCRR4T7R447DF7QMtexRcwib6reOLIQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67bdry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 19:36:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JI1BoD037641;
	Mon, 19 Aug 2024 19:36:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 413h5shynh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 19:36:46 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47JJajjU028358;
	Mon, 19 Aug 2024 19:36:45 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 413h5shym6-1;
	Mon, 19 Aug 2024 19:36:45 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>,
        Sonal Santan <sonal.santan@amd.com>, Max Zhen <max.zhen@amd.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] dmaengine: xilinx: xdma: Fix IS_ERR() vs NULL bug in xdma_probe()
Date: Mon, 19 Aug 2024 12:36:40 -0700
Message-ID: <20240819193641.600176-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408190133
X-Proofpoint-ORIG-GUID: nuWlg6L4e4M8i_2_jREaf2qEeNzMUwkQ
X-Proofpoint-GUID: nuWlg6L4e4M8i_2_jREaf2qEeNzMUwkQ

devm_regmap_init_mmio() returns error pointers on error, it doesn't
return NULL. Update the error check.

Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis with smatch, only compile tested.
---
 drivers/dma/xilinx/xdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 718842fdaf98..44fae351f0a0 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -1240,7 +1240,8 @@ static int xdma_probe(struct platform_device *pdev)
 
 	xdev->rmap = devm_regmap_init_mmio(&pdev->dev, reg_base,
 					   &xdma_regmap_config);
-	if (!xdev->rmap) {
+	if (IS_ERR(xdev->rmap)) {
+		ret = PTR_ERR(xdev->rmap);
 		xdma_err(xdev, "config regmap failed: %d", ret);
 		goto failed;
 	}
-- 
2.39.3


