Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5FE82D97CC
	for <lists+dmaengine@lfdr.de>; Mon, 14 Dec 2020 13:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395543AbgLNL7t (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Dec 2020 06:59:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42080 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731284AbgLNL7t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Dec 2020 06:59:49 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BEBoSfj141299;
        Mon, 14 Dec 2020 11:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=rq0xzwZ3je7Zay+cGeew2R6YygWdjh66V9tw7L6ZUOQ=;
 b=G/ZWYuP/Kxpt7/+fFtDl+y/6+w2QUNNDb2gAgG6PaJu3uaeGYjsjfvcFgs1CJYC65kR9
 PQ0RDiCewxUnDrU85ZdpjUwClIoIf42YB/RPsFJXMeqVHqxzxrL3MrO2PhmxE0Wzuybw
 jFYu0MsiGFxdlwvnj+BNrr2+mhSyM6t/XT4v841Zk1N24JfFXmLsbkSWMV2jj3Vfxl73
 Yt8ia6hsCKjLjOCCMFZVXYycZlkmHHNE+1qBYVYzcvtCJSoUrD/9FQrgklk9kThw2Bco
 88cSa+4CmiXJzLfT9zxsYtRSqN1PG7ziANkhPw8ZTv2dqllX2nQQXXLk/Gcs8RkUx/aH Hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 35cntkvre5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Dec 2020 11:59:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BEBt8Bd020614;
        Mon, 14 Dec 2020 11:57:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 35d7ekck0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Dec 2020 11:57:03 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BEBv1jN013401;
        Mon, 14 Dec 2020 11:57:01 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Dec 2020 03:57:01 -0800
Date:   Mon, 14 Dec 2020 14:56:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: dw-edma: Fix use after free in
 dw_edma_alloc_chunk()
Message-ID: <X9dTBFrUPEvvW7qc@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140084
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If the dw_edma_alloc_burst() function fails then we free "chunk" but
it's still on the "desc->chunk->list" list so it will lead to a use
after free.  Also the "->chunks_alloc" count is incremented when it
shouldn't be.

In current kernels small allocations are guaranteed to succeed and
dw_edma_alloc_burst() can't fail so this will not actually affect
runtime.

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Based on static analysis.  Not tested.

 drivers/dma/dw-edma/dw-edma-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b971505b8715..08d71dafa001 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -86,12 +86,12 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 
 	if (desc->chunk) {
 		/* Create and add new element into the linked list */
-		desc->chunks_alloc++;
-		list_add_tail(&chunk->list, &desc->chunk->list);
 		if (!dw_edma_alloc_burst(chunk)) {
 			kfree(chunk);
 			return NULL;
 		}
+		desc->chunks_alloc++;
+		list_add_tail(&chunk->list, &desc->chunk->list);
 	} else {
 		/* List head */
 		chunk->burst = NULL;
-- 
2.29.2

