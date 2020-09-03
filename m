Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E936E25CA2C
	for <lists+dmaengine@lfdr.de>; Thu,  3 Sep 2020 22:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgICU0X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Sep 2020 16:26:23 -0400
Received: from foss.arm.com ([217.140.110.172]:40196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729059AbgICU0X (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Sep 2020 16:26:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB9281063;
        Thu,  3 Sep 2020 13:26:22 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 04D093F71F;
        Thu,  3 Sep 2020 13:26:21 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 7/9] dmaengine: ste_dma40: Drop local dma_parms
Date:   Thu,  3 Sep 2020 21:25:51 +0100
Message-Id: <011a956183b92a258bf0922385d145ea966dcbea.1599164692.git.robin.murphy@arm.com>
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
 drivers/dma/ste_dma40.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 21e2f1d0c210..6b10d5c935a0 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -535,7 +535,6 @@ struct d40_gen_dmac {
  * mode" allocated physical channels.
  * @num_log_chans: The number of logical channels. Calculated from
  * num_phy_chans.
- * @dma_parms: DMA parameters for the channel
  * @dma_both: dma_device channels that can do both memcpy and slave transfers.
  * @dma_slave: dma_device channels that can do only do slave transfers.
  * @dma_memcpy: dma_device channels that can do only do memcpy transfers.
@@ -577,7 +576,6 @@ struct d40_base {
 	int				  num_memcpy_chans;
 	int				  num_phy_chans;
 	int				  num_log_chans;
-	struct device_dma_parameters	  dma_parms;
 	struct dma_device		  dma_both;
 	struct dma_device		  dma_slave;
 	struct dma_device		  dma_memcpy;
@@ -3641,7 +3639,6 @@ static int __init d40_probe(struct platform_device *pdev)
 	if (ret)
 		goto destroy_cache;
 
-	base->dev->dma_parms = &base->dma_parms;
 	ret = dma_set_max_seg_size(base->dev, STEDMA40_MAX_SEG_SIZE);
 	if (ret) {
 		d40_err(&pdev->dev, "Failed to set dma max seg size\n");
-- 
2.28.0.dirty

