Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1F114487E
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jan 2020 00:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgAUXoU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 18:44:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:16109 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgAUXoT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jan 2020 18:44:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 15:44:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="244862674"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002.jf.intel.com with ESMTP; 21 Jan 2020 15:44:17 -0800
Subject: [PATCH v5 7/9] dmaengine: idxd: add descriptor manipulation routines
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Cc:     dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Date:   Tue, 21 Jan 2020 16:44:17 -0700
Message-ID: <157965025757.73301.12692876585357550065.stgit@djiang5-desk3.ch.intel.com>
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

This commit adds helper functions for DSA descriptor allocation,
submission, and free operations.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/Makefile |    2 -
 drivers/dma/idxd/idxd.h   |   10 +++++
 drivers/dma/idxd/submit.c |   91 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/idxd/submit.c

diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
index a552560a03dc..50eca12015e2 100644
--- a/drivers/dma/idxd/Makefile
+++ b/drivers/dma/idxd/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_INTEL_IDXD) += idxd.o
-idxd-y := init.o irq.o device.o sysfs.o
+idxd-y := init.o irq.o device.o sysfs.o submit.o
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 909926aefd3e..d369b75468e3 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -68,6 +68,11 @@ enum idxd_wq_type {
 #define WQ_NAME_SIZE   1024
 #define WQ_TYPE_SIZE   10
 
+enum idxd_op_type {
+	IDXD_OP_BLOCK = 0,
+	IDXD_OP_NONBLOCK = 1,
+};
+
 struct idxd_wq {
 	void __iomem *dportal;
 	struct device conf_dev;
@@ -246,4 +251,9 @@ int idxd_wq_disable(struct idxd_wq *wq);
 int idxd_wq_map_portal(struct idxd_wq *wq);
 void idxd_wq_unmap_portal(struct idxd_wq *wq);
 
+/* submission */
+int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc);
+struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq, enum idxd_op_type optype);
+void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc);
+
 #endif
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
new file mode 100644
index 000000000000..a405f06990e3
--- /dev/null
+++ b/drivers/dma/idxd/submit.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2019 Intel Corporation. All rights rsvd. */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <uapi/linux/idxd.h>
+#include "idxd.h"
+#include "registers.h"
+
+struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq, enum idxd_op_type optype)
+{
+	struct idxd_desc *desc;
+	int idx;
+	struct idxd_device *idxd = wq->idxd;
+
+	if (idxd->state != IDXD_DEV_ENABLED)
+		return ERR_PTR(-EIO);
+
+	if (optype == IDXD_OP_BLOCK)
+		percpu_down_read(&wq->submit_lock);
+	else if (!percpu_down_read_trylock(&wq->submit_lock))
+		return ERR_PTR(-EBUSY);
+
+	if (!atomic_add_unless(&wq->dq_count, 1, wq->size)) {
+		int rc;
+
+		if (optype == IDXD_OP_NONBLOCK) {
+			percpu_up_read(&wq->submit_lock);
+			return ERR_PTR(-EAGAIN);
+		}
+
+		percpu_up_read(&wq->submit_lock);
+		percpu_down_write(&wq->submit_lock);
+		rc = wait_event_interruptible(wq->submit_waitq,
+					      atomic_add_unless(&wq->dq_count,
+								1, wq->size) ||
+					       idxd->state != IDXD_DEV_ENABLED);
+		percpu_up_write(&wq->submit_lock);
+		if (rc < 0)
+			return ERR_PTR(-EINTR);
+		if (idxd->state != IDXD_DEV_ENABLED)
+			return ERR_PTR(-EIO);
+	} else {
+		percpu_up_read(&wq->submit_lock);
+	}
+
+	idx = sbitmap_get(&wq->sbmap, 0, false);
+	if (idx < 0) {
+		atomic_dec(&wq->dq_count);
+		return ERR_PTR(-EAGAIN);
+	}
+
+	desc = wq->descs[idx];
+	memset(desc->hw, 0, sizeof(struct dsa_hw_desc));
+	memset(desc->completion, 0, sizeof(struct dsa_completion_record));
+	return desc;
+}
+
+void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc)
+{
+	atomic_dec(&wq->dq_count);
+
+	sbitmap_clear_bit(&wq->sbmap, desc->id);
+	wake_up(&wq->submit_waitq);
+}
+
+int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
+{
+	struct idxd_device *idxd = wq->idxd;
+	int vec = desc->hw->int_handle;
+
+	if (idxd->state != IDXD_DEV_ENABLED)
+		return -EIO;
+
+	/*
+	 * The wmb() flushes writes to coherent DMA data before possibly
+	 * triggering a DMA read. The wmb() is necessary even on UP because
+	 * the recipient is a device.
+	 */
+	wmb();
+	iosubmit_cmds512(wq->dportal, desc->hw, 1);
+
+	/*
+	 * Pending the descriptor to the lockless list for the irq_entry
+	 * that we designated the descriptor to.
+	 */
+	llist_add(&desc->llnode, &idxd->irq_entries[vec].pending_llist);
+
+	return 0;
+}

