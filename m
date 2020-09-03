Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E34125CA2D
	for <lists+dmaengine@lfdr.de>; Thu,  3 Sep 2020 22:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgICU0Z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Sep 2020 16:26:25 -0400
Received: from foss.arm.com ([217.140.110.172]:40206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729059AbgICU0Y (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Sep 2020 16:26:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28C17113E;
        Thu,  3 Sep 2020 13:26:24 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3B7563F71F;
        Thu,  3 Sep 2020 13:26:23 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 8/9] dmaengine: qcom: bam_dma: Drop local dma_parms
Date:   Thu,  3 Sep 2020 21:25:52 +0100
Message-Id: <60ac2ef17e242dbf631db29ebde9d64d6df67030.1599164692.git.robin.murphy@arm.com>
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
 drivers/dma/qcom/bam_dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 5a08dd0d3388..773e60c82b20 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -381,7 +381,6 @@ struct bam_device {
 	void __iomem *regs;
 	struct device *dev;
 	struct dma_device common;
-	struct device_dma_parameters dma_parms;
 	struct bam_chan *channels;
 	u32 num_channels;
 	u32 num_ees;
@@ -1316,7 +1315,6 @@ static int bam_dma_probe(struct platform_device *pdev)
 
 	/* set max dma segment size */
 	bdev->common.dev = bdev->dev;
-	bdev->common.dev->dma_parms = &bdev->dma_parms;
 	ret = dma_set_max_seg_size(bdev->common.dev, BAM_FIFO_SIZE);
 	if (ret) {
 		dev_err(bdev->dev, "cannot set maximum segment size\n");
-- 
2.28.0.dirty

