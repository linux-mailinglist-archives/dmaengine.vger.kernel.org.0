Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E426F11D551
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2019 19:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbfLLSYa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Dec 2019 13:24:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:20582 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730295AbfLLSY3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 12 Dec 2019 13:24:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 10:24:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="239042146"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2019 10:24:28 -0800
Subject: [PATCH RFC v2 03/14] dmaengine: add new dma device registration
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Cc:     dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, axboe@kernel.dk,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Date:   Thu, 12 Dec 2019 11:24:28 -0700
Message-ID: <157617506831.42350.5972817923465724195.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <157617487798.42350.4471714981643413895.stgit@djiang5-desk3.ch.intel.com>
References: <157617487798.42350.4471714981643413895.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a new device registration call in order to allow dynamic registration
of channels. __dma_async_device_register() will only register the DMA
device. The channel registration is done separately.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/dmaengine.c |  106 ++++++++++++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 43 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index a20ab568b637..3c74402f1c34 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -149,10 +149,8 @@ static void chan_dev_release(struct device *dev)
 	struct dma_chan_dev *chan_dev;
 
 	chan_dev = container_of(dev, typeof(*chan_dev), device);
-	if (atomic_dec_and_test(chan_dev->idr_ref)) {
-		ida_free(&dma_ida, chan_dev->dev_id);
+	if (atomic_dec_and_test(chan_dev->idr_ref))
 		kfree(chan_dev->idr_ref);
-	}
 	kfree(chan_dev);
 }
 
@@ -950,8 +948,23 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	chan->client_count = 0;
 	device->chancnt = chan->chan_id + 1;
 
+	if (dmaengine_ref_count &&
+	    !dma_has_cap(DMA_PRIVATE, device->cap_mask)) {
+		if (dma_chan_get(chan) == -ENODEV) {
+			/*
+			 * Note we can only get here for the first
+			 * channel as the remaining channels are
+			 * guaranteed to get a reference.
+			 */
+			rc = -ENODEV;
+			goto chan_get_err;
+		}
+	}
+
 	return 0;
 
+ chan_get_err:
+	device_unregister(&chan->dev->device);
  err_out:
 	free_percpu(chan->local);
 	kfree(chan->dev);
@@ -981,6 +994,8 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
 		  "%s called while %d clients hold a reference\n",
 		  __func__, chan->client_count);
 	mutex_lock(&dma_list_mutex);
+	list_del(&chan->device_node);
+	device->chancnt--;
 	chan->dev->chan = NULL;
 	mutex_unlock(&dma_list_mutex);
 	device_unregister(&chan->dev->device);
@@ -995,13 +1010,53 @@ void dma_async_device_channel_unregister(struct dma_device *device,
 }
 EXPORT_SYMBOL_GPL(dma_async_device_channel_unregister);
 
+/**
+ * __dma_async_device_register - registers DMA devices found.
+ * Core function that registers a DMA device.
+ * @device: &dma_device
+ */
+static int __dma_async_device_register(struct dma_device *device)
+{
+	struct dma_chan *chan;
+	int rc, i = 0;
+
+	if (!device)
+		return -ENODEV;
+
+	/* Validate device routines */
+	if (!device->dev) {
+		pr_err("DMA device must have valid dev\n");
+		return -EIO;
+	}
+
+	rc = get_dma_id(device);
+	if (rc != 0)
+		return rc;
+
+	/* represent channels in sysfs. Probably want devs too */
+	list_for_each_entry(chan, &device->channels, device_node) {
+		rc = __dma_async_device_channel_register(device, chan, i++);
+		if (rc < 0)
+			return rc;
+	}
+
+	mutex_lock(&dma_list_mutex);
+	list_add_tail_rcu(&device->global_node, &dma_device_list);
+	if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
+		device->privatecnt++;	/* Always private */
+	dma_channel_rebalance();
+	mutex_unlock(&dma_list_mutex);
+
+	return 0;
+}
+
 /**
  * dma_async_device_register - registers DMA devices found
  * @device: &dma_device
  */
 int dma_async_device_register(struct dma_device *device)
 {
-	int rc, i = 0;
+	int rc;
 	struct dma_chan* chan;
 
 	if (!device)
@@ -1094,45 +1149,9 @@ int dma_async_device_register(struct dma_device *device)
 	if (device_has_all_tx_types(device))
 		dma_cap_set(DMA_ASYNC_TX, device->cap_mask);
 
-	rc = get_dma_id(device);
+	rc = __dma_async_device_register(device);
 	if (rc != 0)
-		return rc;
-
-	/* represent channels in sysfs. Probably want devs too */
-	list_for_each_entry(chan, &device->channels, device_node) {
-		rc = __dma_async_device_channel_register(device, chan, i++);
-		if (rc < 0)
-			goto err_out;
-	}
-
-	if (!device->chancnt) {
-		dev_err(device->dev, "%s: device has no channels!\n", __func__);
-		rc = -ENODEV;
 		goto err_out;
-	}
-
-	mutex_lock(&dma_list_mutex);
-	/* take references on public channels */
-	if (dmaengine_ref_count && !dma_has_cap(DMA_PRIVATE, device->cap_mask))
-		list_for_each_entry(chan, &device->channels, device_node) {
-			/* if clients are already waiting for channels we need
-			 * to take references on their behalf
-			 */
-			if (dma_chan_get(chan) == -ENODEV) {
-				/* note we can only get here for the first
-				 * channel as the remaining channels are
-				 * guaranteed to get a reference
-				 */
-				rc = -ENODEV;
-				mutex_unlock(&dma_list_mutex);
-				goto err_out;
-			}
-		}
-	list_add_tail_rcu(&device->global_node, &dma_device_list);
-	if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
-		device->privatecnt++;	/* Always private */
-	dma_channel_rebalance();
-	mutex_unlock(&dma_list_mutex);
 
 	return 0;
 
@@ -1165,15 +1184,16 @@ EXPORT_SYMBOL(dma_async_device_register);
  */
 void dma_async_device_unregister(struct dma_device *device)
 {
-	struct dma_chan *chan;
+	struct dma_chan *chan, *n;
 
 	mutex_lock(&dma_list_mutex);
 	list_del_rcu(&device->global_node);
 	dma_channel_rebalance();
 	mutex_unlock(&dma_list_mutex);
 
-	list_for_each_entry(chan, &device->channels, device_node)
+	list_for_each_entry_safe(chan, n, &device->channels, device_node)
 		__dma_async_device_channel_unregister(device, chan);
+	ida_free(&dma_ida, device->dev_id);
 }
 EXPORT_SYMBOL(dma_async_device_unregister);
 

