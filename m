Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEEA49791B
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2019 14:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfHUMTu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Aug 2019 08:19:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4745 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbfHUMTu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 21 Aug 2019 08:19:50 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CF30E66DE0F5DA9FA94C;
        Wed, 21 Aug 2019 20:19:46 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 21 Aug 2019
 20:19:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] dmaengine: iop-adma: remove set but not used variable 'slots_per_op'
Date:   Wed, 21 Aug 2019 20:19:08 +0800
Message-ID: <20190821121908.7468-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/dma/iop-adma.c: In function iop_adma_tx_submit:
drivers/dma/iop-adma.c:367:6: warning:
 variable slots_per_op set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/dma/iop-adma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index 03f4a58..0dab7b7 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -364,13 +364,11 @@ iop_adma_tx_submit(struct dma_async_tx_descriptor *tx)
 	struct iop_adma_chan *iop_chan = to_iop_adma_chan(tx->chan);
 	struct iop_adma_desc_slot *grp_start, *old_chain_tail;
 	int slot_cnt;
-	int slots_per_op;
 	dma_cookie_t cookie;
 	dma_addr_t next_dma;
 
 	grp_start = sw_desc->group_head;
 	slot_cnt = grp_start->slot_cnt;
-	slots_per_op = grp_start->slots_per_op;
 
 	spin_lock_bh(&iop_chan->lock);
 	cookie = dma_cookie_assign(tx);
-- 
2.7.4


