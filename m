Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B9025CA28
	for <lists+dmaengine@lfdr.de>; Thu,  3 Sep 2020 22:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgICU0T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Sep 2020 16:26:19 -0400
Received: from foss.arm.com ([217.140.110.172]:40178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbgICU0T (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Sep 2020 16:26:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3127D1396;
        Thu,  3 Sep 2020 13:26:19 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4618D3F71F;
        Thu,  3 Sep 2020 13:26:18 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/9] dmaengine: imx-sdma: Drop local dma_parms
Date:   Thu,  3 Sep 2020 21:25:48 +0100
Message-Id: <d9b551dcf712a91860af3c5dd01a31b9b97ac1c5.1599164692.git.robin.murphy@arm.com>
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
 drivers/dma/imx-sdma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 4f8d8f5e1132..16b908c77db3 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -426,7 +426,6 @@ struct sdma_driver_data {
 
 struct sdma_engine {
 	struct device			*dev;
-	struct device_dma_parameters	dma_parms;
 	struct sdma_channel		channel[MAX_DMA_CHANNELS];
 	struct sdma_channel_control	*channel_control;
 	void __iomem			*regs;
@@ -2118,7 +2117,6 @@ static int sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
 	sdma->dma_device.device_prep_dma_memcpy = sdma_prep_memcpy;
 	sdma->dma_device.device_issue_pending = sdma_issue_pending;
-	sdma->dma_device.dev->dma_parms = &sdma->dma_parms;
 	sdma->dma_device.copy_align = 2;
 	dma_set_max_seg_size(sdma->dma_device.dev, SDMA_BD_MAX_CNT);
 
-- 
2.28.0.dirty

