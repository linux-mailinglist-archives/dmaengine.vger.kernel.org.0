Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D024A662A
	for <lists+dmaengine@lfdr.de>; Tue,  1 Feb 2022 21:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbiBAUlU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Feb 2022 15:41:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:16639 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242885AbiBAUkA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 1 Feb 2022 15:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643748000; x=1675284000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kMTXwZ1e+jdxL0YDhYsvirXXe+wF0/Era8joL0xpNMA=;
  b=nyKWqxGuAqYmSJGbzLxWNAZ31NC113xG//ceAycGDcvmT9L8S+snYM2r
   b74hmPaH2DktDfXwScMYKjiTNRvO16XKiNOI1SvS6yzBtvHieDwKho47F
   zMejcMB5q1uAOpWAxuq2J3x3Fy0i365LZM8NweCwhbVn4HXSQEyKrNKpH
   OOTn6O4Innlv4vd/spV/XL/3ASj61gDR0dOzNjbreIwaHaiuKb1BoCSko
   1b/015gEyzZPlxmG9v1VAD8a20+CWxIbGfzWUKT6ni6Ljl/P951A9k2uj
   /ydYxiZJ6QYIuk8F4xP0EywylCIjmqXRpw2XJcMAHrq8TnnxJwbz3BqyQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="334143886"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="334143886"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 12:39:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="479820785"
Received: from bwalker-desk.ch.intel.com ([143.182.137.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Feb 2022 12:39:11 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [RESEND 04/10] dmaengine: Remove last, used from dma_tx_state
Date:   Tue,  1 Feb 2022 13:38:07 -0700
Message-Id: <20220201203813.3951461-5-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220201203813.3951461-1-benjamin.walker@intel.com>
References: <20220201203813.3951461-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Nothing uses these and they don't convey usable information.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/dma/dmaengine.h   | 4 ----
 include/linux/dmaengine.h | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index e72876a512a39..08c7bd7cfc229 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -74,8 +74,6 @@ static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
 	complete = chan->completed_cookie;
 	barrier();
 	if (state) {
-		state->last = complete;
-		state->used = used;
 		state->residue = 0;
 		state->in_flight_bytes = 0;
 	}
@@ -96,8 +94,6 @@ static inline void dma_set_tx_state(struct dma_tx_state *st,
 	if (!st)
 		return;
 
-	st->last = last;
-	st->used = used;
 	st->residue = residue;
 }
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 5f884fffe74cc..3c545b42723ec 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -716,16 +716,12 @@ static inline struct dma_async_tx_descriptor *txd_next(struct dma_async_tx_descr
 /**
  * struct dma_tx_state - filled in to report the status of
  * a transfer.
- * @last: last completed DMA cookie
- * @used: last issued DMA cookie (i.e. the one in progress)
  * @residue: the remaining number of bytes left to transmit
  *	on the selected transfer for states DMA_IN_PROGRESS and
  *	DMA_PAUSED if this is implemented in the driver, else 0
  * @in_flight_bytes: amount of data in bytes cached by the DMA.
  */
 struct dma_tx_state {
-	dma_cookie_t last;
-	dma_cookie_t used;
 	u32 residue;
 	u32 in_flight_bytes;
 };
-- 
2.33.1

