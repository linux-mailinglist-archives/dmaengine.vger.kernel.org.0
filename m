Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B79C2465CC
	for <lists+dmaengine@lfdr.de>; Mon, 17 Aug 2020 13:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgHQL5r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 07:57:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50318 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbgHQL5q (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Aug 2020 07:57:46 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2189CAE7D8B1F88B5A92;
        Mon, 17 Aug 2020 19:57:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 17 Aug 2020
 19:57:38 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>,
        <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <nicolas.ferre@microchip.com>, <plagnioj@jcrosoft.com>,
        <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 1/3] dmaengine: at_hdmac: check return value of of_find_device_by_node() in at_dma_xlate()
Date:   Mon, 17 Aug 2020 19:57:26 +0800
Message-ID: <20200817115728.1706719-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200817115728.1706719-1-yukuai3@huawei.com>
References: <20200817115728.1706719-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The reurn value of of_find_device_by_node() is not checked, thus null
pointer dereference will be triggered if of_find_device_by_node()
failed.

Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/dma/at_hdmac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 45bbcd6146fd..1c941f839c42 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1650,6 +1650,8 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
 		return NULL;
 
 	dmac_pdev = of_find_device_by_node(dma_spec->np);
+	if (!dmac_pdev)
+		return NULL;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
-- 
2.25.4

