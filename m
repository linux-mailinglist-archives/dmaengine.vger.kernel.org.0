Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889C3308B05
	for <lists+dmaengine@lfdr.de>; Fri, 29 Jan 2021 18:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhA2RJW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Jan 2021 12:09:22 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:65302 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231871AbhA2RIz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Jan 2021 12:08:55 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10TH6Vvd007638;
        Fri, 29 Jan 2021 11:08:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=InbfmcNQ3u+eutYnwP8FnOSnY1mQqECHGcLKmEZ24/s=;
 b=Owh4aZEcpAxX8wm82rBfYBZHF6g7aI8uUnO8ADYgIlcTIvTrKMkIJGfj1IgZSC95/tbA
 gZsqcYnKSpf7q1kyiHGLkVPB94vNru9NNwuat5oPhL9MxuvmCdYgOwYYSZUQJj3VTll7
 KQTXdSeQII6Yu3u5zGktAHKakl6ymaUe2zzPn8ENZG/z1RCNicPN/GZNZn7JINySSpc/
 qJkZUybb4Py/ZyRVRz3AzGNeklbSnCH+5ZOpEZukLkTgSRvSJMfNT/+u5++Ehd24EACY
 Tv4f1dCtFHwWwR3fQ+pfFICNeHXDImakoISiixyuysLad7/2hEhwKkDdRMFeJAAi6wgQ Kw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 368h3u7nxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Jan 2021 11:08:04 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 29 Jan
 2021 17:08:02 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 29 Jan 2021 17:08:02 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.253])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 240B345;
        Fri, 29 Jan 2021 17:08:02 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <michal.simek@xilinx.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] dmaengine: xilinx_dma: Alloc tx descriptors GFP_NOWAIT
Date:   Fri, 29 Jan 2021 17:08:00 +0000
Message-ID: <20210129170800.31857-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 clxscore=1011 mlxlogscore=725 mlxscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101290084
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use GFP_NOWAIT allocation in xilinx_dma_alloc_tx_descriptor().

This is necessary for compatibility with ALSA, which calls
dmaengine_prep_dma_cyclic() from an atomic context.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 22faea653ea8..fb046af9ac53 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -800,7 +800,7 @@ xilinx_dma_alloc_tx_descriptor(struct xilinx_dma_chan *chan)
 {
 	struct xilinx_dma_tx_descriptor *desc;
 
-	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
-- 
2.20.1

