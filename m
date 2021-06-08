Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212D139EC85
	for <lists+dmaengine@lfdr.de>; Tue,  8 Jun 2021 05:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhFHDCg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Jun 2021 23:02:36 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3093 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhFHDCf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Jun 2021 23:02:35 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzZcR0JkgzWtVM;
        Tue,  8 Jun 2021 10:55:51 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 11:00:40 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 11:00:39 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        "Michal Simek" <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Shravya Kumbham <shravya.kumbham@xilinx.com>,
        Matthew Murrian <matthew.murrian@goctsi.com>,
        Romain Perier <romain.perier@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Allen Pais <allen.lkml@gmail.com>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] dmaengine: xilinx_dma: Use list_move_tail instead of list_del/list_add_tail
Date:   Tue, 8 Jun 2021 11:09:05 +0800
Message-ID: <20210608030905.2818831-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Using list_move_tail() instead of list_del() + list_add_tail().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 75c0b8e904e5..77022ef05ac5 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1411,8 +1411,7 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 
 	chan->desc_submitcount++;
 	chan->desc_pendingcount--;
-	list_del(&desc->node);
-	list_add_tail(&desc->node, &chan->active_list);
+	list_move_tail(&desc->node, &chan->active_list);
 	if (chan->desc_submitcount == chan->num_frms)
 		chan->desc_submitcount = 0;
 

