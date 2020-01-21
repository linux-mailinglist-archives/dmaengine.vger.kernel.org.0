Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5479144874
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jan 2020 00:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgAUXnv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 18:43:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:19278 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgAUXnv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jan 2020 18:43:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 15:43:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="259257908"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jan 2020 15:43:47 -0800
Subject: [PATCH v5 2/9] dmaengine: break out channel registration
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Cc:     dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Date:   Tue, 21 Jan 2020 16:43:47 -0700
Message-ID: <157965022778.73301.8929944324898985438.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <157965011794.73301.15960052071729101309.stgit@djiang5-desk3.ch.intel.com>
References: <157965011794.73301.15960052071729101309.stgit@djiang5-desk3.ch.intel.com>
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
 drivers/dma/dmaengine.c |  135 ++++++++++++++++++++++++++++-------------------
 1 file changed, 81 insertions(+), 54 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 7550dbdf5488..2daf2ee9bebd 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -926,6 +926,79 @@ static int get_dma_id(struct dma_device *device)
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
+static void __dma_async_device_channel_unregister(struct dma_device *device,
+						  struct dma_chan *chan)
+{
+	WARN_ONCE(!device->device_release && chan->client_count,
+		  "%s called while %d clients hold a reference\n",
+		  __func__, chan->client_count);
+	mutex_lock(&dma_list_mutex);
+	chan->dev->chan = NULL;
+	mutex_unlock(&dma_list_mutex);
+	device_unregister(&chan->dev->device);
+	free_percpu(chan->local);
+}
+
 /**
  * dma_async_device_register - registers DMA devices found
  * @device: &dma_device
@@ -936,9 +1009,8 @@ static int get_dma_id(struct dma_device *device)
  */
 int dma_async_device_register(struct dma_device *device)
 {
-	int chancnt = 0, rc;
+	int rc, i = 0;
 	struct dma_chan* chan;
-	atomic_t *idr_ref;
 
 	if (!device)
 		return -ENODEV;
@@ -1038,59 +1110,23 @@ int dma_async_device_register(struct dma_device *device)
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
@@ -1118,9 +1154,8 @@ int dma_async_device_register(struct dma_device *device)
 
 err_out:
 	/* if we never registered a channel just release the idr */
-	if (atomic_read(idr_ref) == 0) {
+	if (!device->chancnt) {
 		ida_free(&dma_ida, device->dev_id);
-		kfree(idr_ref);
 		return rc;
 	}
 
@@ -1148,16 +1183,8 @@ void dma_async_device_unregister(struct dma_device *device)
 {
 	struct dma_chan *chan;
 
-	list_for_each_entry(chan, &device->channels, device_node) {
-		WARN_ONCE(!device->device_release && chan->client_count,
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
 
 	mutex_lock(&dma_list_mutex);
 	/*

