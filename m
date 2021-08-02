Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A793DDF75
	for <lists+dmaengine@lfdr.de>; Mon,  2 Aug 2021 20:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhHBSnr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Aug 2021 14:43:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:35014 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhHBSnq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Aug 2021 14:43:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="213241543"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="213241543"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 11:43:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="418757489"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 02 Aug 2021 11:43:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AC688B9; Mon,  2 Aug 2021 21:44:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 3/3] dmaengine: dw: Simplify DT property parser
Date:   Mon,  2 Aug 2021 21:43:55 +0300
Message-Id: <20210802184355.49879-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210802184355.49879-1-andriy.shevchenko@linux.intel.com>
References: <20210802184355.49879-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since we converted internal data types to match DT, there is no need to have
an intermediate conversion layer, hence drop a few conditionals and for loops
for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/of.c | 44 ++++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/dw/of.c b/drivers/dma/dw/of.c
index 4d2b89142721..523ca806837c 100644
--- a/drivers/dma/dw/of.c
+++ b/drivers/dma/dw/of.c
@@ -50,7 +50,7 @@ struct dw_dma_platform_data *dw_dma_parse_dt(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct dw_dma_platform_data *pdata;
-	u32 tmp, arr[DW_DMA_MAX_NR_MASTERS], mb[DW_DMA_MAX_NR_CHANNELS];
+	u32 tmp, arr[DW_DMA_MAX_NR_MASTERS];
 	u32 nr_masters;
 	u32 nr_channels;
 
@@ -71,41 +71,29 @@ struct dw_dma_platform_data *dw_dma_parse_dt(struct platform_device *pdev)
 	pdata->nr_masters = nr_masters;
 	pdata->nr_channels = nr_channels;
 
-	if (!of_property_read_u32(np, "chan_allocation_order", &tmp))
-		pdata->chan_allocation_order = (unsigned char)tmp;
+	of_property_read_u32(np, "chan_allocation_order", &pdata->chan_allocation_order);
+	of_property_read_u32(np, "chan_priority", &pdata->chan_priority);
 
-	if (!of_property_read_u32(np, "chan_priority", &tmp))
-		pdata->chan_priority = tmp;
+	of_property_read_u32(np, "block_size", &pdata->block_size);
 
-	if (!of_property_read_u32(np, "block_size", &tmp))
-		pdata->block_size = tmp;
-
-	if (!of_property_read_u32_array(np, "data-width", arr, nr_masters)) {
-		for (tmp = 0; tmp < nr_masters; tmp++)
-			pdata->data_width[tmp] = arr[tmp];
-	} else if (!of_property_read_u32_array(np, "data_width", arr, nr_masters)) {
+	/* Try deprecated property first */
+	if (!of_property_read_u32_array(np, "data_width", arr, nr_masters)) {
 		for (tmp = 0; tmp < nr_masters; tmp++)
 			pdata->data_width[tmp] = BIT(arr[tmp] & 0x07);
 	}
 
-	if (!of_property_read_u32_array(np, "multi-block", mb, nr_channels)) {
-		for (tmp = 0; tmp < nr_channels; tmp++)
-			pdata->multi_block[tmp] = mb[tmp];
-	} else {
-		for (tmp = 0; tmp < nr_channels; tmp++)
-			pdata->multi_block[tmp] = 1;
-	}
+	/* If "data_width" and "data-width" both provided use the latter one */
+	of_property_read_u32_array(np, "data-width", pdata->data_width, nr_masters);
 
-	if (of_property_read_u32_array(np, "snps,max-burst-len", pdata->max_burst,
-				       nr_channels)) {
-		memset32(pdata->max_burst, DW_DMA_MAX_BURST, nr_channels);
-	}
+	memset32(pdata->multi_block, 1, nr_channels);
+	of_property_read_u32_array(np, "multi-block", pdata->multi_block, nr_channels);
 
-	if (!of_property_read_u32(np, "snps,dma-protection-control", &tmp)) {
-		if (tmp > CHAN_PROTCTL_MASK)
-			return NULL;
-		pdata->protctl = tmp;
-	}
+	memset32(pdata->max_burst, DW_DMA_MAX_BURST, nr_channels);
+	of_property_read_u32_array(np, "snps,max-burst-len", pdata->max_burst, nr_channels);
+
+	of_property_read_u32(np, "snps,dma-protection-control", &pdata->protctl);
+	if (pdata->protctl > CHAN_PROTCTL_MASK)
+		return NULL;
 
 	return pdata;
 }
-- 
2.30.2

