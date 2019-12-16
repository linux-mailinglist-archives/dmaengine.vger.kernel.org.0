Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C28A12199F
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2019 20:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfLPTBl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 14:01:41 -0500
Received: from ale.deltatee.com ([207.54.116.67]:34952 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfLPTB0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Dec 2019 14:01:26 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1igvcR-0005jF-3f; Mon, 16 Dec 2019 12:01:25 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1igvcQ-0005Zg-GF; Mon, 16 Dec 2019 12:01:22 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Kit Chow <kchow@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon, 16 Dec 2019 12:01:18 -0700
Message-Id: <20191216190120.21374-4-logang@deltatee.com>
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
Subject: [PATCH 3/5] dmaengine: Move dma_channel_rebalance() infrastructure up in code
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

So it can be called by a release function which is needed higher up in
the code. No functional changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/dmaengine.c | 288 ++++++++++++++++++++--------------------
 1 file changed, 144 insertions(+), 144 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 776fdf535a3a..1f9a6293f15a 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -164,6 +164,150 @@ static struct class dma_devclass = {
 
 /* --- client and device registration --- */
 
+/**
+ * dma_cap_mask_all - enable iteration over all operation types
+ */
+static dma_cap_mask_t dma_cap_mask_all;
+
+/**
+ * dma_chan_tbl_ent - tracks channel allocations per core/operation
+ * @chan - associated channel for this entry
+ */
+struct dma_chan_tbl_ent {
+	struct dma_chan *chan;
+};
+
+/**
+ * channel_table - percpu lookup table for memory-to-memory offload providers
+ */
+static struct dma_chan_tbl_ent __percpu *channel_table[DMA_TX_TYPE_END];
+
+static int __init dma_channel_table_init(void)
+{
+	enum dma_transaction_type cap;
+	int err = 0;
+
+	bitmap_fill(dma_cap_mask_all.bits, DMA_TX_TYPE_END);
+
+	/* 'interrupt', 'private', and 'slave' are channel capabilities,
+	 * but are not associated with an operation so they do not need
+	 * an entry in the channel_table
+	 */
+	clear_bit(DMA_INTERRUPT, dma_cap_mask_all.bits);
+	clear_bit(DMA_PRIVATE, dma_cap_mask_all.bits);
+	clear_bit(DMA_SLAVE, dma_cap_mask_all.bits);
+
+	for_each_dma_cap_mask(cap, dma_cap_mask_all) {
+		channel_table[cap] = alloc_percpu(struct dma_chan_tbl_ent);
+		if (!channel_table[cap]) {
+			err = -ENOMEM;
+			break;
+		}
+	}
+
+	if (err) {
+		pr_err("initialization failure\n");
+		for_each_dma_cap_mask(cap, dma_cap_mask_all)
+			free_percpu(channel_table[cap]);
+	}
+
+	return err;
+}
+arch_initcall(dma_channel_table_init);
+
+/**
+ * dma_chan_is_local - returns true if the channel is in the same numa-node as
+ *	the cpu
+ */
+static bool dma_chan_is_local(struct dma_chan *chan, int cpu)
+{
+	int node = dev_to_node(chan->device->dev);
+	return node == NUMA_NO_NODE ||
+		cpumask_test_cpu(cpu, cpumask_of_node(node));
+}
+
+/**
+ * min_chan - returns the channel with min count and in the same numa-node as
+ *	the cpu
+ * @cap: capability to match
+ * @cpu: cpu index which the channel should be close to
+ *
+ * If some channels are close to the given cpu, the one with the lowest
+ * reference count is returned. Otherwise, cpu is ignored and only the
+ * reference count is taken into account.
+ * Must be called under dma_list_mutex.
+ */
+static struct dma_chan *min_chan(enum dma_transaction_type cap, int cpu)
+{
+	struct dma_device *device;
+	struct dma_chan *chan;
+	struct dma_chan *min = NULL;
+	struct dma_chan *localmin = NULL;
+
+	list_for_each_entry(device, &dma_device_list, global_node) {
+		if (!dma_has_cap(cap, device->cap_mask) ||
+		    dma_has_cap(DMA_PRIVATE, device->cap_mask))
+			continue;
+		list_for_each_entry(chan, &device->channels, device_node) {
+			if (!chan->client_count)
+				continue;
+			if (!min || chan->table_count < min->table_count)
+				min = chan;
+
+			if (dma_chan_is_local(chan, cpu))
+				if (!localmin ||
+				    chan->table_count < localmin->table_count)
+					localmin = chan;
+		}
+	}
+
+	chan = localmin ? localmin : min;
+
+	if (chan)
+		chan->table_count++;
+
+	return chan;
+}
+
+/**
+ * dma_channel_rebalance - redistribute the available channels
+ *
+ * Optimize for cpu isolation (each cpu gets a dedicated channel for an
+ * operation type) in the SMP case,  and operation isolation (avoid
+ * multi-tasking channels) in the non-SMP case.  Must be called under
+ * dma_list_mutex.
+ */
+static void dma_channel_rebalance(void)
+{
+	struct dma_chan *chan;
+	struct dma_device *device;
+	int cpu;
+	int cap;
+
+	/* undo the last distribution */
+	for_each_dma_cap_mask(cap, dma_cap_mask_all)
+		for_each_possible_cpu(cpu)
+			per_cpu_ptr(channel_table[cap], cpu)->chan = NULL;
+
+	list_for_each_entry(device, &dma_device_list, global_node) {
+		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
+			continue;
+		list_for_each_entry(chan, &device->channels, device_node)
+			chan->table_count = 0;
+	}
+
+	/* don't populate the channel_table if no clients are available */
+	if (!dmaengine_ref_count)
+		return;
+
+	/* redistribute available channels */
+	for_each_dma_cap_mask(cap, dma_cap_mask_all)
+		for_each_online_cpu(cpu) {
+			chan = min_chan(cap, cpu);
+			per_cpu_ptr(channel_table[cap], cpu)->chan = chan;
+		}
+}
+
 #define dma_device_satisfies_mask(device, mask) \
 	__dma_device_satisfies_mask((device), &(mask))
 static int
@@ -289,57 +433,6 @@ enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie)
 }
 EXPORT_SYMBOL(dma_sync_wait);
 
-/**
- * dma_cap_mask_all - enable iteration over all operation types
- */
-static dma_cap_mask_t dma_cap_mask_all;
-
-/**
- * dma_chan_tbl_ent - tracks channel allocations per core/operation
- * @chan - associated channel for this entry
- */
-struct dma_chan_tbl_ent {
-	struct dma_chan *chan;
-};
-
-/**
- * channel_table - percpu lookup table for memory-to-memory offload providers
- */
-static struct dma_chan_tbl_ent __percpu *channel_table[DMA_TX_TYPE_END];
-
-static int __init dma_channel_table_init(void)
-{
-	enum dma_transaction_type cap;
-	int err = 0;
-
-	bitmap_fill(dma_cap_mask_all.bits, DMA_TX_TYPE_END);
-
-	/* 'interrupt', 'private', and 'slave' are channel capabilities,
-	 * but are not associated with an operation so they do not need
-	 * an entry in the channel_table
-	 */
-	clear_bit(DMA_INTERRUPT, dma_cap_mask_all.bits);
-	clear_bit(DMA_PRIVATE, dma_cap_mask_all.bits);
-	clear_bit(DMA_SLAVE, dma_cap_mask_all.bits);
-
-	for_each_dma_cap_mask(cap, dma_cap_mask_all) {
-		channel_table[cap] = alloc_percpu(struct dma_chan_tbl_ent);
-		if (!channel_table[cap]) {
-			err = -ENOMEM;
-			break;
-		}
-	}
-
-	if (err) {
-		pr_err("initialization failure\n");
-		for_each_dma_cap_mask(cap, dma_cap_mask_all)
-			free_percpu(channel_table[cap]);
-	}
-
-	return err;
-}
-arch_initcall(dma_channel_table_init);
-
 /**
  * dma_find_channel - find a channel to carry out the operation
  * @tx_type: transaction type
@@ -370,97 +463,6 @@ void dma_issue_pending_all(void)
 }
 EXPORT_SYMBOL(dma_issue_pending_all);
 
-/**
- * dma_chan_is_local - returns true if the channel is in the same numa-node as the cpu
- */
-static bool dma_chan_is_local(struct dma_chan *chan, int cpu)
-{
-	int node = dev_to_node(chan->device->dev);
-	return node == NUMA_NO_NODE ||
-		cpumask_test_cpu(cpu, cpumask_of_node(node));
-}
-
-/**
- * min_chan - returns the channel with min count and in the same numa-node as the cpu
- * @cap: capability to match
- * @cpu: cpu index which the channel should be close to
- *
- * If some channels are close to the given cpu, the one with the lowest
- * reference count is returned. Otherwise, cpu is ignored and only the
- * reference count is taken into account.
- * Must be called under dma_list_mutex.
- */
-static struct dma_chan *min_chan(enum dma_transaction_type cap, int cpu)
-{
-	struct dma_device *device;
-	struct dma_chan *chan;
-	struct dma_chan *min = NULL;
-	struct dma_chan *localmin = NULL;
-
-	list_for_each_entry(device, &dma_device_list, global_node) {
-		if (!dma_has_cap(cap, device->cap_mask) ||
-		    dma_has_cap(DMA_PRIVATE, device->cap_mask))
-			continue;
-		list_for_each_entry(chan, &device->channels, device_node) {
-			if (!chan->client_count)
-				continue;
-			if (!min || chan->table_count < min->table_count)
-				min = chan;
-
-			if (dma_chan_is_local(chan, cpu))
-				if (!localmin ||
-				    chan->table_count < localmin->table_count)
-					localmin = chan;
-		}
-	}
-
-	chan = localmin ? localmin : min;
-
-	if (chan)
-		chan->table_count++;
-
-	return chan;
-}
-
-/**
- * dma_channel_rebalance - redistribute the available channels
- *
- * Optimize for cpu isolation (each cpu gets a dedicated channel for an
- * operation type) in the SMP case,  and operation isolation (avoid
- * multi-tasking channels) in the non-SMP case.  Must be called under
- * dma_list_mutex.
- */
-static void dma_channel_rebalance(void)
-{
-	struct dma_chan *chan;
-	struct dma_device *device;
-	int cpu;
-	int cap;
-
-	/* undo the last distribution */
-	for_each_dma_cap_mask(cap, dma_cap_mask_all)
-		for_each_possible_cpu(cpu)
-			per_cpu_ptr(channel_table[cap], cpu)->chan = NULL;
-
-	list_for_each_entry(device, &dma_device_list, global_node) {
-		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
-			continue;
-		list_for_each_entry(chan, &device->channels, device_node)
-			chan->table_count = 0;
-	}
-
-	/* don't populate the channel_table if no clients are available */
-	if (!dmaengine_ref_count)
-		return;
-
-	/* redistribute available channels */
-	for_each_dma_cap_mask(cap, dma_cap_mask_all)
-		for_each_online_cpu(cpu) {
-			chan = min_chan(cap, cpu);
-			per_cpu_ptr(channel_table[cap], cpu)->chan = chan;
-		}
-}
-
 int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 {
 	struct dma_device *device;
@@ -1376,5 +1378,3 @@ static int __init dma_bus_init(void)
 	return class_register(&dma_devclass);
 }
 arch_initcall(dma_bus_init);
-
-
-- 
2.20.1

