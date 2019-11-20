Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE7710459C
	for <lists+dmaengine@lfdr.de>; Wed, 20 Nov 2019 22:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfKTVX6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Nov 2019 16:23:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:53821 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfKTVX6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Nov 2019 16:23:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 13:23:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="209676825"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003.jf.intel.com with ESMTP; 20 Nov 2019 13:23:55 -0800
Subject: [PATCH RFC 02/14] dmaengine: break out channel registration
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Cc:     dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, axboe@kernel.dk,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Date:   Wed, 20 Nov 2019 14:23:55 -0700
Message-ID: <157428503565.36836.13496272413647602295.stgit@djiang5-desk3.ch.intel.com>
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

In preparation for dynamic channel registration, the code segment that
does the channel registration is broken out to its own function.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/dmaengine.c   |  157 ++++++++++++++++++++++++++++++---------------
 include/linux/dmaengine.h |    4 +
 2 files changed, 107 insertions(+), 54 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 03ac4b96117c..a20ab568b637 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -900,15 +900,109 @@ static int get_dma_id(struct dma_device *device)
 	return 0;
 }
 
+static int __dma_async_device_channel_register(struct dma_device *device,
+					       struct dma_chan *chan,
+					       int chan_id)
+{
+	int rc = 0;
+	int chancnt = device->chancnt;
+	atomic_t *idr_ref;
+	struct dma_chan *tchan;
+
+	tchan = list_first_entry_or_null(&device->channels,
+					 struct dma_chan, device_node);
+	if (tchan->dev) {
+		idr_ref = tchan->dev->idr_ref;
+	} else {
+		idr_ref = kmalloc(sizeof(*idr_ref), GFP_KERNEL);
+		if (!idr_ref)
+			return -ENOMEM;
+		atomic_set(idr_ref, 0);
+	}
+
+	chan->local = alloc_percpu(typeof(*chan->local));
+	if (!chan->local)
+		goto err_out;
+	chan->dev = kzalloc(sizeof(*chan->dev), GFP_KERNEL);
+	if (!chan->dev) {
+		free_percpu(chan->local);
+		chan->local = NULL;
+		goto err_out;
+	}
+
+	/*
+	 * When the chan_id is a negative value, we are dynamically adding
+	 * the channel. Otherwise we are static enumerating.
+	 */
+	chan->chan_id = chan_id < 0 ? chancnt : chan_id;
+	chan->dev->device.class = &dma_devclass;
+	chan->dev->device.parent = device->dev;
+	chan->dev->chan = chan;
+	chan->dev->idr_ref = idr_ref;
+	chan->dev->dev_id = device->dev_id;
+	atomic_inc(idr_ref);
+	dev_set_name(&chan->dev->device, "dma%dchan%d",
+		     device->dev_id, chan->chan_id);
+
+	rc = device_register(&chan->dev->device);
+	if (rc)
+		goto err_out;
+	chan->client_count = 0;
+	device->chancnt = chan->chan_id + 1;
+
+	return 0;
+
+ err_out:
+	free_percpu(chan->local);
+	kfree(chan->dev);
+	if (atomic_dec_return(idr_ref) == 0)
+		kfree(idr_ref);
+	return rc;
+}
+
+int dma_async_device_channel_register(struct dma_device *device,
+				      struct dma_chan *chan)
+{
+	int rc;
+
+	rc = __dma_async_device_channel_register(device, chan, -1);
+	if (rc < 0)
+		return rc;
+
+	dma_channel_rebalance();
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dma_async_device_channel_register);
+
+static void __dma_async_device_channel_unregister(struct dma_device *device,
+						  struct dma_chan *chan)
+{
+	WARN_ONCE(chan->client_count,
+		  "%s called while %d clients hold a reference\n",
+		  __func__, chan->client_count);
+	mutex_lock(&dma_list_mutex);
+	chan->dev->chan = NULL;
+	mutex_unlock(&dma_list_mutex);
+	device_unregister(&chan->dev->device);
+	free_percpu(chan->local);
+}
+
+void dma_async_device_channel_unregister(struct dma_device *device,
+					 struct dma_chan *chan)
+{
+	__dma_async_device_channel_unregister(device, chan);
+	dma_channel_rebalance();
+}
+EXPORT_SYMBOL_GPL(dma_async_device_channel_unregister);
+
 /**
  * dma_async_device_register - registers DMA devices found
  * @device: &dma_device
  */
 int dma_async_device_register(struct dma_device *device)
 {
-	int chancnt = 0, rc;
+	int rc, i = 0;
 	struct dma_chan* chan;
-	atomic_t *idr_ref;
 
 	if (!device)
 		return -ENODEV;
@@ -1000,59 +1094,23 @@ int dma_async_device_register(struct dma_device *device)
 	if (device_has_all_tx_types(device))
 		dma_cap_set(DMA_ASYNC_TX, device->cap_mask);
 
-	idr_ref = kmalloc(sizeof(*idr_ref), GFP_KERNEL);
-	if (!idr_ref)
-		return -ENOMEM;
 	rc = get_dma_id(device);
-	if (rc != 0) {
-		kfree(idr_ref);
+	if (rc != 0)
 		return rc;
-	}
-
-	atomic_set(idr_ref, 0);
 
 	/* represent channels in sysfs. Probably want devs too */
 	list_for_each_entry(chan, &device->channels, device_node) {
-		rc = -ENOMEM;
-		chan->local = alloc_percpu(typeof(*chan->local));
-		if (chan->local == NULL)
+		rc = __dma_async_device_channel_register(device, chan, i++);
+		if (rc < 0)
 			goto err_out;
-		chan->dev = kzalloc(sizeof(*chan->dev), GFP_KERNEL);
-		if (chan->dev == NULL) {
-			free_percpu(chan->local);
-			chan->local = NULL;
-			goto err_out;
-		}
-
-		chan->chan_id = chancnt++;
-		chan->dev->device.class = &dma_devclass;
-		chan->dev->device.parent = device->dev;
-		chan->dev->chan = chan;
-		chan->dev->idr_ref = idr_ref;
-		chan->dev->dev_id = device->dev_id;
-		atomic_inc(idr_ref);
-		dev_set_name(&chan->dev->device, "dma%dchan%d",
-			     device->dev_id, chan->chan_id);
-
-		rc = device_register(&chan->dev->device);
-		if (rc) {
-			free_percpu(chan->local);
-			chan->local = NULL;
-			kfree(chan->dev);
-			atomic_dec(idr_ref);
-			goto err_out;
-		}
-		chan->client_count = 0;
 	}
 
-	if (!chancnt) {
+	if (!device->chancnt) {
 		dev_err(device->dev, "%s: device has no channels!\n", __func__);
 		rc = -ENODEV;
 		goto err_out;
 	}
 
-	device->chancnt = chancnt;
-
 	mutex_lock(&dma_list_mutex);
 	/* take references on public channels */
 	if (dmaengine_ref_count && !dma_has_cap(DMA_PRIVATE, device->cap_mask))
@@ -1080,9 +1138,8 @@ int dma_async_device_register(struct dma_device *device)
 
 err_out:
 	/* if we never registered a channel just release the idr */
-	if (atomic_read(idr_ref) == 0) {
+	if (!device->chancnt) {
 		ida_free(&dma_ida, device->dev_id);
-		kfree(idr_ref);
 		return rc;
 	}
 
@@ -1115,16 +1172,8 @@ void dma_async_device_unregister(struct dma_device *device)
 	dma_channel_rebalance();
 	mutex_unlock(&dma_list_mutex);
 
-	list_for_each_entry(chan, &device->channels, device_node) {
-		WARN_ONCE(chan->client_count,
-			  "%s called while %d clients hold a reference\n",
-			  __func__, chan->client_count);
-		mutex_lock(&dma_list_mutex);
-		chan->dev->chan = NULL;
-		mutex_unlock(&dma_list_mutex);
-		device_unregister(&chan->dev->device);
-		free_percpu(chan->local);
-	}
+	list_for_each_entry(chan, &device->channels, device_node)
+		__dma_async_device_channel_unregister(device, chan);
 }
 EXPORT_SYMBOL(dma_async_device_unregister);
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 8fcdee1c0cf9..0202d44a17a5 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1399,6 +1399,10 @@ static inline int dmaengine_desc_free(struct dma_async_tx_descriptor *desc)
 int dma_async_device_register(struct dma_device *device);
 int dmaenginem_async_device_register(struct dma_device *device);
 void dma_async_device_unregister(struct dma_device *device);
+int dma_async_device_channel_register(struct dma_device *device,
+				      struct dma_chan *chan);
+void dma_async_device_channel_unregister(struct dma_device *device,
+					 struct dma_chan *chan);
 void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
 struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
 struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);

