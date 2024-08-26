Return-Path: <dmaengine+bounces-2965-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 060A195F10B
	for <lists+dmaengine@lfdr.de>; Mon, 26 Aug 2024 14:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890001F22008
	for <lists+dmaengine@lfdr.de>; Mon, 26 Aug 2024 12:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E88192D64;
	Mon, 26 Aug 2024 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NN4pM6e7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81A1922C5;
	Mon, 26 Aug 2024 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674280; cv=none; b=Xme7y8mlYpCVowWshMbKoe7siQDmufEUV97VLTE6miH/7DAjlC3bTRcNbmlznob6mDmZxEb1ofBX1fubr/pCswY7+VZ60R0p893IYGvsidPoDpFZwm3jhXrGWJ1yQXuPFpoyRAw3nT73amIDS8IYtL9Hcaoryughba6qo1cu19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674280; c=relaxed/simple;
	bh=2LR4QjIA/PkoKFG4ghzl7hwL4NmodTxNSXJuhMxmrVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z7WNwSS2c1G0KNB2dW/jaZydJIcJqjYuSELWsN3x5FC/stAcb7XruNCbwqMWAuXIfgYBO+IDxKszuphAPwo6nOXVwcSg+/P8PTkm26hMDzXiVqsihlM4x3gK7z3xEvgavMcxKoS49ksxiHfWpsasEhX6RrJCeDwD8fnMnG1PFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NN4pM6e7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q8MOnP017688;
	Mon, 26 Aug 2024 12:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=X4BCi4GwH41+U+y5D6WUKqWUYYIsRuvsCMc7bjn8fTk=; b=NN
	4pM6e7pcboVLpH6Wb6pTThprZaTcxU0+vfjPtZZouSAe0wiTHvjp0EcdopXjsrcr
	DjVjJNd2v02PXPM3UTvdKf/7VQ61D6CjN4QWpU0UFuVYbNmhr/5/hFjIvqhdBVOj
	gVIWPgVAcSYgld0U1D7pnQw9cLlIl3uUcqGKa/v3Wab+ZbMw+TgNLiXeUVwu70mi
	ryZ150DCOK51W/+wvxdkzVg10Qcs65tC3Lj61ZXdNYGEWKiYFu2R0AArBy4krlr3
	zKRWzZ4K95hxXdF65DV9o/f44FB77dnLc0kc4ufQtw6ySRKPt/yveQbqYXJe/mW5
	U8s9n5tJ035+4Ts73fgw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4179a1uhjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 12:11:10 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47QCB7Mn023402;
	Mon, 26 Aug 2024 12:11:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4178kkjan7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 26 Aug 2024 12:11:07 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47QCB7nU023396;
	Mon, 26 Aug 2024 12:11:07 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 47QCB75O023393;
	Mon, 26 Aug 2024 12:11:07 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 66C5FB63; Mon, 26 Aug 2024 17:41:06 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: manivannan.sadhasivam@linaro.org, fancer.lancer@gmail.com,
        vkoul@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>, stable@vger.kernel.org,
        Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] dmaengine: dw-edma: Do not enable watermark interrupts for HDMA
Date: Mon, 26 Aug 2024 17:41:01 +0530
Message-Id: <1724674261-3144-3-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1724674261-3144-1-git-send-email-quic_msarkar@quicinc.com>
References: <1724674261-3144-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CWL01elRRLT20lk9S5NS2KdGYT3U3BpE
X-Proofpoint-ORIG-GUID: CWL01elRRLT20lk9S5NS2KdGYT3U3BpE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_08,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=467
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408260095
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

Since the watermark interrupts are not used but enabled, this leads to
spurious interrupts getting generated. So remove the code that enables
them to avoid generating spurious watermark interrupts.

And also rename DW_HDMA_V0_LIE to DW_HDMA_V0_LWIE and DW_HDMA_V0_RIE to
DW_HDMA_V0_RWIE as there is no LIE and RIE bits in HDMA and those bits
are corresponds to LWIE and RWIE bits.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
cc: stable@vger.kernel.org
Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 2addaca..e3f8db4 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -17,8 +17,8 @@ enum dw_hdma_control {
 	DW_HDMA_V0_CB					= BIT(0),
 	DW_HDMA_V0_TCB					= BIT(1),
 	DW_HDMA_V0_LLP					= BIT(2),
-	DW_HDMA_V0_LIE					= BIT(3),
-	DW_HDMA_V0_RIE					= BIT(4),
+	DW_HDMA_V0_LWIE					= BIT(3),
+	DW_HDMA_V0_RWIE					= BIT(4),
 	DW_HDMA_V0_CCS					= BIT(8),
 	DW_HDMA_V0_LLE					= BIT(9),
 };
@@ -195,25 +195,14 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_burst *child;
-	struct dw_edma_chan *chan = chunk->chan;
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


