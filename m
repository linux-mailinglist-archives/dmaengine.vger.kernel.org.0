Return-Path: <dmaengine+bounces-2854-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD048950636
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2024 15:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578281F217E2
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2024 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843B919CCEB;
	Tue, 13 Aug 2024 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ViDZakoy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612A91E517;
	Tue, 13 Aug 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554956; cv=none; b=Ajl+97JGF0Br1r7GxoZ5dXjldzH4rWe0CyvNAxLUzJnd/8T5yEawKDktTnuXZe9+LmIrKe142Eqp9b7k50q7deWfijMnSYl2kaMIKIJMbtEOEBx/yW421h1TJG1puZTUdI+Ydd36Tf9ZobEan3kbsYpHU/mtiAbGYUeb9MsGmd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554956; c=relaxed/simple;
	bh=YvKcJwx5k/w9Z5RN8WQLKZDIz67nb4HyPtqIwVQHDcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fkUdOM2yPHMapvkbRuyz04hsC9YIYlXex6kT/k/GRRwOBQXvbUNa5E81bod9WeQ5WzeLLkqFsMos3FKKxHYwKLD1EDa0qw+0dD8yaj0SfaXdqGB/pmcfkyguF7kOfFOJSAuZcm8erNESyf5RbHn/vB6H+XqfmEIwiIM6nF0NcPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ViDZakoy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DCAQSP008223;
	Tue, 13 Aug 2024 13:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=MJ3frZLq3vX5/UZq5IN2RIsYYUFupgBsQWqaDcukM7s=; b=Vi
	DZakoys/maHmY4iCzIUHUZi0/IuNB9/L5lq9jzEshfUEhg06bh4b5W8lbOe1y+Zx
	Qrohr9eNAt7hAa6EMQ0PPKf/byJM5SUaaXerANRTQZ+I6X+RFv3WRTekU/59SI/l
	4Y6OQOnDW1K2tSZkQk8r4WUBks4uQnBiCZDVUYJG7WtNstQCOIG9Ln+LvksnEJkT
	bIte599mj6CKNK3/1Qmr87hvqV5FA0nlikz3Tdh4btXJE74N6Y0x0RZ/yNQbA5zS
	DgAxmEFKXr+pThWV2PRePFogw7bpkbbqtEYMLX7fSdbktwx7ePGPlJhcupk35xOz
	m8JUDvggR5u8yRhVpW1Q==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x15e7vq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 13:15:47 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47DDFihm001360;
	Tue, 13 Aug 2024 13:15:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 40xkmgxsys-1;
	Tue, 13 Aug 2024 13:15:44 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47DDFhrM001353;
	Tue, 13 Aug 2024 13:15:43 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 47DDFhsM001352;
	Tue, 13 Aug 2024 13:15:43 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 23654974; Tue, 13 Aug 2024 18:45:43 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: manivannan.sadhasivam@linaro.org, fancer.lancer@gmail.com,
        vkoul@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>, stable@vger.kernel.org,
        Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dmaengine: dw-edma: Do not enable watermark interrupts for HDMA
Date: Tue, 13 Aug 2024 18:45:38 +0530
Message-Id: <1723554938-23852-3-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1723554938-23852-1-git-send-email-quic_msarkar@quicinc.com>
References: <1723554938-23852-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ef0ibwGKKf_BijZhsu5dckk5sDsJiU0P
X-Proofpoint-ORIG-GUID: ef0ibwGKKf_BijZhsu5dckk5sDsJiU0P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_04,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=465
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130096
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
index a0aabdd..c4c73c4 100644
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


