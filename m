Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADADD231E8A
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jul 2020 14:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgG2M3B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jul 2020 08:29:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8852 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbgG2M3B (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 29 Jul 2020 08:29:01 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 50D97E8CFB5032563D5B;
        Wed, 29 Jul 2020 20:28:57 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Jul 2020
 20:28:46 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>,
        <vkoul@kernel.org>, <dan.j.williams@intel.com>, <arnd@arndb.de>,
        <nicolas.ferre@microchip.com>, <plagnioj@jcrosoft.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] dmaengine: at_hdmac: do exception handling appropriately in at_dma_xlate()
Date:   Wed, 29 Jul 2020 20:29:03 +0800
Message-ID: <20200729122903.2473297-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Do several things for exception handing:

a. check return value of of_find_device_by_node().
b. call put_device() if memory allocation for 'atslave' failed.
c. if dma_request_channel() failed, call put_device() and kfree().

Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/dma/at_hdmac.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 45bbcd6146fd..a2cf25c6e3b3 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1650,13 +1650,17 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
 		return NULL;
 
 	dmac_pdev = of_find_device_by_node(dma_spec->np);
+	if (!dmac_pdev)
+		return NULL;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
 	atslave = kmalloc(sizeof(*atslave), GFP_KERNEL);
-	if (!atslave)
+	if (!atslave) {
+		put_device(&dmac_pdev->dev);
 		return NULL;
+	}
 
 	atslave->cfg = ATC_DST_H2SEL_HW | ATC_SRC_H2SEL_HW;
 	/*
@@ -1685,8 +1689,11 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
 	atslave->dma_dev = &dmac_pdev->dev;
 
 	chan = dma_request_channel(mask, at_dma_filter, atslave);
-	if (!chan)
+	if (!chan) {
+		put_device(&dmac_pdev->dev);
+		kfree(atslave);
 		return NULL;
+	}
 
 	atchan = to_at_dma_chan(chan);
 	atchan->per_if = dma_spec->args[0] & 0xff;
-- 
2.25.4

