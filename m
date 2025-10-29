Return-Path: <dmaengine+bounces-7035-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA5EC1B807
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 16:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27F0640919
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 14:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B79331A53;
	Wed, 29 Oct 2025 14:26:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FCE28B4F0;
	Wed, 29 Oct 2025 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748017; cv=none; b=WTXRUXPmlKbc/fSWF1S5qNKc+l5EOWqgIZoC4GoURjX9nLO2faV8wp+jOhs5Em9ywFBVNl8mbJfMYrPOK4oo6IYjtLRRVFJracHxDWV2f3O1qRUCuCB7G6GU6HYpF7DFgFWzxsdvSUFa82MgAzjcrmF8bYFEh9krMKi501nu6I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748017; c=relaxed/simple;
	bh=9E3sn5v4uL6bXUZ0dN3HFWrALD67aVsRrF+k5Bgs7KQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAM7ej79p/+hnfQsP0AOtvZutIX020/wiikpChKaDO2/l8tWuvAfLToc+9GwDhktjeSFYbkj1+D0OMS9TAtjuZYJp8B/rjqZ+T20jkpWxOglilAMgLOeC6ecYpa7NbjeduMJFjbGo4QlaK16v4cWIN8YFylvA2FP4Z7gb90i/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 59TEQdpa080486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Wed, 29 Oct 2025 22:26:39 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Oct
 2025 22:26:39 +0800
From: CL Wang <cl634@andestech.com>
To: <cl634@andestech.com>, <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>
Subject: [PATCH V2 2/2] dmaengine: atcdmac300: Add driver for Andes ATCDMAC300 DMA controller
Date: Wed, 29 Oct 2025 22:26:21 +0800
Message-ID: <20251029142621.4170368-3-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029142621.4170368-1-cl634@andestech.com>
References: <20251029142621.4170368-1-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 59TEQdpa080486

This patch adds support for the Andes ATCDMAC300 DMA controller.

The ATCDMAC300 is a memory-to-memory and peripheral DMA controller
that provides scatter-gather, cyclic, and slave transfer capabilities.

Signed-off-by: CL Wang <cl634@andestech.com>

---
Changes for v2:
  - Remove unused variable 'total_len' to address -Wunused-but-set-variable
    warnings.
  - Add platform-specific compatible string "andestech,qilai-dma"
---
 drivers/dma/Kconfig      |   12 +
 drivers/dma/Makefile     |    1 +
 drivers/dma/atcdmac300.c | 1556 ++++++++++++++++++++++++++++++++++++++
 drivers/dma/atcdmac300.h |  276 +++++++
 4 files changed, 1845 insertions(+)
 create mode 100644 drivers/dma/atcdmac300.c
 create mode 100644 drivers/dma/atcdmac300.h

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index b8a74b1798ba..383d492fd0dd 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -100,6 +100,18 @@ config ARM_DMA350
 	help
 	  Enable support for the Arm DMA-350 controller.
 
+config DMA_ATCDMAC300
+	bool "Andes DMA support"
+	depends on ARCH_ANDES
+	depends on OF
+	select DMA_ENGINE
+	select DMATEST
+	help
+	  Enable support for the Andes ATCDMAC300 DMA controller.
+	  Select Y if your platform includes an ATCDMAC300 device that
+	  requires DMA engine support. This driver supports DMA_SLAVE,
+	  DMA_MEMCPY, and DMA_CYCLIC transfer modes.
+
 config AT_HDMAC
 	tristate "Atmel AHB DMA support"
 	depends on ARCH_AT91
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index a54d7688392b..6847d141ee48 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
 obj-$(CONFIG_AT_XDMAC) += at_xdmac.o
 obj-$(CONFIG_AXI_DMAC) += dma-axi-dmac.o
 obj-$(CONFIG_BCM_SBA_RAID) += bcm-sba-raid.o
+obj-$(CONFIG_DMA_ATCDMAC300) += atcdmac300.o
 obj-$(CONFIG_DMA_BCM2835) += bcm2835-dma.o
 obj-$(CONFIG_DMA_JZ4780) += dma-jz4780.o
 obj-$(CONFIG_DMA_SA11X0) += sa11x0-dma.o
diff --git a/drivers/dma/atcdmac300.c b/drivers/dma/atcdmac300.c
new file mode 100644
index 000000000000..aef8d00171d3
--- /dev/null
+++ b/drivers/dma/atcdmac300.c
@@ -0,0 +1,1556 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Andes ATCDMAC300 controller driver
+ *
+ * Copyright (C) 2025 Andes Technology Corporation
+ */
+#include <linux/dmaengine.h>
+#include <linux/dmapool.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kallsyms.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_dma.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+
+#include "dmaengine.h"
+#include "atcdmac300.h"
+
+static int atcdmac_is_chan_enable(struct atcdmac_chan *dmac_chan)
+{
+	struct atcdmac_dmac *dmac =
+		atcdmac_dev_to_dmac(dmac_chan->dma_chan.device);
+
+	return regmap_test_bits(dmac->regmap,
+				REG_CH_EN,
+				BIT(dmac_chan->chan_id));
+}
+
+static void atcdmac_enable_chan(struct atcdmac_chan *dmac_chan, bool enable)
+{
+	regmap_update_bits(dmac_chan->regmap, REG_CH_CTL_OFF, CHEN, enable);
+}
+
+static void atcdmac_abort_chan(struct atcdmac_chan *dmac_chan)
+{
+	regmap_write_bits(dmac_chan->regmap,
+			  REG_CH_ABT,
+			  BIT(dmac_chan->chan_id),
+			  1);
+}
+
+static dma_cookie_t atcdmac_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	struct atcdmac_desc *desc = atcdmac_txd_to_dma_desc(tx);
+	struct atcdmac_chan *dmac_chan = atcdmac_chan_to_dmac_chan(tx->chan);
+	dma_cookie_t cookie;
+
+	spin_lock_bh(&dmac_chan->lock);
+	cookie = dma_cookie_assign(tx);
+	list_add_tail(&desc->desc_node, &dmac_chan->queue_list);
+	spin_unlock_bh(&dmac_chan->lock);
+
+	return cookie;
+}
+
+static struct atcdmac_desc *
+atcdmac_get_active_head(struct atcdmac_chan *dmac_chan)
+{
+	return list_first_entry(&dmac_chan->active_list,
+				struct atcdmac_desc,
+				desc_node);
+}
+
+static struct atcdmac_desc *atcdmac_alloc_desc(struct dma_chan *chan,
+					       gfp_t gfp_flags)
+{
+	struct atcdmac_desc *desc;
+	struct atcdmac_dmac *dmac = atcdmac_dev_to_dmac(chan->device);
+	dma_addr_t phys;
+
+	desc = dma_pool_zalloc(dmac->dma_desc_pool, gfp_flags, &phys);
+	if (desc) {
+		INIT_LIST_HEAD(&desc->tx_list);
+		dma_async_tx_descriptor_init(&desc->txd, chan);
+		desc->txd.flags = DMA_CTRL_ACK;
+		desc->txd.tx_submit = atcdmac_tx_submit;
+		if (dmac->regmap_iocp)
+			desc->txd.phys = phys | IOCP_MASK;
+		else
+			desc->txd.phys = phys;
+	}
+
+	return desc;
+}
+
+static struct atcdmac_desc *atcdmac_get_desc(struct atcdmac_chan *dmac_chan)
+{
+	struct atcdmac_desc *desc;
+	struct atcdmac_desc *desc_next;
+	struct atcdmac_desc *ret = NULL;
+
+	spin_lock_bh(&dmac_chan->lock);
+	list_for_each_entry_safe(desc, desc_next,
+				 &dmac_chan->free_list,
+				 desc_node) {
+		if (async_tx_test_ack(&desc->txd)) {
+			list_del_init(&desc->desc_node);
+			ret = desc;
+			break;
+		}
+	}
+	spin_unlock_bh(&dmac_chan->lock);
+
+	if (!ret) {
+		ret = atcdmac_alloc_desc(&dmac_chan->dma_chan, GFP_ATOMIC);
+		if (ret) {
+			spin_lock_bh(&dmac_chan->lock);
+			dmac_chan->descs_allocated++;
+			spin_unlock_bh(&dmac_chan->lock);
+		} else {
+			dev_info(atcdmac_chan_to_dev(&dmac_chan->dma_chan),
+				 "not enough descriptors available\n");
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * atcdmac_put_desc_nolock - move a descriptor to the free list
+ * @dmac_chan: DMA channel we work on
+ * @desc: Head of the descriptor chain to be added to the free list
+ *
+ * This function does not use a lock to protect any linked lists in
+ * 'struct atcdmac_chan', so please remember to add a proper lock when
+ * calling the function.
+ */
+static void atcdmac_put_desc_nolock(struct atcdmac_chan *dmac_chan,
+				    struct atcdmac_desc *desc)
+{
+	struct list_head *next_node;
+	unsigned short num_sg;
+	unsigned short index;
+
+	if (desc) {
+		next_node = desc->tx_list.next;
+		num_sg = desc->num_sg;
+
+		list_del_init(&desc->desc_node);
+		desc->at = NULL;
+		desc->num_sg = 0;
+		INIT_LIST_HEAD(&desc->tx_list);
+		list_add_tail(&desc->desc_node, &dmac_chan->free_list);
+
+		for (index = 1; index < num_sg; index++) {
+			desc = list_entry(next_node,
+					  struct atcdmac_desc,
+					  desc_node);
+			next_node = desc->desc_node.next;
+			desc->at = NULL;
+			desc->num_sg = 0;
+			INIT_LIST_HEAD(&desc->tx_list);
+			list_add_tail(&desc->desc_node, &dmac_chan->free_list);
+		}
+	}
+}
+
+static void atcdmac_put_desc(struct atcdmac_chan *dmac_chan,
+			     struct atcdmac_desc *desc)
+{
+	if (!desc) {
+		dev_info(atcdmac_chan_to_dev(&dmac_chan->dma_chan),
+			 "A NULL descriptor was found.\n");
+		return;
+	}
+
+	spin_lock_bh(&dmac_chan->lock);
+	atcdmac_put_desc_nolock(dmac_chan, desc);
+	spin_unlock_bh(&dmac_chan->lock);
+}
+
+static void atcdmac_show_desc(struct atcdmac_chan *dmac_chan,
+			      struct atcdmac_desc *desc)
+{
+	struct device *dev = atcdmac_chan_to_dev(&dmac_chan->dma_chan);
+
+	dev_info(dev, "Dump desc info of chan: %u\n", dmac_chan->chan_id);
+	dev_info(dev, "chan ctrl: 0x%08x\n", desc->regs.ctrl);
+	dev_info(dev, "tran size: 0x%08x\n", desc->regs.trans_size);
+	dev_info(dev, "src addr: hi:0x%08x lo:0x%08x\n",
+		 desc->regs.src_addr_hi,
+		 desc->regs.src_addr_lo);
+	dev_info(dev, "dst addr: hi:0x%08x lo:0x%08x\n",
+		 desc->regs.dst_addr_hi,
+		 desc->regs.dst_addr_lo);
+	dev_info(dev, "link addr: hi:0x%08x lo:0x%08x\n",
+		 desc->regs.ll_ptr_hi,
+		 desc->regs.ll_ptr_lo);
+}
+
+/**
+ * atcdmac_chain_desc - Chain a DMA descriptor into a linked-list
+ * @first: Pointer to the first descriptor in the chain
+ * @prev: Pointer to the previous descriptor in the chain
+ * @desc: The descriptor to be added to the chain
+ * @cyclic: Indicates if the transfer operates in cyclic mode
+ *
+ * This function appends a DMA descriptor (desc) to a linked-list of
+ * descriptors. If this is the first descriptor being added, it initializes
+ * the list and sets *first to point to desc. Otherwise, it links the
+ * new descriptor to the end of the list managed by *first.
+ *
+ * For non-cyclic descriptors, it updates the hardware linked list pointers
+ * (ll_ptr_lo and ll_ptr_hi) of the previous descriptor (*prev) to point to
+ * the physical address of the new descriptor.
+ *
+ * Finally, it adds the new descriptor to the list and updates *prev to
+ * point to the current descriptor (desc).
+ */
+static void atcdmac_chain_desc(struct atcdmac_desc **first,
+			       struct atcdmac_desc **prev,
+			       struct atcdmac_desc *desc,
+			       bool cyclic)
+{
+	if (!(*first)) {
+		*first = desc;
+		desc->at = &desc->tx_list;
+	} else {
+		if (!cyclic) {
+			(*prev)->regs.ll_ptr_lo =
+				lower_32_bits(desc->txd.phys);
+			(*prev)->regs.ll_ptr_hi =
+				upper_32_bits(desc->txd.phys);
+		}
+		list_add_tail(&desc->desc_node, &(*first)->tx_list);
+	}
+	*prev = desc;
+
+	desc->regs.ll_ptr_hi = 0;
+	desc->regs.ll_ptr_lo = 0;
+}
+
+/**
+ * atcdmac_start_transfer - Start the DMA engine with the provided descriptor
+ * @dmac_chan: The DMA channel to be started
+ * @first_desc: The first descriptor in the list to begin the transfer
+ *
+ * This function configures the DMA engine by programming the hardware
+ * registers with the information from the provided descriptor (first_desc).
+ * It then starts the DMA transfer for the specified channel (dmac_chan).
+ *
+ * The first_desc contains the initial configuration for the transfer,
+ * including source and destination addresses, transfer size, and any linked
+ * list pointers for subsequent descriptors in the chain.
+ */
+static void atcdmac_start_transfer(struct atcdmac_chan *dmac_chan,
+				   struct atcdmac_desc *first_desc)
+{
+	struct atcdmac_dmac *dmac = dmac_chan->dma_dev;
+	struct regmap *reg = dmac_chan->regmap;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dmac->lock, flags);
+	dmac->used_chan |= BIT(dmac_chan->chan_id);
+	spin_unlock_irqrestore(&dmac->lock, flags);
+
+	regmap_write(reg, REG_CH_CTL_OFF, first_desc->regs.ctrl);
+	regmap_write(reg, REG_CH_SIZE_OFF, first_desc->regs.trans_size);
+	regmap_write(reg, REG_CH_SRC_LOW_OFF, first_desc->regs.src_addr_lo);
+	regmap_write(reg, REG_CH_DST_LOW_OFF, first_desc->regs.dst_addr_lo);
+	regmap_write(reg, REG_CH_LLP_LOW_OFF, first_desc->regs.ll_ptr_lo);
+	regmap_write(reg, REG_CH_SRC_HIGH_OFF, first_desc->regs.src_addr_hi);
+	regmap_write(reg, REG_CH_DST_HIGH_OFF, first_desc->regs.dst_addr_hi);
+	regmap_write(reg, REG_CH_LLP_HIGH_OFF, first_desc->regs.ll_ptr_hi);
+	atcdmac_enable_chan(dmac_chan, 1);
+}
+
+/**
+ * atcdmac_start_next_trans - Retrieve and initiate the next DMA transfer
+ * @dmac_chan: Pointer to the DMA channel structure
+ *
+ * In non-cyclic mode, if active_list is empty, the function moves
+ * descriptors from queue_list (if available) to active_list and starts
+ * the transfer. If both lists are empty, it marks the channel as unused.
+ * If there are already active descriptors in active_list, the function
+ * retrieves the next DMA descriptor from it and starts the transfer.
+ *
+ * In cyclic mode, the function retrieves the next DMA descriptor
+ * from the linked list of tx_list to maintain continuous transfers.
+ */
+static void atcdmac_start_next_trans(struct atcdmac_chan *dmac_chan)
+{
+	struct atcdmac_desc *dma_desc;
+	struct atcdmac_desc *next_tx = NULL;
+
+	if (dmac_chan->cyclic) {
+		/* Get the next DMA descriptor from tx_list. */
+		dma_desc = atcdmac_get_active_head(dmac_chan);
+		dma_desc->at = dma_desc->at->next;
+		if ((uintptr_t)dma_desc->at == (uintptr_t)&dma_desc->tx_list)
+			next_tx = list_entry(dma_desc->at,
+					     struct atcdmac_desc,
+					     tx_list);
+		else
+			next_tx = list_entry(dma_desc->at,
+					     struct atcdmac_desc,
+					     desc_node);
+	} else {
+		if (list_empty(&dmac_chan->active_list)) {
+			if (!list_empty(&dmac_chan->queue_list)) {
+				list_splice_init(&dmac_chan->queue_list,
+						 &dmac_chan->active_list);
+				next_tx = atcdmac_get_active_head(dmac_chan);
+			}
+		} else {
+			next_tx = atcdmac_get_active_head(dmac_chan);
+		}
+	}
+
+	if (next_tx) {
+		dmac_chan->chan_used = 1;
+		atcdmac_start_transfer(dmac_chan, next_tx);
+	} else {
+		dmac_chan->chan_used = 0;
+	}
+}
+
+/**
+ * atcdmac_complete_desc - Complete a descriptor transaction of DMA and
+ *                         invoke the result
+ * @dmac_chan: DMA channel on which the transaction was executed
+ * @desc: Descriptor to be completed
+ * @result: Result of the transaction
+ *
+ * This function ensures proper cleanup and notification to the DMA engine
+ * framework after the execution of a single descriptor transaction.
+ */
+static void atcdmac_complete_desc(struct atcdmac_chan *dmac_chan,
+				  struct atcdmac_desc *desc,
+				  enum dmaengine_tx_result result)
+{
+	struct dma_async_tx_descriptor *txd = &desc->txd;
+	struct dmaengine_result res;
+
+	res.result = result;
+	dma_cookie_complete(txd);
+	dmaengine_desc_get_callback_invoke(txd, &res);
+	dma_run_dependencies(txd);
+	atcdmac_put_desc_nolock(dmac_chan, desc);
+}
+
+/**
+ * atcdmac_complete_all_active - Reclaim all descriptors from the active
+ *                               list and refill the active list from the
+ *                               queue list
+ * @dmac_chan: DMA channel to process
+ *
+ * This function reclaims all descriptors from the active_list of the
+ * specified DMA channel (dmac_chan) and transfers them to a temporary list
+ * for processing. After clearing the active_list, it refills it with
+ * descriptors from the queue_list list. This ensures that any pending
+ * descriptors in the queue_list are prepared for processing.
+ */
+static void atcdmac_complete_all_active(struct atcdmac_chan *dmac_chan)
+{
+	struct atcdmac_desc *desc;
+	struct atcdmac_desc *desc_next;
+	LIST_HEAD(list);
+
+	/*
+	 * Move all descriptors from active_list to a temporary list for
+	 * processing. This ensures that active_list is emptied, allowing
+	 * it to be reused.
+	 */
+	list_splice_init(&dmac_chan->active_list, &list);
+
+	/*
+	 * Refill the active_list by transferring all pending descriptors
+	 * from the queue_list. This step prepares active_list for processing
+	 * any remaining queued transactions.
+	 */
+	list_splice_init(&dmac_chan->queue_list, &dmac_chan->active_list);
+
+	list_for_each_entry_safe(desc, desc_next, &list, desc_node)
+		atcdmac_complete_desc(dmac_chan, desc, DMA_TRANS_NOERROR);
+}
+
+/**
+ * atcdmac_advance_work - Process the completed transaction and move to the
+ *                        next descriptor
+ * @dmac_chan: DMA channel where the transaction has completed
+ *
+ * This function is responsible for performing necessary operations after
+ * a DMA transaction completes successfully. It retrieves the next descriptor
+ * from the active list, initiates its transfer, and communicates the result
+ * of the completed transaction to the DMA engine framework.
+ */
+static void atcdmac_advance_work(struct atcdmac_chan *dmac_chan)
+{
+	struct dmaengine_result res;
+	struct atcdmac_desc *dma_desc;
+	struct atcdmac_dmac *dmac =
+		atcdmac_dev_to_dmac(dmac_chan->dma_chan.device);
+	unsigned short stop;
+
+	clear_bit(ATCDMAC_STA_TC, &dmac_chan->status);
+
+	spin_lock(&dmac_chan->lock);
+	dma_desc = atcdmac_get_active_head(dmac_chan);
+	stop = dmac->stop_mask & BIT(dmac_chan->chan_id);
+	if (dmac_chan->cyclic) {
+		if (!stop)
+			atcdmac_start_next_trans(dmac_chan);
+		res.result = DMA_TRANS_NOERROR;
+		dmaengine_desc_get_callback_invoke(&dma_desc->txd, &res);
+	} else {
+		if (list_is_singular(&dmac_chan->active_list))
+			atcdmac_complete_all_active(dmac_chan);
+		else
+			atcdmac_complete_desc(dmac_chan, dma_desc,
+					      DMA_TRANS_NOERROR);
+
+		if (!stop)
+			atcdmac_start_next_trans(dmac_chan);
+	}
+	spin_unlock(&dmac_chan->lock);
+}
+
+/**
+ * atcdmac_handle_error - Handle errors reported by the DMA controller
+ * @dmac_chan: DMA channel where the error occurred
+ *
+ * This function is invoked when the DMA controller detects an error during a
+ * transaction. This function ensures that the DMA channel can recover from
+ * errors while reporting issues to aid in debugging. It prevents the DMA
+ * controller from operating on potentially invalid memory regions and
+ * attempts to maintain system stability.
+ */
+static void atcdmac_handle_error(struct atcdmac_chan *dmac_chan)
+{
+	struct device *dev = atcdmac_chan_to_dev(&dmac_chan->dma_chan);
+	struct atcdmac_desc *bad_desc;
+	struct atcdmac_dmac *dmac =
+		atcdmac_dev_to_dmac(dmac_chan->dma_chan.device);
+	unsigned short stop;
+
+	clear_bit(ATCDMAC_STA_ERR, &dmac_chan->status);
+	spin_lock(&dmac_chan->lock);
+
+	/*
+	 * If both the active and queue lists are empty, it indicates
+	 * this descriptor has already been handled by another function
+	 * (e.g., atcdmac_terminate_all()). Therefore, no further action
+	 * is needed.
+	 */
+	if (!list_empty(&dmac_chan->active_list) &&
+	    !list_empty(&dmac_chan->queue_list)) {
+		/*
+		 * Identify the problematic descriptor at the head of the
+		 * active list and remove it from the list for further
+		 * processing.
+		 */
+		bad_desc = atcdmac_get_active_head(dmac_chan);
+		list_del_init(&bad_desc->desc_node);
+
+		/*
+		 * Transfer any pending descriptors from the queue list to the
+		 * active list, allowing them to be processed in subsequent
+		 * operations.
+		 */
+		list_splice_init(&dmac_chan->queue_list,
+				 dmac_chan->active_list.prev);
+
+		stop = dmac->stop_mask & BIT(dmac_chan->chan_id);
+		if (!list_empty(&dmac_chan->active_list) && stop == 0)
+			atcdmac_start_transfer(dmac_chan,
+				atcdmac_get_active_head(dmac_chan));
+		else
+			dmac_chan->chan_used = 0;
+
+		spin_unlock(&dmac_chan->lock);
+
+		/*
+		 * Show the details information of the bad descriptor and
+		 * return "DMA_TRANS_ABORTED" to the DMA engine framework.
+		 */
+		dev_info(dev, "DMA transaction failed possible DMA desc error\n");
+		atcdmac_show_desc(dmac_chan, bad_desc);
+		atcdmac_complete_desc(dmac_chan, bad_desc, DMA_TRANS_ABORTED);
+	} else {
+		spin_unlock(&dmac_chan->lock);
+	}
+}
+
+static void atcdmac_tasklet(unsigned long data)
+{
+	struct atcdmac_chan *dmac_chan = (struct atcdmac_chan *)data;
+
+	/*
+	 * ATCDMAC_STA_ABORT only occurs when the DMA channel is terminated or
+	 * freed, and all descriptors and callbacks have already been
+	 * processed. Therefore, no additional handling is required.
+	 */
+	if (test_and_clear_bit(ATCDMAC_STA_TC, &dmac_chan->status))
+		atcdmac_advance_work(dmac_chan);
+	else if (test_and_clear_bit(ATCDMAC_STA_ERR, &dmac_chan->status))
+		atcdmac_handle_error(dmac_chan);
+	else
+		clear_bit(ATCDMAC_STA_ABORT, &dmac_chan->status);
+}
+
+static irqreturn_t atcdmac_interrupt(int irq, void *dev_id)
+{
+	struct atcdmac_dmac *dmac = (struct atcdmac_dmac *)dev_id;
+	struct atcdmac_chan *dmac_chan;
+	unsigned int status;
+	unsigned int int_ch;
+	int ret = IRQ_NONE;
+	int i;
+
+	regmap_read(dmac->regmap, REG_INT_STA, &status);
+	int_ch = dmac->used_chan & DMA_INT_ALL(status);
+
+	while (int_ch) {
+		spin_lock(&dmac->lock);
+		dmac->used_chan &= ~int_ch;
+		spin_unlock(&dmac->lock);
+		regmap_write(dmac->regmap, REG_INT_STA, DMA_INT_CLR(int_ch));
+
+		for (i = 0; i < dmac->dma_device.chancnt; i++) {
+			if (int_ch & BIT(i)) {
+				int_ch &= ~BIT(i);
+				dmac_chan = &dmac->chan[i];
+
+				if (status & DMA_TC(i))
+					set_bit(ATCDMAC_STA_TC,
+						&dmac_chan->status);
+
+				if (status & DMA_ERR(i))
+					set_bit(ATCDMAC_STA_ERR,
+						&dmac_chan->status);
+
+				if (status & DMA_ABT(i))
+					set_bit(ATCDMAC_STA_ABORT,
+						&dmac_chan->status);
+
+				tasklet_schedule(&dmac_chan->tasklet);
+				ret = IRQ_HANDLED;
+			}
+			if (!int_ch)
+				break;
+		}
+
+		regmap_read(dmac->regmap, REG_INT_STA, &status);
+		int_ch = dmac->used_chan & DMA_INT_ALL(status);
+	}
+
+	return ret;
+}
+
+/**
+ * atcdmac_issue_pending - Trigger the execution of queued DMA transactions
+ * @chan: DMA channel on which to issue pending transactions
+ *
+ * This function checks if the DMA channel is currently idle and if there are
+ * descriptors waiting in the queue_list. If the channel is idle and the
+ * queue_list is not empty, it moves the first queued descriptor to the active
+ * list and starts the DMA transfer by calling atcdmac_start_transfer().
+ */
+static void atcdmac_issue_pending(struct dma_chan *chan)
+{
+	struct atcdmac_chan *dmac_chan = atcdmac_chan_to_dmac_chan(chan);
+	struct atcdmac_dmac *dmac =
+		atcdmac_dev_to_dmac(dmac_chan->dma_chan.device);
+	unsigned short stop;
+
+	spin_lock_bh(&dmac_chan->lock);
+	stop = dmac->stop_mask & BIT(dmac_chan->chan_id);
+	if (dmac_chan->chan_used == 0 && stop == 0 &&
+	    !list_empty(&dmac_chan->queue_list)) {
+		dmac_chan->chan_used = 1;
+		list_move(dmac_chan->queue_list.next, &dmac_chan->active_list);
+		atcdmac_start_transfer(dmac_chan,
+				       atcdmac_get_active_head(dmac_chan));
+	}
+
+	spin_unlock_bh(&dmac_chan->lock);
+}
+
+static unsigned char atcdmac_map_buswidth(enum dma_slave_buswidth addr_width)
+{
+	switch (addr_width) {
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		return 0;
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		return 1;
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		return 2;
+	case DMA_SLAVE_BUSWIDTH_8_BYTES:
+		return 3;
+	case DMA_SLAVE_BUSWIDTH_16_BYTES:
+		return 4;
+	case DMA_SLAVE_BUSWIDTH_32_BYTES:
+		return 5;
+	default:
+		return 0;
+	}
+}
+
+static unsigned int atcdmac_map_tran_width(dma_addr_t src,
+					   dma_addr_t dst,
+					   size_t len,
+					   unsigned int max_align_bytes)
+{
+	unsigned int align = src | dst | len | max_align_bytes;
+	unsigned int width;
+
+	if (!(align & 0x1F))
+		width = WIDTH_32_BYTES;
+	else if (!(align & 0xF))
+		width = WIDTH_16_BYTES;
+	else if (!(align & 0x7))
+		width = WIDTH_8_BYTES;
+	else if (!(align & 0x3))
+		width = WIDTH_4_BYTES;
+	else if (!(align & 0x1))
+		width = WIDTH_2_BYTES;
+	else
+		width = WIDTH_1_BYTE;
+
+	return width;
+}
+
+/**
+ * atcdmac_convert_burst - Convert burst size to a power of two index
+ * @burst_size: Actual burst size in bytes
+ *
+ * This function converts a burst size (e.g., 1, 2, 4, 8...) into the
+ * corresponding hardware-encoded value, which represents the index of
+ * the power of two.
+ *
+ * Return: The zero-based power-of-two index corresponding to @burst_size.
+ *
+ * Example:
+ * If burst_size is 8 (binary 1000), the most significant bit is at position
+ * 4, so the function returns 3 (i.e., 4 - 1).
+ */
+static unsigned char atcdmac_convert_burst(unsigned int burst_size)
+{
+	return fls(burst_size) - 1;
+}
+
+static struct atcdmac_desc *
+atcdmac_build_desc(struct atcdmac_chan *dmac_chan,
+		   dma_addr_t src,
+		   dma_addr_t dst,
+		   unsigned int ctrl,
+		   unsigned int trans_size,
+		   unsigned int num_sg)
+{
+	struct atcdmac_desc *desc;
+
+	desc = atcdmac_get_desc(dmac_chan);
+	if (!desc)
+		return NULL;
+
+	desc->regs.src_addr_lo = lower_32_bits(src);
+	desc->regs.src_addr_hi = upper_32_bits(src);
+	desc->regs.dst_addr_lo = lower_32_bits(dst);
+	desc->regs.dst_addr_hi = upper_32_bits(dst);
+	desc->regs.ctrl = ctrl;
+	desc->regs.trans_size = trans_size;
+	desc->num_sg = num_sg;
+
+	return desc;
+}
+
+/**
+ * atcdmac_prep_dma_memcpy - Prepare a DMA memcpy operation for the specified
+ *                           channel
+ * @chan: DMA channel to configure for the operation
+ * @dst: Physical destination address for the transfer
+ * @src: Physical source address for the transfer
+ * @len: Size of the data to transfer, in bytes
+ * @flags: Status flags for the transfer descriptor
+ *
+ * This function sets up a DMA memcpy operation to transfer data from the
+ * specified source address to the destination address. It returns a DMA
+ * descriptor that represents the configured transaction.
+ */
+static struct dma_async_tx_descriptor *
+atcdmac_prep_dma_memcpy(struct dma_chan *chan,
+			dma_addr_t dst,
+			dma_addr_t src,
+			size_t len,
+			unsigned long flags)
+{
+	struct atcdmac_chan *dmac_chan = atcdmac_chan_to_dmac_chan(chan);
+	struct atcdmac_dmac *dmac = atcdmac_dev_to_dmac(chan->device);
+	struct atcdmac_desc *desc;
+	unsigned int src_width;
+	unsigned int dst_width;
+	unsigned int ctrl;
+	unsigned char src_max_burst;
+
+	if (unlikely(!len)) {
+		dev_warn(atcdmac_chan_to_dev(chan),
+			 "Failed to prepare DMA operation: len is zero\n");
+		return NULL;
+	}
+
+	if (dmac->regmap_iocp) {
+		dst |= IOCP_MASK;
+		src |= IOCP_MASK;
+	}
+	src_max_burst =
+		atcdmac_convert_burst((unsigned int)SRC_BURST_SIZE_1024);
+	src_width = atcdmac_map_tran_width(src,
+					   dst,
+					   len,
+					   1 << dmac->data_width);
+	dst_width = src_width;
+	ctrl = SRC_BURST_SIZE(src_max_burst) |
+	       SRC_ADDR_MODE_INCR |
+	       DST_ADDR_MODE_INCR |
+	       DST_WIDTH(dst_width) |
+	       SRC_WIDTH(src_width);
+
+	desc = atcdmac_build_desc(dmac_chan, src, dst, ctrl,
+				  len >> src_width, 1);
+	if (!desc)
+		goto err_desc_get;
+
+	return &desc->txd;
+
+err_desc_get:
+	dev_warn(atcdmac_chan_to_dev(chan), "Failed to allocate descriptor\n");
+	return NULL;
+}
+
+/**
+ * atcdmac_prep_device_sg - Prepare descriptors for memory/device DMA
+ *                          transactions
+ * @chan: DMA channel to configure for the operation
+ * @sgl: Scatter-gather list representing the memory regions to transfer
+ * @sg_len: Number of entries in the scatter-gather list
+ * @direction: Direction of the DMA transfer
+ * @flags: Status flags for the transfer descriptor
+ * @context: transaction context (ignored)
+ *
+ * This function prepares a DMA transaction by setting up the required
+ * descriptors based on the provided scatter-gather list and parameters.
+ * It supports memory-to-device and device-to-memory DMA transfers.
+ */
+static struct dma_async_tx_descriptor *
+atcdmac_prep_device_sg(struct dma_chan *chan,
+		       struct scatterlist *sgl,
+		       unsigned int sg_len,
+		       enum dma_transfer_direction direction,
+		       unsigned long flags,
+		       void *context)
+{
+	struct atcdmac_dmac *dmac = atcdmac_dev_to_dmac(chan->device);
+	struct atcdmac_chan *dmac_chan = atcdmac_chan_to_dmac_chan(chan);
+	struct dma_slave_config *sconfig = &dmac_chan->dma_sconfig;
+	struct atcdmac_desc *first;
+	struct scatterlist *sg;
+	dma_addr_t reg;
+	unsigned int i;
+	unsigned int width_src;
+	unsigned int width_dst;
+	unsigned short burst_bytes;
+
+	if (unlikely(!sg_len)) {
+		dev_warn(atcdmac_chan_to_dev(chan), "sg_len is zero\n");
+		return NULL;
+	}
+
+	if (direction == DMA_MEM_TO_DEV) {
+		reg = sconfig->dst_addr;
+		burst_bytes = sconfig->dst_addr_width * sconfig->dst_maxburst;
+		width_dst = atcdmac_map_buswidth(sconfig->dst_addr_width);
+		width_src = atcdmac_map_buswidth(sconfig->src_addr_width);
+	} else if (direction == DMA_DEV_TO_MEM) {
+		reg = sconfig->src_addr;
+		burst_bytes = sconfig->src_addr_width * sconfig->src_maxburst;
+		width_src = atcdmac_map_buswidth(sconfig->src_addr_width);
+		width_dst = atcdmac_map_buswidth(sconfig->dst_addr_width);
+	} else {
+		dev_info(atcdmac_chan_to_dev(chan),
+			 "Invalid transfer direction %d\n", direction);
+		return NULL;
+	}
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		struct atcdmac_desc *prev, *desc;
+		dma_addr_t mem;
+		dma_addr_t src, dst;
+		unsigned int width_cal;
+		unsigned int len;
+		unsigned int ctrl;
+		unsigned short burst_size;
+
+		mem = sg_dma_address(sg);
+		len = sg_dma_len(sg);
+		if (unlikely(!len)) {
+			dev_info(atcdmac_chan_to_dev(chan),
+				 "sg(%u) data len is zero\n", i);
+			goto err;
+		}
+
+		if (dmac->regmap_iocp)
+			mem |= IOCP_MASK;
+
+		width_cal = atcdmac_map_tran_width(mem,
+						   reg,
+						   len,
+						   (1 << dmac->data_width) |
+						   burst_bytes);
+		if (direction == DMA_MEM_TO_DEV) {
+			if (burst_bytes < (1 << width_cal)) {
+				burst_size = burst_bytes;
+				width_cal = WIDTH_1_BYTE;
+			} else {
+				burst_size = burst_bytes / (1 << width_cal);
+			}
+
+			ctrl = SRC_ADDR_MODE_INCR | DST_ADDR_MODE_FIXED |
+			       DST_HS | DST_REQ(dmac_chan->req_num) |
+			       SRC_WIDTH(width_cal) | DST_WIDTH(width_dst) |
+			       SRC_BURST_SIZE(ilog2(burst_size));
+			src = mem;
+			dst = reg;
+		} else {
+			burst_size = burst_bytes / sconfig->src_addr_width;
+
+			ctrl = SRC_ADDR_MODE_FIXED | DST_ADDR_MODE_INCR |
+			       SRC_HS | SRC_REQ(dmac_chan->req_num) |
+			       SRC_WIDTH(width_src) | DST_WIDTH(width_cal) |
+			       SRC_BURST_SIZE(ilog2(burst_size));
+			src = reg;
+			dst = mem;
+			width_cal = width_src;
+		}
+
+		desc = atcdmac_build_desc(dmac_chan, src, dst, ctrl,
+					  len >> width_cal, sg_len);
+		if (!desc)
+			goto err_desc_get;
+
+		atcdmac_chain_desc(&first, &prev, desc, false);
+	}
+
+	first->txd.cookie = -EBUSY;
+	first->txd.flags = flags;
+
+	return &first->txd;
+
+err_desc_get:
+	dev_warn(atcdmac_chan_to_dev(chan), "Failed to allocate descriptor\n");
+
+err:
+	if (first)
+		atcdmac_put_desc(dmac_chan, first);
+	return NULL;
+}
+
+static struct dma_async_tx_descriptor *
+atcdmac_prep_dma_cyclic(struct dma_chan *chan,
+			dma_addr_t buf_addr,
+			size_t buf_len,
+			size_t period_len,
+			enum dma_transfer_direction direction,
+			unsigned long flags)
+{
+	struct atcdmac_chan *dmac_chan = atcdmac_chan_to_dmac_chan(chan);
+	struct atcdmac_dmac *dmac = atcdmac_dev_to_dmac(chan->device);
+	struct dma_slave_config *sconfig = &dmac_chan->dma_sconfig;
+	struct atcdmac_desc *first;
+	dma_addr_t reg;
+	unsigned int period;
+	unsigned int width_src;
+	unsigned int width_dst;
+	unsigned int num_periods;
+	unsigned short burst_bytes;
+
+	if (period_len == 0 || buf_len == 0) {
+		dev_warn(atcdmac_chan_to_dev(chan),
+			 "invalid cyclic params buf_len=%zu period_len=%zu\n",
+			 buf_len, period_len);
+		return NULL;
+	}
+
+	if (direction == DMA_MEM_TO_DEV) {
+		reg = sconfig->dst_addr;
+		burst_bytes = sconfig->dst_addr_width * sconfig->dst_maxburst;
+		width_dst = atcdmac_map_buswidth(sconfig->dst_addr_width);
+		width_src = atcdmac_map_buswidth(sconfig->src_addr_width);
+	} else if (direction == DMA_DEV_TO_MEM) {
+		reg = sconfig->src_addr;
+		burst_bytes = sconfig->src_addr_width * sconfig->src_maxburst;
+		width_src = atcdmac_map_buswidth(sconfig->src_addr_width);
+		width_dst = atcdmac_map_buswidth(sconfig->dst_addr_width);
+	} else {
+		dev_info(atcdmac_chan_to_dev(chan),
+			 "Invalid transfer direction %d\n", direction);
+		return NULL;
+	}
+
+	num_periods = (buf_len + period_len - 1) / period_len;
+
+	for (period = 0; period < buf_len; period += period_len) {
+		struct atcdmac_desc *prev, *desc;
+		dma_addr_t mem;
+		dma_addr_t src, dst;
+		unsigned int width_cal;
+		unsigned int len;
+		unsigned int ctrl;
+		unsigned short burst_size;
+
+		mem = buf_addr + period;
+		len = buf_len - period;
+		if (len > period_len)
+			len = period_len;
+		if (dmac->regmap_iocp)
+			mem |= IOCP_MASK;
+
+		width_cal = atcdmac_map_tran_width(mem, reg, len,
+						   (1 << dmac->data_width) |
+						   burst_bytes);
+
+		if (direction == DMA_MEM_TO_DEV) {
+			if (burst_bytes < (1 << width_cal)) {
+				burst_size = burst_bytes;
+				width_cal = WIDTH_1_BYTE;
+			} else {
+				burst_size = burst_bytes / (1 << width_cal);
+			}
+			ctrl = SRC_ADDR_MODE_INCR | DST_ADDR_MODE_FIXED |
+			       DST_HS | DST_REQ(dmac_chan->req_num) |
+			       SRC_WIDTH(width_cal) | DST_WIDTH(width_dst) |
+			       SRC_BURST_SIZE(ilog2(burst_size));
+			src = mem;
+			dst = reg;
+		} else {
+			burst_size = burst_bytes / sconfig->src_addr_width;
+			ctrl = SRC_ADDR_MODE_FIXED | DST_ADDR_MODE_INCR |
+			       SRC_HS | SRC_REQ(dmac_chan->req_num) |
+			       SRC_WIDTH(width_src) | DST_WIDTH(width_cal) |
+			       SRC_BURST_SIZE(ilog2(burst_size));
+			src = reg;
+			dst = mem;
+			width_cal = width_src;
+		}
+
+		desc = atcdmac_build_desc(dmac_chan, src, dst, ctrl,
+					  len >> width_cal, num_periods);
+		if (!desc)
+			goto err_desc_get;
+		atcdmac_chain_desc(&first, &prev, desc, false);
+	}
+
+	first->txd.flags = flags;
+	dmac_chan->cyclic = true;
+
+	return &first->txd;
+
+err_desc_get:
+	dev_warn(atcdmac_chan_to_dev(chan), "Failed to allocate descriptor\n");
+	if (first)
+		atcdmac_put_desc(dmac_chan, first);
+
+	return NULL;
+}
+
+static int atcdmac_set_device_config(struct dma_chan *chan,
+				     struct dma_slave_config *sconfig)
+{
+	struct atcdmac_chan *dmac_chan = atcdmac_chan_to_dmac_chan(chan);
+
+	/* Check if this chan is configured for device transfers */
+	if (!dmac_chan->dev_chan)
+		return -EINVAL;
+
+	/* Must be powers of two according to ATCDMAC300 spec */
+	if (!is_power_of_2(sconfig->src_maxburst) ||
+	    !is_power_of_2(sconfig->dst_maxburst) ||
+	    !is_power_of_2(sconfig->src_addr_width) ||
+	    !is_power_of_2(sconfig->dst_addr_width))
+		return -EINVAL;
+
+	memcpy(&dmac_chan->dma_sconfig, sconfig, sizeof(*sconfig));
+
+	return 0;
+}
+
+/**
+ * atcdmac_tx_status - Stop DMA transmission and reclaim descriptors
+ * @chan: DMA channel to stop
+ *
+ * This function terminates all pending and active transactions on the
+ * specified DMA channel. It stops the DMA engine, clears all descriptors
+ * in both the active and queue lists, and reclaims these descriptors
+ * to ensure proper cleanup.
+ *
+ * Return: The status of the transaction associated with @cookie, which may
+ *         be one of the enum dma_status values, such as DMA_COMPLETE,
+ *         DMA_IN_PROGRESS, or DMA_ERROR.
+ */
+static int atcdmac_terminate_all(struct dma_chan *chan)
+{
+	struct atcdmac_chan *dmac_chan = atcdmac_chan_to_dmac_chan(chan);
+	struct atcdmac_desc *desc_cur;
+	struct atcdmac_desc *desc_next;
+	struct dmaengine_result res;
+
+	res.result = DMA_TRANS_ABORTED;
+	spin_lock_bh(&dmac_chan->lock);
+	atcdmac_abort_chan(dmac_chan);
+	atcdmac_enable_chan(dmac_chan, 0);
+
+	/* confirm that this channel is disabled */
+	while (atcdmac_is_chan_enable(dmac_chan))
+		cpu_relax();
+
+	/* active_list entries will end up before queued entries */
+	list_for_each_entry_safe(desc_cur,
+				 desc_next,
+				 &dmac_chan->queue_list,
+				 desc_node) {
+		dmaengine_desc_get_callback_invoke(&desc_cur->txd, &res);
+		dma_cookie_complete(&desc_cur->txd);
+		atcdmac_put_desc_nolock(dmac_chan, desc_cur);
+	}
+	INIT_LIST_HEAD(&dmac_chan->queue_list);
+
+	list_for_each_entry_safe(desc_cur,
+				 desc_next,
+				 &dmac_chan->active_list,
+				 desc_node) {
+		dmaengine_desc_get_callback_invoke(&desc_cur->txd, &res);
+		dma_cookie_complete(&desc_cur->txd);
+		atcdmac_put_desc_nolock(dmac_chan, desc_cur);
+	}
+	INIT_LIST_HEAD(&dmac_chan->active_list);
+
+	dmac_chan->chan_used = 0;
+	spin_unlock_bh(&dmac_chan->lock);
+	return 0;
+}
+
+static enum dma_status atcdmac_get_tx_status(struct dma_chan *chan,
+					     dma_cookie_t cookie,
+					     struct dma_tx_state *state)
+{
+	return dma_cookie_status(chan, cookie, state);
+}
+
+static int atcdmac_wait_chan_idle(struct atcdmac_dmac *dmac,
+				  unsigned short chan_mask,
+				  unsigned int timeout_us)
+{
+	unsigned int val;
+	int ret;
+
+	ret = readl_poll_timeout(dmac->regs + REG_CH_EN, val,
+				 !(val & chan_mask), 50, timeout_us);
+	if (ret)
+		dev_info(dmac->dma_device.dev,
+			 "Timeout waiting for device ready %d\n", ret);
+
+	return ret;
+}
+
+/**
+ * atcdmac_alloc_chan_resources - Allocate resources for a DMA channel
+ * @chan: The DMA channel for which resources are being allocated
+ *
+ * This function sets up and allocates the necessary resources for the
+ * specified DMA channel (chan). It ensures the channel is prepared to
+ * handle DMA requests from clients by allocating descriptors and any other
+ * required resources.
+ *
+ * Return: The number of descriptors successfully allocated, or a negative
+ *         error code on failure.
+ */
+static int atcdmac_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct atcdmac_chan *dmac_chan = atcdmac_chan_to_dmac_chan(chan);
+	struct atcdmac_dmac *dmac = atcdmac_dev_to_dmac(chan->device);
+	struct atcdmac_desc *desc;
+	int i;
+
+	if (atcdmac_is_chan_enable(dmac_chan)) {
+		dev_info(atcdmac_chan_to_dev(chan),
+			 "DMA channel is not in an idle state\n");
+		return -EBUSY;
+	}
+
+	if (!list_empty(&dmac_chan->free_list))
+		return dmac_chan->descs_allocated;
+
+	/*
+	 * Spin-lock protection is not necessary during DMA channel
+	 * initialization, as the channel is not yet in use at this stage,
+	 * and the shared resources are not accessed by other threads.
+	 */
+	for (i = 0; i < ATCDMAC_DESC_PER_CHAN; i++) {
+		desc = atcdmac_alloc_desc(chan, GFP_KERNEL);
+		if (!desc) {
+			dev_info(dmac->dma_device.dev,
+				 "Insufficient descriptors: only %d descriptors available\n",
+				 i);
+			break;
+		}
+		list_add_tail(&desc->desc_node, &dmac_chan->free_list);
+	}
+	dmac_chan->descs_allocated = i;
+	dmac_chan->cyclic = false;
+	dma_cookie_init(chan);
+	spin_lock_irq(&dmac->lock);
+	dmac->stop_mask &= ~BIT(dmac_chan->chan_id);
+	spin_unlock_irq(&dmac->lock);
+
+	return dmac_chan->descs_allocated;
+}
+
+/**
+ * atcdmac_free_chan_resources - Release a DMA channel's resources
+ * @chan: The DMA channel to release
+ *
+ * This function ensures that any remaining DMA descriptors in the
+ * active_list and queue_list are properly reclaimed. It releases all
+ * resources associated with the specified DMA channel and resets the
+ * channel's management structures to their initial states.
+ */
+static void atcdmac_free_chan_resources(struct dma_chan *chan)
+{
+	struct atcdmac_chan *dmac_chan = atcdmac_chan_to_dmac_chan(chan);
+	struct atcdmac_dmac *dmac = atcdmac_dev_to_dmac(chan->device);
+	struct atcdmac_desc *desc;
+	struct atcdmac_desc *desc_next;
+
+	WARN_ON_ONCE(atcdmac_is_chan_enable(dmac_chan));
+
+	spin_lock_irq(&dmac->lock);
+	dmac->stop_mask |= BIT(dmac_chan->chan_id);
+	spin_unlock_irq(&dmac->lock);
+
+	spin_lock_bh(&dmac_chan->lock);
+	if (!list_empty(&dmac_chan->active_list) ||
+	    !list_empty(&dmac_chan->queue_list)) {
+		WARN_ON_ONCE(!list_empty(&dmac_chan->active_list));
+		WARN_ON_ONCE(!list_empty(&dmac_chan->queue_list));
+		spin_unlock_bh(&dmac_chan->lock);
+		atcdmac_terminate_all(chan);
+		spin_lock_bh(&dmac_chan->lock);
+	}
+
+	list_for_each_entry_safe(desc, desc_next, &dmac_chan->free_list,
+				 desc_node) {
+		list_del(&desc->desc_node);
+		dma_pool_free(dmac->dma_desc_pool, desc, desc->txd.phys);
+	}
+
+	INIT_LIST_HEAD(&dmac_chan->free_list);
+	dmac_chan->descs_allocated = 0;
+	dmac_chan->status = 0;
+	dmac_chan->chan_used = 0;
+	dmac_chan->dev_chan = 0;
+	spin_unlock_bh(&dmac_chan->lock);
+}
+
+static bool atcdmac_filter_chan(struct dma_chan *chan, void *dma_dev)
+{
+	if (dma_dev == chan->device->dev)
+		return true;
+
+	return false;
+}
+
+static struct dma_chan *atcdmac_dma_xlate_handler(struct of_phandle_args *dmac,
+						  struct of_dma *of_dma)
+{
+	struct platform_device *dmac_pdev;
+	struct dma_chan *chan;
+	struct atcdmac_chan *dmac_chan;
+	dma_cap_mask_t mask;
+
+	dmac_pdev = of_find_device_by_node(dmac->np);
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	chan = dma_request_channel(mask, atcdmac_filter_chan, &dmac_pdev->dev);
+	if (!chan)
+		return NULL;
+
+	dmac_chan = atcdmac_chan_to_dmac_chan(chan);
+	dmac_chan->dev_chan = true;
+	dmac_chan->req_num = dmac->args[0] & 0xff;
+
+	return chan;
+}
+
+/**
+ * atcdmac_reset_and_wait_chan_idle - Reset the DMA controller and wait for
+ *                                    all channels to become idle
+ * @dmac: Pointer to the DMA controller structure
+ *
+ * This function performs a reset of the DMA controller and ensures that all
+ * DMA channels are disabled.
+ */
+static int atcdmac_reset_and_wait_chan_idle(struct atcdmac_dmac *dmac)
+{
+	regmap_update_bits(dmac->regmap, REG_CTL, DMAC_RESET, 1);
+	msleep(20);
+	regmap_update_bits(dmac->regmap, REG_CTL, DMAC_RESET, 0);
+
+	return atcdmac_wait_chan_idle(dmac,
+				      BIT(dmac->dma_num_ch) - 1,
+				      1000000);
+}
+
+static int atcdmac_init_iocp(struct platform_device *pdev,
+			     struct atcdmac_dmac *dmac)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const struct regmap_config iocp_regmap_config = {
+		.name = "iocp",
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+		.pad_bits = 0,
+		.max_register = 0,
+		.cache_type = REGCACHE_NONE,
+	};
+	void __iomem *regs;
+	const __be32 *prop;
+	phys_addr_t phy_addr;
+	int len;
+
+	prop = of_get_property(np, "iocp-address", &len);
+	if (!prop)
+		goto err;
+
+	phy_addr = of_translate_address(np, prop);
+	regs = devm_ioremap(&pdev->dev, phy_addr + REG_CACHE_CTRL, 4);
+	if (IS_ERR(regs))
+		goto err;
+
+	dmac->regmap_iocp = devm_regmap_init_mmio(&pdev->dev,
+						  regs,
+						  &iocp_regmap_config);
+	if (IS_ERR(dmac->regmap_iocp))
+		goto err;
+
+	regmap_write(dmac->regmap_iocp,
+		     0,
+		     IOCP_CACHE_DMAC0_AW |
+		     IOCP_CACHE_DMAC0_AR |
+		     IOCP_CACHE_DMAC1_AW |
+		     IOCP_CACHE_DMAC1_AR);
+
+err:
+	dmac->regmap_iocp = NULL;
+	return 0;
+}
+
+static void atcdmac_init_dma_device(struct platform_device *pdev,
+				    struct atcdmac_dmac *dmac)
+{
+	struct dma_device *device = &dmac->dma_device;
+
+	device->device_alloc_chan_resources = atcdmac_alloc_chan_resources;
+	device->device_free_chan_resources = atcdmac_free_chan_resources;
+	device->device_tx_status = atcdmac_get_tx_status;
+	device->device_issue_pending = atcdmac_issue_pending;
+	device->device_prep_dma_memcpy = atcdmac_prep_dma_memcpy;
+	device->device_prep_slave_sg = atcdmac_prep_device_sg;
+	device->device_config = atcdmac_set_device_config;
+	device->device_terminate_all = atcdmac_terminate_all;
+	device->device_prep_dma_cyclic = atcdmac_prep_dma_cyclic;
+
+	device->dev = &pdev->dev;
+	device->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+				  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+				  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	device->dst_addr_widths = device->src_addr_widths;
+	device->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	device->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+
+	dma_cap_set(DMA_SLAVE, device->cap_mask);
+	dma_cap_set(DMA_MEMCPY, device->cap_mask);
+	dma_cap_set(DMA_CYCLIC, device->cap_mask);
+}
+
+static int atcdmac_init_channels(struct platform_device *pdev,
+				 struct atcdmac_dmac *dmac)
+{
+	struct regmap_config chan_regmap_config = {
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+		.pad_bits = 0,
+		.cache_type = REGCACHE_NONE,
+		.max_register = REG_CH_LLP_HIGH_OFF,
+	};
+	struct atcdmac_chan *dmac_chan;
+	int ret;
+	int i;
+
+	INIT_LIST_HEAD(&dmac->dma_device.channels);
+
+	for (i = 0; i < dmac->dma_num_ch; i++) {
+		char *regmap_name = kasprintf(GFP_KERNEL, "chan%d", i);
+
+		if (!regmap_name)
+			return -ENOMEM;
+
+		dmac_chan = &dmac->chan[i];
+		chan_regmap_config.name = regmap_name;
+		dmac_chan->regmap =
+			devm_regmap_init_mmio(&pdev->dev,
+					      dmac->regs + REG_CH_OFF(i),
+					      &chan_regmap_config);
+		kfree(regmap_name);
+
+		if (IS_ERR(dmac_chan->regmap)) {
+			ret = PTR_ERR(dmac_chan->regmap);
+			dev_err_probe(&pdev->dev, ret,
+				      "Failed to create regmap for DMA chan%d\n",
+				      i);
+			return ret;
+		}
+
+		spin_lock_init(&dmac_chan->lock);
+		dmac_chan->dma_chan.device = &dmac->dma_device;
+		dmac_chan->dma_dev = dmac;
+		dmac_chan->chan_id = i;
+		dmac_chan->chan_used = 0;
+
+		INIT_LIST_HEAD(&dmac_chan->active_list);
+		INIT_LIST_HEAD(&dmac_chan->queue_list);
+		INIT_LIST_HEAD(&dmac_chan->free_list);
+
+		tasklet_init(&dmac_chan->tasklet,
+			     atcdmac_tasklet,
+			     (unsigned long)dmac_chan);
+
+		list_add_tail(&dmac_chan->dma_chan.device_node,
+			      &dmac->dma_device.channels);
+		dma_cookie_init(&dmac_chan->dma_chan);
+	}
+
+	return 0;
+}
+
+static int atcdmac_init_desc_pool(struct platform_device *pdev,
+				  struct atcdmac_dmac *dmac)
+{
+	dmac->dma_desc_pool = dma_pool_create(dev_name(&pdev->dev),
+					      &pdev->dev,
+					      sizeof(struct atcdmac_desc),
+					      64,
+					      4096);
+	if (!dmac->dma_desc_pool)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "Failed to create memory pool for DMA descriptors\n");
+	return 0;
+}
+
+static int atcdmac_init_irq(struct platform_device *pdev,
+			    struct atcdmac_dmac *dmac)
+{
+	int irq = platform_get_irq(pdev, 0);
+
+	if (irq < 0)
+		return irq;
+
+	return devm_request_irq(&pdev->dev,
+				irq,
+				atcdmac_interrupt,
+				IRQF_SHARED,
+				dev_name(&pdev->dev),
+				dmac);
+}
+
+static int atcdmac_init_ioremap_and_regmap(struct platform_device *pdev,
+					   struct atcdmac_dmac **out_dmac)
+{
+	const struct regmap_config dmac_regmap_config = {
+		.name = dev_name(&pdev->dev),
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+		.pad_bits = 0,
+		.cache_type = REGCACHE_NONE,
+		.max_register = REG_CH_EN,
+	};
+	struct atcdmac_dmac *dmac;
+	struct regmap *regmap;
+	void __iomem *regs;
+	size_t size;
+	unsigned int val;
+	int ret = 0;
+	unsigned char dma_num_ch;
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return dev_err_probe(&pdev->dev, PTR_ERR(regs),
+				     "Failed to ioremap I/O resource\n");
+
+	regmap = devm_regmap_init_mmio(&pdev->dev, regs, &dmac_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(regmap),
+				     "Failed to create regmap for I/O\n");
+
+	regmap_read(regmap, REG_CFG, &val);
+	dma_num_ch = val & CH_NUM;
+	size = sizeof(*dmac) + dma_num_ch * sizeof(struct atcdmac_chan);
+	dmac = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	if (!dmac)
+		return -ENOMEM;
+
+	dmac->regmap = regmap;
+	dmac->dma_num_ch = dma_num_ch;
+	dmac->regs = regs;
+
+	/*
+	 * Adjust the AXI bus data width (from the DMAC Configuration
+	 * Register) to align with the transfer width encoding (in the
+	 * Channel n Control Register). For example, an AXI width of 0
+	 * (32-bit) corresponds to a transfer width of 2 (word transfer).
+	 */
+	dmac->data_width = FIELD_GET(DATA_WIDTH, val) + 2;
+	spin_lock_init(&dmac->lock);
+
+	platform_set_drvdata(pdev, dmac);
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret)
+		dev_err_probe(&pdev->dev, ret, "Failed to set DMA mask\n");
+
+	*out_dmac = dmac;
+
+	return ret;
+}
+
+static int atcdmac_probe(struct platform_device *pdev)
+{
+	struct atcdmac_dmac *dmac;
+	int ret;
+
+	ret = atcdmac_init_ioremap_and_regmap(pdev, &dmac);
+	if (ret)
+		return ret;
+
+	ret = atcdmac_reset_and_wait_chan_idle(dmac);
+	if (ret)
+		return ret;
+
+	ret = atcdmac_init_irq(pdev, dmac);
+	if (ret)
+		return ret;
+
+	ret = atcdmac_init_desc_pool(pdev, dmac);
+	if (ret)
+		return ret;
+
+	ret = atcdmac_init_channels(pdev, dmac);
+	if (ret)
+		goto err_desc_pool;
+
+	atcdmac_init_dma_device(pdev, dmac);
+
+	ret = dma_async_device_register(&dmac->dma_device);
+	if (ret)
+		goto err_desc_pool;
+
+	ret = of_dma_controller_register(pdev->dev.of_node,
+					 atcdmac_dma_xlate_handler,
+					 dmac);
+	if (ret)
+		goto err_dma_async_register;
+
+	atcdmac_init_iocp(pdev, dmac);
+
+	return 0;
+
+err_dma_async_register:
+	dma_async_device_unregister(&dmac->dma_device);
+
+err_desc_pool:
+	dma_pool_destroy(dmac->dma_desc_pool);
+
+	return ret;
+}
+
+static int atcdmac_resume(struct device *dev)
+{
+	struct dma_chan *chan;
+	struct dma_chan *chan_next;
+	struct atcdmac_dmac *dmac = dev_get_drvdata(dev);
+	struct atcdmac_chan *dmac_chan;
+
+	spin_lock_irq(&dmac->lock);
+	dmac->stop_mask = 0;
+	spin_unlock_irq(&dmac->lock);
+	list_for_each_entry_safe(chan,
+				 chan_next,
+				 &dmac->dma_device.channels,
+				 device_node) {
+		dmac_chan = atcdmac_chan_to_dmac_chan(chan);
+		spin_lock_bh(&dmac_chan->lock);
+		atcdmac_start_next_trans(dmac_chan);
+		spin_unlock_bh(&dmac_chan->lock);
+	}
+
+	return 0;
+}
+
+static int atcdmac_suspend(struct device *dev)
+{
+	struct atcdmac_dmac *dmac = dev_get_drvdata(dev);
+	int ret;
+
+	spin_lock_irq(&dmac->lock);
+	dmac->stop_mask = BIT(dmac->dma_num_ch) - 1;
+	spin_unlock_irq(&dmac->lock);
+	ret = atcdmac_wait_chan_idle(dmac, dmac->stop_mask, 1000000);
+
+	return ret;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(atcdmac_pm_ops,
+				atcdmac_suspend,
+				atcdmac_resume);
+
+static const struct of_device_id atcdmac_dt_ids[] = {
+	{ .compatible = "andestech,qilai-dma", },
+	{ .compatible = "andestech,atcdmac300", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, atcdmac_dt_ids);
+
+static struct platform_driver atcdmac_driver = {
+	.probe = atcdmac_probe,
+	.driver = {
+		.name = "atcdmac300",
+		.of_match_table = atcdmac_dt_ids,
+		.pm = pm_sleep_ptr(&atcdmac_pm_ops),
+	},
+};
+module_platform_driver(atcdmac_driver);
+
+MODULE_AUTHOR("CL Wang <cl634@andestech.com>");
+MODULE_DESCRIPTION("Andes ATCDMAC300 DMA Controller driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/dma/atcdmac300.h b/drivers/dma/atcdmac300.h
new file mode 100644
index 000000000000..c4230a3836b9
--- /dev/null
+++ b/drivers/dma/atcdmac300.h
@@ -0,0 +1,276 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Header file for Andes ATCDMAC300 DMA controller driver
+ *
+ * Copyright (C) 2025 Andes Technology Corporation
+ */
+#ifndef ATCDMAC300_H
+#define ATCDMAC300_H
+
+#include <linux/bitfield.h>
+#include <linux/dmaengine.h>
+#include <linux/dmapool.h>
+#include <linux/interrupt.h>
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+
+/*
+ * Register Map Definitions for ATCDMAC300 DMA Controller
+ *
+ * These macros define the offsets and bit masks for various registers
+ * within the ATCDMAC300 DMA controller.
+ */
+
+/* Global DMAC Registers */
+#define REG_CFG			0x10
+#define CH_NUM			GENMASK(3, 0)
+#define DATA_WIDTH		GENMASK(25, 24)
+
+#define REG_CTL			0x20
+#define DMAC_RESET		BIT(0)
+
+#define REG_CH_ABT		0x24
+
+#define REG_INT_STA		0x30
+#define TC_OFFSET		16
+#define ABT_OFFSET		8
+#define ERR_OFFSET		0
+#define DMA_TC(val)		BIT(TC_OFFSET + (val))
+#define DMA_ABT(val)		BIT(ABT_OFFSET + (val))
+#define DMA_ERR(val)		BIT(ERR_OFFSET + (val))
+#define DMA_TC_FIELD		GENMASK(TC_OFFSET + 7, TC_OFFSET)
+#define DMA_ABT_FIELD		GENMASK(ABT_OFFSET + 7, ABT_OFFSET)
+#define DMA_ERR_FIELD		GENMASK(ERR_OFFSET + 7, ERR_OFFSET)
+#define DMA_INT_ALL(val)	(FIELD_GET(DMA_TC_FIELD, (val)) |	\
+				 FIELD_GET(DMA_ABT_FIELD, (val)) |	\
+				 FIELD_GET(DMA_ERR_FIELD, (val)))
+#define DMA_INT_CLR(val)	(FIELD_PREP(DMA_TC_FIELD, (val)) |	\
+				 FIELD_PREP(DMA_ABT_FIELD, (val)) |	\
+				 FIELD_PREP(DMA_ERR_FIELD, (val)))
+
+#define REG_CH_EN		0x34
+
+#define REG_CH_OFF(ch)		((ch) * 0x20 + 0x40)
+#define REG_CH_CTL_OFF		0x0
+#define REG_CH_SIZE_OFF		0x4
+#define REG_CH_SRC_LOW_OFF	0x8
+#define REG_CH_SRC_HIGH_OFF	0xC
+#define REG_CH_DST_LOW_OFF	0x10
+#define REG_CH_DST_HIGH_OFF	0x14
+#define REG_CH_LLP_LOW_OFF	0x18
+#define REG_CH_LLP_HIGH_OFF	0x1C
+
+#define SRC_BURST_SIZE_1	BIT(0)
+#define SRC_BURST_SIZE_2	BIT(1)
+#define SRC_BURST_SIZE_4	BIT(2)
+#define SRC_BURST_SIZE_8	BIT(3)
+#define SRC_BURST_SIZE_16	BIT(4)
+#define SRC_BURST_SIZE_32	BIT(5)
+#define SRC_BURST_SIZE_64	BIT(6)
+#define SRC_BURST_SIZE_128	BIT(7)
+#define SRC_BURST_SIZE_256	BIT(8)
+#define SRC_BURST_SIZE_512	BIT(9)
+#define SRC_BURST_SIZE_1024	BIT(10)
+#define SRC_BURST_SIZE_MASK	GENMASK(27, 24)
+#define SRC_BURST_SIZE(size)	FIELD_PREP(SRC_BURST_SIZE_MASK, size)
+
+#define WIDTH_1_BYTE		0x0
+#define WIDTH_2_BYTES		0x1
+#define WIDTH_4_BYTES		0x2
+#define WIDTH_8_BYTES		0x3
+#define WIDTH_16_BYTES		0x4
+#define WIDTH_32_BYTES		0x5
+#define SRC_WIDTH_MASK		GENMASK(23, 21)
+#define SRC_WIDTH(width)	FIELD_PREP(SRC_WIDTH_MASK, width)
+#define SRC_WIDTH_GET(val)	FIELD_GET(SRC_WIDTH_MASK, val)
+#define DST_WIDTH_MASK		GENMASK(20, 18)
+#define DST_WIDTH(width)	FIELD_PREP(DST_WIDTH_MASK, width)
+#define DST_WIDTH_GET(val)	FIELD_GET(DST_WIDTH_MASK, val)
+
+/* DMA handshake mode */
+#define SRC_HS			BIT(17)
+#define DST_HS			BIT(16)
+
+/* Address control */
+#define SRC_ADDR_CTRL_MASK	GENMASK(15, 14)
+#define SRC_ADDR_MODE_INCR	FIELD_PREP(SRC_ADDR_CTRL_MASK, 0x0)
+#define SRC_ADDR_MODE_DECR	FIELD_PREP(SRC_ADDR_CTRL_MASK, 0x1)
+#define SRC_ADDR_MODE_FIXED	FIELD_PREP(SRC_ADDR_CTRL_MASK, 0x2)
+#define DST_ADDR_CTRL_MASK	GENMASK(13, 12)
+#define DST_ADDR_MODE_INCR	FIELD_PREP(DST_ADDR_CTRL_MASK, 0x0)
+#define DST_ADDR_MODE_DECR	FIELD_PREP(DST_ADDR_CTRL_MASK, 0x1)
+#define DST_ADDR_MODE_FIXED	FIELD_PREP(DST_ADDR_CTRL_MASK, 0x2)
+
+/* DMA request select */
+#define SRC_REQ_SEL_MASK	GENMASK(11, 8)
+#define SRC_REQ(req_num)	FIELD_PREP(SRC_REQ_SEL_MASK, (req_num))
+#define DST_REQ_SEL_MASK	GENMASK(7, 4)
+#define DST_REQ(req_num)	FIELD_PREP(DST_REQ_SEL_MASK, (req_num))
+
+/* Channel abort interrupt mask */
+#define INT_ABT_MASK		BIT(3)
+/* Channel error interrupt mask */
+#define INT_ERR_MASK		BIT(2)
+/* Channel terminal count interrupt mask */
+#define INT_TC_MASK		BIT(1)
+
+/* Channel Enable */
+#define CHEN			BIT(0)
+
+#define REG_CACHE_CTRL		0x184
+#define IOCP_MASK		0x4000000000
+#define IOCP_CACHE_DMAC0_AW	GENMASK(3, 0)
+#define IOCP_CACHE_DMAC0_AR	GENMASK(7, 4)
+#define IOCP_CACHE_DMAC1_AW	GENMASK(11, 8)
+#define IOCP_CACHE_DMAC1_AR	GENMASK(15, 12)
+
+#define ATCDMAC_DESC_PER_CHAN	64
+
+/*
+ * Status for tasklet processing.
+ */
+enum dma_sta {
+	ATCDMAC_STA_TC = 0,
+	ATCDMAC_STA_ERR,
+	ATCDMAC_STA_ABORT
+};
+
+/**
+ * struct atcdmac_regs - Hardware DMA descriptor registers.
+ *
+ * @ctrl: Channel Control Register.
+ * @trans_size: Transfer Size Register.
+ * @src_addr_lo: Source Address Register (low 32-bit).
+ * @src_addr_hi: Source Address Register (high 32-bit).
+ * @dst_addr_lo: Destination Address Register (low 32-bit).
+ * @dst_addr_hi: Destination Address Register (high 32-bit).
+ * @ll_ptr_lo: Linked List Pointer Register (low 32-bit).
+ * @ll_ptr_hi: Linked List Pointer Register (high 32-bit).
+ */
+struct atcdmac_regs {
+	unsigned int ctrl;
+	unsigned int trans_size;
+	unsigned int src_addr_lo;
+	unsigned int src_addr_hi;
+	unsigned int dst_addr_lo;
+	unsigned int dst_addr_hi;
+	unsigned int ll_ptr_lo;
+	unsigned int ll_ptr_hi;
+};
+
+/**
+ * struct atcdmac_desc - Internal representation of a DMA descriptor.
+ *
+ * @regs: Hardware registers for this descriptor.
+ * @txd: DMA transaction descriptor for dmaengine framework.
+ * @desc_node: Node for linking descriptors in software lists.
+ * @tx_list: List head for chaining multiple descriptors in a single transfer.
+ * @at: Next descriptor in a cyclic transfer (for internal use).
+ * @num_sg: Number of scatterlist entries this descriptor handles.
+ */
+struct atcdmac_desc {
+	struct atcdmac_regs		regs;
+	struct dma_async_tx_descriptor	txd;
+	struct list_head		desc_node;
+	struct list_head		tx_list;
+	struct list_head		*at;
+	unsigned short			num_sg;
+};
+
+/**
+ * struct atcdmac_chan - Private data for each DMA channel.
+ *
+ * @dma_chan: Common DMA engine channel object members
+ * @dma_dev: Pointer to the struct atcdmac_dmac
+ * @tasklet: Tasklet used as the bottom half to finalize transaction work
+ * @dma_sconfig: DMA transfer config for device-to-memory or memory-to-device
+ * @regmap: Regmap for the DMA channel register
+ * @active_list: List of descriptors being processed by the DMA engine
+ * @queue_list: List of descriptors ready to be submitted to the DMA engine
+ * @free_list: List of descriptors available for reuse by the channel
+ * @lock: Protects data access in atomic operations
+ * @status: Transmit status info, shared between IRQ functions and the tasklet
+ * @descs_allocated: Number of descriptors currently allocated in the pool
+ * @chan_id: Channel ID number
+ * @req_num: Request number assigned to the channel
+ * @chan_used: Indicates whether the DMA channel is currently in use
+ * @cyclic: Indicates if the transfer operates in cyclic mode
+ * @dev_chan: Indicates if the DMA channel transfers data between device
+ *            and memory
+ */
+struct atcdmac_chan {
+	struct dma_chan		dma_chan;
+	struct atcdmac_dmac	*dma_dev;
+	struct tasklet_struct	tasklet;
+	struct dma_slave_config	dma_sconfig;
+	struct regmap		*regmap;
+
+	struct list_head	active_list;
+	struct list_head	queue_list;
+	struct list_head	free_list;
+
+	spinlock_t		lock;
+	unsigned long		status;
+	unsigned short		descs_allocated;
+	unsigned char		chan_id;
+	unsigned char		req_num;
+	bool			chan_used;
+	bool			cyclic;
+	bool			dev_chan;
+};
+
+/**
+ * struct atcdmac_dmac - Representation of the ATCDMAC300 DMA controller
+ * @dma_device: DMA device object for integration with DMA engine framework
+ * @regmap: Regmap for main DMA controller registers
+ * @regmap_iocp: Regmap for IOCP registers
+ * @dma_desc_pool: DMA descriptor pool for allocating and managing descriptors
+ * @regs: Memory-mapped base address of the main DMA controller registers
+ * @lock: Protects data access in atomic operations
+ * @used_chan: Bitmask of DMA channels actively issuing DMA descriptors
+ * @stop_mask: Stops the DMA channel after the current transaction completes
+ * @data_width: Max data bus width supported by the DMA controller
+ * @dma_num_ch: Total number of DMA channels available in the controller
+ * @chan: Array of DMA channel structures, sized by the controller's channel
+ *        count
+ */
+struct atcdmac_dmac {
+	struct dma_device	dma_device;
+	struct regmap		*regmap;
+	struct regmap		*regmap_iocp;
+	struct dma_pool		*dma_desc_pool;
+	void __iomem		*regs;
+	spinlock_t		lock;
+	unsigned short		used_chan;
+	unsigned short		stop_mask;
+	unsigned char		data_width;
+	unsigned char		dma_num_ch;
+	struct atcdmac_chan	chan[] __counted_by(dma_num_ch);
+};
+
+/*
+ * Helper functions to convert between dmaengine and internal structures.
+ */
+static inline struct atcdmac_desc *
+atcdmac_txd_to_dma_desc(struct dma_async_tx_descriptor *txd)
+{
+	return container_of(txd, struct atcdmac_desc, txd);
+}
+
+static inline struct atcdmac_chan *
+atcdmac_chan_to_dmac_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct atcdmac_chan, dma_chan);
+}
+
+static inline struct atcdmac_dmac *atcdmac_dev_to_dmac(struct dma_device *dev)
+{
+	return container_of(dev, struct atcdmac_dmac, dma_device);
+}
+
+static inline struct device *atcdmac_chan_to_dev(struct dma_chan *chan)
+{
+	return &chan->dev->device;
+}
+
+#endif
-- 
2.34.1


