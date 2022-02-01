Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0E14A6629
	for <lists+dmaengine@lfdr.de>; Tue,  1 Feb 2022 21:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbiBAUlC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Feb 2022 15:41:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:16619 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242565AbiBAUjs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 1 Feb 2022 15:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643747988; x=1675283988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wjQp+P47gkfvSfgYviN2n5UOyMJ67oVhdAuMx8bF8Hw=;
  b=myynbRw0nqru3FDn4dngrtwxC9g+l0bbLyWrjEuQdAFIEgDmWI9esmFV
   j52iM22JhhIN9B0ysP4NRRrBIjrBywyWP4+DRnYs9CbeqbQWRBKVNFfFi
   hPnJp+gWGGF2CGj4VeYap1ceczZl6cqzXby+IAvo4+mz4Ebxgjqj1ZFNz
   arutjlQC6M//wXZRFrUkTK4+VxqltVFmiZlymIXFQ5UKtS2oJkGTZEAgW
   Obc4GYk9X6zTKDfF+Ha0u3lyHQ1woEzUN6XHywZgIZnnvaAbn4BO+vle5
   /g0+8rHPBIohpaMYdl4Ic4tmOho8GuadrA7xEhOllknOsFStH6xn/0l65
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="334143885"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="334143885"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 12:39:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="479820780"
Received: from bwalker-desk.ch.intel.com ([143.182.137.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Feb 2022 12:39:11 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [RESEND 03/10] dmaengine: Remove the last, used parameters in dma_async_is_tx_complete
Date:   Tue,  1 Feb 2022 13:38:06 -0700
Message-Id: <20220201203813.3951461-4-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220201203813.3951461-1-benjamin.walker@intel.com>
References: <20220201203813.3951461-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

These are only used by a single driver (pxa_camera) which knows exactly
which DMA engine it is dealing with and therefore knows the behavior
of the cookie values. It can grab the value it needs directly from
the dma_chan instead. No other DMA client assumes anything about
the behavior of the cookie values, so the cookie becomes an opaque
handle after this patch.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 Documentation/driver-api/dmaengine/client.rst  | 17 +++--------------
 .../driver-api/dmaengine/provider.rst          |  6 +++---
 drivers/crypto/stm32/stm32-hash.c              |  3 +--
 drivers/dma/dmaengine.c                        |  2 +-
 drivers/dma/dmatest.c                          |  3 +--
 drivers/media/platform/omap/omap_vout_vrfb.c   |  2 +-
 drivers/media/platform/pxa_camera.c            | 13 +++++++++++--
 drivers/rapidio/devices/rio_mport_cdev.c       |  3 +--
 include/linux/dmaengine.h                      | 18 +++---------------
 9 files changed, 25 insertions(+), 42 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index 85ecec2c40005..6e43c9c428e68 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -259,8 +259,8 @@ The details of these operations are:
 
       dma_cookie_t dmaengine_submit(struct dma_async_tx_descriptor *desc)
 
-   This returns a cookie can be used to check the progress of DMA engine
-   activity via other DMA engine calls not covered in this document.
+   This returns a cookie that can be used to check the progress of a transaction
+   via dma_async_is_tx_complete().
 
    dmaengine_submit() will not start the DMA operation, it merely adds
    it to the pending queue. For this, see step 5, dma_async_issue_pending.
@@ -340,22 +340,11 @@ Further APIs
    .. code-block:: c
 
       enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
-		dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
-
-   This can be used to check the status of the channel. Please see
-   the documentation in include/linux/dmaengine.h for a more complete
-   description of this API.
+		dma_cookie_t cookie)
 
    This can be used with the cookie returned from dmaengine_submit()
    to check for completion of a specific DMA transaction.
 
-   .. note::
-
-      Not all DMA engine drivers can return reliable information for
-      a running DMA channel. It is recommended that DMA engine users
-      pause or stop (via dmaengine_terminate_all()) the channel before
-      using this API.
-
 5. Synchronize termination API
 
    .. code-block:: c
diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 0072c9c7efd34..e9e9de18d6b02 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -543,10 +543,10 @@ where to put them)
 
 dma_cookie_t
 
-- it's a DMA transaction ID that will increment over time.
+- it's a DMA transaction ID.
 
-- Not really relevant any more since the introduction of ``virt-dma``
-  that abstracts it away.
+- The value can be chosen by the provider, or use the helper APIs
+  such as dma_cookie_assign() and dma_cookie_complete().
 
 DMA_CTRL_ACK
 
diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index d33006d43f761..9c3b6526e39f8 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -453,8 +453,7 @@ static int stm32_hash_xmit_dma(struct stm32_hash_dev *hdev,
 					 msecs_to_jiffies(100)))
 		err = -ETIMEDOUT;
 
-	if (dma_async_is_tx_complete(hdev->dma_lch, cookie,
-				     NULL, NULL) != DMA_COMPLETE)
+	if (dma_async_is_tx_complete(hdev->dma_lch, cookie) != DMA_COMPLETE)
 		err = -ETIMEDOUT;
 
 	if (err) {
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 2cfa8458b51be..590f238a0671a 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -523,7 +523,7 @@ enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie)
 
 	dma_async_issue_pending(chan);
 	do {
-		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
+		status = dma_async_is_tx_complete(chan, cookie);
 		if (time_after_eq(jiffies, dma_sync_wait_timeout)) {
 			dev_err(chan->device->dev, "%s: timeout!\n", __func__);
 			return DMA_ERROR;
diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index f696246f57fdb..0574090a80c8c 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -832,8 +832,7 @@ static int dmatest_func(void *data)
 					done->done,
 					msecs_to_jiffies(params->timeout));
 
-			status = dma_async_is_tx_complete(chan, cookie, NULL,
-							  NULL);
+			status = dma_async_is_tx_complete(chan, cookie);
 		}
 
 		if (!done->done) {
diff --git a/drivers/media/platform/omap/omap_vout_vrfb.c b/drivers/media/platform/omap/omap_vout_vrfb.c
index 0cfa0169875f0..d762939ffa5de 100644
--- a/drivers/media/platform/omap/omap_vout_vrfb.c
+++ b/drivers/media/platform/omap/omap_vout_vrfb.c
@@ -289,7 +289,7 @@ int omap_vout_prepare_vrfb(struct omap_vout_device *vout,
 					 vout->vrfb_dma_tx.tx_status == 1,
 					 VRFB_TX_TIMEOUT);
 
-	status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
+	status = dma_async_is_tx_complete(chan, cookie);
 
 	if (vout->vrfb_dma_tx.tx_status == 0) {
 		pr_err("%s: Timeout while waiting for DMA\n", __func__);
diff --git a/drivers/media/platform/pxa_camera.c b/drivers/media/platform/pxa_camera.c
index 3ba00b0f93200..6d5c36ea6622a 100644
--- a/drivers/media/platform/pxa_camera.c
+++ b/drivers/media/platform/pxa_camera.c
@@ -1049,8 +1049,17 @@ static void pxa_camera_dma_irq(struct pxa_camera_dev *pcdev,
 	last_buf = list_entry(pcdev->capture.prev,
 			      struct pxa_buffer, queue);
 	last_status = dma_async_is_tx_complete(pcdev->dma_chans[chan],
-					       last_buf->cookie[chan],
-					       NULL, &last_issued);
+					       last_buf->cookie[chan]);
+	/*
+	 * Peek into the channel and read the last cookie that was issued.
+	 * This is a layering violation - the dmaengine API does not officially
+	 * provide this information. Since this camera driver is tightly coupled
+	 * with a specific DMA device we know exactly how this cookie value will
+	 * behave. Otherwise, this wouldn't be safe.
+	 */
+	last_issued = pcdev->dma_chans[chan]->cookie;
+	barrier();
+
 	if (camera_status & overrun &&
 	    last_status != DMA_COMPLETE) {
 		dev_dbg(pcdev_to_dev(pcdev), "FIFO overrun! CISR: %x\n",
diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 7df466e222820..790e0c7a3306c 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -597,8 +597,7 @@ static void dma_xfer_callback(void *param)
 	struct mport_dma_req *req = (struct mport_dma_req *)param;
 	struct mport_cdev_priv *priv = req->priv;
 
-	req->status = dma_async_is_tx_complete(priv->dmach, req->cookie,
-					       NULL, NULL);
+	req->status = dma_async_is_tx_complete(priv->dmach, req->cookie);
 	complete(&req->req_comp);
 	kref_put(&req->refcount, dma_req_free);
 }
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 8c4934bc038ec..5f884fffe74cc 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1436,25 +1436,13 @@ static inline void dma_async_issue_pending(struct dma_chan *chan)
  * dma_async_is_tx_complete - poll for transaction completion
  * @chan: DMA channel
  * @cookie: transaction identifier to check status of
- * @last: returns last completed cookie, can be NULL
- * @used: returns last issued cookie, can be NULL
- *
- * If @last and @used are passed in, upon return they reflect the most
- * recently submitted (used) cookie and the most recently completed
- * cookie.
  */
 static inline enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
-	dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
+	dma_cookie_t cookie)
 {
 	struct dma_tx_state state;
-	enum dma_status status;
-
-	status = chan->device->device_tx_status(chan, cookie, &state);
-	if (last)
-		*last = state.last;
-	if (used)
-		*used = state.used;
-	return status;
+
+	return chan->device->device_tx_status(chan, cookie, &state);
 }
 
 #ifdef CONFIG_DMA_ENGINE
-- 
2.33.1

