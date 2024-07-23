Return-Path: <dmaengine+bounces-2728-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876C593A138
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2024 15:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404CC2814A2
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2024 13:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3736153BED;
	Tue, 23 Jul 2024 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I+YoUEWt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A23153803;
	Tue, 23 Jul 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740796; cv=none; b=deo2+5y2aPQ2VwBPwoGLKYRkconBe50CV5XQr7BLlUBmiaee/NuX/0h5T4UDIXralVoB1OuBIuMA4mnL4cd/cfxPAjnZKmYuEWXInN5I1IHmu7TRGpgM5Ar+bkQpO5A/sRYQHReezrEwN1B4W0jzqTI9Dzvp8BqjqICqb1IgR8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740796; c=relaxed/simple;
	bh=Bll5H5v993IeqkWlydA+jqNxchMOMzxU2IgellDICXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TJeNE8P4uWNavYOnvWDAyzF77npNrprXP3yaNctbLv5JUst7rkq3vZKNHlvMF48KHzTvnGIIwoFE9Dz7CUc/iuZxEHCOsSSUqzU7aayZPfPWeBd5Wo8UGQ0ZukopDUVTY0BFtOpbKiqi7kZsmZeYa+2BFobSNXxhBXRmg7+pvZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I+YoUEWt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NBDTIf032520;
	Tue, 23 Jul 2024 13:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=nhcAXTxzaTGesQYfMlJa5VIwcFFT8n2SiRW4vqD7rzo=; b=I+
	YoUEWtaZnWmvFaW5t6JEpz/iCSWaGw+c8qdMKbfAXWPpdwC3Fbzgk/0lSnEUyEGd
	U7FeyEC4cFvgPRCjfWcKH9XHUTqJ9AlCfedjPEZEyQQiUg2YTvtG1Ji/UFBhbChj
	LVr8FVf/xUhK5dRaB0JM/dyHk+/6Js1f2aJOZzoxzx58wUzk5bPINtlX79qAUz24
	NtrithlsYiDgx3AGbrdaGGltpwFFS1QTeHJGP11OSMUQlPVHPNvA+UKyRx6xp7Tc
	a+HoOA+/UugQ/JlO2Uprmmg+LA8HGsR4S8FA2IWsfcL2s1BWG+pcy7F9Cf2aqssA
	nFjs+2hq0b2IKZX2M8wQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g487et9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 13:19:39 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 46NDJapK019993;
	Tue, 23 Jul 2024 13:19:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 40g6akuxrb-1;
	Tue, 23 Jul 2024 13:19:36 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46NDJaIr019986;
	Tue, 23 Jul 2024 13:19:36 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 46NDJacA019985;
	Tue, 23 Jul 2024 13:19:36 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 8811B1548; Tue, 23 Jul 2024 18:49:35 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: manivannan.sadhasivam@linaro.org, fancer.lancer@gmail.com,
        vkoul@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        stable@vger.kernel.org, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dmaengine: dw-edma: Fix unmasking STOP and ABORT interrupts for HDMA
Date: Tue, 23 Jul 2024 18:49:31 +0530
Message-Id: <1721740773-23181-2-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721740773-23181-1-git-send-email-quic_msarkar@quicinc.com>
References: <1721740773-23181-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZtTiKoSCCPcNDDfHVdXEbEjUUCZ1bJvE
X-Proofpoint-GUID: ZtTiKoSCCPcNDDfHVdXEbEjUUCZ1bJvE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_02,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=581
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407230095
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
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 10e8f07..fa89b3a 100644
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
+		/* Interrupt unmask - STOP, ABORT */
+		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) &
+		      ~HDMA_V0_STOP_INT_MASK & ~HDMA_V0_ABORT_INT_MASK;
+		/* Interrupt enable - STOP, ABORT */
+		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
 		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
 			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
 		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
-- 
2.7.4


