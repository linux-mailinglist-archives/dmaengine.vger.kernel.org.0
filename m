Return-Path: <dmaengine+bounces-588-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163FA819768
	for <lists+dmaengine@lfdr.de>; Wed, 20 Dec 2023 04:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C776C287A22
	for <lists+dmaengine@lfdr.de>; Wed, 20 Dec 2023 03:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC5B125AC;
	Wed, 20 Dec 2023 03:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qwzouqfi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D811C84
	for <dmaengine@vger.kernel.org>; Wed, 20 Dec 2023 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703044399; x=1734580399;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sw6kRPTvEd2m86lW2mQerTx93hzySwBU5juMt1GzWLg=;
  b=QwzouqfiHXV6URwfGC08eq0mAjPyzeHD8lyMLrKjcPi3jkbQJwzrN2lj
   s1uHKKD/EyiI5NVG7fkGpWMtVxwcivhQNFL+p1OHGqNKFLHxYSM6q/5dE
   flRFeqKlpAjxfSey+ftO9kqOAcX66geAzAc37T0EFEYaW6ERItBavX3sp
   V72GRXbqjUVgibW1iv7iADT2/JoeBi8pHGnUXliYiqAF1dQ+gpk0a4HGH
   FP2rcfHhHovI4kvXr5YJV/xqVMrVOKL/bJrNNQN0d1+BK1QsfwBg6t3x1
   d/UqXlHR+c09wGTNFHTO8T00AmUFljzqI8EI6sHWoCMzltviVYyueqGpc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="395484892"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="395484892"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 19:53:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="776195425"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="776195425"
Received: from rex-z390-aorus-pro.sh.intel.com ([10.239.161.21])
  by orsmga002.jf.intel.com with ESMTP; 19 Dec 2023 19:53:16 -0800
From: Rex Zhang <rex.zhang@intel.com>
To: dmaengine@vger.kernel.org,
	vkoul@kernel.org
Cc: dave.jiang@intel.com,
	fenghua.yu@intel.com,
	rex.zhang@intel.com
Subject: [PATCH] dmaengine: idxd: Convert spinlock to mutex to lock evl workqueue
Date: Wed, 20 Dec 2023 11:53:10 +0800
Message-Id: <20231220035310.883595-1-rex.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The drain_workqueue() is not in a locked context. In the multi-task case,
it's possible to call queue_work() when drain_workqueue() is ongoing, then
it can cause Call Trace due to pushing a work into a draining workqueue:
    Call Trace:
    <TASK>
    ? __warn+0x7d/0x140
    ? __queue_work+0x2b2/0x440
    ? report_bug+0x1f8/0x200
    ? handle_bug+0x3c/0x70
    ? exc_invalid_op+0x18/0x70
    ? asm_exc_invalid_op+0x1a/0x20
    ? __queue_work+0x2b2/0x440
    queue_work_on+0x28/0x30
    idxd_misc_thread+0x303/0x5a0 [idxd]
    ? __schedule+0x369/0xb40
    ? __pfx_irq_thread_fn+0x10/0x10
    ? irq_thread+0xbc/0x1b0
    irq_thread_fn+0x21/0x70
    irq_thread+0x102/0x1b0
    ? preempt_count_add+0x74/0xa0
    ? __pfx_irq_thread_dtor+0x10/0x10
    ? __pfx_irq_thread+0x10/0x10
    kthread+0x103/0x140
    ? __pfx_kthread+0x10/0x10
    ret_from_fork+0x31/0x50
    ? __pfx_kthread+0x10/0x10
    ret_from_fork_asm+0x1b/0x30
    </TASK>
The original locker for event log was spinlock, drain_workqueue() can't
be in a spinlocked context because it may cause task rescheduling. The
spinlock was called in thread and irq thread context, the current usages
does not require a spinlock for event log, so it's feasible to convert
spinlock to mutex.
For putting drain_workqueue() into a locked context, convert the spinlock
to mutex, then lock drain_workqueue() by mutex.

Fixes: c40bd7d9737b ("dmaengine: idxd: process user page faults for completion record")
Signed-off-by: Rex Zhang <rex.zhang@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/cdev.c    | 5 ++---
 drivers/dma/idxd/debugfs.c | 4 ++--
 drivers/dma/idxd/device.c  | 8 ++++----
 drivers/dma/idxd/idxd.h    | 2 +-
 drivers/dma/idxd/init.c    | 2 +-
 drivers/dma/idxd/irq.c     | 4 ++--
 6 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 0423655f5a88..556cac187612 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -342,7 +342,7 @@ static void idxd_cdev_evl_drain_pasid(struct idxd_wq *wq, u32 pasid)
 	if (!evl)
 		return;
 
-	spin_lock(&evl->lock);
+	mutex_lock(&evl->lock);
 	status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
 	t = status.tail;
 	h = evl->head;
@@ -354,9 +354,8 @@ static void idxd_cdev_evl_drain_pasid(struct idxd_wq *wq, u32 pasid)
 			set_bit(h, evl->bmap);
 		h = (h + 1) % size;
 	}
-	spin_unlock(&evl->lock);
-
 	drain_workqueue(wq->wq);
+	mutex_unlock(&evl->lock);
 }
 
 static int idxd_cdev_release(struct inode *node, struct file *filep)
diff --git a/drivers/dma/idxd/debugfs.c b/drivers/dma/idxd/debugfs.c
index 9cfbd9b14c4c..7f689b3aff65 100644
--- a/drivers/dma/idxd/debugfs.c
+++ b/drivers/dma/idxd/debugfs.c
@@ -66,7 +66,7 @@ static int debugfs_evl_show(struct seq_file *s, void *d)
 	if (!evl || !evl->log)
 		return 0;
 
-	spin_lock(&evl->lock);
+	mutex_lock(&evl->lock);
 
 	h = evl->head;
 	evl_status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
@@ -87,7 +87,7 @@ static int debugfs_evl_show(struct seq_file *s, void *d)
 		dump_event_entry(idxd, s, i, &count, processed);
 	}
 
-	spin_unlock(&evl->lock);
+	mutex_unlock(&evl->lock);
 	return 0;
 }
 
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 8f754f922217..042e076a6f2a 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -770,7 +770,7 @@ static int idxd_device_evl_setup(struct idxd_device *idxd)
 		goto err_alloc;
 	}
 
-	spin_lock(&evl->lock);
+	mutex_lock(&evl->lock);
 	evl->log = addr;
 	evl->dma = dma_addr;
 	evl->log_size = size;
@@ -791,7 +791,7 @@ static int idxd_device_evl_setup(struct idxd_device *idxd)
 	gencfg.evl_en = 1;
 	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
 
-	spin_unlock(&evl->lock);
+	mutex_unlock(&evl->lock);
 	return 0;
 
 err_alloc:
@@ -811,7 +811,7 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
 	if (!gencfg.evl_en)
 		return;
 
-	spin_lock(&evl->lock);
+	mutex_lock(&evl->lock);
 	gencfg.evl_en = 0;
 	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
 
@@ -826,7 +826,7 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
 	bitmap_free(evl->bmap);
 	evl->log = NULL;
 	evl->size = IDXD_EVL_SIZE_MIN;
-	spin_unlock(&evl->lock);
+	mutex_unlock(&evl->lock);
 }
 
 static void idxd_group_config_write(struct idxd_group *group)
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 1e89c80a07fc..b925c972b99b 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -283,7 +283,7 @@ struct idxd_driver_data {
 
 struct idxd_evl {
 	/* Lock to protect event log access. */
-	spinlock_t lock;
+	struct mutex lock;
 	void *log;
 	dma_addr_t dma;
 	/* Total size of event log = number of entries * entry size. */
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 0eb1c827a215..611101f99405 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -351,7 +351,7 @@ static int idxd_init_evl(struct idxd_device *idxd)
 	if (!evl)
 		return -ENOMEM;
 
-	spin_lock_init(&evl->lock);
+	mutex_init(&evl->lock);
 	evl->size = IDXD_EVL_SIZE_MIN;
 
 	idxd->evl_cache = kmem_cache_create(dev_name(idxd_confdev(idxd)),
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 2183d7f9cdbd..3037eda986de 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -363,7 +363,7 @@ static void process_evl_entries(struct idxd_device *idxd)
 	evl_status.bits = 0;
 	evl_status.int_pending = 1;
 
-	spin_lock(&evl->lock);
+	mutex_lock(&evl->lock);
 	/* Clear interrupt pending bit */
 	iowrite32(evl_status.bits_upper32,
 		  idxd->reg_base + IDXD_EVLSTATUS_OFFSET + sizeof(u32));
@@ -381,7 +381,7 @@ static void process_evl_entries(struct idxd_device *idxd)
 	evl->head = h;
 	evl_status.head = h;
 	iowrite32(evl_status.bits_lower32, idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
-	spin_unlock(&evl->lock);
+	mutex_unlock(&evl->lock);
 }
 
 irqreturn_t idxd_misc_thread(int vec, void *data)
-- 
2.25.1


