Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE5A2DBCB6
	for <lists+dmaengine@lfdr.de>; Wed, 16 Dec 2020 09:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgLPIcj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Dec 2020 03:32:39 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44992 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgLPIcj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Dec 2020 03:32:39 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG8TjCj030139;
        Wed, 16 Dec 2020 08:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=/pwmgfT99CRqc8VXFKgknxtER8IjPbFB9frS6oAOPyI=;
 b=uCozIkc+f69BHiaOqyh6SS98aXDAZcxKLOH/0dQg0bbYzdtmYCP8djvZb4xuVCdVPI5e
 68d4rbthI4kxxgdcC5n5J4BkFf2GZAMwpl8dB6PPfucpEVKddYxpUHlNZAvpe2XlypNP
 dS2KEhfyaSJ26PmAonu2DxfHmkS2sNzdM1jdyKzbk4Bral0qrpL4atjVhhnZYvL+XCzG
 niZxbBiNA5r0RQ4ac+aUcPEsBwwVvYQYrWwFIBH7WPqvHwlZHcFtPCXwHKNKu+Cv1fCU
 dJ2OXP5LDzSYMhXv8yuFPQyvjSxq0Yx1cIK6J2XBzIzj0q1MfC5clM8UwRspbA8uuSXw oA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35cntm6t59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Dec 2020 08:31:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG8LAhF076796;
        Wed, 16 Dec 2020 08:29:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 35e6jsdrmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 08:29:54 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BG8Tr2X013623;
        Wed, 16 Dec 2020 08:29:53 GMT
Received: from mwanda (/10.175.200.55)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Dec 2020 00:29:53 -0800
Date:   Wed, 16 Dec 2020 11:29:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: off by one in cleanup code
Message-ID: <X9nFeojulsNqUSnG@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160054
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The clean up is off by one so this will start at "i" and it should start
with "i - 1" and then it doesn't unregister the zeroeth elements in the
array.

Fixes: c52ca478233c ("dmaengine: idxd: add configuration component of driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/dma/idxd/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 266423a2cabc..4dbb03c545e4 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -434,7 +434,7 @@ int idxd_register_driver(void)
 	return 0;
 
 drv_fail:
-	for (; i > 0; i--)
+	while (--i >= 0)
 		driver_unregister(&idxd_drvs[i]->drv);
 	return rc;
 }
@@ -1840,7 +1840,7 @@ int idxd_register_bus_type(void)
 	return 0;
 
 bus_err:
-	for (; i > 0; i--)
+	while (--i >= 0)
 		bus_unregister(idxd_bus_types[i]);
 	return rc;
 }
-- 
2.29.2

