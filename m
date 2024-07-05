Return-Path: <dmaengine+bounces-2633-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07A4928A35
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 15:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1906C1C22A3E
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 13:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D89215ADBB;
	Fri,  5 Jul 2024 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ImiNr2gK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A5414B96D;
	Fri,  5 Jul 2024 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187749; cv=none; b=RC5SoEhtkMFtsE/R+A2IwiCE3u8O4f49rQBOuP0T89JvBKWUk2Brfp3rwHKKF8nXWml0h9LZ/TRZdrKUwd5Qsqeh50GvGqRfPn6p0f+MS5opQ+Dh8rOp44FNGDk7VlDdpTc8Q8/AaDbYsET8vUr45idwmnrst3MxDMB15gmNkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187749; c=relaxed/simple;
	bh=15ptzpTNCYjUuE/sqhS3/SOfF79oMO6iooTT2u8FgUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kw0TJOu4rGch7aHomeCJWF7adMcDQUOku+bDcG8cDerklh0/CbcGKhtU7bhl2AWBG6fewceiewah4aBcWqmVI4qRKQal94V1lVP32c6/kvHbWMOO+1slwxSq5C9T79y4pElu0Z0Vz7k19bcAODMETA82BtcHGprGgasl+5tcBD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ImiNr2gK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465A57I3015420;
	Fri, 5 Jul 2024 13:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=oDhBULGS9XoU/mAg66Ji2xywsUW0Gg3CLtt59wPJDRA=; b=Im
	iNr2gKIFJ/avEpapwfRxw9wAbeIlfcLvR05JJGB4cw9ZKpLbCl+IXz5zq1k/QCNo
	csbnv8DfbYikjoyOpuSgtwBUNn0nP8hr+U8FN+DsBwrZKX7No23UzvgjQMpB9oym
	9088wAYsNn6TIDMrDMsgmlzfCgd3EyY+x0MBWF+4LwihTmRUfHlxVBZITGn/dXE7
	xxuuM6JibnIwoQ/WymFdMwsNBJRbfbbyd/Im5DfEQRtUTonE2L7YqdxFgxNhrXSA
	DbQklbDrpSoKu5gFvp16igcjn0Djd1vUdzTkWhUnylpMvCA/eUcw7f5el5mKJJfs
	oCdJRbQwimTmXMMHZYcA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402996xg5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 13:55:43 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 465DteZE001996;
	Fri, 5 Jul 2024 13:55:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 402bbm4nnp-1;
	Fri, 05 Jul 2024 13:55:40 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 465DtddI001991;
	Fri, 5 Jul 2024 13:55:39 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 465DtdS1001989;
	Fri, 05 Jul 2024 13:55:39 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id DAFF5DA0; Fri,  5 Jul 2024 19:25:38 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: manivannan.sadhasivam@linaro.org, fancer.lancer@gmail.com,
        vkoul@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dmaengine: dw-edma: Add fix to unmask the interrupt bit for HDMA
Date: Fri,  5 Jul 2024 19:25:32 +0530
Message-Id: <1720187733-5380-2-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1720187733-5380-1-git-send-email-quic_msarkar@quicinc.com>
References: <1720187733-5380-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f4wF8L0LpylwAe3m1ftOJnrT_ce2Wh6_
X-Proofpoint-ORIG-GUID: f4wF8L0LpylwAe3m1ftOJnrT_ce2Wh6_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=865
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407050099
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

The current logic is enabling both STOP_INT_MASK and ABORT_INT_MASK
bit. This is apparently masking those particular interrupt rather than
unmasking the same.

This change will reset STOP_INT_MASK and ABORT_INT_MASK bit and unmask
these interrupts.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 10e8f07..88bd652f 100644
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
+		/* Interrupt unmask - done, abort */
+		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) &
+		      ~HDMA_V0_STOP_INT_MASK & ~HDMA_V0_ABORT_INT_MASK;
+		/* Interrupt enable - done, abort */
+		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
 		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
 			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
 		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
-- 
2.7.4


