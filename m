Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 059171530D6
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2020 13:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBEMdC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Feb 2020 07:33:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57254 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgBEMdC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Feb 2020 07:33:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015CDQWe030562;
        Wed, 5 Feb 2020 12:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=1vnf/xgw4kqXc7IRy8A9QgU6nxV7YLB/grjPo7sqFho=;
 b=FsnHxU8Br70a5kYGqN/iDp+Y1G5cNNwmHhDtm+K8M3q8jLCbrztd3o89lvyzKuo1whIT
 KwzEIW0jzsaU+o6V5pkxIx1ojVo55vYRvylXZYNmjnXOMaiL8MKrvguLba5HLTpvZTfA
 YE19Tn965M+4uHyLQVk3S9pNT/7372YFdt8ErKaK6xUedIZEb6COe2dUvrZfnkt3FUFr
 wpwp/PDRBQN4NcHqnTqiuzGLSDa6YxMVgOIjg/32ZOp6vixiC3ifVrGhNlQmFsYyrJrd
 EGRVBMIb0c9cWP0/wOkcYn0+EqaScjVFo2b5sY5NDKj9xcM8PFlYfeAcJqPNvau5c9Kp eQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xykbp2q0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 12:32:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015CEQwj144182;
        Wed, 5 Feb 2020 12:32:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xykbrrmkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 12:32:58 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 015CWuiC032025;
        Wed, 5 Feb 2020 12:32:57 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Feb 2020 04:32:56 -0800
Date:   Wed, 5 Feb 2020 15:32:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: Fix error handling in
 idxd_wq_cdev_dev_setup()
Message-ID: <20200205123248.hmtog7qa2eiqaagh@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050100
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We can't call kfree(dev) after calling device_register(dev).  The "dev"
pointer has to be freed using put_device().

Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/dma/idxd/cdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 1d7347825b95..df47be612ebb 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -204,6 +204,7 @@ static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
 	minor = ida_simple_get(&cdev_ctx->minor_ida, 0, MINORMASK, GFP_KERNEL);
 	if (minor < 0) {
 		rc = minor;
+		kfree(dev);
 		goto ida_err;
 	}
 
@@ -212,7 +213,6 @@ static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
 	rc = device_register(dev);
 	if (rc < 0) {
 		dev_err(&idxd->pdev->dev, "device register failed\n");
-		put_device(dev);
 		goto dev_reg_err;
 	}
 	idxd_cdev->minor = minor;
@@ -221,8 +221,8 @@ static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
 
  dev_reg_err:
 	ida_simple_remove(&cdev_ctx->minor_ida, MINOR(dev->devt));
+	put_device(dev);
  ida_err:
-	kfree(dev);
 	idxd_cdev->dev = NULL;
 	return rc;
 }
-- 
2.11.0

