Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C911C04E8
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 20:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgD3Sft (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 14:35:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:29832 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgD3Sft (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 30 Apr 2020 14:35:49 -0400
IronPort-SDR: ooMhMp2tFT6UtToL0pEC6ofg00mKYILBH5FyiclY1lO5Whsv+EZGxDIE3+DxD82PaUHC6zDIgB
 e3bf/Ris22KQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 11:35:47 -0700
IronPort-SDR: 2F86vwcAAs7TgIBPIOpku4OWpq5AhrwHFrRn6AxsmAU+LlyIp4BqAHZGnz9DXRGFDYdDeq+AWJ
 Z3OHhvxDnvJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,336,1583222400"; 
   d="scan'208";a="368236384"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001.fm.intel.com with ESMTP; 30 Apr 2020 11:35:47 -0700
Subject: [PATCH] dmaengine: cookie bypass for out of order completion
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, swathi.kovvuri@intel.com
Date:   Thu, 30 Apr 2020 11:35:47 -0700
Message-ID: <158827174736.34343.16479132955205930987.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The cookie tracking in dmaengine expects all submissions completed in
order. Some DMA devices like Intel DSA can complete submissions out of
order, especially if configured with a work queue sharing multiple DMA
engines. Add a status DMA_OUT_OF_ORDER that tx_status can be returned for
those DMA devices. The user should use callbacks to track the completion
rather than the DMA cookie. This would address the issue of dmatest
complaining that descriptors are "busy" when the cookie count goes
backwards due to out of order completion.

Reported-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
---
 drivers/dma/dmatest.c     |    3 ++-
 drivers/dma/idxd/dma.c    |    2 +-
 include/linux/dmaengine.h |    1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index a2cadfa2e6d7..60a4a9cec3c8 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -821,7 +821,8 @@ static int dmatest_func(void *data)
 			result("test timed out", total_tests, src->off, dst->off,
 			       len, 0);
 			goto error_unmap_continue;
-		} else if (status != DMA_COMPLETE) {
+		} else if (status != DMA_COMPLETE &&
+			   status != DMA_OUT_OF_ORDER) {
 			result(status == DMA_ERROR ?
 			       "completion error status" :
 			       "completion busy status", total_tests, src->off,
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index c64c1429d160..3f54826abc12 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -133,7 +133,7 @@ static enum dma_status idxd_dma_tx_status(struct dma_chan *dma_chan,
 					  dma_cookie_t cookie,
 					  struct dma_tx_state *txstate)
 {
-	return dma_cookie_status(dma_chan, cookie, txstate);
+	return DMA_OUT_OF_ORDER;
 }
 
 /*
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 21065c04c4ac..a0c130131e45 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -39,6 +39,7 @@ enum dma_status {
 	DMA_IN_PROGRESS,
 	DMA_PAUSED,
 	DMA_ERROR,
+	DMA_OUT_OF_ORDER,
 };
 
 /**

