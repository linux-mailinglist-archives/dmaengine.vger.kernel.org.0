Return-Path: <dmaengine+bounces-806-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460C583862A
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 04:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0A428936A
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 03:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6CC1852;
	Tue, 23 Jan 2024 03:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExY/XeQ0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCCE17E8
	for <dmaengine@vger.kernel.org>; Tue, 23 Jan 2024 03:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705981723; cv=none; b=ggx5F+Mc9nDOSyH4ubhMFbxp4CWE6XoxwXge4GW60a0F6JTKohDRyXbooqo+2sZYo2clsx7PQJGVW+qm0xfKzpdL60O9Z9y7lbV66vPsOj7uqqT9oJAK8zGDuc5dMw9UFjIfYdU/iT8g7Xqx/sTPSvJNZwbfbcwwtmchDpWCrQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705981723; c=relaxed/simple;
	bh=m1Mw71M5iP/JI9mrsj0Hrq/3V0EgaxqrlGXcHSLBINg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kWXLkH62jAw+Qp6XWyhP1RDp93Qxr/Bh0+zbbefk7XChZihqEiBNCZNd0o/EhMmxuliFCZanOdPkLKCKPIEPhz9aVNW/lOPoGxhd8JhRVrO0OZqSaQr06RsGoU5QTSFyihskciyw6To5aChygbIdEV0ehRiavZ5XOLfRU7uKjCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExY/XeQ0; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705981719; x=1737517719;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m1Mw71M5iP/JI9mrsj0Hrq/3V0EgaxqrlGXcHSLBINg=;
  b=ExY/XeQ08CrCQrroZ2La24ljCNv3du+/fVZ8BY09cdJpvVtK928SjIZU
   FneJ0+0a3LqVkC4SqfrREikLc69JsHK372kbuFJlsvq1a2s67S6J6YVUQ
   8INhF/5QjKxSDynKtVRmhK/9M4v2llMgttSBvFy9PggRf7C+Tfuzcqgnj
   lmB2ByrueM5nkIITBOFHQVU+F5/V+cKSkWeNXLg11oSc4Ba971apq2Uwr
   WhqJj2zUSz29vtkcoB29d7C61xvt0iZy0ojhnuaRQFCnnXL0k73iU9Yso
   ghxDrDqY0xHynxidlHhzWMvDvWXirqjWViOFRBFIsg3kCdvCMy8WshymW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="400262370"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="400262370"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 19:48:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="1448794"
Received: from rex-z390-aorus-pro.sh.intel.com ([10.239.161.21])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jan 2024 19:48:36 -0800
From: Rex Zhang <rex.zhang@intel.com>
To: dmaengine@vger.kernel.org,
	vkoul@kernel.org
Cc: dave.jiang@intel.com,
	fenghua.yu@intel.com,
	lijun.pan@intel.com,
	rex.zhang@intel.com
Subject: [RESEND PATCH v3] dmaengine: idxd: Convert spinlock to mutex to lock evl workqueue
Date: Tue, 23 Jan 2024 11:48:31 +0800
Message-Id: <20240123034831.3020048-1-rex.zhang@intel.com>
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
The original lock for event log was spinlock, drain_workqueue() can't
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
Reviewed-by: Lijun Pan <lijun.pan@intel.com>
---
Changelog:
v2:
- Update commit message.
v3:
- Rebase on v6.8-rc1
---
 drivers/dma/idxd/cdev.c    | 5 ++---
 drivers/dma/idxd/debugfs.c | 4 ++--
 drivers/dma/idxd/device.c  | 8 ++++----
 drivers/dma/idxd/idxd.h    | 2 +-
 drivers/dma/idxd/init.c    | 2 +-
 drivers/dma/idxd/irq.c     | 4 ++--
 6 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 77f8885cf407..00d78d78fb7f 100644
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
index ecfdf4a8f1f8..c41ef195eeb9 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -775,7 +775,7 @@ static int idxd_device_evl_setup(struct idxd_device *idxd)
 		goto err_alloc;
 	}
 
-	spin_lock(&evl->lock);
+	mutex_lock(&evl->lock);
 	evl->log = addr;
 	evl->dma = dma_addr;
 	evl->log_size = size;
@@ -796,7 +796,7 @@ static int idxd_device_evl_setup(struct idxd_device *idxd)
 	gencfg.evl_en = 1;
 	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
 
-	spin_unlock(&evl->lock);
+	mutex_unlock(&evl->lock);
 	return 0;
 
 err_alloc:
@@ -819,7 +819,7 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
 	if (!gencfg.evl_en)
 		return;
 
-	spin_lock(&evl->lock);
+	mutex_lock(&evl->lock);
 	gencfg.evl_en = 0;
 	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
 
@@ -836,7 +836,7 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
 	evl_dma = evl->dma;
 	evl->log = NULL;
 	evl->size = IDXD_EVL_SIZE_MIN;
-	spin_unlock(&evl->lock);
+	mutex_unlock(&evl->lock);
 
 	dma_free_coherent(dev, evl_log_size, evl_log, evl_dma);
 }
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 47de3f93ff1e..d7f0d3eb9c72 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -293,7 +293,7 @@ struct idxd_driver_data {
 
 struct idxd_evl {
 	/* Lock to protect event log access. */
-	spinlock_t lock;
+	struct mutex lock;
 	void *log;
 	dma_addr_t dma;
 	/* Total size of event log = number of entries * entry size. */
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 14df1f1347a8..79dae8525d56 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -352,7 +352,7 @@ static int idxd_init_evl(struct idxd_device *idxd)
 	if (!evl)
 		return -ENOMEM;
 
-	spin_lock_init(&evl->lock);
+	mutex_init(&evl->lock);
 	evl->size = IDXD_EVL_SIZE_MIN;
 
 	idxd->evl_cache = kmem_cache_create(dev_name(idxd_confdev(idxd)),
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index c8a0aa874b11..053dda0edc8c 100644
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


