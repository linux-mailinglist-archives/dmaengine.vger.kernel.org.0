Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BABF1D59E0
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2020 21:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgEOTWd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 May 2020 15:22:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:35750 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgEOTWd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 May 2020 15:22:33 -0400
IronPort-SDR: yKRGDXyEYBmB9O2oMOBjW0VGCq6CY81Bjd3U620FaMI/5knHrE8vHSqOJVQTTAYcsox8XF7CSR
 KEj/mqT/fNWw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 12:22:32 -0700
IronPort-SDR: kH3WO39RB0eNK+AB1Ewo7Pyr9GMWnvn93pue12grbHzo9L3Oo16fGpanV4SywnKwQjhYOZRr9+
 mktags6Iz/ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; 
   d="scan'208";a="438422396"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005.jf.intel.com with ESMTP; 15 May 2020 12:22:32 -0700
Subject: [PATCH] dmaengine: check device and channel list for empty
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, swathi.kovvuri@intel.com
Date:   Fri, 15 May 2020 12:22:32 -0700
Message-ID: <158957055210.11529.14023177009907426289.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Check dma device list and channel list for empty before iterate as the
iteration function assume the list to be not empty. With devices and
channels now being hot pluggable this is a condition that needs to be
checked. Otherwise it can cause the iterator to spin forever.

Fixes: e81274cd6b52 ("dmaengine: add support to dynamic register/unregister of channels")

Reported-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
---
 drivers/dma/dmaengine.c |  119 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 94 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index d31076d9ef25..4d29c5f2fcfd 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -83,6 +83,9 @@ static void dmaengine_dbg_summary_show(struct seq_file *s,
 {
 	struct dma_chan *chan;
 
+	if (list_empty(&dma_dev->channels))
+		return;
+
 	list_for_each_entry(chan, &dma_dev->channels, device_node) {
 		if (chan->client_count) {
 			seq_printf(s, " %-13s| %s", dma_chan_name(chan),
@@ -102,6 +105,11 @@ static int dmaengine_summary_show(struct seq_file *s, void *data)
 	struct dma_device *dma_dev = NULL;
 
 	mutex_lock(&dma_list_mutex);
+	if (list_empty(&dma_device_list)) {
+		mutex_unlock(&dma_list_mutex);
+		return 0;
+	}
+
 	list_for_each_entry(dma_dev, &dma_device_list, global_node) {
 		seq_printf(s, "dma%d (%s): number of channels: %u\n",
 			   dma_dev->dev_id, dev_name(dma_dev->dev),
@@ -323,10 +331,15 @@ static struct dma_chan *min_chan(enum dma_transaction_type cap, int cpu)
 	struct dma_chan *min = NULL;
 	struct dma_chan *localmin = NULL;
 
+	if (list_empty(&dma_device_list))
+		return NULL;
+
 	list_for_each_entry(device, &dma_device_list, global_node) {
 		if (!dma_has_cap(cap, device->cap_mask) ||
 		    dma_has_cap(DMA_PRIVATE, device->cap_mask))
 			continue;
+		if (list_empty(&device->channels))
+			continue;
 		list_for_each_entry(chan, &device->channels, device_node) {
 			if (!chan->client_count)
 				continue;
@@ -363,6 +376,9 @@ static void dma_channel_rebalance(void)
 	int cpu;
 	int cap;
 
+	if (list_empty(&dma_device_list))
+		return;
+
 	/* undo the last distribution */
 	for_each_dma_cap_mask(cap, dma_cap_mask_all)
 		for_each_possible_cpu(cpu)
@@ -371,6 +387,8 @@ static void dma_channel_rebalance(void)
 	list_for_each_entry(device, &dma_device_list, global_node) {
 		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
 			continue;
+		if (list_empty(&device->channels))
+			continue;
 		list_for_each_entry(chan, &device->channels, device_node)
 			chan->table_count = 0;
 	}
@@ -554,6 +572,10 @@ void dma_issue_pending_all(void)
 	struct dma_chan *chan;
 
 	rcu_read_lock();
+	if (list_empty(&dma_device_list)) {
+		rcu_read_unlock();
+		return;
+	}
 	list_for_each_entry_rcu(device, &dma_device_list, global_node) {
 		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
 			continue;
@@ -611,6 +633,10 @@ static struct dma_chan *private_candidate(const dma_cap_mask_t *mask,
 		dev_dbg(dev->dev, "%s: wrong capabilities\n", __func__);
 		return NULL;
 	}
+
+	if (list_empty(&dev->channels))
+		return NULL;
+
 	/* devices with multiple channels need special handling as we need to
 	 * ensure that all channels are either private or public.
 	 */
@@ -747,6 +773,11 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 
 	/* Find a channel */
 	mutex_lock(&dma_list_mutex);
+	if (list_empty(&dma_device_list)) {
+		mutex_unlock(&dma_list_mutex);
+		return NULL;
+	}
+
 	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
 		/* Finds a DMA controller with matching device node */
 		if (np && device->dev->of_node && np != device->dev->of_node)
@@ -817,6 +848,11 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 
 	/* Try to find the channel via the DMA filter map(s) */
 	mutex_lock(&dma_list_mutex);
+	if (list_empty(&dma_device_list)) {
+		mutex_unlock(&dma_list_mutex);
+		return NULL;
+	}
+
 	list_for_each_entry_safe(d, _d, &dma_device_list, global_node) {
 		dma_cap_mask_t mask;
 		const struct dma_slave_map *map = dma_filter_match(d, name, dev);
@@ -940,10 +976,17 @@ void dmaengine_get(void)
 	mutex_lock(&dma_list_mutex);
 	dmaengine_ref_count++;
 
+	if (list_empty(&dma_device_list)) {
+		mutex_unlock(&dma_list_mutex);
+		return;
+	}
+
 	/* try to grab channels */
 	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
 		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
 			continue;
+		if (list_empty(&device->channels))
+			continue;
 		list_for_each_entry(chan, &device->channels, device_node) {
 			err = dma_chan_get(chan);
 			if (err == -ENODEV) {
@@ -978,10 +1021,17 @@ void dmaengine_put(void)
 	mutex_lock(&dma_list_mutex);
 	dmaengine_ref_count--;
 	BUG_ON(dmaengine_ref_count < 0);
+	if (list_empty(&dma_device_list)) {
+		mutex_unlock(&dma_list_mutex);
+		return;
+	}
+
 	/* drop channel references */
 	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
 		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
 			continue;
+		if (list_empty(&device->channels))
+			continue;
 		list_for_each_entry(chan, &device->channels, device_node)
 			dma_chan_put(chan);
 	}
@@ -1130,6 +1180,39 @@ void dma_async_device_channel_unregister(struct dma_device *device,
 }
 EXPORT_SYMBOL_GPL(dma_async_device_channel_unregister);
 
+static int dma_channel_enumeration(struct dma_device *device)
+{
+	struct dma_chan *chan;
+	int rc;
+
+	if (list_empty(&device->channels))
+		return 0;
+
+	/* represent channels in sysfs. Probably want devs too */
+	list_for_each_entry(chan, &device->channels, device_node) {
+		rc = __dma_async_device_channel_register(device, chan);
+		if (rc < 0)
+			return rc;
+	}
+
+	/* take references on public channels */
+	if (dmaengine_ref_count && !dma_has_cap(DMA_PRIVATE, device->cap_mask))
+		list_for_each_entry(chan, &device->channels, device_node) {
+			/* if clients are already waiting for channels we need
+			 * to take references on their behalf
+			 */
+			if (dma_chan_get(chan) == -ENODEV) {
+				/* note we can only get here for the first
+				 * channel as the remaining channels are
+				 * guaranteed to get a reference
+				 */
+				return -ENODEV;
+			}
+		}
+
+	return 0;
+}
+
 /**
  * dma_async_device_register - registers DMA devices found
  * @device: &dma_device
@@ -1245,33 +1328,15 @@ int dma_async_device_register(struct dma_device *device)
 	if (rc != 0)
 		return rc;
 
+	mutex_lock(&dma_list_mutex);
 	mutex_init(&device->chan_mutex);
 	ida_init(&device->chan_ida);
-
-	/* represent channels in sysfs. Probably want devs too */
-	list_for_each_entry(chan, &device->channels, device_node) {
-		rc = __dma_async_device_channel_register(device, chan);
-		if (rc < 0)
-			goto err_out;
+	rc = dma_channel_enumeration(device);
+	if (rc < 0) {
+		mutex_unlock(&dma_list_mutex);
+		goto err_out;
 	}
 
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
 	list_add_tail_rcu(&device->global_node, &dma_device_list);
 	if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
 		device->privatecnt++;	/* Always private */
@@ -1289,6 +1354,9 @@ int dma_async_device_register(struct dma_device *device)
 		return rc;
 	}
 
+	if (list_empty(&device->channels))
+		return rc;
+
 	list_for_each_entry(chan, &device->channels, device_node) {
 		if (chan->local == NULL)
 			continue;
@@ -1315,8 +1383,9 @@ void dma_async_device_unregister(struct dma_device *device)
 
 	dmaengine_debug_unregister(device);
 
-	list_for_each_entry_safe(chan, n, &device->channels, device_node)
-		__dma_async_device_channel_unregister(device, chan);
+	if (!list_empty(&device->channels))
+		list_for_each_entry_safe(chan, n, &device->channels, device_node)
+			__dma_async_device_channel_unregister(device, chan);
 
 	mutex_lock(&dma_list_mutex);
 	/*

