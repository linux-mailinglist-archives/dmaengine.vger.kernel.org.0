Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D7912EDC
	for <lists+dmaengine@lfdr.de>; Fri,  3 May 2019 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfECNPY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 May 2019 09:15:24 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52788 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfECNPY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 May 2019 09:15:24 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x43DEPat139648;
        Fri, 3 May 2019 13:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=d49XUlWUS/ecewkjLcZmEWaD2tXdj0+kyjA873JE4hM=;
 b=4G2lnSaLD8X4wRYJ38dijgjZLueSpdU7LYYdGThu52pqBD75fahhJi6c7x7h0b7ksA32
 EWl8O6Jy1wQJdu30G0LHmT5Y3eNw3sgIWqyNJ8CNx1hyk5A1myTHu6G5xOf3B6AHYPkz
 j++flV1QRQAmdu1ZPjyJxyKm72oU8iOu2hXTM1z55OH5Uv2uNAEs7vAdbnVev9/Qx3EE
 OhhGvM1F9K1mL3nbIYAMZwXBXhFAKnvZPlH54MPgTh1drUV2c7LiGJ0+sywVjJN2CAnI
 cN7RfTTYZrnB50SlMBXys7fBN/ucP3OutpglWCVbaU6E565X8heMH40l17MjOUKZcOAW Sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2s6xhypmwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 May 2019 13:15:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x43DDkfT181036;
        Fri, 3 May 2019 13:15:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2s7p8aaxgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 May 2019 13:15:17 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x43DFF1V006149;
        Fri, 3 May 2019 13:15:15 GMT
Received: from mwanda (/196.104.111.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 May 2019 06:15:14 -0700
Date:   Fri, 3 May 2019 16:15:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Barry Song <21cnbao@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: at_xdmac: remove a stray bottom half unlock
Message-ID: <20190503131507.GA1236@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905030083
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905030083
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We switched this code from spin_lock_bh() to vanilla spin_lock() but
there was one stray spin_unlock_bh() that was overlooked.  This
patch converts it to spin_unlock() as well.

Fixes: d8570d018f69 ("dmaengine: at_xdmac: move spin_lock_bh to spin_lock in tasklet")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/dma/at_xdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 06cbe54e4c30..e4ae2ee46d3f 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1655,7 +1655,7 @@ static void at_xdmac_tasklet(unsigned long data)
 		dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
 		if (!desc->active_xfer) {
 			dev_err(chan2dev(&atchan->chan), "Xfer not active: exiting");
-			spin_unlock_bh(&atchan->lock);
+			spin_unlock(&atchan->lock);
 			return;
 		}
 
-- 
2.18.0

