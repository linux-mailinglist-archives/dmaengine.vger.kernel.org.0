Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C0A55F4BD
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jun 2022 06:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiF2D6d (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jun 2022 23:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiF2D62 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jun 2022 23:58:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1271FCE8;
        Tue, 28 Jun 2022 20:58:25 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LXnhK0DMrzkWfc;
        Wed, 29 Jun 2022 11:56:33 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 11:58:20 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 11:58:20 +0800
From:   Jie Hai <haijie1@huawei.com>
To:     <vkoul@kernel.org>, <wangzhou1@hisilicon.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/7] dmaengine: hisilicon: Fix CQ head update
Date:   Wed, 29 Jun 2022 11:55:44 +0800
Message-ID: <20220629035549.44181-3-haijie1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220629035549.44181-1-haijie1@huawei.com>
References: <20220625074422.3479591-1-haijie1@huawei.com>
 <20220629035549.44181-1-haijie1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

After completion of data transfer of one or multiple descriptors,
the completion status and the current head pointer to submission
queue are written into the CQ and interrupt can be generated to
inform the software. In interrupt process CQ is read and cq_head
is updated.

hisi_dma_irq updates cq_head only when the completion status is
success. When an abnormal interrupt reports, cq_head will not update
which will cause subsequent interrupt processes read the error CQ
and never report the correct status.

This patch updates cq_head whenever CQ is accessed.

Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jie Hai <haijie1@huawei.com>
---
 drivers/dma/hisi_dma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index 98bc488893cc..7609e6e7eb37 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -436,12 +436,12 @@ static irqreturn_t hisi_dma_irq(int irq, void *data)
 	desc = chan->desc;
 	cqe = chan->cq + chan->cq_head;
 	if (desc) {
+		chan->cq_head = (chan->cq_head + 1) %
+				hdma_dev->chan_depth;
+		hisi_dma_chan_write(hdma_dev->base,
+				    HISI_DMA_CQ_HEAD_PTR, chan->qp_num,
+				    chan->cq_head);
 		if (FIELD_GET(STATUS_MASK, cqe->w0) == STATUS_SUCC) {
-			chan->cq_head = (chan->cq_head + 1) %
-					hdma_dev->chan_depth;
-			hisi_dma_chan_write(hdma_dev->base,
-					    HISI_DMA_CQ_HEAD_PTR, chan->qp_num,
-					    chan->cq_head);
 			vchan_cookie_complete(&desc->vd);
 		} else {
 			dev_err(&hdma_dev->pdev->dev, "task error!\n");
-- 
2.33.0

