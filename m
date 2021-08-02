Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B368D3DDF73
	for <lists+dmaengine@lfdr.de>; Mon,  2 Aug 2021 20:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhHBSnp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Aug 2021 14:43:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:17779 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230362AbhHBSnp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Aug 2021 14:43:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="193107205"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="193107205"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 11:43:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="436750448"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2021 11:43:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B2CE2142; Mon,  2 Aug 2021 21:44:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 2/3] dmaengine: dw: Convert members to u32 in platform data
Date:   Mon,  2 Aug 2021 21:43:54 +0300
Message-Id: <20210802184355.49879-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210802184355.49879-1-andriy.shevchenko@linux.intel.com>
References: <20210802184355.49879-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

u32 is a type that is used for properties retrieval from DT.
With the type change it allows to clean up properties reading routine.

While at it, order the fields in way how they are parsed.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/platform_data/dma-dw.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/platform_data/dma-dw.h b/include/linux/platform_data/dma-dw.h
index b11b0c8bc5da..860ba4bc5ead 100644
--- a/include/linux/platform_data/dma-dw.h
+++ b/include/linux/platform_data/dma-dw.h
@@ -41,11 +41,11 @@ struct dw_dma_slave {
 
 /**
  * struct dw_dma_platform_data - Controller configuration parameters
+ * @nr_masters: Number of AHB masters supported by the controller
  * @nr_channels: Number of channels supported by hardware (max 8)
  * @chan_allocation_order: Allocate channels starting from 0 or 7
  * @chan_priority: Set channel priority increasing from 0 to 7 or 7 to 0.
  * @block_size: Maximum block size supported by the controller
- * @nr_masters: Number of AHB masters supported by the controller
  * @data_width: Maximum data width supported by hardware per AHB master
  *		(in bytes, power of 2)
  * @multi_block: Multi block transfers supported by hardware per channel.
@@ -55,25 +55,25 @@ struct dw_dma_slave {
  * @quirks: Optional platform quirks.
  */
 struct dw_dma_platform_data {
-	unsigned int	nr_channels;
+	u32		nr_masters;
+	u32		nr_channels;
 #define CHAN_ALLOCATION_ASCENDING	0	/* zero to seven */
 #define CHAN_ALLOCATION_DESCENDING	1	/* seven to zero */
-	unsigned char	chan_allocation_order;
+	u32		chan_allocation_order;
 #define CHAN_PRIORITY_ASCENDING		0	/* chan0 highest */
 #define CHAN_PRIORITY_DESCENDING	1	/* chan7 highest */
-	unsigned char	chan_priority;
-	unsigned int	block_size;
-	unsigned char	nr_masters;
-	unsigned char	data_width[DW_DMA_MAX_NR_MASTERS];
-	unsigned char	multi_block[DW_DMA_MAX_NR_CHANNELS];
+	u32		chan_priority;
+	u32		block_size;
+	u32		data_width[DW_DMA_MAX_NR_MASTERS];
+	u32		multi_block[DW_DMA_MAX_NR_CHANNELS];
 	u32		max_burst[DW_DMA_MAX_NR_CHANNELS];
 #define CHAN_PROTCTL_PRIVILEGED		BIT(0)
 #define CHAN_PROTCTL_BUFFERABLE		BIT(1)
 #define CHAN_PROTCTL_CACHEABLE		BIT(2)
 #define CHAN_PROTCTL_MASK		GENMASK(2, 0)
-	unsigned char	protctl;
+	u32		protctl;
 #define DW_DMA_QUIRK_XBAR_PRESENT	BIT(0)
-	unsigned int	quirks;
+	u32		quirks;
 };
 
 #endif /* _PLATFORM_DATA_DMA_DW_H */
-- 
2.30.2

