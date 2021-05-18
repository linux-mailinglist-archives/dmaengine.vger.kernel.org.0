Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF053876CE
	for <lists+dmaengine@lfdr.de>; Tue, 18 May 2021 12:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243193AbhERKoa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 May 2021 06:44:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:23545 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240727AbhERKo2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 18 May 2021 06:44:28 -0400
IronPort-SDR: bj3+xBxUeEMrq41lAxBc0hNYUiGsdne9d2s5SPAfjo+8Ngwb47iHODT9zMpHs1nP2VXwJ+jWrS
 OY5rXnnTjLmA==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="187805303"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="187805303"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 03:43:10 -0700
IronPort-SDR: NdxQZcVl3jXpAKZqHAeeKhJ7Iap3e0TMnL/OPMWf/Cxc+Peo3iZiPVLc5uR13jwuBUYWbSZr/5
 O1Zm96jRtSYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="472890047"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 18 May 2021 03:43:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 50AF312F; Tue, 18 May 2021 13:43:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dmaengine: Move kdoc description of struct dma_chan_percpu closer to it
Date:   Tue, 18 May 2021 13:43:22 +0300
Message-Id: <20210518104323.37632-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We have split by unknown reason of kdoc and struct dma_chan_percpu definition.
Join them back. No functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/dmaengine.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 004736b6a9c8..93c3ca5fdafd 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -229,12 +229,6 @@ enum sum_check_flags {
  */
 typedef struct { DECLARE_BITMAP(bits, DMA_TX_TYPE_END); } dma_cap_mask_t;
 
-/**
- * struct dma_chan_percpu - the per-CPU part of struct dma_chan
- * @memcpy_count: transaction counter
- * @bytes_transferred: byte counter
- */
-
 /**
  * enum dma_desc_metadata_mode - per descriptor metadata mode types supported
  * @DESC_METADATA_CLIENT - the metadata buffer is allocated/provided by the
@@ -291,6 +285,11 @@ enum dma_desc_metadata_mode {
 	DESC_METADATA_ENGINE = BIT(1),
 };
 
+/**
+ * struct dma_chan_percpu - the per-CPU part of struct dma_chan
+ * @memcpy_count: transaction counter
+ * @bytes_transferred: byte counter
+ */
 struct dma_chan_percpu {
 	/* stats */
 	unsigned long memcpy_count;
-- 
2.30.2

