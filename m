Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583AF1FA21B
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2020 22:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbgFOUy1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Jun 2020 16:54:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:10845 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgFOUy1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 15 Jun 2020 16:54:27 -0400
IronPort-SDR: 6R8r20ESZ2CJbyX9MXGSg6ignYvVRokwNh7NtsyThLdvxKwzHLO80vM0+SNHu0+G9s5pZdJMtH
 b6w7J6PJTvPg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 13:54:26 -0700
IronPort-SDR: KkLBG2HexM1LPML9rAOzlnBY+7V46OAUjkex5kdQOdlFuzcTVdwWyrh6gBvAWPgQOawNM4UFib
 UFZERAKx50gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,516,1583222400"; 
   d="scan'208";a="382659119"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2020 13:54:27 -0700
Subject: [PATCH] dmaengine: idxd: move submission to sbitmap_queue
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Date:   Mon, 15 Jun 2020 13:54:26 -0700
Message-ID: <159225446631.68253.8860709181621260997.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Kill the percpu-rwsem for work submission in favor of an sbitmap_queue.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dma/Kconfig       |    2 +
 drivers/dma/idxd/device.c |   14 ++++-----
 drivers/dma/idxd/idxd.h   |    6 +---
 drivers/dma/idxd/init.c   |   20 ------------
 drivers/dma/idxd/submit.c |   74 +++++++++++++++++++++++----------------------
 5 files changed, 46 insertions(+), 70 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index de41d7928bff..b70e90765ad3 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -285,8 +285,8 @@ config INTEL_IDMA64
 config INTEL_IDXD
 	tristate "Intel Data Accelerators support"
 	depends on PCI && X86_64
+	depends on SBITMAP
 	select DMA_ENGINE
-	select SBITMAP
 	help
 	  Enable support for the Intel(R) data accelerators present
 	  in Intel Xeon CPU.
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 8fe344412bd9..95b8820ef087 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -160,16 +160,14 @@ static int alloc_descs(struct idxd_wq *wq, int num)
 int idxd_wq_alloc_resources(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
-	struct idxd_group *group = wq->group;
 	struct device *dev = &idxd->pdev->dev;
 	int rc, num_descs, i;
 
 	if (wq->type != IDXD_WQT_KERNEL)
 		return 0;
 
-	num_descs = wq->size +
-		idxd->hw.gen_cap.max_descs_per_engine * group->num_engines;
-	wq->num_descs = num_descs;
+	wq->num_descs = wq->size;
+	num_descs = wq->size;
 
 	rc = alloc_hw_descs(wq, num_descs);
 	if (rc < 0)
@@ -187,8 +185,8 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
 	if (rc < 0)
 		goto fail_alloc_descs;
 
-	rc = sbitmap_init_node(&wq->sbmap, num_descs, -1, GFP_KERNEL,
-			       dev_to_node(dev));
+	rc = sbitmap_queue_init_node(&wq->sbq, num_descs, -1, false, GFP_KERNEL,
+				     dev_to_node(dev));
 	if (rc < 0)
 		goto fail_sbitmap_init;
 
@@ -201,7 +199,7 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
 			sizeof(struct dsa_completion_record) * i;
 		desc->id = i;
 		desc->wq = wq;
-
+		desc->cpu = -1;
 		dma_async_tx_descriptor_init(&desc->txd, &wq->dma_chan);
 		desc->txd.tx_submit = idxd_dma_tx_submit;
 	}
@@ -227,7 +225,7 @@ void idxd_wq_free_resources(struct idxd_wq *wq)
 	free_hw_descs(wq);
 	free_descs(wq);
 	dma_free_coherent(dev, wq->compls_size, wq->compls, wq->compls_addr);
-	sbitmap_free(&wq->sbmap);
+	sbitmap_queue_free(&wq->sbq);
 }
 
 int idxd_wq_enable(struct idxd_wq *wq)
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 013d68d42bc4..0769354df4cf 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -104,7 +104,6 @@ struct idxd_wq {
 	enum idxd_wq_state state;
 	unsigned long flags;
 	union wqcfg wqcfg;
-	atomic_t dq_count;	/* dedicated queue flow control */
 	u32 vec_ptr;		/* interrupt steering */
 	struct dsa_hw_desc **hw_descs;
 	int num_descs;
@@ -112,10 +111,8 @@ struct idxd_wq {
 	dma_addr_t compls_addr;
 	int compls_size;
 	struct idxd_desc **descs;
-	struct sbitmap sbmap;
+	struct sbitmap_queue sbq;
 	struct dma_chan dma_chan;
-	struct percpu_rw_semaphore submit_lock;
-	wait_queue_head_t submit_waitq;
 	char name[WQ_NAME_SIZE + 1];
 };
 
@@ -205,6 +202,7 @@ struct idxd_desc {
 	struct llist_node llnode;
 	struct list_head list;
 	int id;
+	int cpu;
 	struct idxd_wq *wq;
 };
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 51cdf77038dc..c7c61974f20f 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -141,17 +141,6 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 	return rc;
 }
 
-static void idxd_wqs_free_lock(struct idxd_device *idxd)
-{
-	int i;
-
-	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
-
-		percpu_free_rwsem(&wq->submit_lock);
-	}
-}
-
 static int idxd_setup_internals(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -182,19 +171,11 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 
 	for (i = 0; i < idxd->max_wqs; i++) {
 		struct idxd_wq *wq = &idxd->wqs[i];
-		int rc;
 
 		wq->id = i;
 		wq->idxd = idxd;
 		mutex_init(&wq->wq_lock);
-		atomic_set(&wq->dq_count, 0);
-		init_waitqueue_head(&wq->submit_waitq);
 		wq->idxd_cdev.minor = -1;
-		rc = percpu_init_rwsem(&wq->submit_lock);
-		if (rc < 0) {
-			idxd_wqs_free_lock(idxd);
-			return rc;
-		}
 	}
 
 	for (i = 0; i < idxd->max_engines; i++) {
@@ -464,7 +445,6 @@ static void idxd_remove(struct pci_dev *pdev)
 	dev_dbg(&pdev->dev, "%s called\n", __func__);
 	idxd_cleanup_sysfs(idxd);
 	idxd_shutdown(pdev);
-	idxd_wqs_free_lock(idxd);
 	mutex_lock(&idxd_idr_lock);
 	idr_remove(&idxd_idrs[idxd->type], idxd->id);
 	mutex_unlock(&idxd_idr_lock);
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 45a0c5869a0a..156a1ee233aa 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -8,61 +8,61 @@
 #include "idxd.h"
 #include "registers.h"
 
-struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq, enum idxd_op_type optype)
+static struct idxd_desc *__get_desc(struct idxd_wq *wq, int idx, int cpu)
 {
 	struct idxd_desc *desc;
-	int idx;
+
+	desc = wq->descs[idx];
+	memset(desc->hw, 0, sizeof(struct dsa_hw_desc));
+	memset(desc->completion, 0, sizeof(struct dsa_completion_record));
+	desc->cpu = cpu;
+	return desc;
+}
+
+struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq, enum idxd_op_type optype)
+{
+	int cpu, idx;
 	struct idxd_device *idxd = wq->idxd;
+	DEFINE_SBQ_WAIT(wait);
+	struct sbq_wait_state *ws;
+	struct sbitmap_queue *sbq;
 
 	if (idxd->state != IDXD_DEV_ENABLED)
 		return ERR_PTR(-EIO);
 
-	if (optype == IDXD_OP_BLOCK)
-		percpu_down_read(&wq->submit_lock);
-	else if (!percpu_down_read_trylock(&wq->submit_lock))
-		return ERR_PTR(-EBUSY);
-
-	if (!atomic_add_unless(&wq->dq_count, 1, wq->size)) {
-		int rc;
-
-		if (optype == IDXD_OP_NONBLOCK) {
-			percpu_up_read(&wq->submit_lock);
+	sbq = &wq->sbq;
+	idx = sbitmap_queue_get(sbq, &cpu);
+	if (idx < 0) {
+		if (optype == IDXD_OP_NONBLOCK)
 			return ERR_PTR(-EAGAIN);
-		}
-
-		percpu_up_read(&wq->submit_lock);
-		percpu_down_write(&wq->submit_lock);
-		rc = wait_event_interruptible(wq->submit_waitq,
-					      atomic_add_unless(&wq->dq_count,
-								1, wq->size) ||
-					       idxd->state != IDXD_DEV_ENABLED);
-		percpu_up_write(&wq->submit_lock);
-		if (rc < 0)
-			return ERR_PTR(-EINTR);
-		if (idxd->state != IDXD_DEV_ENABLED)
-			return ERR_PTR(-EIO);
 	} else {
-		percpu_up_read(&wq->submit_lock);
+		return __get_desc(wq, idx, cpu);
 	}
 
-	idx = sbitmap_get(&wq->sbmap, 0, false);
-	if (idx < 0) {
-		atomic_dec(&wq->dq_count);
-		return ERR_PTR(-EAGAIN);
+	ws = &sbq->ws[0];
+	for (;;) {
+		sbitmap_prepare_to_wait(sbq, ws, &wait, TASK_INTERRUPTIBLE);
+		if (signal_pending_state(TASK_INTERRUPTIBLE, current))
+			break;
+		idx = sbitmap_queue_get(sbq, &cpu);
+		if (idx > 0)
+			break;
+		schedule();
 	}
 
-	desc = wq->descs[idx];
-	memset(desc->hw, 0, sizeof(struct dsa_hw_desc));
-	memset(desc->completion, 0, sizeof(struct dsa_completion_record));
-	return desc;
+	sbitmap_finish_wait(sbq, ws, &wait);
+	if (idx < 0)
+		return ERR_PTR(-EAGAIN);
+
+	return __get_desc(wq, idx, cpu);
 }
 
 void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 {
-	atomic_dec(&wq->dq_count);
+	int cpu = desc->cpu;
 
-	sbitmap_clear_bit(&wq->sbmap, desc->id);
-	wake_up(&wq->submit_waitq);
+	desc->cpu = -1;
+	sbitmap_queue_clear(&wq->sbq, desc->id, cpu);
 }
 
 int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)

