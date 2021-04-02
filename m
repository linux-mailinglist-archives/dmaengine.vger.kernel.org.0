Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C264B352FFF
	for <lists+dmaengine@lfdr.de>; Fri,  2 Apr 2021 21:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbhDBT5E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Apr 2021 15:57:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:26286 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235256AbhDBT5D (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 2 Apr 2021 15:57:03 -0400
IronPort-SDR: GqTPKS+izQzgGF/LEHjjR79nCe+cVNVtpQrviiMRAYqsW7CQWe401UbUh6Y5PHG2WeL9bi2L7J
 w9jzVlVgp0SQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="190294418"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="190294418"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 12:57:00 -0700
IronPort-SDR: 6if1xdOwCrfrliHonCAwo7SIWJF6AmQKG6TP9Dg6jmcm/N5ohm/hs/mrhdicZb1val6OM771f3
 9aGMw2JiWLbQ==
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="417173029"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 12:57:00 -0700
Subject: [PATCH v9 01/11] dmaengine: idxd: fix dma device lifetime
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Date:   Fri, 02 Apr 2021 12:56:59 -0700
Message-ID: <161739341962.2945060.9004867866071099415.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
References: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The devm managed lifetime is incompatible with 'struct device' objects that
resides in idxd context. This is one of the series that clean up the idxd
driver 'struct device' lifetime. Remove embedding of dma_device and dma_chan
in idxd since it's not the only interface that idxd will use. The freeing of
the dma_device will be managed by the ->release() function.

Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dma/idxd/device.c |    2 +
 drivers/dma/idxd/dma.c    |   65 +++++++++++++++++++++++++++++++++++++--------
 drivers/dma/idxd/idxd.h   |   17 ++++++++++--
 3 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 84a6ea60ecf0..971a10a60093 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -186,7 +186,7 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
 		desc->id = i;
 		desc->wq = wq;
 		desc->cpu = -1;
-		dma_async_tx_descriptor_init(&desc->txd, &wq->dma_chan);
+		dma_async_tx_descriptor_init(&desc->txd, &wq->idxd_chan->chan);
 		desc->txd.tx_submit = idxd_dma_tx_submit;
 	}
 
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index a15e50126434..2bfa9c7de886 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -14,7 +14,10 @@
 
 static inline struct idxd_wq *to_idxd_wq(struct dma_chan *c)
 {
-	return container_of(c, struct idxd_wq, dma_chan);
+	struct idxd_dma_chan *idxd_chan;
+
+	idxd_chan = container_of(c, struct idxd_dma_chan, chan);
+	return idxd_chan->wq;
 }
 
 void idxd_dma_complete_txd(struct idxd_desc *desc,
@@ -156,14 +159,25 @@ dma_cookie_t idxd_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 
 static void idxd_dma_release(struct dma_device *device)
 {
+	struct idxd_dma_dev *idxd_dma = container_of(device, struct idxd_dma_dev, dma);
+
+	kfree(idxd_dma);
 }
 
 int idxd_register_dma_device(struct idxd_device *idxd)
 {
-	struct dma_device *dma = &idxd->dma_dev;
+	struct idxd_dma_dev *idxd_dma;
+	struct dma_device *dma;
+	struct device *dev = &idxd->pdev->dev;
+	int rc;
+
+	idxd_dma = kzalloc_node(sizeof(*idxd_dma), GFP_KERNEL, dev_to_node(dev));
+	if (!idxd_dma)
+		return -ENOMEM;
 
+	dma = &idxd_dma->dma;
 	INIT_LIST_HEAD(&dma->channels);
-	dma->dev = &idxd->pdev->dev;
+	dma->dev = dev;
 
 	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
 	dma_cap_set(DMA_COMPLETION_NO_ORDER, dma->cap_mask);
@@ -179,35 +193,64 @@ int idxd_register_dma_device(struct idxd_device *idxd)
 	dma->device_alloc_chan_resources = idxd_dma_alloc_chan_resources;
 	dma->device_free_chan_resources = idxd_dma_free_chan_resources;
 
-	return dma_async_device_register(&idxd->dma_dev);
+	rc = dma_async_device_register(dma);
+	if (rc < 0) {
+		kfree(idxd_dma);
+		return rc;
+	}
+
+	idxd_dma->idxd = idxd;
+	/*
+	 * This pointer is protected by the refs taken by the dma_chan. It will remain valid
+	 * as long as there are outstanding channels.
+	 */
+	idxd->idxd_dma = idxd_dma;
+	return 0;
 }
 
 void idxd_unregister_dma_device(struct idxd_device *idxd)
 {
-	dma_async_device_unregister(&idxd->dma_dev);
+	dma_async_device_unregister(&idxd->idxd_dma->dma);
 }
 
 int idxd_register_dma_channel(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
-	struct dma_device *dma = &idxd->dma_dev;
-	struct dma_chan *chan = &wq->dma_chan;
+	struct dma_device *dma = &idxd->idxd_dma->dma;
+	struct device *dev = &idxd->pdev->dev;
+	struct idxd_dma_chan *idxd_chan;
+	struct dma_chan *chan;
 	int rc;
 
-	memset(&wq->dma_chan, 0, sizeof(struct dma_chan));
+	idxd_chan = kzalloc_node(sizeof(*idxd_chan), GFP_KERNEL, dev_to_node(dev));
+	if (!idxd_chan)
+		return -ENOMEM;
+
+	chan = &idxd_chan->chan;
 	chan->device = dma;
 	list_add_tail(&chan->device_node, &dma->channels);
 	rc = dma_async_device_channel_register(dma, chan);
-	if (rc < 0)
+	if (rc < 0) {
+		kfree(idxd_chan);
 		return rc;
+	}
+
+	wq->idxd_chan = idxd_chan;
+	idxd_chan->wq = wq;
+	get_device(&wq->conf_dev);
 
 	return 0;
 }
 
 void idxd_unregister_dma_channel(struct idxd_wq *wq)
 {
-	struct dma_chan *chan = &wq->dma_chan;
+	struct idxd_dma_chan *idxd_chan = wq->idxd_chan;
+	struct dma_chan *chan = &idxd_chan->chan;
+	struct idxd_dma_dev *idxd_dma = wq->idxd->idxd_dma;
 
-	dma_async_device_channel_unregister(&wq->idxd->dma_dev, chan);
+	dma_async_device_channel_unregister(&idxd_dma->dma, chan);
 	list_del(&chan->device_node);
+	kfree(wq->idxd_chan);
+	wq->idxd_chan = NULL;
+	put_device(&wq->conf_dev);
 }
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 81a0e65fd316..40001c46d95c 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -14,6 +14,9 @@
 
 extern struct kmem_cache *idxd_desc_pool;
 
+struct idxd_device;
+struct idxd_wq;
+
 #define IDXD_REG_TIMEOUT	50
 #define IDXD_DRAIN_TIMEOUT	5000
 
@@ -96,6 +99,11 @@ enum idxd_complete_type {
 	IDXD_COMPLETE_DEV_FAIL,
 };
 
+struct idxd_dma_chan {
+	struct dma_chan chan;
+	struct idxd_wq *wq;
+};
+
 struct idxd_wq {
 	void __iomem *portal;
 	struct device conf_dev;
@@ -125,7 +133,7 @@ struct idxd_wq {
 	int compls_size;
 	struct idxd_desc **descs;
 	struct sbitmap_queue sbq;
-	struct dma_chan dma_chan;
+	struct idxd_dma_chan *idxd_chan;
 	char name[WQ_NAME_SIZE + 1];
 	u64 max_xfer_bytes;
 	u32 max_batch_size;
@@ -162,6 +170,11 @@ enum idxd_device_flag {
 	IDXD_FLAG_PASID_ENABLED,
 };
 
+struct idxd_dma_dev {
+	struct idxd_device *idxd;
+	struct dma_device dma;
+};
+
 struct idxd_device {
 	enum idxd_type type;
 	struct device conf_dev;
@@ -210,7 +223,7 @@ struct idxd_device {
 	int num_wq_irqs;
 	struct idxd_irq_entry *irq_entries;
 
-	struct dma_device dma_dev;
+	struct idxd_dma_dev *idxd_dma;
 	struct workqueue_struct *wq;
 	struct work_struct work;
 };


