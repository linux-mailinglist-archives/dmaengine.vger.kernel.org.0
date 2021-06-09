Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706953A0D20
	for <lists+dmaengine@lfdr.de>; Wed,  9 Jun 2021 09:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbhFIHGy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Jun 2021 03:06:54 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8108 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbhFIHGy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Jun 2021 03:06:54 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G0J28721NzYsXt;
        Wed,  9 Jun 2021 15:02:08 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 15:04:41 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 15:04:40 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        "Michal Simek" <michal.simek@xilinx.com>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <allen.lkml@gmail.com>, Yu Kuai <yukuai3@huawei.com>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <libaokun1@huawei.com>,
        <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next v2] dmaengine: zynqmp_dma: Use list_move_tail instead of list_del/list_add_tail
Date:   Wed, 9 Jun 2021 15:13:49 +0800
Message-ID: <20210609071349.1336853-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

 drivers/dma/xilinx/zynqmp_dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 5fecf5aa6e85..97f02f8eb03a 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -434,8 +434,7 @@ static void zynqmp_dma_free_descriptor(struct zynqmp_dma_chan *chan,
 	struct zynqmp_dma_desc_sw *child, *next;
 
 	chan->desc_free_cnt++;
-	list_del(&sdesc->node);
-	list_add_tail(&sdesc->node, &chan->free_list);
+	list_move_tail(&sdesc->node, &chan->free_list);
 	list_for_each_entry_safe(child, next, &sdesc->tx_list, node) {
 		chan->desc_free_cnt++;
 		list_move_tail(&child->node, &chan->free_list);

