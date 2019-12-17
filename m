Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D008B123ADA
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2019 00:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLQXdi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Dec 2019 18:33:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:44745 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLQXdh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 17 Dec 2019 18:33:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 15:33:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,327,1571727600"; 
   d="scan'208";a="205645614"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2019 15:33:36 -0800
Subject: [PATCH RFC v3 06/14] dmaengine: add dma request submit and
 completion path support
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Cc:     dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, axboe@kernel.dk,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Date:   Tue, 17 Dec 2019 16:33:35 -0700
Message-ID: <157662561593.51652.3266493424446586707.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <157662541786.51652.7666763291600764054.stgit@djiang5-desk3.ch.intel.com>
References: <157662541786.51652.7666763291600764054.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There are several issues with the existing dmaengine submission APIs.
1. A new function pointer is introduced every time a new operation is
   added.
2. The whole submission path requires locking and requires multiple API
   calls with prep+submit+start engine.

A new DMA register function for request based DMA devices is added,
dma_async_request_device_register(). This allows the checking of parts for
dma requests that are setup.

A new submission API call that can start an I/O immediately in a single
call and will be lockless is being introduced. A helper function that
submits and wait is also added for consumers such as dmatest that will wait
on the completion of the I/O. And a helper function is added that completes
the I/O by either calling complete() or envoking the callback depending on
the setup for submission.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/dmaengine.c   |   59 ++++++++++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h |   67 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 3c74402f1c34..5b053624f9e3 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1050,6 +1050,37 @@ static int __dma_async_device_register(struct dma_device *device)
 	return 0;
 }
 
+/**
+ * dma_async_request_device_register - registers DMA devices found that
+ *					support DMA requests.
+ * @device: &dma_device
+ */
+int dma_async_request_device_register(struct dma_device *device)
+{
+	int rc;
+
+	if (!device)
+		return -ENODEV;
+
+	/* validate device routines */
+	if (!device->dev) {
+		pr_err("DMA device must have dev\n");
+		return -EIO;
+	}
+
+	if (!device->device_submit_request) {
+		dev_err(device->dev, "Device has no op defined\n");
+		return -EIO;
+	}
+
+	rc = __dma_async_device_register(device);
+	if (rc != 0)
+		return rc;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dma_async_request_device_register);
+
 /**
  * dma_async_device_register - registers DMA devices found
  * @device: &dma_device
@@ -1232,6 +1263,34 @@ int dmaenginem_async_device_register(struct dma_device *device)
 }
 EXPORT_SYMBOL(dmaenginem_async_device_register);
 
+/**
+ * dmaenginem_async_request_device_register - registers DMA devices
+ *					support DMA requests found
+ * @device: &dma_device
+ *
+ * The operation is managed and will be undone on driver detach.
+ */
+int dmaenginem_async_request_device_register(struct dma_device *device)
+{
+	void *p;
+	int ret;
+
+	p = devres_alloc(dmam_device_release, sizeof(void *), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	ret = dma_async_request_device_register(device);
+	if (!ret) {
+		*(struct dma_device **)p = device;
+		devres_add(device->dev, p);
+	} else {
+		devres_free(p);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(dmaenginem_async_request_device_register);
+
 struct dmaengine_unmap_pool {
 	struct kmem_cache *cache;
 	const char *name;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 7bc8c3f8283f..220d241d71ed 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -461,6 +461,7 @@ enum dmaengine_tx_result {
 	DMA_TRANS_NOERROR = 0,		/* SUCCESS */
 	DMA_TRANS_READ_FAILED,		/* Source DMA read failed */
 	DMA_TRANS_WRITE_FAILED,		/* Destination DMA write failed */
+	DMA_TRANS_ERROR,		/* General error not rd/wr */
 	DMA_TRANS_ABORTED,		/* Op never submitted / aborted */
 };
 
@@ -831,6 +832,10 @@ struct dma_device {
 					    dma_cookie_t cookie,
 					    struct dma_tx_state *txstate);
 	void (*device_issue_pending)(struct dma_chan *chan);
+
+	/* function calls for request API */
+	int (*device_submit_request)(struct dma_chan *chan,
+				     struct dma_request *req);
 };
 
 static inline int dmaengine_slave_config(struct dma_chan *chan,
@@ -1390,6 +1395,66 @@ static inline int dma_get_slave_caps(struct dma_chan *chan,
 }
 #endif
 
+/* dmaengine_submit_request - helper routine for caller to submit
+ *				a DMA request.
+ * @chan: dma channel context
+ * @req: dma request context
+ */
+static inline int dmaengine_submit_request(struct dma_chan *chan,
+					   struct dma_request *req)
+{
+	struct dma_device *ddev;
+
+	if (!chan)
+		return -EINVAL;
+
+	ddev = chan->device;
+	if (!ddev->device_submit_request)
+		return -EINVAL;
+
+	return ddev->device_submit_request(chan, req);
+}
+
+/* dmaengine_submit_request_and_wait - helper routine for caller to submit
+ *					a DMA request and wait until
+ *					completion or timeout.
+ * @chan: dma channel context
+ * @req: dma request context
+ * @timeout: time in jiffies to wait for completion timeout. A timeout of 0
+ *		equals to wait indefinitely.
+ */
+static inline int dmaengine_submit_request_and_wait(struct dma_chan *chan,
+						    struct dma_request *req,
+						    int timeout)
+{
+	int rc;
+	DECLARE_COMPLETION_ONSTACK(done);
+
+	req->rq_private = &done;
+	rc = dmaengine_submit_request(chan, req);
+	if (rc < 0)
+		return rc;
+
+	if (timeout)
+		return wait_for_completion_timeout(&done, timeout);
+
+	wait_for_completion(&done);
+	return 0;
+}
+
+/* dmaengine_request_complete - helper function to complete dma request.
+ *				If callback exists will envoke callback.
+ *
+ * @req - dma request context
+ */
+static inline void dmaengine_request_complete(struct dma_request *req)
+{
+	if (req->rq_private)
+		complete(req->rq_private);
+	else if (req->callback)
+		req->callback(req->callback_param, &req->result);
+}
+
 #ifdef CONFIG_DMA_ENGINE_REQUEST
 struct dma_request *dma_chan_alloc_request(struct dma_chan *chan);
 void dma_chan_free_request(struct dma_chan *chan, struct dma_request *rq);
@@ -1454,7 +1519,9 @@ static inline int dmaengine_desc_free(struct dma_async_tx_descriptor *desc)
 /* --- DMA device --- */
 
 int dma_async_device_register(struct dma_device *device);
+int dma_async_request_device_register(struct dma_device *device);
 int dmaenginem_async_device_register(struct dma_device *device);
+int dmaenginem_async_request_device_register(struct dma_device *device);
 void dma_async_device_unregister(struct dma_device *device);
 int dma_async_device_channel_register(struct dma_device *device,
 				      struct dma_chan *chan);

