Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A745D1C52A4
	for <lists+dmaengine@lfdr.de>; Tue,  5 May 2020 12:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgEEKJ4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 May 2020 06:09:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43852 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728402AbgEEKJz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 5 May 2020 06:09:55 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E5C314B04EC27FF0D1CE;
        Tue,  5 May 2020 18:09:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 5 May 2020 18:09:44 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <dmaengine@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] dmaengine: moxart-dma: Drop pointless static qualifier in moxart_probe()
Date:   Tue, 5 May 2020 10:13:53 +0000
Message-ID: <20200505101353.195446-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no need to have the 'void __iomem *dma_base_addr' variable
static since new value always be assigned before use it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/dma/moxart-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index 2a77fa319d78..347146a6e1d0 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -568,7 +568,7 @@ static int moxart_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct resource *res;
-	static void __iomem *dma_base_addr;
+	void __iomem *dma_base_addr;
 	int ret, i;
 	unsigned int irq;
 	struct moxart_chan *ch;





