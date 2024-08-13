Return-Path: <dmaengine+bounces-2852-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34FA950632
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2024 15:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C686B2151F
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2024 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871B2170A2B;
	Tue, 13 Aug 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZZG0F0Bp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA429A5;
	Tue, 13 Aug 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554954; cv=none; b=Soht6w2z2XfbuFNZv5B9GZh9p7UwF00Zg1jIULwTB6DBEUrIPOTbOVoKSrGUVm60etSqVYlg2GpPHHKXaJDyf7FkhXSm3K1vzp6rmPmr+d9tGrcoCvUy+PuzvgLXRa64wpN27xQN2Dc5/ZiOQwAZusji9K7MLxBSQ1s3aZSGZic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554954; c=relaxed/simple;
	bh=T9EcR14SZLpmz/ySqHmqT5ZiaHueZmYtuY2MB20Qi/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Zy1wArhQ3oQJE5dXg2FF1JH1b2twFCMzLmeTtPcfWtRfQ6luZZAJll8CSe2TqwyMYzZGqqwOuxYrChOc6ZvYLPqxRajOeZPhII0lnv+tUcOBaqJxoS+cMBHjnZiIddKfDKraMexL2Su52E7fdtcF96Skzf0dGxnsskdDro6jd9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZZG0F0Bp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D8MNq1004609;
	Tue, 13 Aug 2024 13:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=nlMus2LYCatizlNSBZ63L6GzGEe2A9gttBd0WWmWUR4=; b=ZZ
	G0F0BpT9avPNjXQBuuEfnFnEkC+rlCHtvFoVV3gMCQOmsZR3AVgmm+6OsxE4KIZ4
	kzsMHdu3qdd4U2x1xwV4v+EWLByslZXg56JNQthWHrofqkIXeY1fx/dbcRVthz5N
	CjSdW5S9MLuE7QlCj5P9sXZpKztu6rRLiFGVvpDryHD4Y2pY5gTec+alcVJwIU7o
	OXFzYLCPbH3pd0qH+DDCyG9SkYtTAJdKljbbg2ANWmjO0VRaIRd/y97mFLDKqvwn
	0iXz6ObvgmRqQFQ98q0QH5j1U30vyQ/wN5+GjQNSSGGigxQQPvEfXqwl0lnimdge
	lfUrrc60kIMApGhspmwA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4103ws11n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 13:15:46 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47DDFf5P001335;
	Tue, 13 Aug 2024 13:15:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 40xkmgxsyk-1;
	Tue, 13 Aug 2024 13:15:42 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47DDFgEW001339;
	Tue, 13 Aug 2024 13:15:42 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 47DDFg4e001338;
	Tue, 13 Aug 2024 13:15:42 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 01DDE974; Tue, 13 Aug 2024 18:45:42 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: manivannan.sadhasivam@linaro.org, fancer.lancer@gmail.com,
        vkoul@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>, stable@vger.kernel.org,
        Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dmaengine: dw-edma: Fix unmasking STOP and ABORT interrupts for HDMA
Date: Tue, 13 Aug 2024 18:45:37 +0530
Message-Id: <1723554938-23852-2-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1723554938-23852-1-git-send-email-quic_msarkar@quicinc.com>
References: <1723554938-23852-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yEJiylgHCwlcoMzvWJhbeR8kVcyCHrMi
X-Proofpoint-ORIG-GUID: yEJiylgHCwlcoMzvWJhbeR8kVcyCHrMi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_04,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=619 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130096
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

The current logic is enabling both STOP_INT_MASK and ABORT_INT_MASK
bit. This is apparently masking those particular interrupts rather than
unmasking the same. If the interrupts are masked, they would never get
triggered.

So fix the issue by unmasking the STOP and ABORT interrupts properly.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
cc: stable@vger.kernel.org
Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 10e8f07..a0aabdd 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -247,10 +247,11 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	if (first) {
 		/* Enable engine */
 		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
-		/* Interrupt enable&unmask - done, abort */
-		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
-		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
-		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
+		/* Interrupt unmask - stop, abort */
+		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) &
+		      ~HDMA_V0_STOP_INT_MASK & ~HDMA_V0_ABORT_INT_MASK;
+		/* Interrupt enable - stop, abort */
+		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
 		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
 			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
 		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
-- 
2.7.4


