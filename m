Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9831045A3
	for <lists+dmaengine@lfdr.de>; Wed, 20 Nov 2019 22:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfKTVYQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Nov 2019 16:24:16 -0500
Received: from mga05.intel.com ([192.55.52.43]:31719 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfKTVYP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Nov 2019 16:24:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 13:24:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="237898627"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002.fm.intel.com with ESMTP; 20 Nov 2019 13:24:14 -0800
Subject: [PATCH RFC 05/14] dmaengine: add dma_request support functions
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Cc:     dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, axboe@kernel.dk,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Date:   Wed, 20 Nov 2019 14:24:13 -0700
Message-ID: <157428505388.36836.6718021856806210449.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In order to provide a lockless submission path, the request context needs
to be pre-allocated rather than pulling from a memory pool.
Use the common request allocation call request_from_pages_alloc() to
accomplish this. The sbitmap code will be used to get the next
free request context. This is a simplified version of what blk-mq does
(not sbitmap_queue). The config option DMA_ENGINE_REQUEST is added so that
only drivers that supports dma request would enable the code.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/Kconfig       |    5 ++
 drivers/dma/Makefile      |    1 
 drivers/dma/dma-request.c |   96 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h |   57 +++++++++++++++++++++++++++
 4 files changed, 159 insertions(+)
 create mode 100644 drivers/dma/dma-request.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 7af874b69ffb..8885e9d3f363 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -56,6 +56,11 @@ config DMA_OF
 	depends on OF
 	select DMA_ENGINE
 
+config DMA_ENGINE_REQUEST
+	def_bool n
+	depends on DMA_ENGINE
+	select SBITMAP
+
 #devices
 config ALTERA_MSGDMA
 	tristate "Altera / Intel mSGDMA Engine"
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index f5ce8665e944..205f343e39fe 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_DMA_ENGINE) += dmaengine.o
 obj-$(CONFIG_DMA_VIRTUAL_CHANNELS) += virt-dma.o
 obj-$(CONFIG_DMA_ACPI) += acpi-dma.o
 obj-$(CONFIG_DMA_OF) += of-dma.o
+obj-$(CONFIG_DMA_ENGINE_REQUEST) += dma-request.o
 
 #dmatest
 obj-$(CONFIG_DMATEST) += dmatest.o
diff --git a/drivers/dma/dma-request.c b/drivers/dma/dma-request.c
new file mode 100644
index 000000000000..01390f179107
--- /dev/null
+++ b/drivers/dma/dma-request.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright(c) 2019 Intel Corporation. All rights reserved.  */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/device.h>
+#include <linux/dmaengine.h>
+#include <linux/mempool.h>
+
+struct dma_request *dma_chan_alloc_request(struct dma_chan *chan)
+{
+	int nr;
+	struct dma_request *req;
+
+	nr = sbitmap_get(&chan->sbmap, 0, false);
+	if (nr < 0)
+		return NULL;
+
+	req = chan->rqs[nr];
+	req->rq_private = NULL;
+	req->callback = NULL;
+	memset(&req->result, 0, sizeof(struct dmaengine_result));
+	return req;
+}
+EXPORT_SYMBOL_GPL(dma_chan_alloc_request);
+
+void dma_chan_free_request(struct dma_chan *chan, struct dma_request *rq)
+{
+	sbitmap_clear_bit(&chan->sbmap, rq->id);
+}
+EXPORT_SYMBOL_GPL(dma_chan_free_request);
+
+void dma_chan_free_request_resources(struct dma_chan *chan)
+{
+	request_from_pages_free(&chan->page_list);
+	kfree(chan->rqs);
+}
+EXPORT_SYMBOL_GPL(dma_chan_free_request_resources);
+
+static void dma_chan_assign_request(void *ctx, void *ptr, int idx)
+{
+	struct dma_chan *chan = (struct dma_chan *)ctx;
+	struct dma_request *rq = ptr;
+
+	chan->rqs[idx] = rq;
+}
+
+int dma_chan_alloc_request_resources(struct dma_chan *chan)
+{
+	int i, node, rc, id = 0;
+	size_t rq_size;
+
+	/* Requests are already allocated */
+	if (chan->rqs)
+		return 0;
+
+	node = dev_to_node(chan->device->dev);
+	rc = sbitmap_init_node(&chan->sbmap, chan->depth, -1,
+			       GFP_KERNEL, node);
+	if (rc < 0)
+		return rc;
+
+	chan->rqs = kcalloc_node(chan->depth, sizeof(struct dma_request *),
+				 GFP_KERNEL, node);
+	if (!chan->rqs) {
+		rc = -ENOMEM;
+		goto fail;
+	}
+
+	INIT_LIST_HEAD(&chan->page_list);
+
+	rq_size = round_up(sizeof(struct dma_request) +
+			chan->max_sgs * sizeof(struct scatterlist),
+			cache_line_size());
+
+	rc = request_from_pages_alloc((void *)chan, chan->depth, rq_size,
+				      &chan->page_list, 4, node,
+				      dma_chan_assign_request);
+	if (rc < 0)
+		goto fail;
+
+	for (i = 0; i < rc; i++) {
+		struct dma_request *rq = chan->rqs[i];
+
+		rq->id = id++;
+		rq->chan = chan;
+	}
+
+	return 0;
+
+ fail:
+	sbitmap_free(&chan->sbmap);
+	dma_chan_free_request_resources(chan);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(dma_chan_alloc_request_resources);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 0202d44a17a5..7bc8c3f8283f 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -12,6 +12,8 @@
 #include <linux/scatterlist.h>
 #include <linux/bitmap.h>
 #include <linux/types.h>
+#include <linux/sbitmap.h>
+#include <linux/bvec.h>
 #include <asm/page.h>
 
 /**
@@ -176,6 +178,8 @@ struct dma_interleaved_template {
  * @DMA_PREP_CMD: tell the driver that the data passed to DMA API is command
  *  data and the descriptor should be in different format from normal
  *  data descriptors.
+ *  @DMA_SUBMIT_NONBLOCK: tell the driver do not wait for resources if submit
+ *  is not possible.
  */
 enum dma_ctrl_flags {
 	DMA_PREP_INTERRUPT = (1 << 0),
@@ -186,6 +190,7 @@ enum dma_ctrl_flags {
 	DMA_PREP_FENCE = (1 << 5),
 	DMA_CTRL_REUSE = (1 << 6),
 	DMA_PREP_CMD = (1 << 7),
+	DMA_SUBMIT_NONBLOCK = (1 << 8),
 };
 
 /**
@@ -268,6 +273,13 @@ struct dma_chan {
 	struct dma_router *router;
 	void *route_data;
 
+	/* DMA request */
+	int max_sgs;
+	int depth;
+	struct sbitmap sbmap;
+	struct dma_request **rqs;
+	struct list_head page_list;
+
 	void *private;
 };
 
@@ -511,6 +523,25 @@ struct dma_async_tx_descriptor {
 #endif
 };
 
+struct dma_request {
+	int id;
+	struct dma_chan *chan;
+	enum dma_transaction_type cmd;
+	enum dma_ctrl_flags flags;
+	struct bio_vec bvec;
+	dma_addr_t pg_dma;
+	int sg_nents;
+	void *rq_private;
+
+	/* Set by driver */
+	dma_async_tx_callback_result callback;
+	struct dmaengine_result result;
+	void *callback_param;
+
+	/* Leave as last member for flexible array of scatterlist */
+	struct scatterlist sg[];
+};
+
 #ifdef CONFIG_DMA_ENGINE
 static inline void dma_set_unmap(struct dma_async_tx_descriptor *tx,
 				 struct dmaengine_unmap_data *unmap)
@@ -1359,6 +1390,32 @@ static inline int dma_get_slave_caps(struct dma_chan *chan,
 }
 #endif
 
+#ifdef CONFIG_DMA_ENGINE_REQUEST
+struct dma_request *dma_chan_alloc_request(struct dma_chan *chan);
+void dma_chan_free_request(struct dma_chan *chan, struct dma_request *rq);
+void dma_chan_free_request_resources(struct dma_chan *chan);
+int dma_chan_alloc_request_resources(struct dma_chan *chan);
+#else
+static inline struct dma_request *dma_chan_alloc_request(struct dma_chan *chan)
+{
+	return NULL;
+}
+
+static inline void dma_chan_free_request(struct dma_chan *chan,
+					 struct dma_request *rq)
+{
+}
+
+static inline void dma_chan_free_request_resources(struct dma_chan *chan)
+{
+}
+
+static inline int dma_chan_alloc_request_resources(struct dma_chan *chan)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 #define dma_request_slave_channel_reason(dev, name) dma_request_chan(dev, name)
 
 static inline int dmaengine_desc_set_reuse(struct dma_async_tx_descriptor *tx)

