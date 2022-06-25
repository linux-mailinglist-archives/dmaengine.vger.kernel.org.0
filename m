Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAD155A7D0
	for <lists+dmaengine@lfdr.de>; Sat, 25 Jun 2022 09:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiFYHo4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 25 Jun 2022 03:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiFYHo4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 25 Jun 2022 03:44:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67344707F;
        Sat, 25 Jun 2022 00:44:52 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LVQsc1lMPzShDW;
        Sat, 25 Jun 2022 15:41:24 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 25 Jun 2022 15:44:50 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 25 Jun 2022 15:44:50 +0800
From:   Jie Hai <haijie1@huawei.com>
To:     <vkoul@kernel.org>, <wangzhou1@hisilicon.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/8] dmaengine: hisilicon: Add multi-thread support for a DMA channel
Date:   Sat, 25 Jun 2022 15:44:17 +0800
Message-ID: <20220625074422.3479591-4-haijie1@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220625074422.3479591-1-haijie1@huawei.com>
References: <20220625074422.3479591-1-haijie1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

When we get a DMA channel and try to use it in multiple threads it
will cause oops and hanging the system.

% echo 100 > /sys/module/dmatest/parameters/threads_per_chan
% echo 100 > /sys/module/dmatest/parameters/iterations
% echo 1 > /sys/module/dmatest/parameters/run
[383493.327077] Unable to handle kernel paging request at virtual
		address dead000000000108
[383493.335103] Mem abort info:
[383493.335103]   ESR = 0x96000044
[383493.335105]   EC = 0x25: DABT (current EL), IL = 32 bits
[383493.335107]   SET = 0, FnV = 0
[383493.335108]   EA = 0, S1PTW = 0
[383493.335109]   FSC = 0x04: level 0 translation fault
[383493.335110] Data abort info:
[383493.335111]   ISV = 0, ISS = 0x00000044
[383493.364739]   CM = 0, WnR = 1
[383493.367793] [dead000000000108] address between user and kernel
		address ranges
[383493.375021] Internal error: Oops: 96000044 [#1] PREEMPT SMP
[383493.437574] CPU: 63 PID: 27895 Comm: dma0chan0-copy2 Kdump:
		loaded Tainted: GO 5.17.0-rc4+ #2
[383493.457851] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT
		-SSBS BTYPE=--)
[383493.465331] pc : vchan_tx_submit+0x64/0xa0
[383493.469957] lr : vchan_tx_submit+0x34/0xa0

This happens because of data race. Each thread rewrite channels's
descriptor as soon as device_issue_pending is called. It leads to
the situation that the driver thinks that it uses the right
descriptor in interrupt handler while channels's descriptor has
been changed by other thread.

With current fixes channels's descriptor changes it's value only
when it has been used. A new descriptor is acquired from
vc->desc_issued queue that is already filled with descriptors
that are ready to be sent. Threads have no direct access to DMA
channel descriptor. Now it is just possible to queue a descriptor
for further processing.

Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
Signed-off-by: Jie Hai <haijie1@huawei.com>
---
 drivers/dma/hisi_dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index 0a0f8a4d168a..0385419be8d5 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -271,7 +271,6 @@ static void hisi_dma_start_transfer(struct hisi_dma_chan *chan)
 
 	vd = vchan_next_desc(&chan->vc);
 	if (!vd) {
-		dev_err(&hdma_dev->pdev->dev, "no issued task!\n");
 		chan->desc = NULL;
 		return;
 	}
@@ -303,7 +302,7 @@ static void hisi_dma_issue_pending(struct dma_chan *c)
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 
-	if (vchan_issue_pending(&chan->vc))
+	if (vchan_issue_pending(&chan->vc) && !chan->desc)
 		hisi_dma_start_transfer(chan);
 
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
@@ -442,11 +441,10 @@ static irqreturn_t hisi_dma_irq(int irq, void *data)
 				    chan->qp_num, chan->cq_head);
 		if (FIELD_GET(STATUS_MASK, cqe->w0) == STATUS_SUCC) {
 			vchan_cookie_complete(&desc->vd);
+			hisi_dma_start_transfer(chan);
 		} else {
 			dev_err(&hdma_dev->pdev->dev, "task error!\n");
 		}
-
-		chan->desc = NULL;
 	}
 
 	spin_unlock(&chan->vc.lock);
-- 
2.33.0

