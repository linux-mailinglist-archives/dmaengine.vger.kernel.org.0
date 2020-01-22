Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A444144880
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jan 2020 00:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgAUXoZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 18:44:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:49561 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgAUXoZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jan 2020 18:44:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 15:44:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="307362605"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2020 15:44:23 -0800
Subject: [PATCH v5 8/9] dmaengine: idxd: connect idxd to dmaengine subsystem
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Cc:     dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Date:   Tue, 21 Jan 2020 16:44:23 -0700
Message-ID: <157965026376.73301.13867988830650740445.stgit@djiang5-desk3.ch.intel.com>
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

Add plumbing for dmaengine subsystem connection. The driver register a DMA
device per DSA device. The channels are dynamically registered when a
workqueue is configured to be "kernel:dmanegine" type.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/Makefile |    2 
 drivers/dma/idxd/device.c |    5 +
 drivers/dma/idxd/dma.c    |  217 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/idxd.h   |   20 ++++
 drivers/dma/idxd/init.c   |   30 ++++++
 drivers/dma/idxd/irq.c    |   87 ++++++++++++++++++
 drivers/dma/idxd/submit.c |    4 +
 drivers/dma/idxd/sysfs.c  |   28 ++++++
 8 files changed, 391 insertions(+), 2 deletions(-)
 create mode 100644 drivers/dma/idxd/dma.c

diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
index 50eca12015e2..a036ba0e77d2 100644
--- a/drivers/dma/idxd/Makefile
+++ b/drivers/dma/idxd/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_INTEL_IDXD) += idxd.o
-idxd-y := init.o irq.o device.o sysfs.o submit.o
+idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index d626780caa53..b4c4cec489df 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -5,7 +5,9 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/dmaengine.h>
 #include <uapi/linux/idxd.h>
+#include "../dmaengine.h"
 #include "idxd.h"
 #include "registers.h"
 
@@ -192,6 +194,9 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
 			sizeof(struct dsa_completion_record) * i;
 		desc->id = i;
 		desc->wq = wq;
+
+		dma_async_tx_descriptor_init(&desc->txd, &wq->dma_chan);
+		desc->txd.tx_submit = idxd_dma_tx_submit;
 	}
 
 	return 0;
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
new file mode 100644
index 000000000000..c64c1429d160
--- /dev/null
+++ b/drivers/dma/idxd/dma.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2019 Intel Corporation. All rights rsvd. */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/dmaengine.h>
+#include <uapi/linux/idxd.h>
+#include "../dmaengine.h"
+#include "registers.h"
+#include "idxd.h"
+
+static inline struct idxd_wq *to_idxd_wq(struct dma_chan *c)
+{
+	return container_of(c, struct idxd_wq, dma_chan);
+}
+
+void idxd_dma_complete_txd(struct idxd_desc *desc,
+			   enum idxd_complete_type comp_type)
+{
+	struct dma_async_tx_descriptor *tx;
+	struct dmaengine_result res;
+	int complete = 1;
+
+	if (desc->completion->status == DSA_COMP_SUCCESS)
+		res.result = DMA_TRANS_NOERROR;
+	else if (desc->completion->status)
+		res.result = DMA_TRANS_WRITE_FAILED;
+	else if (comp_type == IDXD_COMPLETE_ABORT)
+		res.result = DMA_TRANS_ABORTED;
+	else
+		complete = 0;
+
+	tx = &desc->txd;
+	if (complete && tx->cookie) {
+		dma_cookie_complete(tx);
+		dma_descriptor_unmap(tx);
+		dmaengine_desc_get_callback_invoke(tx, &res);
+		tx->callback = NULL;
+		tx->callback_result = NULL;
+	}
+}
+
+static void op_flag_setup(unsigned long flags, u32 *desc_flags)
+{
+	*desc_flags = IDXD_OP_FLAG_CRAV | IDXD_OP_FLAG_RCR;
+	if (flags & DMA_PREP_INTERRUPT)
+		*desc_flags |= IDXD_OP_FLAG_RCI;
+}
+
+static inline void set_completion_address(struct idxd_desc *desc,
+					  u64 *compl_addr)
+{
+		*compl_addr = desc->compl_dma;
+}
+
+static inline void idxd_prep_desc_common(struct idxd_wq *wq,
+					 struct dsa_hw_desc *hw, char opcode,
+					 u64 addr_f1, u64 addr_f2, u64 len,
+					 u64 compl, u32 flags)
+{
+	struct idxd_device *idxd = wq->idxd;
+
+	hw->flags = flags;
+	hw->opcode = opcode;
+	hw->src_addr = addr_f1;
+	hw->dst_addr = addr_f2;
+	hw->xfer_size = len;
+	hw->priv = !!(wq->type == IDXD_WQT_KERNEL);
+	hw->completion_addr = compl;
+
+	/*
+	 * Descriptor completion vectors are 1-8 for MSIX. We will round
+	 * robin through the 8 vectors.
+	 */
+	wq->vec_ptr = (wq->vec_ptr % idxd->num_wq_irqs) + 1;
+	hw->int_handle =  wq->vec_ptr;
+}
+
+static struct dma_async_tx_descriptor *
+idxd_dma_submit_memcpy(struct dma_chan *c, dma_addr_t dma_dest,
+		       dma_addr_t dma_src, size_t len, unsigned long flags)
+{
+	struct idxd_wq *wq = to_idxd_wq(c);
+	u32 desc_flags;
+	struct idxd_device *idxd = wq->idxd;
+	struct idxd_desc *desc;
+
+	if (wq->state != IDXD_WQ_ENABLED)
+		return NULL;
+
+	if (len > idxd->max_xfer_bytes)
+		return NULL;
+
+	op_flag_setup(flags, &desc_flags);
+	desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
+	if (IS_ERR(desc))
+		return NULL;
+
+	idxd_prep_desc_common(wq, desc->hw, DSA_OPCODE_MEMMOVE,
+			      dma_src, dma_dest, len, desc->compl_dma,
+			      desc_flags);
+
+	desc->txd.flags = flags;
+
+	return &desc->txd;
+}
+
+static int idxd_dma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct idxd_wq *wq = to_idxd_wq(chan);
+	struct device *dev = &wq->idxd->pdev->dev;
+
+	idxd_wq_get(wq);
+	dev_dbg(dev, "%s: client_count: %d\n", __func__,
+		idxd_wq_refcount(wq));
+	return 0;
+}
+
+static void idxd_dma_free_chan_resources(struct dma_chan *chan)
+{
+	struct idxd_wq *wq = to_idxd_wq(chan);
+	struct device *dev = &wq->idxd->pdev->dev;
+
+	idxd_wq_put(wq);
+	dev_dbg(dev, "%s: client_count: %d\n", __func__,
+		idxd_wq_refcount(wq));
+}
+
+static enum dma_status idxd_dma_tx_status(struct dma_chan *dma_chan,
+					  dma_cookie_t cookie,
+					  struct dma_tx_state *txstate)
+{
+	return dma_cookie_status(dma_chan, cookie, txstate);
+}
+
+/*
+ * issue_pending() does not need to do anything since tx_submit() does the job
+ * already.
+ */
+static void idxd_dma_issue_pending(struct dma_chan *dma_chan)
+{
+}
+
+dma_cookie_t idxd_dma_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	struct dma_chan *c = tx->chan;
+	struct idxd_wq *wq = to_idxd_wq(c);
+	dma_cookie_t cookie;
+	int rc;
+	struct idxd_desc *desc = container_of(tx, struct idxd_desc, txd);
+
+	cookie = dma_cookie_assign(tx);
+
+	rc = idxd_submit_desc(wq, desc);
+	if (rc < 0) {
+		idxd_free_desc(wq, desc);
+		return rc;
+	}
+
+	return cookie;
+}
+
+static void idxd_dma_release(struct dma_device *device)
+{
+}
+
+int idxd_register_dma_device(struct idxd_device *idxd)
+{
+	struct dma_device *dma = &idxd->dma_dev;
+
+	INIT_LIST_HEAD(&dma->channels);
+	dma->dev = &idxd->pdev->dev;
+
+	dma->device_release = idxd_dma_release;
+
+	if (idxd->hw.opcap.bits[0] & IDXD_OPCAP_MEMMOVE) {
+		dma_cap_set(DMA_MEMCPY, dma->cap_mask);
+		dma->device_prep_dma_memcpy = idxd_dma_submit_memcpy;
+	}
+
+	dma->device_tx_status = idxd_dma_tx_status;
+	dma->device_issue_pending = idxd_dma_issue_pending;
+	dma->device_alloc_chan_resources = idxd_dma_alloc_chan_resources;
+	dma->device_free_chan_resources = idxd_dma_free_chan_resources;
+
+	return dma_async_device_register(&idxd->dma_dev);
+}
+
+void idxd_unregister_dma_device(struct idxd_device *idxd)
+{
+	dma_async_device_unregister(&idxd->dma_dev);
+}
+
+int idxd_register_dma_channel(struct idxd_wq *wq)
+{
+	struct idxd_device *idxd = wq->idxd;
+	struct dma_device *dma = &idxd->dma_dev;
+	struct dma_chan *chan = &wq->dma_chan;
+	int rc;
+
+	memset(&wq->dma_chan, 0, sizeof(struct dma_chan));
+	chan->device = dma;
+	list_add_tail(&chan->device_node, &dma->channels);
+	rc = dma_async_device_channel_register(dma, chan);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
+void idxd_unregister_dma_channel(struct idxd_wq *wq)
+{
+	dma_async_device_channel_unregister(&wq->idxd->dma_dev, &wq->dma_chan);
+}
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index d369b75468e3..a36214818d1e 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -4,6 +4,7 @@
 #define _IDXD_H_
 
 #include <linux/sbitmap.h>
+#include <linux/dmaengine.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/wait.h>
 #include "registers.h"
@@ -73,6 +74,11 @@ enum idxd_op_type {
 	IDXD_OP_NONBLOCK = 1,
 };
 
+enum idxd_complete_type {
+	IDXD_COMPLETE_NORMAL = 0,
+	IDXD_COMPLETE_ABORT,
+};
+
 struct idxd_wq {
 	void __iomem *dportal;
 	struct device conf_dev;
@@ -97,6 +103,7 @@ struct idxd_wq {
 	int compls_size;
 	struct idxd_desc **descs;
 	struct sbitmap sbmap;
+	struct dma_chan dma_chan;
 	struct percpu_rw_semaphore submit_lock;
 	wait_queue_head_t submit_waitq;
 	char name[WQ_NAME_SIZE + 1];
@@ -169,6 +176,8 @@ struct idxd_device {
 	struct msix_entry *msix_entries;
 	int num_wq_irqs;
 	struct idxd_irq_entry *irq_entries;
+
+	struct dma_device dma_dev;
 };
 
 /* IDXD software descriptor */
@@ -177,6 +186,7 @@ struct idxd_desc {
 	dma_addr_t desc_dma;
 	struct dsa_completion_record *completion;
 	dma_addr_t compl_dma;
+	struct dma_async_tx_descriptor txd;
 	struct llist_node llnode;
 	struct list_head list;
 	int id;
@@ -256,4 +266,14 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc);
 struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq, enum idxd_op_type optype);
 void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc);
 
+/* dmaengine */
+int idxd_register_dma_device(struct idxd_device *idxd);
+void idxd_unregister_dma_device(struct idxd_device *idxd);
+int idxd_register_dma_channel(struct idxd_wq *wq);
+void idxd_unregister_dma_channel(struct idxd_wq *wq);
+void idxd_parse_completion_status(u8 status, enum dmaengine_tx_result *res);
+void idxd_dma_complete_txd(struct idxd_desc *desc,
+			   enum idxd_complete_type comp_type);
+dma_cookie_t idxd_dma_tx_submit(struct dma_async_tx_descriptor *tx);
+
 #endif
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 229386464923..cf6e1d89dd02 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -15,6 +15,8 @@
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <uapi/linux/idxd.h>
+#include <linux/dmaengine.h>
+#include "../dmaengine.h"
 #include "registers.h"
 #include "idxd.h"
 
@@ -396,6 +398,32 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 }
 
+static void idxd_flush_pending_llist(struct idxd_irq_entry *ie)
+{
+	struct idxd_desc *desc, *itr;
+	struct llist_node *head;
+
+	head = llist_del_all(&ie->pending_llist);
+	if (!head)
+		return;
+
+	llist_for_each_entry_safe(desc, itr, head, llnode) {
+		idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT);
+		idxd_free_desc(desc->wq, desc);
+	}
+}
+
+static void idxd_flush_work_list(struct idxd_irq_entry *ie)
+{
+	struct idxd_desc *desc, *iter;
+
+	list_for_each_entry_safe(desc, iter, &ie->work_list, list) {
+		list_del(&desc->list);
+		idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT);
+		idxd_free_desc(desc->wq, desc);
+	}
+}
+
 static void idxd_shutdown(struct pci_dev *pdev)
 {
 	struct idxd_device *idxd = pci_get_drvdata(pdev);
@@ -419,6 +447,8 @@ static void idxd_shutdown(struct pci_dev *pdev)
 		synchronize_irq(idxd->msix_entries[i].vector);
 		if (i == 0)
 			continue;
+		idxd_flush_pending_llist(irq_entry);
+		idxd_flush_work_list(irq_entry);
 	}
 }
 
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index de4b80973c2f..770d408470db 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -5,7 +5,9 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/dmaengine.h>
 #include <uapi/linux/idxd.h>
+#include "../dmaengine.h"
 #include "idxd.h"
 #include "registers.h"
 
@@ -146,11 +148,96 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 	return IRQ_HANDLED;
 }
 
+static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
+				     int *processed)
+{
+	struct idxd_desc *desc, *t;
+	struct llist_node *head;
+	int queued = 0;
+
+	head = llist_del_all(&irq_entry->pending_llist);
+	if (!head)
+		return 0;
+
+	llist_for_each_entry_safe(desc, t, head, llnode) {
+		if (desc->completion->status) {
+			idxd_dma_complete_txd(desc, IDXD_COMPLETE_NORMAL);
+			idxd_free_desc(desc->wq, desc);
+			(*processed)++;
+		} else {
+			list_add_tail(&desc->list, &irq_entry->work_list);
+			queued++;
+		}
+	}
+
+	return queued;
+}
+
+static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
+				 int *processed)
+{
+	struct list_head *node, *next;
+	int queued = 0;
+
+	if (list_empty(&irq_entry->work_list))
+		return 0;
+
+	list_for_each_safe(node, next, &irq_entry->work_list) {
+		struct idxd_desc *desc =
+			container_of(node, struct idxd_desc, list);
+
+		if (desc->completion->status) {
+			list_del(&desc->list);
+			/* process and callback */
+			idxd_dma_complete_txd(desc, IDXD_COMPLETE_NORMAL);
+			idxd_free_desc(desc->wq, desc);
+			(*processed)++;
+		} else {
+			queued++;
+		}
+	}
+
+	return queued;
+}
+
 irqreturn_t idxd_wq_thread(int irq, void *data)
 {
 	struct idxd_irq_entry *irq_entry = data;
+	int rc, processed = 0, retry = 0;
+
+	/*
+	 * There are two lists we are processing. The pending_llist is where
+	 * submmiter adds all the submitted descriptor after sending it to
+	 * the workqueue. It's a lockless singly linked list. The work_list
+	 * is the common linux double linked list. We are in a scenario of
+	 * multiple producers and a single consumer. The producers are all
+	 * the kernel submitters of descriptors, and the consumer is the
+	 * kernel irq handler thread for the msix vector when using threaded
+	 * irq. To work with the restrictions of llist to remain lockless,
+	 * we are doing the following steps:
+	 * 1. Iterate through the work_list and process any completed
+	 *    descriptor. Delete the completed entries during iteration.
+	 * 2. llist_del_all() from the pending list.
+	 * 3. Iterate through the llist that was deleted from the pending list
+	 *    and process the completed entries.
+	 * 4. If the entry is still waiting on hardware, list_add_tail() to
+	 *    the work_list.
+	 * 5. Repeat until no more descriptors.
+	 */
+	do {
+		rc = irq_process_work_list(irq_entry, &processed);
+		if (rc != 0) {
+			retry++;
+			continue;
+		}
+
+		rc = irq_process_pending_llist(irq_entry, &processed);
+	} while (rc != 0 && retry != 10);
 
 	idxd_unmask_msix_vector(irq_entry->idxd, irq_entry->id);
 
+	if (processed == 0)
+		return IRQ_NONE;
+
 	return IRQ_HANDLED;
 }
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index a405f06990e3..e16cab37dda8 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -85,7 +85,9 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	 * Pending the descriptor to the lockless list for the irq_entry
 	 * that we designated the descriptor to.
 	 */
-	llist_add(&desc->llnode, &idxd->irq_entries[vec].pending_llist);
+	if (desc->hw->flags & IDXD_OP_FLAG_RCI)
+		llist_add(&desc->llnode,
+			  &idxd->irq_entries[vec].pending_llist);
 
 	return 0;
 }
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index b6a0a59b500f..f5e3f962ee6a 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -55,6 +55,14 @@ static inline bool is_idxd_wq_dev(struct device *dev)
 	return dev ? dev->type == &idxd_wq_device_type : false;
 }
 
+static inline bool is_idxd_wq_dmaengine(struct idxd_wq *wq)
+{
+	if (wq->type == IDXD_WQT_KERNEL &&
+	    strcmp(wq->name, "dmaengine") == 0)
+		return true;
+	return false;
+}
+
 static int idxd_config_bus_match(struct device *dev,
 				 struct device_driver *drv)
 {
@@ -122,6 +130,12 @@ static int idxd_config_bus_probe(struct device *dev)
 		spin_unlock_irqrestore(&idxd->dev_lock, flags);
 		dev_info(dev, "Device %s enabled\n", dev_name(dev));
 
+		rc = idxd_register_dma_device(idxd);
+		if (rc < 0) {
+			spin_unlock_irqrestore(&idxd->dev_lock, flags);
+			dev_dbg(dev, "Failed to register dmaengine device\n");
+			return rc;
+		}
 		return 0;
 	} else if (is_idxd_wq_dev(dev)) {
 		struct idxd_wq *wq = confdev_to_wq(dev);
@@ -194,6 +208,16 @@ static int idxd_config_bus_probe(struct device *dev)
 		wq->client_count = 0;
 
 		dev_info(dev, "wq %s enabled\n", dev_name(&wq->conf_dev));
+
+		if (is_idxd_wq_dmaengine(wq)) {
+			rc = idxd_register_dma_channel(wq);
+			if (rc < 0) {
+				dev_dbg(dev, "DMA channel register failed\n");
+				mutex_unlock(&wq->wq_lock);
+				return rc;
+			}
+		}
+
 		mutex_unlock(&wq->wq_lock);
 		return 0;
 	}
@@ -215,6 +239,9 @@ static void disable_wq(struct idxd_wq *wq)
 		return;
 	}
 
+	if (is_idxd_wq_dmaengine(wq))
+		idxd_unregister_dma_channel(wq);
+
 	if (idxd_wq_refcount(wq))
 		dev_warn(dev, "Clients has claim on wq %d: %d\n",
 			 wq->id, idxd_wq_refcount(wq));
@@ -264,6 +291,7 @@ static int idxd_config_bus_remove(struct device *dev)
 			device_release_driver(&wq->conf_dev);
 		}
 
+		idxd_unregister_dma_device(idxd);
 		spin_lock_irqsave(&idxd->dev_lock, flags);
 		rc = idxd_device_disable(idxd);
 		spin_unlock_irqrestore(&idxd->dev_lock, flags);

