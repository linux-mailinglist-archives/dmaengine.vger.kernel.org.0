Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABDA1C734E
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2020 16:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgEFOuR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 May 2020 10:50:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:30351 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgEFOuR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 6 May 2020 10:50:17 -0400
IronPort-SDR: 1PmeYZarF4DYQJ2PTGqbS8qX26NpM9OyU1lcAfC9HjZ5D6jwS8wKQfhNng2DpZNj0U9+EjaFI1
 O7EgPn9pIoCg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 07:50:16 -0700
IronPort-SDR: dSOkBUpGvNLTA9DQqg26Ph/wfMjXWY+4fo9BX80AZ21bwvV6plHjBGOyAwXtpvPab0fWHGAzO9
 6OoamVemsubQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,359,1583222400"; 
   d="scan'208";a="260127737"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003.jf.intel.com with ESMTP; 06 May 2020 07:50:16 -0700
Subject: [PATCH v3] dmaengine: cookie bypass for out of order completion
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, swathi.kovvuri@intel.com
Date:   Wed, 06 May 2020 07:50:16 -0700
Message-ID: <158877653369.51303.5331705116646956272.stgit@djiang5-desk3.ch.intel.com>
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
backwards due to out of order completion. Add DMA_NO_COMPLETION_ORDER
DMA capability to allow the driver to flag the device's ability to complete
operations out of order.

Reported-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
---

v3:
- v2 mailed wrong patch
v2:
- Add DMA capability (vinod)
- Add documentation (vinod)

 Documentation/driver-api/dmaengine/provider.rst |   11 +++++++++++
 drivers/dma/dmatest.c                           |    5 ++++-
 drivers/dma/idxd/dma.c                          |    3 ++-
 include/linux/dmaengine.h                       |    2 ++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 56e5833e8a07..783ca141e147 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -239,6 +239,14 @@ Currently, the types available are:
     want to transfer a portion of uncompressed data directly to the
     display to print it
 
+- DMA_COMPLETION_NO_ORDER
+
+  - The device supports out of order completion of the operations.
+
+  - The driver should return DMA_OUT_OF_ORDER for device_tx_status if
+    the device supports out of order completion and the completion is
+    is expected to be completed out of order.
+
 These various types will also affect how the source and destination
 addresses change over time.
 
@@ -399,6 +407,9 @@ supported.
   - In the case of a cyclic transfer, it should only take into
     account the current period.
 
+  - Should return DMA_OUT_OF_ORDER if the device supports out of order
+    completion and is completing the operation out of order.
+
   - This function can be called in an interrupt context.
 
 - device_config
diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index a2cadfa2e6d7..8953e096a05c 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -821,7 +821,10 @@ static int dmatest_func(void *data)
 			result("test timed out", total_tests, src->off, dst->off,
 			       len, 0);
 			goto error_unmap_continue;
-		} else if (status != DMA_COMPLETE) {
+		} else if (status != DMA_COMPLETE &&
+			   !(dma_has_cap(DMA_COMPLETION_NO_ORDER,
+					 dev->cap_mask) &&
+			     status == DMA_OUT_OF_ORDER)) {
 			result(status == DMA_ERROR ?
 			       "completion error status" :
 			       "completion busy status", total_tests, src->off,
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index c64c1429d160..0c892cbd72e0 100644
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
@@ -174,6 +174,7 @@ int idxd_register_dma_device(struct idxd_device *idxd)
 	INIT_LIST_HEAD(&dma->channels);
 	dma->dev = &idxd->pdev->dev;
 
+	dma_cap_set(DMA_COMPLETION_NO_ORDER, dma->cap_mask);
 	dma->device_release = idxd_dma_release;
 
 	if (idxd->hw.opcap.bits[0] & IDXD_OPCAP_MEMMOVE) {
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 21065c04c4ac..1123f4d15bae 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -39,6 +39,7 @@ enum dma_status {
 	DMA_IN_PROGRESS,
 	DMA_PAUSED,
 	DMA_ERROR,
+	DMA_OUT_OF_ORDER,
 };
 
 /**
@@ -61,6 +62,7 @@ enum dma_transaction_type {
 	DMA_SLAVE,
 	DMA_CYCLIC,
 	DMA_INTERLEAVE,
+	DMA_COMPLETION_NO_ORDER,
 /* last transaction type for creation of the capabilities mask */
 	DMA_TX_TYPE_END,
 };

