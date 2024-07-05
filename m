Return-Path: <dmaengine+bounces-2634-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21997928A38
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 15:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14A2286EEC
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1881154BEE;
	Fri,  5 Jul 2024 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gefagsm6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F315EFAA;
	Fri,  5 Jul 2024 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187753; cv=none; b=C+Xs3kCu3HQD8k5mdBrD9jeGw5G6PLJ9AMgFEel/X+51m7JgqTzXbbdmoyKu0gXNyHFKBCHkFsoeqzu4Pm5Fb5fTUMZwVqVC2Shb0FpuNmi9CCNVFhYWL2yOmtx0lMTflsLybjJXJAfTAzcz5h7Vi1pwW6fwHRABgCN6q7Iakm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187753; c=relaxed/simple;
	bh=ONe2Io9zA6anNvzEJ7HXnYtdSbcXkw9iKrk4SRs4/aA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cARRnIpKeBJEM+kQ3+A8OpS0bCCRKXqpUM+0O9iIwkixmdEClSzoRf1w1hecZ6Fr+KhtSOk6tvzPUogPDufs0W/USFwzMKUd4lKLcn9e5qF3RhBO2PqkcZVqf0+5cxmdcYBRHnJJaOV8aSfgAMwyYQeXXDo6qhWIk3VhKQ+ZMqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gefagsm6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4657wwRY019819;
	Fri, 5 Jul 2024 13:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=9rwoRY+YziQMgYzn0R1tmb6AOIowVXemGfCfHzN2K4k=; b=ge
	fagsm6tCxjYTqqGkDqQh87MZ/4ghTIUVNKLKSNy3R7Ww0Kr90eyoaS2t+zpi3BhJ
	PI+Jnb/Lqp5uK00PlZRWjmKgxt2K4DP9oc22pJy5uB4deVFeCwSeNfrO29I+ehZg
	jAhqq4rRq+8wG20yX+7nQUztud2+29r96sjiCmOlg0yjAVXLtJAZtI92iEJqhey4
	MvxNW+f+7oD0TJnvVidAuvs0oD3Z/t1dKUofIM9nsmv5CwrEOahsO2BilHPsh//T
	mRxAT4emWqXfyvzBAp3BMZInLGD8ZVbtzipUCVytX9uk3zB1SnG+OAbQ56sTihW0
	jWDYdSzZzgWyqsmniEaA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406cww95et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 13:55:44 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 465DtecZ002001;
	Fri, 5 Jul 2024 13:55:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 402bbm4nnv-1;
	Fri, 05 Jul 2024 13:55:41 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 465Dte00002002;
	Fri, 5 Jul 2024 13:55:40 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 465Dte3K001999;
	Fri, 05 Jul 2024 13:55:40 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id CD4D8DA8; Fri,  5 Jul 2024 19:25:39 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: manivannan.sadhasivam@linaro.org, fancer.lancer@gmail.com,
        vkoul@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] dmaengine: dw-edma: Add change to remove watermark interrupt enablement
Date: Fri,  5 Jul 2024 19:25:33 +0530
Message-Id: <1720187733-5380-3-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1720187733-5380-1-git-send-email-quic_msarkar@quicinc.com>
References: <1720187733-5380-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oYrabfRwndClpqDvt_q8XNUmfPbyLvOK
X-Proofpoint-GUID: oYrabfRwndClpqDvt_q8XNUmfPbyLvOK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxlogscore=767 lowpriorityscore=0 mlxscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407050099
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

DW_HDMA_V0_LIE and DW_HDMA_V0_RIE are initialized as BIT(3) and BIT(4)
respectively in dw_hdma_control enum. But as per HDMA register these
bits are corresponds to LWIE and RWIE bit i.e local watermark interrupt
enable and remote watermarek interrupt enable. In linked list mode LWIE
and RWIE bits only enable the local and remote watermark interrupt.

As we are not handling watermark interruprt so removing watermark
interrupt enablement logic to avoid unnecessary watermark interrupt
event.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 88bd652f..aaf2e27 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -197,23 +197,13 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	struct dw_edma_burst *child;
 	struct dw_edma_chan *chan = chunk->chan;
 	u32 control = 0, i = 0;
-	int j;
 
 	if (chunk->cb)
 		control = DW_HDMA_V0_CB;
 
-	j = chunk->bursts_alloc;
-	list_for_each_entry(child, &chunk->burst->list, list) {
-		j--;
-		if (!j) {
-			control |= DW_HDMA_V0_LIE;
-			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-				control |= DW_HDMA_V0_RIE;
-		}
-
+	list_for_each_entry(child, &chunk->burst->list, list)
 		dw_hdma_v0_write_ll_data(chunk, i++, control, child->sz,
 					 child->sar, child->dar);
-	}
 
 	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
 	if (!chunk->cb)
-- 
2.7.4


