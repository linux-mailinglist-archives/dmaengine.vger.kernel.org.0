Return-Path: <dmaengine+bounces-2727-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC4093A133
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2024 15:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589BB281EDE
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2024 13:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F339F15382C;
	Tue, 23 Jul 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dqvnJXTI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22994153800;
	Tue, 23 Jul 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740795; cv=none; b=GOQWBiF8B+Hxa6g/fzAGBXiTrDH/CukHpnOADt/k0+MqUgByFA9doTvzeBNyDA2LmwHW5MEFjcFdYBm1eX9eKkYQdun6NOD5bpeav8SgfkgtIXY60sTDBG9iV8Ep7VGV1pUmJrxUanF3EFBy2S8wuPnAMPCvdPbYmZi7oZjFYdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740795; c=relaxed/simple;
	bh=IMr7YJGbOdix0fpteQaCKeaWLy/Ja8V7oLgGw6GKR8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XyxoPYnrBKMkUO7UpcJtRZ938kraqVlO2bRw4fZiyQ8dvAC9jsHCKQ4inpOkBlgEGX1gUbh4Q2iAf8fb1U0jeL+3Y14V8/8wYTdpQeI61eJHd6EMIaFc9Ko7oJr2RuxDBTvEW2gLS5JSXAk9+1KeykZQa6evpR27WaTp/vl4MaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dqvnJXTI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NBXL9C010043;
	Tue, 23 Jul 2024 13:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=UJ1TFD8YzJbPs1iEy88g5SWQ2FliNIBdUSwHTKmzLIw=; b=dq
	vnJXTI1ZYDtRvunhlhCB+nrbLLt+X0cK5q3bgTlLXYqhMpNLFW8hrwk6Z+1/UEPY
	yw8nMEughXmKg68I10fnrBMbjSWUaChJ5cm3NqtB6yZsmkMQghaQVgB7IGymhNSw
	d5qPXXOg06w3s/716a5RWz0F5Sr3jfOvjNCGCLs088COibLuguVbCcEhDSdrLP1J
	v2oWVPlCh7C5hXRPITbwUdJhKQgxSIKgwiE9KZxBXEyZZsbvZkSvRoLKsk9hyU7n
	COtgeF/u+NMVBWBe5M+LQ99qaugz+PzpSpAKQ5vwXcZyjWIB9X8Fcc/Br/u1VOdy
	tiyX18UkYMtKxlCtf29Q==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40gurtnhjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 13:19:40 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 46NDJapL019993;
	Tue, 23 Jul 2024 13:19:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 40g6akuxrf-1;
	Tue, 23 Jul 2024 13:19:37 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46NDJaIt019986;
	Tue, 23 Jul 2024 13:19:37 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 46NDJbGm019996;
	Tue, 23 Jul 2024 13:19:37 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 9DD331534; Tue, 23 Jul 2024 18:49:36 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: manivannan.sadhasivam@linaro.org, fancer.lancer@gmail.com,
        vkoul@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        stable@vger.kernel.org, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dmaengine: dw-edma: Do not enable watermark interrupts for HDMA
Date: Tue, 23 Jul 2024 18:49:32 +0530
Message-Id: <1721740773-23181-3-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721740773-23181-1-git-send-email-quic_msarkar@quicinc.com>
References: <1721740773-23181-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z8rzuDKD3ZBDn_skkJwZ2cxvce5QkZL_
X-Proofpoint-ORIG-GUID: z8rzuDKD3ZBDn_skkJwZ2cxvce5QkZL_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_02,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=442
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230095
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
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index fa89b3a..9ad2e28 100644
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


