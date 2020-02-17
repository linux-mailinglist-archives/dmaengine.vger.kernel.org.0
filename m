Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81FCA1614D9
	for <lists+dmaengine@lfdr.de>; Mon, 17 Feb 2020 15:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgBQOlP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Feb 2020 09:41:15 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48768 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgBQOlP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Feb 2020 09:41:15 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01HEd51w036740;
        Mon, 17 Feb 2020 14:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=lNSy4MY7tJkmA0otKbFVvoWD69fUmaOTKq9HL2N/k5g=;
 b=n0caQ1wrumvJUiuD2y/EgPAFj7yjuJJ68fr0zOq75KYU4eLcocxPk5kdKtETTWKQ1Uqc
 U/+0ot+TG6ZHKh5CMv69aRrmZ22ZOe/q/IoXTgecPUBT0LoPUrd1g/DCW1dNW7Btyzx1
 kh3cuttFsWYrsErClKBKre+PRcFBg8s6MPBU5xIQX30mmZGFnSM3TS2uYsGQLFcIA7SN
 8G+6pFR/JJ1Lt1m5keKtnUpwoz4J7nIf82472FsBI9TAFYxZmbHAA+s+Yge1izFCrloL
 KdItVdNrD4dhsrSvPNahgPUQEeiCmff93wfbKLXzCVMfkCtYow62f7awb0jnpLBmohqN JA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2y68kqrks4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 14:41:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01HEbfSe125405;
        Mon, 17 Feb 2020 14:41:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2y6tejawd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 14:41:01 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01HEewYl015006;
        Mon, 17 Feb 2020 14:40:58 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Feb 2020 06:40:57 -0800
Date:   Mon, 17 Feb 2020 17:40:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Linus Walleij <linus.walleij@stericsson.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: coh901318: Fix a double lock bug in
 dma_tc_handle()
Message-ID: <20200217144050.3i4ymbytogod4ijn@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9533 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=928 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002170121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9533 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=985 malwarescore=0 priorityscore=1501
 clxscore=1011 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002170121
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The caller is already holding the lock so this will deadlock.

Fixes: 0b58828c923e ("DMAENGINE: COH 901 318 remove irq counting")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This is the second double lock bug found using static analysis.  The
previous one was commit 627469e4445b ("dmaengine: coh901318: Fix a
double-lock bug").

The fact that this has been broken for ten years suggests that no one
has the hardware.

 drivers/dma/coh901318.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index e51d836afcc7..1092d4ce723e 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -1947,8 +1947,6 @@ static void dma_tc_handle(struct coh901318_chan *cohc)
 		return;
 	}
 
-	spin_lock(&cohc->lock);
-
 	/*
 	 * When we reach this point, at least one queue item
 	 * should have been moved over from cohc->queue to
@@ -1969,8 +1967,6 @@ static void dma_tc_handle(struct coh901318_chan *cohc)
 	if (coh901318_queue_start(cohc) == NULL)
 		cohc->busy = 0;
 
-	spin_unlock(&cohc->lock);
-
 	/*
 	 * This tasklet will remove items from cohc->active
 	 * and thus terminates them.
-- 
2.11.0

