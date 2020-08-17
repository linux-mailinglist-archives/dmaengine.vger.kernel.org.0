Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64D42465CE
	for <lists+dmaengine@lfdr.de>; Mon, 17 Aug 2020 13:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgHQL5y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 07:57:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9823 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbgHQL5x (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Aug 2020 07:57:53 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5D0A310D3AFDE9BFBD9D;
        Mon, 17 Aug 2020 19:57:49 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 17 Aug 2020
 19:57:39 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>,
        <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <nicolas.ferre@microchip.com>, <plagnioj@jcrosoft.com>,
        <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 3/3] dmaengine: at_hdmac: add missing kfree() call in at_dma_xlate()
Date:   Mon, 17 Aug 2020 19:57:28 +0800
Message-ID: <20200817115728.1706719-4-yukuai3@huawei.com>
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

If memory allocation for 'atslave' succeed, at_dma_xlate() doesn't have a
corresponding kfree() in exception handling. Thus add kfree() for this
function implementation.

Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/dma/at_hdmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index bf874367097c..a2cf25c6e3b3 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1691,6 +1691,7 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
 	chan = dma_request_channel(mask, at_dma_filter, atslave);
 	if (!chan) {
 		put_device(&dmac_pdev->dev);
+		kfree(atslave);
 		return NULL;
 	}
 
-- 
2.25.4

