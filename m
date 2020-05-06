Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A331C6CBC
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2020 11:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgEFJTw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 May 2020 05:19:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3861 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728385AbgEFJTw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 6 May 2020 05:19:52 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id ED36674D501AC1816258;
        Wed,  6 May 2020 17:19:49 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 6 May 2020 17:19:39 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Samuel Zou <zou_wei@huawei.com>
Subject: [PATCH -next] dmaengine: ti: k3-udma: Use PTR_ERR_OR_ZERO() to simplify code
Date:   Wed, 6 May 2020 17:25:46 +0800
Message-ID: <1588757146-38858-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fixes coccicheck warnings:

drivers/dma/ti/k3-udma.c:1294:1-3: WARNING: PTR_ERR_OR_ZERO can be used
drivers/dma/ti/k3-udma.c:1311:1-3: WARNING: PTR_ERR_OR_ZERO can be used
drivers/dma/ti/k3-udma.c:1376:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 drivers/dma/ti/k3-udma.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 0a04174..f5775ca 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1291,10 +1291,8 @@ static int udma_get_tchan(struct udma_chan *uc)
 	}
 
 	uc->tchan = __udma_reserve_tchan(ud, uc->config.channel_tpl, -1);
-	if (IS_ERR(uc->tchan))
-		return PTR_ERR(uc->tchan);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(uc->tchan);
 }
 
 static int udma_get_rchan(struct udma_chan *uc)
@@ -1308,10 +1306,8 @@ static int udma_get_rchan(struct udma_chan *uc)
 	}
 
 	uc->rchan = __udma_reserve_rchan(ud, uc->config.channel_tpl, -1);
-	if (IS_ERR(uc->rchan))
-		return PTR_ERR(uc->rchan);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(uc->rchan);
 }
 
 static int udma_get_chan_pair(struct udma_chan *uc)
@@ -1373,10 +1369,8 @@ static int udma_get_rflow(struct udma_chan *uc, int flow_id)
 	}
 
 	uc->rflow = __udma_get_rflow(ud, flow_id);
-	if (IS_ERR(uc->rflow))
-		return PTR_ERR(uc->rflow);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(uc->rflow);
 }
 
 static void udma_put_rchan(struct udma_chan *uc)
-- 
2.6.2

