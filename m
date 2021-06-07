Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0839C39D33B
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jun 2021 05:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhFGDDw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 6 Jun 2021 23:03:52 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4328 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhFGDDv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 6 Jun 2021 23:03:51 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FyyhQ1Jsvz1BJnL;
        Mon,  7 Jun 2021 10:57:10 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 11:01:58 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 7 Jun 2021 11:01:58 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <vkoul@kernel.org>, <mripard@kernel.org>, <wens@csie.org>,
        <jernej.skrabec@gmail.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] dmaengine: sun4i: Use list_move_tail instead of list_del/list_add_tail
Date:   Mon, 7 Jun 2021 11:20:35 +0800
Message-ID: <1623036035-30614-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Using list_move_tail() instead of list_del() + list_add_tail().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/dma/sun4i-dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index e8b6633..93f1645 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -1042,9 +1042,8 @@ static irqreturn_t sun4i_dma_interrupt(int irq, void *dev_id)
 			 * Move the promise into the completed list now that
 			 * we're done with it
 			 */
-			list_del(&vchan->processing->list);
-			list_add_tail(&vchan->processing->list,
-				      &contract->completed_demands);
+			list_move_tail(&vchan->processing->list,
+				       &contract->completed_demands);
 
 			/*
 			 * Cyclic DMA transfers are special:
-- 
2.6.2

