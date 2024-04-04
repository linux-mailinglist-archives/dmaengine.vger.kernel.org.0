Return-Path: <dmaengine+bounces-1740-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1828899174
	for <lists+dmaengine@lfdr.de>; Fri,  5 Apr 2024 00:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A141C2282C
	for <lists+dmaengine@lfdr.de>; Thu,  4 Apr 2024 22:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C1F6F505;
	Thu,  4 Apr 2024 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bddWIEn6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1FD5479F;
	Thu,  4 Apr 2024 22:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712270394; cv=none; b=W9kNLsin0n9ocLYCu8Qk6mlLpBjQ/sHaU+l8WMdtUJ18QX6cWyljAl+88KGOV9+2H75DiYmjG+p/NSP+q2wx/zI/BJm/nq/L846IWX0kKDh1RLwbnSQbwdJkqKGoSTMxSQawhWO1vb4gtZ39UcAZnFHThy5Hjx+Y8/jc1kkwq+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712270394; c=relaxed/simple;
	bh=ZW9ZUbKsIK1opfIGQ4iWZHRrIrsnI+gctGFHX7UTW4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YlR8arZ4/0br+IluMEgZqbkrQKGyK+floWhspYylwed8eUcdepumxET6FxcESGT9ZIDpqwvnMdn3WGZOm1P2rdnsFKJlu/lZz8erVTq74oA75R1cQ+r6MOaGZESBfJyA5Re88PEwvIKUm9XICFi4QaaaAXCl5jYACaZrk1+kLpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bddWIEn6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712270392; x=1743806392;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZW9ZUbKsIK1opfIGQ4iWZHRrIrsnI+gctGFHX7UTW4Y=;
  b=bddWIEn6MW9ASIhAQDhAXpBfgrsiTyKStW8GhmTfnXhbwDm1W20UhMot
   PcSnAOrSn0DCQmRiJCs8f69+14AD55WSQIZ7/muku1IcfsMu9QaaQlEAl
   /roWiAiQY5b8XqO+YPK+pJ9MDnE7MoTnQOPTmqtnykIqTA/IUBo5VxqGU
   kE4jH+Kt5rLCoWgDeNdn9ybc0eKNU+FZqDrI9ThnydHf2sAts9hajqWQ9
   I2jdNjhzxH4cqfz3QojYxkOIzOjOKwVxppr9EETf/hRhvvlJwN/rPDq6l
   m6TlN1/k2JNH537O3f7vyuTRQZSQp9ny824IX3VLqtcqVis5evachH2sn
   w==;
X-CSE-ConnectionGUID: 7jSba1KoTb+yD11n5/mxWw==
X-CSE-MsgGUID: svYeUgqeQciq9ZCt+HWm7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="25093104"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="25093104"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 15:39:43 -0700
X-CSE-ConnectionGUID: 7f41T+tXQDypJWcc46SrlA==
X-CSE-MsgGUID: wGeUfTnQS96AJNkAhiBxlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="19372594"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa007.jf.intel.com with ESMTP; 04 Apr 2024 15:39:43 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Rex Zhang <rex.zhang@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Lijun Pan <lijun.pan@intel.com>
Subject: [PATCH v4] dmaengine: idxd: Convert spinlock to mutex to lock evl workqueue
Date: Thu,  4 Apr 2024 15:39:49 -0700
Message-Id: <20240404223949.2885604-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rex Zhang <rex.zhang@intel.com>

drain_workqueue() cannot be called safely in a spinlocked context due to
possible task rescheduling. In the multi-task scenario, calling
queue_work() while drain_workqueue() will lead to a Call Trace as
pushing a work on a draining workqueue is not permitted in spinlocked
context.
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

The current implementation uses a spinlock to protect event log workqueue
and will lead to the Call Trace due to potential task rescheduling.

To address the locking issue, convert the spinlock to mutex, allowing
the drain_workqueue() to be called in a safe mutex-locked context.

This change ensures proper synchronization when accessing the event log
workqueue, preventing potential Call Trace and improving the overall
robustness of the code.

Fixes: c40bd7d9737b ("dmaengine: idxd: process user page faults for completion record")
Signed-off-by: Rex Zhang <rex.zhang@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Lijun Pan <lijun.pan@intel.com>
---
Changlog:
v4:
- No functional changes. This patch was not picked up before. So rebase
  the patch to the latest kernel version and resend it.
- Update the commit message to provide more details on the issue and
  the fix.
- Fenghua Yu sends the patch to the dmaengine/lkml mailing lists.

v3:
https://lore.kernel.org/dmaengine/20240123034831.3020048-1-rex.zhang@intel.com/

 drivers/dma/idxd/cdev.c    | 5 ++---
 drivers/dma/idxd/debugfs.c | 4 ++--
 drivers/dma/idxd/device.c  | 8 ++++----
 drivers/dma/idxd/idxd.h    | 2 +-
 drivers/dma/idxd/init.c    | 2 +-
 drivers/dma/idxd/irq.c     | 4 ++--
 6 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 8078ab9acfbc..c095a2c8f659 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -342,7 +342,7 @@ static void idxd_cdev_evl_drain_pasid(struct idxd_wq *wq, u32 pasid)
 	if (!evl)
 		return;
 
-	spin_lock(&evl->lock);
+	mutex_lock(&evl->lock);
 	status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
 	t = status.tail;
 	h = status.head;
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
index f3f25ee676f3..ad4245cb301d 100644
--- a/drivers/dma/idxd/debugfs.c
+++ b/drivers/dma/idxd/debugfs.c
@@ -66,7 +66,7 @@ static int debugfs_evl_show(struct seq_file *s, void *d)
 	if (!evl || !evl->log)
 		return 0;
 
-	spin_lock(&evl->lock);
+	mutex_lock(&evl->lock);
 
 	evl_status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
 	t = evl_status.tail;
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
index a4099a1e2340..7b98944135eb 100644
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
index 4954adc6bb60..264c4e47d7cc 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -354,7 +354,7 @@ static int idxd_init_evl(struct idxd_device *idxd)
 	if (!evl)
 		return -ENOMEM;
 
-	spin_lock_init(&evl->lock);
+	mutex_init(&evl->lock);
 	evl->size = IDXD_EVL_SIZE_MIN;
 
 	idxd_name = dev_name(idxd_confdev(idxd));
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 348aa21389a9..8dc029c86551 100644
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
@@ -380,7 +380,7 @@ static void process_evl_entries(struct idxd_device *idxd)
 
 	evl_status.head = h;
 	iowrite32(evl_status.bits_lower32, idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
-	spin_unlock(&evl->lock);
+	mutex_unlock(&evl->lock);
 }
 
 irqreturn_t idxd_misc_thread(int vec, void *data)
-- 
2.37.1


