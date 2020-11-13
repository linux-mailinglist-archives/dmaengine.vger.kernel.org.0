Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6818D2B18DF
	for <lists+dmaengine@lfdr.de>; Fri, 13 Nov 2020 11:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgKMKQo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Nov 2020 05:16:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33748 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMKQo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Nov 2020 05:16:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ADA9Sjk143006;
        Fri, 13 Nov 2020 10:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=cfFkbwO4n7/hA0Zrtzj7joxsa8P/uEHYLoV2Ks+djZ4=;
 b=MHO2RcT1PHx3O+4BfGgzYXcNNF7bs5xzA249tJsJ1d58Hl5fEn+J09wc2R0wpfCsFL0Z
 39hNxNV0EDgM5Rc26lkHVXmvY8luP+XLqjRQ870Yhd8+TbYd8JJLlhH0/2i50yYpww4m
 XQNPFZuoK5GC3WKwdPK8RrNYjBX7dMrO+3h4pfv8yR4B8+h8Oyft4m7cu7h6igr+n9Dc
 wPikhp7K9e6zMvCFOlbtwvkvSKVECkVnmwCwkoD74+lWmSDEjRgKjcnTC1nqkNqC1+Bc
 vyM1Wo99QFjqzVqB8CSg1D2m/1uk2sUCaZN3RFC6glXzr02gzxbM2XDiquRv2EBzJ+9Z Zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34p72f00bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 10:16:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ADABN89097157;
        Fri, 13 Nov 2020 10:16:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34p55stj88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 10:16:39 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0ADAGct5030571;
        Fri, 13 Nov 2020 10:16:38 GMT
Received: from mwanda (/10.175.206.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Nov 2020 02:16:38 -0800
Date:   Fri, 13 Nov 2020 13:16:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: fix error codes in channel_register()
Message-ID: <20201113101631.GE168908@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=2 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130061
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The error codes were not set on some of these error paths.

Also the error handling was more confusing than it needed to be so I
cleaned it up and shuffled it around a bit.

Fixes: d2fb0a043838 ("dmaengine: break out channel registration")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/dma/dmaengine.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 7974fa0400d8..962cbb5e5f7f 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1039,16 +1039,15 @@ static int get_dma_id(struct dma_device *device)
 static int __dma_async_device_channel_register(struct dma_device *device,
 					       struct dma_chan *chan)
 {
-	int rc = 0;
+	int rc;
 
 	chan->local = alloc_percpu(typeof(*chan->local));
 	if (!chan->local)
-		goto err_out;
+		return -ENOMEM;
 	chan->dev = kzalloc(sizeof(*chan->dev), GFP_KERNEL);
 	if (!chan->dev) {
-		free_percpu(chan->local);
-		chan->local = NULL;
-		goto err_out;
+		rc = -ENOMEM;
+		goto err_free_local;
 	}
 
 	/*
@@ -1061,7 +1060,8 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	if (chan->chan_id < 0) {
 		pr_err("%s: unable to alloc ida for chan: %d\n",
 		       __func__, chan->chan_id);
-		goto err_out;
+		rc = chan->chan_id;
+		goto err_free_dev;
 	}
 
 	chan->dev->device.class = &dma_devclass;
@@ -1082,9 +1082,10 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	mutex_lock(&device->chan_mutex);
 	ida_free(&device->chan_ida, chan->chan_id);
 	mutex_unlock(&device->chan_mutex);
- err_out:
-	free_percpu(chan->local);
+ err_free_dev:
 	kfree(chan->dev);
+ err_free_local:
+	free_percpu(chan->local);
 	return rc;
 }
 
-- 
2.28.0

