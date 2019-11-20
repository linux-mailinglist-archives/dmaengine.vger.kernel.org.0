Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 543B91045AD
	for <lists+dmaengine@lfdr.de>; Wed, 20 Nov 2019 22:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKTVYp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Nov 2019 16:24:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:56124 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfKTVYp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Nov 2019 16:24:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 13:24:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="259158793"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Nov 2019 13:24:43 -0800
Subject: [PATCH RFC 10/14] dmaengine: idxd: add descriptor manipulation
 routines
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Cc:     dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, axboe@kernel.dk,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Date:   Wed, 20 Nov 2019 14:24:43 -0700
Message-ID: <157428508351.36836.14148991959604842213.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This commit adds helper functions for DSA descriptor allocation, setup,
submission, and free operations.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---

idxd_submit_desc() and idxd_alloc_desc() are used in the next patch in the
series.
---
 drivers/dma/idxd/Makefile |    2 -
 drivers/dma/idxd/submit.c |  127 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/idxd/submit.c

diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
index a552560a03dc..50eca12015e2 100644
--- a/drivers/dma/idxd/Makefile
+++ b/drivers/dma/idxd/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_INTEL_IDXD) += idxd.o
-idxd-y := init.o irq.o device.o sysfs.o
+idxd-y := init.o irq.o device.o sysfs.o submit.o
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
new file mode 100644
index 000000000000..2dcd13f9f654
--- /dev/null
+++ b/drivers/dma/idxd/submit.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2019 Intel Corporation. All rights rsvd. */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/dmaengine.h>
+#include <uapi/linux/idxd.h>
+#include "../dmaengine.h"
+#include "idxd.h"
+#include "registers.h"
+
+static struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq, bool nonblock)
+{
+	struct idxd_desc *desc;
+	int idx;
+	struct idxd_device *idxd = wq->idxd;
+
+	if (idxd->state != IDXD_DEV_ENABLED)
+		return ERR_PTR(-EIO);
+
+	if (!nonblock)
+		percpu_down_read(&wq->submit_lock);
+	else if (!percpu_down_read_trylock(&wq->submit_lock))
+		return ERR_PTR(-EBUSY);
+
+	if (!atomic_add_unless(&wq->dq_count, 1, wq->size)) {
+		int rc;
+
+		if (nonblock) {
+			percpu_up_read(&wq->submit_lock);
+			return ERR_PTR(-EAGAIN);
+		}
+
+		percpu_up_read(&wq->submit_lock);
+		percpu_down_write(&wq->submit_lock);
+		rc = wait_event_interruptible(wq->submit_waitq,
+				atomic_add_unless(&wq->dq_count, 1, wq->size) ||
+				idxd->state != IDXD_DEV_ENABLED);
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
+static int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc,
+			    bool nonblock)
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
+
+static inline void idxd_prep_desc_common(struct idxd_wq *wq,
+					 struct dsa_hw_desc *hw, char opcode,
+					 u64 addr_f1, u64 addr_f2, u64 len,
+					 u64 compl, u32 flags)
+{
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
+	hw->int_handle = ++wq->vec_ptr;
+	wq->vec_ptr = wq->vec_ptr & 7;
+}
+
+static inline void set_desc_addresses(struct dma_request *req,
+				      u64 *src, u64 *dst)
+{
+		*src = sg_dma_address(&req->sg[0]);
+		*dst = req->pg_dma;
+}
+
+static inline void set_completion_address(struct idxd_desc *desc,
+					  u64 *compl_addr)
+{
+		*compl_addr = desc->compl_dma;
+}

