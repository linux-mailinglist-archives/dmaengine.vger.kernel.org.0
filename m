Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C140628EDC2
	for <lists+dmaengine@lfdr.de>; Thu, 15 Oct 2020 09:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgJOHb6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Oct 2020 03:31:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgJOHb6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Oct 2020 03:31:58 -0400
Received: from localhost.localdomain (unknown [122.171.209.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2E7122243;
        Thu, 15 Oct 2020 07:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602747118;
        bh=OntA+LWhL7f5z0uBEaaPch3mqbF3WVBFeZgkfkwuK8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/bqtc5vjLOxSa7uio+xsNEBQNOUv1uScxcP2SZsmSUC58XlpQlIMdM12UvdDBSv+
         38d8/W6wdOLnhyo9mIMx1/7M1hDEF70QN6v6F1IdlrE03s7Oaq+KSAJ2qLoUZZYKi/
         4LkftNXahKWR0hmZi1yOAx130ygx0YYEHytcJHj4=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4/4] dmaengine: core: update to use peripheral term
Date:   Thu, 15 Oct 2020 13:01:32 +0530
Message-Id: <20201015073132.3571684-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201015073132.3571684-1-vkoul@kernel.org>
References: <20201015073132.3571684-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

dmaengine history has a non inclusive terminology of dmaengine slave, I
feel it is time to replace that.

This moves dmaengine file to use peripheral instead of slave in comments
and updates to use the newly add inclusive names for enums/struct/apis

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dmaengine.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 3b796081a5e4..9041f4f10ea3 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -143,7 +143,7 @@ static inline void dmaengine_debug_unregister(struct dma_device *dma_dev) { }
 
 /* --- sysfs implementation --- */
 
-#define DMA_SLAVE_NAME	"slave"
+#define DMA_PERIPHERAL_NAME	"peripheral"
 
 /**
  * dev_to_dma_chan - convert a device pointer to its sysfs container object
@@ -266,13 +266,13 @@ static int __init dma_channel_table_init(void)
 
 	bitmap_fill(dma_cap_mask_all.bits, DMA_TX_TYPE_END);
 
-	/* 'interrupt', 'private', and 'slave' are channel capabilities,
+	/* 'interrupt', 'private', and 'peripheral' are channel capabilities,
 	 * but are not associated with an operation so they do not need
 	 * an entry in the channel_table
 	 */
 	clear_bit(DMA_INTERRUPT, dma_cap_mask_all.bits);
 	clear_bit(DMA_PRIVATE, dma_cap_mask_all.bits);
-	clear_bit(DMA_SLAVE, dma_cap_mask_all.bits);
+	clear_bit(DMA_PERIPHERAL, dma_cap_mask_all.bits);
 
 	for_each_dma_cap_mask(cap, dma_cap_mask_all) {
 		channel_table[cap] = alloc_percpu(struct dma_chan_tbl_ent);
@@ -576,15 +576,15 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 
 	device = chan->device;
 
-	/* check if the channel supports slave transactions */
-	if (!(test_bit(DMA_SLAVE, device->cap_mask.bits) ||
+	/* check if the channel supports peripheral transactions */
+	if (!(test_bit(DMA_PERIPHERAL, device->cap_mask.bits) ||
 	      test_bit(DMA_CYCLIC, device->cap_mask.bits)))
 		return -ENXIO;
 
 	/*
-	 * Check whether it reports it uses the generic slave
+	 * Check whether it reports it uses the generic peripheral
 	 * capabilities, if not, that means it doesn't support any
-	 * kind of slave capabilities reporting.
+	 * kind of peripheral capabilities reporting.
 	 */
 	if (!device->directions)
 		return -ENXIO;
@@ -603,7 +603,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 
 	/*
 	 * DMA engine device might be configured with non-uniformly
-	 * distributed slave capabilities per device channels. In this
+	 * distributed capabilities per device channels. In this
 	 * case the corresponding driver may provide the device_caps
 	 * callback to override the generic capabilities with
 	 * channel-specific ones.
@@ -783,9 +783,9 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 }
 EXPORT_SYMBOL_GPL(__dma_request_channel);
 
-static const struct dma_slave_map *dma_filter_match(struct dma_device *device,
-						    const char *name,
-						    struct device *dev)
+static const struct dma_peripheral_map *dma_filter_match(struct dma_device *device,
+						         const char *name,
+						         struct device *dev)
 {
 	int i;
 
@@ -804,9 +804,9 @@ static const struct dma_slave_map *dma_filter_match(struct dma_device *device,
 }
 
 /**
- * dma_request_chan - try to allocate an exclusive slave channel
+ * dma_request_chan - try to allocate an exclusive peripheral channel
  * @dev:	pointer to client device structure
- * @name:	slave channel name
+ * @name:	peripheral channel name
  *
  * Returns pointer to appropriate DMA channel on success or an error pointer.
  */
@@ -833,13 +833,13 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 	mutex_lock(&dma_list_mutex);
 	list_for_each_entry_safe(d, _d, &dma_device_list, global_node) {
 		dma_cap_mask_t mask;
-		const struct dma_slave_map *map = dma_filter_match(d, name, dev);
+		const struct dma_peripheral_map *map = dma_filter_match(d, name, dev);
 
 		if (!map)
 			continue;
 
 		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
+		dma_cap_set(DMA_PERIPHERAL, mask);
 
 		chan = find_candidate(d, &mask, d->filter.fn, map->param);
 		if (!IS_ERR(chan))
@@ -864,8 +864,8 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 	chan->peripheral = dev;
 
 	if (sysfs_create_link(&chan->dev->device.kobj, &dev->kobj,
-			      DMA_SLAVE_NAME))
-		dev_warn(dev, "Cannot create DMA %s symlink\n", DMA_SLAVE_NAME);
+			      DMA_PERIPHERAL_NAME))
+		dev_warn(dev, "Cannot create DMA %s symlink\n", DMA_PERIPHERAL_NAME);
 	if (sysfs_create_link(&dev->kobj, &chan->dev->device.kobj, chan->name))
 		dev_warn(dev, "Cannot create DMA %s symlink\n", chan->name);
 
@@ -911,7 +911,7 @@ void dma_release_channel(struct dma_chan *chan)
 		dma_cap_clear(DMA_PRIVATE, chan->device->cap_mask);
 
 	if (chan->peripheral) {
-		sysfs_remove_link(&chan->dev->device.kobj, DMA_SLAVE_NAME);
+		sysfs_remove_link(&chan->dev->device.kobj, DMA_PERIPHERAL_NAME);
 		sysfs_remove_link(&chan->peripheral->kobj, chan->name);
 		kfree(chan->name);
 		chan->name = NULL;
-- 
2.26.2

