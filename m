Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511EF5A5BB7
	for <lists+dmaengine@lfdr.de>; Tue, 30 Aug 2022 08:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiH3GZi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Aug 2022 02:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiH3GZe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Aug 2022 02:25:34 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4E952E75;
        Mon, 29 Aug 2022 23:25:32 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MGy1W49PHzHnXK;
        Tue, 30 Aug 2022 14:23:43 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 14:25:29 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 14:25:29 +0800
From:   Jie Hai <haijie1@huawei.com>
To:     <vkoul@kernel.org>, <wangzhou1@hisilicon.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v5 3/7] dmaengine: hisilicon: Add multi-thread support for a DMA channel
Date:   Tue, 30 Aug 2022 14:22:47 +0800
Message-ID: <20220830062251.52993-4-haijie1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220830062251.52993-1-haijie1@huawei.com>
References: <20220830062251.52993-1-haijie1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

This occurs because the transmission timed out, and that's due
to data race. Each thread rewrite channels's descriptor as soon as
device_issue_pending is called. It leads to the situation that
the driver thinks that it uses the right descriptor in interrupt
handler while channels's descriptor has been changed by other
thread. The descriptor which in fact reported interrupt will not
be handled any more, as well as its tx->callback.
That's why timeout reports.

With current fixes channels' descriptor changes it's value only
when it has been used. A new descriptor is acquired from
vc->desc_issued queue that is already filled with descriptors
that are ready to be sent. Threads have no direct access to DMA
channel descriptor. In case of channel's descriptor is busy, try
to submit to HW again when a descriptor is completed. In this case,
vc->desc_issued may be empty when hisi_dma_start_transfer is called,
so delete error reporting on this. Now it is just possible to queue
a descriptor for further processing.

Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
Signed-off-by: Jie Hai <haijie1@huawei.com>
Acked-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/dma/hisi_dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index 837f7e4adfa6..0233b42143c7 100644
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
@@ -441,11 +440,10 @@ static irqreturn_t hisi_dma_irq(int irq, void *data)
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

