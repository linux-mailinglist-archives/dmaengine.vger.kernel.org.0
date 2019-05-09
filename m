Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2E518828
	for <lists+dmaengine@lfdr.de>; Thu,  9 May 2019 12:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfEIKJw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 May 2019 06:09:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33606 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfEIKJw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 May 2019 06:09:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49A403B169430;
        Thu, 9 May 2019 10:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=y2XrLzeF6CCeBorYFGl9AOutvofXs1S2ehKpPUYXpY8=;
 b=dDtFTFcuR9rplcWZMTVIc3Yhy9FiiDu1tXR+3revVazzWKLcvBdtFi0M7iXhea3gLOSf
 6wC3C9A9v6BruwkoNpvPePAYBwV7Plj/1htiWpwJcY6W5efKBYjGdQwClaviVZpHVaLK
 duDy17PDWJbwV1knFxp/NvEIUzwwtgdsd2SjJLFKAL0+IxIxMJJa1Bvp/V1tqgVF7xtS
 eWPyOKDnKkp1Sgws0sCtz7Wi4hR78J2Wlhr9EaD3BN9pn3A6//7WxMB7JdznEWHLzBcM
 W10pHJOocrTGI4W4SmFNoVrUBp3QNW4nsJq8G7d1Av2kVqox5YWxd2+TinbIislyK8RE Yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2s94b11rg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 10:09:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49A7wkv181073;
        Thu, 9 May 2019 10:09:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2sagyv5j37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 10:09:32 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x49A9U0p002987;
        Thu, 9 May 2019 10:09:31 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 03:09:30 -0700
Date:   Thu, 9 May 2019 13:09:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shun-Chih Yu <shun-chih.yu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: mediatek-cqdma: sleeping in atomic context
Message-ID: <20190509100923.GA7024@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090062
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090062
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The mtk_cqdma_poll_engine_done() function takes a true/false parameter
where true means it's called from atomic context.  There are a couple
places where it was set to false but it's actually in atomic context
so it should be true.

All the callers for mtk_cqdma_hard_reset() are holding a spin_lock and
in mtk_cqdma_free_chan_resources() we take a spin_lock before calling
the mtk_cqdma_poll_engine_done() function.

Fixes: b1f01e48df5a ("dmaengine: mediatek: Add MediaTek Command-Queue DMA controller for MT6765 SoC")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
The "atomic" parameter is always true so the temptation was to just
remove it entirely.

 drivers/dma/mediatek/mtk-cqdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 814853842e29..723b11c190b3 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -225,7 +225,7 @@ static int mtk_cqdma_hard_reset(struct mtk_cqdma_pchan *pc)
 	mtk_dma_set(pc, MTK_CQDMA_RESET, MTK_CQDMA_HARD_RST_BIT);
 	mtk_dma_clr(pc, MTK_CQDMA_RESET, MTK_CQDMA_HARD_RST_BIT);
 
-	return mtk_cqdma_poll_engine_done(pc, false);
+	return mtk_cqdma_poll_engine_done(pc, true);
 }
 
 static void mtk_cqdma_start(struct mtk_cqdma_pchan *pc,
@@ -671,7 +671,7 @@ static void mtk_cqdma_free_chan_resources(struct dma_chan *c)
 		mtk_dma_set(cvc->pc, MTK_CQDMA_FLUSH, MTK_CQDMA_FLUSH_BIT);
 
 		/* wait for the completion of flush operation */
-		if (mtk_cqdma_poll_engine_done(cvc->pc, false) < 0)
+		if (mtk_cqdma_poll_engine_done(cvc->pc, true) < 0)
 			dev_err(cqdma2dev(to_cqdma_dev(c)), "cqdma flush timeout\n");
 
 		/* clear the flush bit and interrupt flag */
-- 
2.18.0

