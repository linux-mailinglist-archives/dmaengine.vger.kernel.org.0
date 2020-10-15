Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE28F28EDC0
	for <lists+dmaengine@lfdr.de>; Thu, 15 Oct 2020 09:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgJOHbz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Oct 2020 03:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgJOHbz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Oct 2020 03:31:55 -0400
Received: from localhost.localdomain (unknown [122.171.209.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B0DF22249;
        Thu, 15 Oct 2020 07:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602747114;
        bh=+c6nwfoth7Zjdubli8/24COztlce5AWnbHKzhJqEisg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0PFV3USidkw9WpTriKyZrKkRZjSdaFyhMTp4UgZHXb21bXKygjQ3DdDvWdz9hESn
         CuuStuXB6a9Bmp8BDJJm4TS9/GJVurlxrgtOya6nIQXUCr2oZjrozry79z9gh8OzD4
         J8yzhmLcupP5NCd/AlR3F2OK++JiBuO3iju/icdw=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 2/4] dmaengine: move struct in interface to use peripheral term
Date:   Thu, 15 Oct 2020 13:01:30 +0530
Message-Id: <20201015073132.3571684-3-vkoul@kernel.org>
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

This moves structures in dmaengine interface with replacement of slave
to peripheral which is an appropriate term for dmaengine peripheral
devices

Since the change of name can break users, the new names have been added
with old structs kept as macro define for new names. Once the users have
been migrated, these macros will be dropped.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dmaengine.c   | 12 +++----
 include/linux/dmaengine.h | 71 +++++++++++++++++++++------------------
 2 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 7974fa0400d8..3b796081a5e4 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -793,10 +793,10 @@ static const struct dma_slave_map *dma_filter_match(struct dma_device *device,
 		return NULL;
 
 	for (i = 0; i < device->filter.mapcnt; i++) {
-		const struct dma_slave_map *map = &device->filter.map[i];
+		const struct dma_peripheral_map *map = &device->filter.map[i];
 
 		if (!strcmp(map->devname, dev_name(dev)) &&
-		    !strcmp(map->slave, name))
+		    !strcmp(map->peripheral, name))
 			return map;
 	}
 
@@ -861,7 +861,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 	chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
 	if (!chan->name)
 		return chan;
-	chan->slave = dev;
+	chan->peripheral = dev;
 
 	if (sysfs_create_link(&chan->dev->device.kobj, &dev->kobj,
 			      DMA_SLAVE_NAME))
@@ -910,12 +910,12 @@ void dma_release_channel(struct dma_chan *chan)
 	if (--chan->device->privatecnt == 0)
 		dma_cap_clear(DMA_PRIVATE, chan->device->cap_mask);
 
-	if (chan->slave) {
+	if (chan->peripheral) {
 		sysfs_remove_link(&chan->dev->device.kobj, DMA_SLAVE_NAME);
-		sysfs_remove_link(&chan->slave->kobj, chan->name);
+		sysfs_remove_link(&chan->peripheral->kobj, chan->name);
 		kfree(chan->name);
 		chan->name = NULL;
-		chan->slave = NULL;
+		chan->peripheral = NULL;
 	}
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index f7f420876d21..04b993a5373c 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -312,13 +312,13 @@ struct dma_router {
 /**
  * struct dma_chan - devices supply DMA channels, clients use them
  * @device: ptr to the dma device who supplies this channel, always !%NULL
- * @slave: ptr to the device using this channel
+ * @peripheral: ptr to the device using this channel
  * @cookie: last cookie value returned to client
  * @completed_cookie: last completed cookie for this channel
  * @chan_id: channel ID for sysfs
  * @dev: class device for sysfs
  * @name: backlink name for sysfs
- * @dbg_client_name: slave name for debugfs in format:
+ * @dbg_client_name: peripheral name for debugfs in format:
  *	dev_name(requester's dev):channel name, for example: "2b00000.mcasp:tx"
  * @device_node: used to add this to the device chan list
  * @local: per-cpu pointer to a struct dma_chan_percpu
@@ -330,7 +330,7 @@ struct dma_router {
  */
 struct dma_chan {
 	struct dma_device *device;
-	struct device *slave;
+	struct device *peripheral;
 	dma_cookie_t cookie;
 	dma_cookie_t completed_cookie;
 
@@ -395,16 +395,16 @@ enum dma_peripheral_buswidth {
 #define dma_slave_buswidth dma_peripheral_buswidth
 
 /**
- * struct dma_slave_config - dma slave channel runtime config
- * @direction: whether the data shall go in or out on this slave
+ * struct dma_peripheral_config - dma peripheral channel runtime config
+ * @direction: whether the data shall go in or out on this peripheral
  * channel, right now. DMA_MEM_TO_DEV and DMA_DEV_TO_MEM are
  * legal values. DEPRECATED, drivers should use the direction argument
- * to the device_prep_slave_sg and device_prep_dma_cyclic functions or
+ * to the device_prep_peripheral_sg and device_prep_dma_cyclic functions or
  * the dir field in the dma_interleaved_template structure.
- * @src_addr: this is the physical address where DMA slave data
+ * @src_addr: this is the physical address where DMA peripheral data
  * should be read (RX), if the source is memory this argument is
  * ignored.
- * @dst_addr: this is the physical address where DMA slave data
+ * @dst_addr: this is the physical address where DMA peripheral data
  * should be written (TX), if the source is memory this argument
  * is ignored.
  * @src_addr_width: this is the width in bytes of the source (RX)
@@ -426,12 +426,12 @@ enum dma_peripheral_buswidth {
  * loops in this area in order to transfer the data.
  * @dst_port_window_size: same as src_port_window_size but for the destination
  * port.
- * @device_fc: Flow Controller Settings. Only valid for slave channels. Fill
+ * @device_fc: Flow Controller Settings. Only valid for peripheral channels. Fill
  * with 'true' if peripheral should be flow controller. Direction will be
  * selected at Runtime.
- * @slave_id: Slave requester id. Only valid for slave channels. The dma
- * slave peripheral will have unique id as dma requester which need to be
- * pass as slave config.
+ * @peripheral_id: Peripheral requester id. Only valid for peripheral channels. The dma
+ * peripheral will have unique id as dma requester which need to be
+ * pass as peripheral config.
  *
  * This struct is passed in as configuration data to a DMA engine
  * in order to set up a certain channel for DMA transport at runtime.
@@ -440,25 +440,28 @@ enum dma_peripheral_buswidth {
  * will then be passed in as an argument to the function.
  *
  * The rationale for adding configuration information to this struct is as
- * follows: if it is likely that more than one DMA slave controllers in
+ * follows: if it is likely that more than one DMA peripheral controllers in
  * the world will support the configuration option, then make it generic.
  * If not: if it is fixed so that it be sent in static from the platform
  * data, then prefer to do that.
  */
-struct dma_slave_config {
+struct dma_peripheral_config {
 	enum dma_transfer_direction direction;
 	phys_addr_t src_addr;
 	phys_addr_t dst_addr;
-	enum dma_slave_buswidth src_addr_width;
-	enum dma_slave_buswidth dst_addr_width;
+	enum dma_peripheral_buswidth src_addr_width;
+	enum dma_peripheral_buswidth dst_addr_width;
 	u32 src_maxburst;
 	u32 dst_maxburst;
 	u32 src_port_window_size;
 	u32 dst_port_window_size;
 	bool device_fc;
 	unsigned int slave_id;
+	unsigned int peripheral_id;
 };
 
+#define dma_slave_config dma_peripheral_config
+
 /**
  * enum dma_residue_granularity - Granularity of the reported transfer residue
  * @DMA_RESIDUE_GRANULARITY_DESCRIPTOR: Residue reporting is not support. The
@@ -486,12 +489,12 @@ enum dma_residue_granularity {
 };
 
 /**
- * struct dma_slave_caps - expose capabilities of a slave channel only
+ * struct dma_peripheral_caps - expose capabilities of a peripheral channel only
  * @src_addr_widths: bit mask of src addr widths the channel supports.
  *	Width is specified in bytes, e.g. for a channel supporting
  *	a width of 4 the mask should have BIT(4) set.
  * @dst_addr_widths: bit mask of dst addr widths the channel supports
- * @directions: bit mask of slave directions the channel supports.
+ * @directions: bit mask of peripheral directions the channel supports.
  *	Since the enum dma_transfer_direction is not defined as bit flag for
  *	each type, the dma controller should set BIT(<TYPE>) and same
  *	should be checked by controller as well
@@ -508,7 +511,7 @@ enum dma_residue_granularity {
  * @descriptor_reuse: if a descriptor can be reused by client and
  * resubmitted multiple times
  */
-struct dma_slave_caps {
+struct dma_peripheral_caps {
 	u32 src_addr_widths;
 	u32 dst_addr_widths;
 	u32 directions;
@@ -522,6 +525,8 @@ struct dma_slave_caps {
 	bool descriptor_reuse;
 };
 
+#define dma_slave_caps dma_peripheral_caps
+
 static inline const char *dma_chan_name(struct dma_chan *chan)
 {
 	return dev_name(&chan->dev->device);
@@ -754,29 +759,31 @@ enum dmaengine_alignment {
 };
 
 /**
- * struct dma_slave_map - associates slave device and it's slave channel with
+ * struct dma_peripheral_map - associates peripheral device and it's peripheral channel with
  * parameter to be used by a filter function
  * @devname: name of the device
- * @slave: slave channel name
+ * @peripheral: peripheral channel name
  * @param: opaque parameter to pass to struct dma_filter.fn
  */
-struct dma_slave_map {
+struct dma_peripheral_map {
 	const char *devname;
-	const char *slave;
+	const char *peripheral;
 	void *param;
 };
 
+#define dma_slave_map dma_peripheral_map
+
 /**
- * struct dma_filter - information for slave device/channel to filter_fn/param
+ * struct dma_filter - information for peripheral device/channel to filter_fn/param
  * mapping
  * @fn: filter function callback
- * @mapcnt: number of slave device/channel in the map
+ * @mapcnt: number of peripheral device/channel in the map
  * @map: array of channel to filter mapping data
  */
 struct dma_filter {
 	dma_filter_fn fn;
 	int mapcnt;
-	const struct dma_slave_map *map;
+	const struct dma_peripheral_map *map;
 };
 
 /**
@@ -785,7 +792,7 @@ struct dma_filter {
  * @privatecnt: how many DMA channels are requested by dma_request_channel
  * @channels: the list of struct dma_chan
  * @global_node: list_head for global dma_device_list
- * @filter: information for device/slave to filter function/param mapping
+ * @filter: information for device/peripheral to filter function/param mapping
  * @cap_mask: one or more dma_capability flags
  * @desc_metadata_modes: supported metadata modes by the DMA device
  * @max_xor: maximum number of xor sources, 0 if no capability
@@ -801,7 +808,7 @@ struct dma_filter {
  *	Width is specified in bytes, e.g. for a device supporting
  *	a width of 4 the mask should have BIT(4) set.
  * @dst_addr_widths: bit mask of dst addr widths the device supports
- * @directions: bit mask of slave directions the device supports.
+ * @directions: bit mask of peripheral directions the device supports.
  *	Since the enum dma_transfer_direction is not defined as bit flag for
  *	each type, the dma controller should set BIT(<TYPE>) and same
  *	should be checked by controller as well
@@ -823,13 +830,13 @@ struct dma_filter {
  * @device_prep_dma_memset: prepares a memset operation
  * @device_prep_dma_memset_sg: prepares a memset operation over a scatter list
  * @device_prep_dma_interrupt: prepares an end of chain interrupt operation
- * @device_prep_slave_sg: prepares a slave dma operation
+ * @device_prep_peripheral_sg: prepares a peripheral dma operation
  * @device_prep_dma_cyclic: prepare a cyclic dma operation suitable for audio.
  *	The function takes a buffer of size buf_len. The callback function will
  *	be called after period_len bytes have been transferred.
  * @device_prep_interleaved_dma: Transfer expression in a generic way.
  * @device_prep_dma_imm_data: DMA's 8 byte immediate data to the dst address
- * @device_caps: May be used to override the generic DMA slave capabilities
+ * @device_caps: May be used to override the generic DMA peripheral capabilities
  *	with per-channel specific ones
  * @device_config: Pushes a new configuration to a channel, return 0 or an error
  *	code
@@ -932,9 +939,9 @@ struct dma_device {
 		unsigned long flags);
 
 	void (*device_caps)(struct dma_chan *chan,
-			    struct dma_slave_caps *caps);
+			    struct dma_peripheral_caps *caps);
 	int (*device_config)(struct dma_chan *chan,
-			     struct dma_slave_config *config);
+			     struct dma_peripheral_config *config);
 	int (*device_pause)(struct dma_chan *chan);
 	int (*device_resume)(struct dma_chan *chan);
 	int (*device_terminate_all)(struct dma_chan *chan);
-- 
2.26.2

