Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9EA3770A4
	for <lists+dmaengine@lfdr.de>; Sat,  8 May 2021 10:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhEHIVy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 8 May 2021 04:21:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42358 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHIVy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 8 May 2021 04:21:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1488K6DW162922;
        Sat, 8 May 2021 08:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=SmqUNYMF18v5K/seR3tr0Jr4Y3EvbY6KMtwd/ZlcZIk=;
 b=UV1xDWZbcTfVvvYqOcKQ8PcFLztPH1HPOzZUWYAaAk6ia+BHBdkZJsdHXQD+9TFPUze2
 UQUT+tiOOoDvg80wk7+B7kbjYkbGZaOfYdh+cVPlHr76kGA0AoEaq6QFqTiPfHYiMZuQ
 MZNi4KKasPXRHqbCwyRynugtiDL2XW4/x/RnVz86S3FHlGWSBSobYtntp7Ok+n0tIGXV
 GBkcH8fH1DS+uATavPyp0QeXv63Pb8sM+G2wf1XtkH3Pva4Qwg7B+i/SR91LBNkU6XYB
 6Yp9Ew8KYVMQ7Gyk4cWIxKwF0FDs0ZHlmOOt5SVKNFfvEygPIin5q9rFAnqzp7L4jXia qA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38dk9n84s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 May 2021 08:20:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1488KTg9183191;
        Sat, 8 May 2021 08:20:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38djf0m9c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 May 2021 08:20:49 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1488Kmcd183669;
        Sat, 8 May 2021 08:20:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 38djf0m9b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 May 2021 08:20:48 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1488Kl2e011056;
        Sat, 8 May 2021 08:20:47 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 08 May 2021 01:20:47 -0700
Date:   Sat, 8 May 2021 11:20:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: double free of devm_ memory on probe error
Message-ID: <YJZJ2Z5CEqQC5s+1@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: CDHINgAlMDYNf3x3Oa2koifqWwmlCqGE
X-Proofpoint-GUID: CDHINgAlMDYNf3x3Oa2koifqWwmlCqGE
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9977 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105080062
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The "idxd->int_handles" pointer is allocated with devm_kcalloc() so
freeing it here leads to a double free.  Delete the kfree().

Fixes: eb15e7154fbf ("dmaengine: idxd: add interrupt handle request and release support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/dma/idxd/init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 2a926bef87f2..b65d28895955 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -318,7 +318,7 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 
 	rc = idxd_setup_wqs(idxd);
 	if (rc < 0)
-		goto err_wqs;
+		return rc;
 
 	rc = idxd_setup_engines(idxd);
 	if (rc < 0)
@@ -345,8 +345,6 @@ static int idxd_setup_internals(struct idxd_device *idxd)
  err_engine:
 	for (i = 0; i < idxd->max_wqs; i++)
 		put_device(&idxd->wqs[i]->conf_dev);
- err_wqs:
-	kfree(idxd->int_handles);
 	return rc;
 }
 
-- 
2.30.2

