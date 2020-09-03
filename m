Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8A925CA26
	for <lists+dmaengine@lfdr.de>; Thu,  3 Sep 2020 22:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgICU0S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Sep 2020 16:26:18 -0400
Received: from foss.arm.com ([217.140.110.172]:40164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbgICU0R (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Sep 2020 16:26:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 803B51063;
        Thu,  3 Sep 2020 13:26:15 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A1D873F71F;
        Thu,  3 Sep 2020 13:26:14 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/9] dmaengine: axi-dmac: Drop local dma_parms
Date:   Thu,  3 Sep 2020 21:25:45 +0100
Message-Id: <9b759e4c9eb37c90a3616d31abe13af6a6dafcd2.1599164692.git.robin.murphy@arm.com>
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
 drivers/dma/dma-axi-dmac.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index f1d149e32839..f333ac4f67fb 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -134,8 +134,6 @@ struct axi_dmac {
 
 	struct dma_device dma_dev;
 	struct axi_dmac_chan chan;
-
-	struct device_dma_parameters dma_parms;
 };
 
 static struct axi_dmac *chan_to_axi_dmac(struct axi_dmac_chan *chan)
@@ -868,7 +866,6 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	}
 	of_node_put(of_channels);
 
-	pdev->dev.dma_parms = &dmac->dma_parms;
 	dma_set_max_seg_size(&pdev->dev, UINT_MAX);
 
 	dma_dev = &dmac->dma_dev;
-- 
2.28.0.dirty

