Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024B53A0D94
	for <lists+dmaengine@lfdr.de>; Wed,  9 Jun 2021 09:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbhFIHUu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Jun 2021 03:20:50 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5465 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbhFIHUt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Jun 2021 03:20:49 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G0JLD0FbszZfb0;
        Wed,  9 Jun 2021 15:16:04 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 15:18:53 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 15:18:53 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>, <dmaengine@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next v2] dmaengine: fsl-dpaa2-qdma: Use list_move_tail instead of list_del/list_add_tail
Date:   Wed, 9 Jun 2021 15:28:02 +0800
Message-ID: <20210609072802.1368785-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Using list_move_tail() instead of list_del() + list_add_tail().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V1->V2:
	CC mailist

 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
index 4ae057922ef1..a0358f2c5cbb 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
@@ -291,9 +291,8 @@ static void dpaa2_qdma_issue_pending(struct dma_chan *chan)
 
 		err = dpaa2_io_service_enqueue_fq(NULL, dpaa2_chan->fqid, fd);
 		if (err) {
-			list_del(&dpaa2_comp->list);
-			list_add_tail(&dpaa2_comp->list,
-				      &dpaa2_chan->comp_free);
+			list_move_tail(&dpaa2_comp->list,
+				       &dpaa2_chan->comp_free);
 		}
 	}
 err_enqueue:
@@ -626,8 +625,7 @@ static void dpaa2_qdma_free_desc(struct virt_dma_desc *vdesc)
 	dpaa2_comp = to_fsl_qdma_comp(vdesc);
 	qchan = dpaa2_comp->qchan;
 	spin_lock_irqsave(&qchan->queue_lock, flags);
-	list_del(&dpaa2_comp->list);
-	list_add_tail(&dpaa2_comp->list, &qchan->comp_free);
+	list_move_tail(&dpaa2_comp->list, &qchan->comp_free);
 	spin_unlock_irqrestore(&qchan->queue_lock, flags);
 }
 

