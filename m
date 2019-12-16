Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5A5B12199E
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2019 20:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfLPTBh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 14:01:37 -0500
Received: from ale.deltatee.com ([207.54.116.67]:34944 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbfLPTB0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Dec 2019 14:01:26 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1igvcR-0005jG-3f; Mon, 16 Dec 2019 12:01:24 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1igvcQ-0005Zj-Jk; Mon, 16 Dec 2019 12:01:22 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Kit Chow <kchow@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon, 16 Dec 2019 12:01:19 -0700
Message-Id: <20191216190120.21374-5-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216190120.21374-1-logang@deltatee.com>
References: <20191216190120.21374-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, dan.j.williams@intel.com, dave.jiang@intel.com, kchow@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE,MYRULES_NO_TEXT autolearn=no autolearn_force=no
        version=3.4.2
Subject: [PATCH 4/5] dmaengine: Add reference counting to dma_device struct
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Adding a reference count helps drivers to properly implement the unbind
while in use case.

References are taken and put every time a channel is allocated or freed.

Once the final reference is put, the device is removed from the
dma_device_list and a release callback function is called to signal
the driver to free the memory.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/dmaengine.c   | 57 +++++++++++++++++++++++++++++++++------
 include/linux/dmaengine.h |  8 +++++-
 2 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 1f9a6293f15a..e316abe3672d 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -342,6 +342,23 @@ static void balance_ref_count(struct dma_chan *chan)
 	}
 }
 
+static void dma_device_release(struct kref *ref)
+{
+	struct dma_device *device = container_of(ref, struct dma_device, ref);
+
+	list_del_rcu(&device->global_node);
+	dma_channel_rebalance();
+
+	if (device->device_release)
+		device->device_release(device);
+}
+
+static void dma_device_put(struct dma_device *device)
+{
+	lockdep_assert_held(&dma_list_mutex);
+	kref_put(&device->ref, dma_device_release);
+}
+
 /**
  * dma_chan_get - try to grab a dma channel's parent driver module
  * @chan - channel to grab
@@ -362,6 +379,12 @@ static int dma_chan_get(struct dma_chan *chan)
 	if (!try_module_get(owner))
 		return -ENODEV;
 
+	ret = kref_get_unless_zero(&chan->device->ref);
+	if (!ret) {
+		ret = -ENODEV;
+		goto module_put_out;
+	}
+
 	/* allocate upon first client reference */
 	if (chan->device->device_alloc_chan_resources) {
 		ret = chan->device->device_alloc_chan_resources(chan);
@@ -377,6 +400,8 @@ static int dma_chan_get(struct dma_chan *chan)
 	return 0;
 
 err_out:
+	dma_device_put(chan->device);
+module_put_out:
 	module_put(owner);
 	return ret;
 }
@@ -402,6 +427,7 @@ static void dma_chan_put(struct dma_chan *chan)
 		chan->device->device_free_chan_resources(chan);
 	}
 
+	dma_device_put(chan->device);
 	module_put(dma_chan_to_owner(chan));
 
 	/* If the channel is used via a DMA request router, free the mapping */
@@ -837,14 +863,14 @@ EXPORT_SYMBOL(dmaengine_get);
  */
 void dmaengine_put(void)
 {
-	struct dma_device *device;
+	struct dma_device *device, *_d;
 	struct dma_chan *chan;
 
 	mutex_lock(&dma_list_mutex);
 	dmaengine_ref_count--;
 	BUG_ON(dmaengine_ref_count < 0);
 	/* drop channel references */
-	list_for_each_entry(device, &dma_device_list, global_node) {
+	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
 		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
 			continue;
 		list_for_each_entry(chan, &device->channels, device_node)
@@ -906,6 +932,10 @@ static int get_dma_id(struct dma_device *device)
 /**
  * dma_async_device_register - registers DMA devices found
  * @device: &dma_device
+ *
+ * After calling this routine the structure should not be freed except in the
+ * device_release() callback which will be called after
+ * dma_async_device_unregister() is called and no further references are taken.
  */
 int dma_async_device_register(struct dma_device *device)
 {
@@ -999,6 +1029,12 @@ int dma_async_device_register(struct dma_device *device)
 		return -EIO;
 	}
 
+	if (!device->device_release)
+		dev_warn(device->dev,
+			 "WARN: Device release is not defined so it is not safe to unbind this driver while in use\n");
+
+	kref_init(&device->ref);
+
 	/* note: this only matters in the
 	 * CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH=n case
 	 */
@@ -1115,13 +1151,8 @@ void dma_async_device_unregister(struct dma_device *device)
 {
 	struct dma_chan *chan;
 
-	mutex_lock(&dma_list_mutex);
-	list_del_rcu(&device->global_node);
-	dma_channel_rebalance();
-	mutex_unlock(&dma_list_mutex);
-
 	list_for_each_entry(chan, &device->channels, device_node) {
-		WARN_ONCE(chan->client_count,
+		WARN_ONCE(!device->device_release && chan->client_count,
 			  "%s called while %d clients hold a reference\n",
 			  __func__, chan->client_count);
 		mutex_lock(&dma_list_mutex);
@@ -1130,6 +1161,16 @@ void dma_async_device_unregister(struct dma_device *device)
 		device_unregister(&chan->dev->device);
 		free_percpu(chan->local);
 	}
+
+	mutex_lock(&dma_list_mutex);
+	/*
+	 * setting DMA_PRIVATE ensures the device being torn down will not
+	 * be used in the channel_table
+	 */
+	dma_cap_set(DMA_PRIVATE, device->cap_mask);
+	dma_channel_rebalance();
+	dma_device_put(device);
+	mutex_unlock(&dma_list_mutex);
 }
 EXPORT_SYMBOL(dma_async_device_unregister);
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 13aa0abb71de..61e59a544af2 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -719,9 +719,14 @@ struct dma_filter {
  *	will just return a simple status code
  * @device_issue_pending: push pending transactions to hardware
  * @descriptor_reuse: a submitted transfer can be resubmitted after completion
+ * @device_release: called sometime atfer dma_async_device_unregister() is
+ *     called and there are no further references to this structure. This
+ *     must be implemented to free resources however many existing drivers
+ *     do not and are therefore not safe to unbind while in use.
+ *
  */
 struct dma_device {
-
+	struct kref ref;
 	unsigned int chancnt;
 	unsigned int privatecnt;
 	struct list_head channels;
@@ -802,6 +807,7 @@ struct dma_device {
 					    dma_cookie_t cookie,
 					    struct dma_tx_state *txstate);
 	void (*device_issue_pending)(struct dma_chan *chan);
+	void (*device_release)(struct dma_device *dev);
 };
 
 static inline int dmaengine_slave_config(struct dma_chan *chan,
-- 
2.20.1

