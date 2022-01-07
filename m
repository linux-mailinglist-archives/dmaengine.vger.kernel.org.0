Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01800487081
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jan 2022 03:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344789AbiAGCfX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jan 2022 21:35:23 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30260 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344761AbiAGCfV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jan 2022 21:35:21 -0500
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JVS3m0vVjzbjnJ;
        Fri,  7 Jan 2022 10:34:44 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 10:35:19 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 10:35:19 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>,
        <vkoul@kernel.org>
Subject: [PATCH -next] dmaengine: at_xdmac: Fix missing unlock in at_xdmac_tasklet()
Date:   Fri, 7 Jan 2022 10:40:47 +0800
Message-ID: <20220107024047.1051915-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the missing unlock before return from at_xdmac_tasklet().

Fixes: e77e561925df ("dmaengine: at_xdmac: Fix race over irq_status")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/dma/at_xdmac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index a1da2b4b6d73..1476156af74b 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1681,8 +1681,10 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 		__func__, atchan->irq_status);
 
 	if (!(atchan->irq_status & AT_XDMAC_CIS_LIS) &&
-	    !(atchan->irq_status & error_mask))
+	    !(atchan->irq_status & error_mask)) {
+		spin_unlock_irq(&atchan->lock);
 		return;
+	}
 
 	if (atchan->irq_status & error_mask)
 		at_xdmac_handle_error(atchan);
-- 
2.25.1

