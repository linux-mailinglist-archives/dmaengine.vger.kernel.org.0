Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BE925CA27
	for <lists+dmaengine@lfdr.de>; Thu,  3 Sep 2020 22:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgICU0T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Sep 2020 16:26:19 -0400
Received: from foss.arm.com ([217.140.110.172]:40172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbgICU0S (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Sep 2020 16:26:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E47E112FC;
        Thu,  3 Sep 2020 13:26:17 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0BEAB3F71F;
        Thu,  3 Sep 2020 13:26:16 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/9] dmaengine: imx-dma: Drop local dma_parms
Date:   Thu,  3 Sep 2020 21:25:47 +0100
Message-Id: <7fad3c60cac2bf4f8dab791f8b6eafae90abc960.1599164692.git.robin.murphy@arm.com>
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
 drivers/dma/imx-dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 5c0fb3134825..3cd8b7d14d1c 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -173,7 +173,6 @@ enum imx_dma_type {
 
 struct imxdma_engine {
 	struct device			*dev;
-	struct device_dma_parameters	dma_parms;
 	struct dma_device		dma_device;
 	void __iomem			*base;
 	struct clk			*dma_ahb;
@@ -1196,7 +1195,6 @@ static int __init imxdma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, imxdma);
 
 	imxdma->dma_device.copy_align = DMAENGINE_ALIGN_4_BYTES;
-	imxdma->dma_device.dev->dma_parms = &imxdma->dma_parms;
 	dma_set_max_seg_size(imxdma->dma_device.dev, 0xffffff);
 
 	ret = dma_async_device_register(&imxdma->dma_device);
-- 
2.28.0.dirty

