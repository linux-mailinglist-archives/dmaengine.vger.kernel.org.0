Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7A725CA25
	for <lists+dmaengine@lfdr.de>; Thu,  3 Sep 2020 22:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgICU0S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Sep 2020 16:26:18 -0400
Received: from foss.arm.com ([217.140.110.172]:40168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728975AbgICU0R (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Sep 2020 16:26:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE227113E;
        Thu,  3 Sep 2020 13:26:16 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF2B43F71F;
        Thu,  3 Sep 2020 13:26:15 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/9] dmaengine: bcm2835: Drop local dma_parms
Date:   Thu,  3 Sep 2020 21:25:46 +0100
Message-Id: <116927330a4a66aac579ad38ddbc3b538cd9524c.1599164692.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1599164692.git.robin.murphy@arm.com>
References: <cover.1599164692.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since commit 9495b7e92f71 ("driver core: platform: Initialize dma_parms
for platform devices"), struct platform_device already provides a
dma_parms structure, so we can save allocating another one.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/dma/bcm2835-dma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 4768ef26013b..630dfbb01a40 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -41,14 +41,12 @@
  * struct bcm2835_dmadev - BCM2835 DMA controller
  * @ddev: DMA device
  * @base: base address of register map
- * @dma_parms: DMA parameters (to convey 1 GByte max segment size to clients)
  * @zero_page: bus address of zero page (to detect transactions copying from
  *	zero page and avoid accessing memory if so)
  */
 struct bcm2835_dmadev {
 	struct dma_device ddev;
 	void __iomem *base;
-	struct device_dma_parameters dma_parms;
 	dma_addr_t zero_page;
 };
 
@@ -902,7 +900,6 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	if (!od)
 		return -ENOMEM;
 
-	pdev->dev.dma_parms = &od->dma_parms;
 	dma_set_max_seg_size(&pdev->dev, 0x3FFFFFFF);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.28.0.dirty

