Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 693CE11D568
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2019 19:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbfLLSZT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Dec 2019 13:25:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:40472 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730164AbfLLSZT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 12 Dec 2019 13:25:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 10:25:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="211201408"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008.fm.intel.com with ESMTP; 12 Dec 2019 10:25:16 -0800
Subject: [PATCH RFC v2 11/14] dmaengine: idxd: connect idxd to dmaengine
 subsystem
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Cc:     dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, axboe@kernel.dk,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Date:   Thu, 12 Dec 2019 11:25:16 -0700
Message-ID: <157617511654.42350.6101197869819911061.stgit@djiang5-desk3.ch.intel.com>
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

Add plumbing for dmaengine subsystem connection. The driver register a DMA
device per DSA device. The channels are dynamically registered when a
workqueue is configured to be "kernel:dmanegine" type. The driver will
utilize the newly introduced DMA request API calls to provide a lockless
descriptor submission path.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/Kconfig       |    1 
 drivers/dma/idxd/Makefile |    2 -
 drivers/dma/idxd/device.c |    2 +
 drivers/dma/idxd/dma.c    |  119 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/idxd.h   |   14 +++++
 drivers/dma/idxd/init.c   |   48 ++++++++++++++++++
 drivers/dma/idxd/irq.c    |  101 ++++++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/submit.c |   51 +++++++++++++++++++
 drivers/dma/idxd/sysfs.c  |   28 +++++++++++
 9 files changed, 364 insertions(+), 2 deletions(-)
 create mode 100644 drivers/dma/idxd/dma.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d6df373d2607..d1474c7c5151 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -282,6 +282,7 @@ config INTEL_IDXD
 	tristate "Intel Data Accelerators support"
 	depends on PCI && X86_64
 	select DMA_ENGINE
+	select DMA_ENGINE_REQUEST
 	select SBITMAP
 	help
 	  Enable support for the Intel(R) data accelerators present
diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
index 50eca12015e2..a036ba0e77d2 100644
--- a/drivers/dma/idxd/Makefile
+++ b/drivers/dma/idxd/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_INTEL_IDXD) += idxd.o
-idxd-y := init.o irq.o device.o sysfs.o submit.o
+idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 74a60a8bef76..49638d3a2151 100644
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
 
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
new file mode 100644
index 000000000000..07fbc98668ae
--- /dev/null
+++ b/drivers/dma/idxd/dma.c
@@ -0,0 +1,119 @@
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
+void idxd_parse_completion_status(u8 status, enum dmaengine_tx_result *res)
+{
+	u8 code = status & DSA_COMP_STATUS_MASK;
+
+	switch (code) {
+	case DSA_COMP_SUCCESS:
+		*res = DMA_TRANS_NOERROR;
+		break;
+	case DSA_COMP_HW_ERR1:
+		*res = DMA_TRANS_READ_FAILED;
+		break;
+	default:
+		*res = DMA_TRANS_ERROR;
+		break;
+	}
+}
+
+static int idxd_dma_submit_request(struct dma_chan *chan,
+				   struct dma_request *req)
+{
+	struct idxd_wq *wq = container_of(chan, struct idxd_wq, dma_chan);
+
+	if (req->cmd == DMA_MEMCPY)
+		return idxd_submit_memcpy(wq, req);
+
+	return -EINVAL;
+}
+
+static int idxd_dma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct idxd_wq *wq = container_of(chan, struct idxd_wq, dma_chan);
+	struct device *dev = &wq->idxd->pdev->dev;
+
+	idxd_wq_get(wq);
+	dev_dbg(dev, "%s: client_count: %d\n", __func__, idxd_wq_refcount(wq));
+	return 0;
+}
+
+static void idxd_dma_free_chan_resources(struct dma_chan *chan)
+{
+	struct idxd_wq *wq = container_of(chan, struct idxd_wq, dma_chan);
+	struct device *dev = &wq->idxd->pdev->dev;
+
+	idxd_wq_put(wq);
+	dev_dbg(dev, "%s: client_count: %d\n", __func__, idxd_wq_refcount(wq));
+}
+
+int idxd_register_dma_device(struct idxd_device *idxd)
+{
+	struct dma_device *dma = &idxd->dma_dev;
+
+	INIT_LIST_HEAD(&dma->channels);
+	dma->dev = &idxd->pdev->dev;
+
+	if (idxd->hw.opcap.bits[0] & IDXD_OPCAP_MEMMOVE)
+		dma_cap_set(DMA_MEMCPY, dma->cap_mask);
+
+	if (idxd->hw.opcap.bits[0] & IDXD_OPCAP_NOOP)
+		dma_cap_set(DMA_INTERRUPT, dma->cap_mask);
+
+	dma->device_submit_request = idxd_dma_submit_request;
+	dma->device_alloc_chan_resources = idxd_dma_alloc_chan_resources;
+	dma->device_free_chan_resources = idxd_dma_free_chan_resources;
+
+	return dma_async_request_device_register(&idxd->dma_dev);
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
+	struct idxd_group *group = wq->group;
+	int rc;
+
+	memset(&wq->dma_chan, 0, sizeof(struct dma_chan));
+	chan->device = dma;
+	list_add_tail(&chan->device_node, &dma->channels);
+	chan->max_sgs = wq->batch_size;
+	chan->depth = wq->size +
+		idxd->hw.gen_cap.max_descs_per_engine * group->num_engines;
+
+	rc = dma_async_device_channel_register(dma, chan);
+	if (rc < 0)
+		return rc;
+
+	rc = dma_chan_alloc_request_resources(chan);
+	if (rc < 0) {
+		dma_async_device_channel_unregister(dma, chan);
+		return rc;
+	}
+
+	return 0;
+}
+
+void idxd_unregister_dma_channel(struct idxd_wq *wq)
+{
+	dma_chan_free_request_resources(&wq->dma_chan);
+	dma_async_device_channel_unregister(&wq->idxd->dma_dev, &wq->dma_chan);
+}
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 654351105d85..7f94e50267cc 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -4,6 +4,7 @@
 #define _IDXD_H_
 
 #include <linux/sbitmap.h>
+#include <linux/dmaengine.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/wait.h>
 #include "registers.h"
@@ -96,6 +97,7 @@ struct idxd_wq {
 	int batches_size;
 	int batch_size;
 	struct sbitmap sbmap;
+	struct dma_chan dma_chan;
 	struct percpu_rw_semaphore submit_lock;
 	wait_queue_head_t submit_waitq;
 	char name[WQ_NAME_SIZE + 1];
@@ -167,6 +169,8 @@ struct idxd_device {
 	struct msix_entry *msix_entries;
 	int num_wq_irqs;
 	struct idxd_irq_entry *irq_entries;
+
+	struct dma_device dma_dev;
 };
 
 /* IDXD software descriptor */
@@ -181,6 +185,7 @@ struct idxd_desc {
 	struct list_head list;
 	int id;
 	struct idxd_wq *wq;
+	struct dma_request *req;
 };
 
 #define confdev_to_idxd(dev) container_of(dev, struct idxd_device, conf_dev)
@@ -252,4 +257,13 @@ int idxd_wq_disable(struct idxd_wq *wq);
 int idxd_wq_map_portal(struct idxd_wq *wq);
 void idxd_wq_unmap_portal(struct idxd_wq *wq);
 
+/* submission */
+int idxd_submit_memcpy(struct idxd_wq *wq, struct dma_request *req);
+
+/* dmaengine */
+int idxd_register_dma_device(struct idxd_device *idxd);
+void idxd_unregister_dma_device(struct idxd_device *idxd);
+int idxd_register_dma_channel(struct idxd_wq *wq);
+void idxd_unregister_dma_channel(struct idxd_wq *wq);
+void idxd_parse_completion_status(u8 status, enum dmaengine_tx_result *res);
 #endif
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index bec686cec27b..3ec1ef0f733e 100644
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
 
@@ -395,6 +397,50 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 }
 
+static void idxd_flush_pending_llist(struct idxd_irq_entry *ie)
+{
+	struct idxd_desc *desc, *itr;
+	struct llist_node *head;
+	struct dma_request *req;
+
+	head = llist_del_all(&ie->pending_llist);
+	if (!head)
+		return;
+
+	llist_for_each_entry_safe(desc, itr, head, llnode) {
+		req = desc->req;
+		if (!desc->completion->status)
+			req->result.result = DMA_TRANS_ABORTED;
+		else if (desc->completion->status == DSA_COMP_SUCCESS)
+			req->result.result = DMA_TRANS_NOERROR;
+		else
+			req->result.result = DMA_TRANS_ERROR;
+
+		dmaengine_request_complete(req);
+		idxd_free_desc(desc->wq, desc);
+	}
+}
+
+static void idxd_flush_work_list(struct idxd_irq_entry *ie)
+{
+	struct idxd_desc *desc, *iter;
+	struct dma_request *req;
+
+	list_for_each_entry_safe(desc, iter, &ie->work_list, list) {
+		req = desc->req;
+		list_del(&desc->list);
+		if (!desc->completion->status)
+			req->result.result = DMA_TRANS_ABORTED;
+		else if (desc->completion->status == DSA_COMP_SUCCESS)
+			req->result.result = DMA_TRANS_NOERROR;
+		else
+			req->result.result = DMA_TRANS_ERROR;
+
+		dmaengine_request_complete(req);
+		idxd_free_desc(desc->wq, desc);
+	}
+}
+
 static void idxd_shutdown(struct pci_dev *pdev)
 {
 	struct idxd_device *idxd = pci_get_drvdata(pdev);
@@ -418,6 +464,8 @@ static void idxd_shutdown(struct pci_dev *pdev)
 		synchronize_irq(idxd->msix_entries[i].vector);
 		if (i == 0)
 			continue;
+		idxd_flush_pending_llist(irq_entry);
+		idxd_flush_work_list(irq_entry);
 	}
 }
 
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index de4b80973c2f..b4adeb2817d1 100644
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
 
@@ -146,11 +148,110 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 	return IRQ_HANDLED;
 }
 
+static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
+				     int *processed)
+{
+	struct idxd_desc *desc, *t;
+	struct llist_node *head;
+	int queued = 0;
+	struct dma_request *req;
+
+	head = llist_del_all(&irq_entry->pending_llist);
+	if (!head)
+		return 0;
+
+	llist_for_each_entry_safe(desc, t, head, llnode) {
+		req = desc->req;
+		if (desc->completion->status) {
+			if ((desc->completion->status & DSA_COMP_STATUS_MASK) !=
+					DSA_COMP_SUCCESS)
+				idxd_parse_completion_status(desc->completion->status,
+							     &req->result.result);
+
+			dmaengine_request_complete(req);
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
+	struct dma_request *req;
+
+	if (list_empty(&irq_entry->work_list))
+		return 0;
+
+	list_for_each_safe(node, next, &irq_entry->work_list) {
+		struct idxd_desc *desc =
+			container_of(node, struct idxd_desc, list);
+
+		req = desc->req;
+		if (desc->completion->status) {
+			list_del(&desc->list);
+			/* process and callback */
+			if ((desc->completion->status & DSA_COMP_STATUS_MASK) !=
+					DSA_COMP_SUCCESS)
+				idxd_parse_completion_status(desc->completion->status,
+							     &req->result.result);
+
+			dmaengine_request_complete(req);
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
index 2dcd13f9f654..f7baa1bbb0c7 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -87,7 +87,9 @@ static int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc,
 	 * Pending the descriptor to the lockless list for the irq_entry
 	 * that we designated the descriptor to.
 	 */
-	llist_add(&desc->llnode, &idxd->irq_entries[vec].pending_llist);
+	if (desc->req->flags & DMA_PREP_INTERRUPT)
+		llist_add(&desc->llnode,
+			  &idxd->irq_entries[vec].pending_llist);
 
 	return 0;
 }
@@ -125,3 +127,50 @@ static inline void set_completion_address(struct idxd_desc *desc,
 {
 		*compl_addr = desc->compl_dma;
 }
+
+static void op_flag_setup(struct idxd_wq *wq, struct dma_request *req,
+			  u32 *desc_flags)
+{
+	*desc_flags = IDXD_OP_FLAG_CRAV | IDXD_OP_FLAG_RCR;
+	if (req->flags & DMA_PREP_INTERRUPT)
+		*desc_flags |= IDXD_OP_FLAG_RCI;
+	if (req->flags & DMA_PREP_FENCE)
+		*desc_flags |= IDXD_OP_FLAG_FENCE;
+}
+
+int idxd_submit_memcpy(struct idxd_wq *wq, struct dma_request *req)
+{
+	u32 desc_flags;
+	struct idxd_device *idxd = wq->idxd;
+	struct idxd_desc *desc;
+	int rc;
+	bool nonblock;
+	u64 compl_addr, src, dst;
+
+	if (wq->state != IDXD_WQ_ENABLED)
+		return -EPERM;
+
+	if (req->bvec.bv_len > idxd->max_xfer_bytes)
+		return -EINVAL;
+
+	op_flag_setup(wq, req, &desc_flags);
+	nonblock = !!(req->flags & DMA_SUBMIT_NONBLOCK);
+	desc = idxd_alloc_desc(wq, nonblock);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	set_completion_address(desc, &compl_addr);
+	set_desc_addresses(req, &src, &dst);
+	idxd_prep_desc_common(wq, desc->hw, DSA_OPCODE_MEMMOVE,
+			      src, dst, req->bvec.bv_len, compl_addr,
+			      desc_flags);
+	desc->req = req;
+
+	rc = idxd_submit_desc(wq, desc, nonblock);
+	if (rc < 0) {
+		idxd_free_desc(wq, desc);
+		return rc;
+	}
+
+	return 0;
+}
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index fab916a555b2..a7468d22c287 100644
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

