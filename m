Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFD94350C2
	for <lists+dmaengine@lfdr.de>; Wed, 20 Oct 2021 18:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhJTQ4m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Oct 2021 12:56:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:17586 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhJTQ4l (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Oct 2021 12:56:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="209624676"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="209624676"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:54:10 -0700
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="575406295"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:54:10 -0700
Subject: [PATCH 6/7] dmaengine: idxd: handle invalid interrupt handle
 descriptors
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Kevin Tian <kevin.tian@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 20 Oct 2021 09:54:09 -0700
Message-ID: <163474884968.2608004.28577475888887187.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <163474864017.2608004.10983485368237365990.stgit@djiang5-desk3.ch.intel.com>
References: <163474864017.2608004.10983485368237365990.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Handle a descriptor that has been marked with invalid interrupt handle
error in status. Create a work item that will resubmit the descriptor. This
typically happens when the driver has handled the revoke interrupt handle
event and has a new interrupt handle.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/dma.c  |   14 +++++++++----
 drivers/dma/idxd/idxd.h |    1 +
 drivers/dma/idxd/irq.c  |   50 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index 375dbae18583..2ce873994e33 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -24,18 +24,24 @@ void idxd_dma_complete_txd(struct idxd_desc *desc,
 			   enum idxd_complete_type comp_type,
 			   bool free_desc)
 {
+	struct idxd_device *idxd = desc->wq->idxd;
 	struct dma_async_tx_descriptor *tx;
 	struct dmaengine_result res;
 	int complete = 1;
 
-	if (desc->completion->status == DSA_COMP_SUCCESS)
+	if (desc->completion->status == DSA_COMP_SUCCESS) {
 		res.result = DMA_TRANS_NOERROR;
-	else if (desc->completion->status)
+	} else if (desc->completion->status) {
+		if (idxd->request_int_handles && comp_type != IDXD_COMPLETE_ABORT &&
+		    desc->completion->status == DSA_COMP_INT_HANDLE_INVAL &&
+		    idxd_queue_int_handle_resubmit(desc))
+			return;
 		res.result = DMA_TRANS_WRITE_FAILED;
-	else if (comp_type == IDXD_COMPLETE_ABORT)
+	} else if (comp_type == IDXD_COMPLETE_ABORT) {
 		res.result = DMA_TRANS_ABORTED;
-	else
+	} else {
 		complete = 0;
+	}
 
 	tx = &desc->txd;
 	if (complete && tx->cookie) {
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 970701738c8a..82c4915f58a2 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -524,6 +524,7 @@ void idxd_unregister_devices(struct idxd_device *idxd);
 int idxd_register_driver(void);
 void idxd_unregister_driver(void);
 void idxd_wqs_quiesce(struct idxd_device *idxd);
+bool idxd_queue_int_handle_resubmit(struct idxd_desc *desc);
 
 /* device interrupt control */
 void idxd_msix_perm_setup(struct idxd_device *idxd);
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 8bca0ed2d23c..26fa871934e6 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -22,6 +22,11 @@ struct idxd_fault {
 	struct idxd_device *idxd;
 };
 
+struct idxd_resubmit {
+	struct work_struct work;
+	struct idxd_desc *desc;
+};
+
 static void idxd_device_reinit(struct work_struct *work)
 {
 	struct idxd_device *idxd = container_of(work, struct idxd_device, work);
@@ -218,6 +223,51 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 	return IRQ_HANDLED;
 }
 
+static void idxd_int_handle_resubmit_work(struct work_struct *work)
+{
+	struct idxd_resubmit *irw = container_of(work, struct idxd_resubmit, work);
+	struct idxd_desc *desc = irw->desc;
+	struct idxd_wq *wq = desc->wq;
+	int rc;
+
+	desc->completion->status = 0;
+	rc = idxd_submit_desc(wq, desc);
+	if (rc < 0) {
+		dev_dbg(&wq->idxd->pdev->dev, "Failed to resubmit desc %d to wq %d.\n",
+			desc->id, wq->id);
+		/*
+		 * If the error is not -EAGAIN, it means the submission failed due to wq
+		 * has been killed instead of ENQCMDS failure. Here the driver needs to
+		 * notify the submitter of the failure by reporting abort status.
+		 *
+		 * -EAGAIN comes from ENQCMDS failure. idxd_submit_desc() will handle the
+		 * abort.
+		 */
+		if (rc != -EAGAIN) {
+			desc->completion->status = IDXD_COMP_DESC_ABORT;
+			idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT, false);
+		}
+		idxd_free_desc(wq, desc);
+	}
+	kfree(irw);
+}
+
+bool idxd_queue_int_handle_resubmit(struct idxd_desc *desc)
+{
+	struct idxd_wq *wq = desc->wq;
+	struct idxd_device *idxd = wq->idxd;
+	struct idxd_resubmit *irw;
+
+	irw = kzalloc(sizeof(*irw), GFP_KERNEL);
+	if (!irw)
+		return false;
+
+	irw->desc = desc;
+	INIT_WORK(&irw->work, idxd_int_handle_resubmit_work);
+	queue_work(idxd->wq, &irw->work);
+	return true;
+}
+
 static void irq_process_pending_llist(struct idxd_irq_entry *irq_entry)
 {
 	struct idxd_desc *desc, *t;


