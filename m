Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A64AC144876
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jan 2020 00:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgAUXn4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 18:43:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:49537 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgAUXnz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jan 2020 18:43:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 15:43:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="220129909"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008.jf.intel.com with ESMTP; 21 Jan 2020 15:43:53 -0800
Subject: [PATCH v5 3/9] dmaengine: add support to dynamic
 register/unregister of channels
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Cc:     dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Date:   Tue, 21 Jan 2020 16:43:53 -0700
Message-ID: <157965023364.73301.7821862091077299040.stgit@djiang5-desk3.ch.intel.com>
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

With the channel registration routines broken out, now add support code to
allow independent registering and unregistering of channels in a hotplug fashion.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/dmaengine.c   |   34 ++++++++++++++++++++++++++--------
 include/linux/dmaengine.h |    4 ++++
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 2daf2ee9bebd..51a2f2b1b2de 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -986,6 +986,20 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	return rc;
 }
 
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
 static void __dma_async_device_channel_unregister(struct dma_device *device,
 						  struct dma_chan *chan)
 {
@@ -993,12 +1007,22 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
 		  "%s called while %d clients hold a reference\n",
 		  __func__, chan->client_count);
 	mutex_lock(&dma_list_mutex);
+	list_del(&chan->device_node);
+	device->chancnt--;
 	chan->dev->chan = NULL;
 	mutex_unlock(&dma_list_mutex);
 	device_unregister(&chan->dev->device);
 	free_percpu(chan->local);
 }
 
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
@@ -1121,12 +1145,6 @@ int dma_async_device_register(struct dma_device *device)
 			goto err_out;
 	}
 
-	if (!device->chancnt) {
-		dev_err(device->dev, "%s: device has no channels!\n", __func__);
-		rc = -ENODEV;
-		goto err_out;
-	}
-
 	mutex_lock(&dma_list_mutex);
 	/* take references on public channels */
 	if (dmaengine_ref_count && !dma_has_cap(DMA_PRIVATE, device->cap_mask))
@@ -1181,9 +1199,9 @@ EXPORT_SYMBOL(dma_async_device_register);
  */
 void dma_async_device_unregister(struct dma_device *device)
 {
-	struct dma_chan *chan;
+	struct dma_chan *chan, *n;
 
-	list_for_each_entry(chan, &device->channels, device_node)
+	list_for_each_entry_safe(chan, n, &device->channels, device_node)
 		__dma_async_device_channel_unregister(device, chan);
 
 	mutex_lock(&dma_list_mutex);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 9cc0e70e7c35..f52f274773ed 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1521,6 +1521,10 @@ static inline int dmaengine_desc_free(struct dma_async_tx_descriptor *desc)
 int dma_async_device_register(struct dma_device *device);
 int dmaenginem_async_device_register(struct dma_device *device);
 void dma_async_device_unregister(struct dma_device *device);
+int dma_async_device_channel_register(struct dma_device *device,
+				      struct dma_chan *chan);
+void dma_async_device_channel_unregister(struct dma_device *device,
+					 struct dma_chan *chan);
 void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
 #define dma_request_channel(mask, x, y) \
 	__dma_request_channel(&(mask), x, y, NULL)

