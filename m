Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF661BDBF3
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2020 14:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgD2MVy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Apr 2020 08:21:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:31507 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgD2MVy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 29 Apr 2020 08:21:54 -0400
IronPort-SDR: 3AhD2uMvg/hLVCQ4h4Y+seBF6/L7Klq7ooUMBcERlN1aJoXBc9dO+vE5aQG52PumJ4VQaFXCZR
 nZ54SOv6kM8A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 05:21:53 -0700
IronPort-SDR: e7s0Rb3UlmyTDCJ15mZvIn1vNf6C9HlCuXvTbGeVMDqyXfTxiQDlliK2uAxWuNxSsh3WbTW1AS
 O7S0XGbbUrXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="247978325"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 29 Apr 2020 05:21:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AC18443; Wed, 29 Apr 2020 15:21:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] dmaengine: Fix doc strings to satisfy validation script
Date:   Wed, 29 Apr 2020 15:21:51 +0300
Message-Id: <20200429122151.50989-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429122151.50989-1-andriy.shevchenko@linux.intel.com>
References: <20200429122151.50989-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The validation kernel doc script complains about undescribed
function parameters

.../dmaengine.c:155: warning: Function parameter or member 'dev' not descr ibed in 'dev_to_dma_chan'
.../dmaengine.c:251: warning: cannot understand function prototype: 'dma_cap_mask_t dma_cap_mask_all; '
.../dmaengine.c:257: warning: cannot understand function prototype: 'struct dma_chan_tbl_ent '
.../dmaengine.c:264: warning: cannot understand function prototype: 'struct dma_chan_tbl_ent __percpu *channel_table[DMA_TX_TYPE_END]; '
.../dmaengine.c:304: warning: Function parameter or member 'chan' not described in 'dma_chan_is_local'
.../dmaengine.c:304: warning: Function parameter or member 'cpu' not described in 'dma_chan_is_local'
.../dmaengine.c:414: warning: Function parameter or member 'chan' not described in 'balance_ref_count'
.../dmaengine.c:447: warning: Function parameter or member 'chan' not described in 'dma_chan_get'
.../dmaengine.c:494: warning: Function parameter or member 'chan' not described in 'dma_chan_put'

Add descriptions to the function parameters and in some cases update
existing text as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmaengine.c | 96 +++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 46 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ee7f51d9da7ddc..2b06a7a8629d6d 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -147,9 +147,9 @@ static inline void dmaengine_debug_unregister(struct dma_device *dma_dev) { }
 
 /**
  * dev_to_dma_chan - convert a device pointer to its sysfs container object
- * @dev - device node
+ * @dev:	device node
  *
- * Must be called under dma_list_mutex
+ * Must be called under dma_list_mutex.
  */
 static struct dma_chan *dev_to_dma_chan(struct device *dev)
 {
@@ -245,22 +245,18 @@ static struct class dma_devclass = {
 
 /* --- client and device registration --- */
 
-/**
- * dma_cap_mask_all - enable iteration over all operation types
- */
+/* enable iteration over all operation types */
 static dma_cap_mask_t dma_cap_mask_all;
 
 /**
- * dma_chan_tbl_ent - tracks channel allocations per core/operation
- * @chan - associated channel for this entry
+ * struct dma_chan_tbl_ent - tracks channel allocations per core/operation
+ * @chan:	associated channel for this entry
  */
 struct dma_chan_tbl_ent {
 	struct dma_chan *chan;
 };
 
-/**
- * channel_table - percpu lookup table for memory-to-memory offload providers
- */
+/* percpu lookup table for memory-to-memory offload providers */
 static struct dma_chan_tbl_ent __percpu *channel_table[DMA_TX_TYPE_END];
 
 static int __init dma_channel_table_init(void)
@@ -297,8 +293,11 @@ static int __init dma_channel_table_init(void)
 arch_initcall(dma_channel_table_init);
 
 /**
- * dma_chan_is_local - returns true if the channel is in the same numa-node as
- *	the cpu
+ * dma_chan_is_local - checks if the channel is in the same NUMA-node as the CPU
+ * @chan:	DMA channel to test
+ * @cpu:	CPU index which the channel should be close to
+ *
+ * Returns true if the channel is in the same NUMA-node as the CPU.
  */
 static bool dma_chan_is_local(struct dma_chan *chan, int cpu)
 {
@@ -308,14 +307,14 @@ static bool dma_chan_is_local(struct dma_chan *chan, int cpu)
 }
 
 /**
- * min_chan - returns the channel with min count and in the same numa-node as
- *	the cpu
- * @cap: capability to match
- * @cpu: cpu index which the channel should be close to
+ * min_chan - finds the channel with min count and in the same NUMA-node as the CPU
+ * @cap:	capability to match
+ * @cpu:	CPU index which the channel should be close to
  *
- * If some channels are close to the given cpu, the one with the lowest
- * reference count is returned. Otherwise, cpu is ignored and only the
+ * If some channels are close to the given CPU, the one with the lowest
+ * reference count is returned. Otherwise, CPU is ignored and only the
  * reference count is taken into account.
+ *
  * Must be called under dma_list_mutex.
  */
 static struct dma_chan *min_chan(enum dma_transaction_type cap, int cpu)
@@ -353,10 +352,11 @@ static struct dma_chan *min_chan(enum dma_transaction_type cap, int cpu)
 /**
  * dma_channel_rebalance - redistribute the available channels
  *
- * Optimize for cpu isolation (each cpu gets a dedicated channel for an
- * operation type) in the SMP case,  and operation isolation (avoid
- * multi-tasking channels) in the non-SMP case.  Must be called under
- * dma_list_mutex.
+ * Optimize for CPU isolation (each CPU gets a dedicated channel for an
+ * operation type) in the SMP case, and operation isolation (avoid
+ * multi-tasking channels) in the non-SMP case.
+ *
+ * Must be called under dma_list_mutex.
  */
 static void dma_channel_rebalance(void)
 {
@@ -406,9 +406,9 @@ static struct module *dma_chan_to_owner(struct dma_chan *chan)
 
 /**
  * balance_ref_count - catch up the channel reference count
- * @chan - channel to balance ->client_count versus dmaengine_ref_count
+ * @chan:	channel to balance ->client_count versus dmaengine_ref_count
  *
- * balance_ref_count must be called under dma_list_mutex
+ * Must be called under dma_list_mutex.
  */
 static void balance_ref_count(struct dma_chan *chan)
 {
@@ -438,10 +438,10 @@ static void dma_device_put(struct dma_device *device)
 }
 
 /**
- * dma_chan_get - try to grab a dma channel's parent driver module
- * @chan - channel to grab
+ * dma_chan_get - try to grab a DMA channel's parent driver module
+ * @chan:	channel to grab
  *
- * Must be called under dma_list_mutex
+ * Must be called under dma_list_mutex.
  */
 static int dma_chan_get(struct dma_chan *chan)
 {
@@ -485,10 +485,10 @@ static int dma_chan_get(struct dma_chan *chan)
 }
 
 /**
- * dma_chan_put - drop a reference to a dma channel's parent driver module
- * @chan - channel to release
+ * dma_chan_put - drop a reference to a DMA channel's parent driver module
+ * @chan:	channel to release
  *
- * Must be called under dma_list_mutex
+ * Must be called under dma_list_mutex.
  */
 static void dma_chan_put(struct dma_chan *chan)
 {
@@ -539,7 +539,7 @@ EXPORT_SYMBOL(dma_sync_wait);
 
 /**
  * dma_find_channel - find a channel to carry out the operation
- * @tx_type: transaction type
+ * @tx_type:	transaction type
  */
 struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type)
 {
@@ -679,7 +679,7 @@ static struct dma_chan *find_candidate(struct dma_device *device,
 
 /**
  * dma_get_slave_channel - try to get specific channel exclusively
- * @chan: target channel
+ * @chan:	target channel
  */
 struct dma_chan *dma_get_slave_channel(struct dma_chan *chan)
 {
@@ -733,10 +733,10 @@ EXPORT_SYMBOL_GPL(dma_get_any_slave_channel);
 
 /**
  * __dma_request_channel - try to allocate an exclusive channel
- * @mask: capabilities that the channel must satisfy
- * @fn: optional callback to disposition available channels
- * @fn_param: opaque parameter to pass to dma_filter_fn
- * @np: device node to look for DMA channels
+ * @mask:	capabilities that the channel must satisfy
+ * @fn:		optional callback to disposition available channels
+ * @fn_param:	opaque parameter to pass to dma_filter_fn()
+ * @np:		device node to look for DMA channels
  *
  * Returns pointer to appropriate DMA channel on success or NULL.
  */
@@ -879,7 +879,7 @@ EXPORT_SYMBOL_GPL(dma_request_slave_channel);
 
 /**
  * dma_request_chan_by_mask - allocate a channel satisfying certain capabilities
- * @mask: capabilities that the channel must satisfy
+ * @mask:	capabilities that the channel must satisfy
  *
  * Returns pointer to appropriate DMA channel on success or an error pointer.
  */
@@ -970,7 +970,7 @@ void dmaengine_get(void)
 EXPORT_SYMBOL(dmaengine_get);
 
 /**
- * dmaengine_put - let dma drivers be removed when ref_count == 0
+ * dmaengine_put - let DMA drivers be removed when ref_count == 0
  */
 void dmaengine_put(void)
 {
@@ -1134,7 +1134,7 @@ EXPORT_SYMBOL_GPL(dma_async_device_channel_unregister);
 
 /**
  * dma_async_device_register - registers DMA devices found
- * @device: &dma_device
+ * @device:	pointer to &struct dma_device
  *
  * After calling this routine the structure should not be freed except in the
  * device_release() callback which will be called after
@@ -1306,7 +1306,7 @@ EXPORT_SYMBOL(dma_async_device_register);
 
 /**
  * dma_async_device_unregister - unregister a DMA device
- * @device: &dma_device
+ * @device:	pointer to &struct dma_device
  *
  * This routine is called by dma driver exit routines, dmaengine holds module
  * references to prevent it being called while channels are in use.
@@ -1343,7 +1343,7 @@ static void dmam_device_release(struct device *dev, void *res)
 
 /**
  * dmaenginem_async_device_register - registers DMA devices found
- * @device: &dma_device
+ * @device:	pointer to &struct dma_device
  *
  * The operation is managed and will be undone on driver detach.
  */
@@ -1580,8 +1580,9 @@ int dmaengine_desc_set_metadata_len(struct dma_async_tx_descriptor *desc,
 }
 EXPORT_SYMBOL_GPL(dmaengine_desc_set_metadata_len);
 
-/* dma_wait_for_async_tx - spin wait for a transaction to complete
- * @tx: in-flight transaction to wait on
+/**
+ * dma_wait_for_async_tx - spin wait for a transaction to complete
+ * @tx:		in-flight transaction to wait on
  */
 enum dma_status
 dma_wait_for_async_tx(struct dma_async_tx_descriptor *tx)
@@ -1604,9 +1605,12 @@ dma_wait_for_async_tx(struct dma_async_tx_descriptor *tx)
 }
 EXPORT_SYMBOL_GPL(dma_wait_for_async_tx);
 
-/* dma_run_dependencies - helper routine for dma drivers to process
- *	(start) dependent operations on their target channel
- * @tx: transaction with dependencies
+/**
+ * dma_run_dependencies - process dependent operations on the target channel
+ * @tx:		transaction with dependencies
+ *
+ * Helper routine for DMA drivers to process (start) dependent operations
+ * on their target channel.
  */
 void dma_run_dependencies(struct dma_async_tx_descriptor *tx)
 {
-- 
2.26.2

