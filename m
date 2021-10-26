Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953EB43BC84
	for <lists+dmaengine@lfdr.de>; Tue, 26 Oct 2021 23:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239676AbhJZVjD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Oct 2021 17:39:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:38392 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239675AbhJZVi5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 Oct 2021 17:38:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="210801825"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="210801825"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 14:36:31 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="724370675"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 14:36:30 -0700
Subject: [PATCH v2 5/7] dmaengine: idxd: create locked version of
 idxd_quiesce() call
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Kevin Tian <kevin.tian@intel.com>, dmaengine@vger.kernel.org
Date:   Tue, 26 Oct 2021 14:36:29 -0700
Message-ID: <163528418980.3925689.5841907054957931211.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <163528412413.3925689.7831987824972063153.stgit@djiang5-desk3.ch.intel.com>
References: <163528412413.3925689.7831987824972063153.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a locked version of idxd_quiesce() call so that the quiesce can be
called with a lock in situations where the lock is not held by the caller.

In the driver probe/remove path, the lock is already held, so the raw
version can be called w/o locking.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |   10 +++++++++-
 drivers/dma/idxd/dma.c    |    4 ++--
 drivers/dma/idxd/idxd.h   |    1 +
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index f381319615fd..943e9967627b 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -411,12 +411,20 @@ int idxd_wq_init_percpu_ref(struct idxd_wq *wq)
 	return 0;
 }
 
-void idxd_wq_quiesce(struct idxd_wq *wq)
+void __idxd_wq_quiesce(struct idxd_wq *wq)
 {
+	lockdep_assert_held(&wq->wq_lock);
 	percpu_ref_kill(&wq->wq_active);
 	wait_for_completion(&wq->wq_dead);
 }
 
+void idxd_wq_quiesce(struct idxd_wq *wq)
+{
+	mutex_lock(&wq->wq_lock);
+	__idxd_wq_quiesce(wq);
+	mutex_unlock(&wq->wq_lock);
+}
+
 /* Device control bits */
 static inline bool idxd_is_enabled(struct idxd_device *idxd)
 {
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index 1ea663215909..375dbae18583 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -316,7 +316,7 @@ static int idxd_dmaengine_drv_probe(struct idxd_dev *idxd_dev)
 	return 0;
 
 err_dma:
-	idxd_wq_quiesce(wq);
+	__idxd_wq_quiesce(wq);
 	percpu_ref_exit(&wq->wq_active);
 err_ref:
 	idxd_wq_free_resources(wq);
@@ -333,7 +333,7 @@ static void idxd_dmaengine_drv_remove(struct idxd_dev *idxd_dev)
 	struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
 
 	mutex_lock(&wq->wq_lock);
-	idxd_wq_quiesce(wq);
+	__idxd_wq_quiesce(wq);
 	idxd_unregister_dma_channel(wq);
 	idxd_wq_free_resources(wq);
 	__drv_disable_wq(wq);
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 355159d4ee68..970701738c8a 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -570,6 +570,7 @@ int idxd_wq_map_portal(struct idxd_wq *wq);
 void idxd_wq_unmap_portal(struct idxd_wq *wq);
 int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid);
 int idxd_wq_disable_pasid(struct idxd_wq *wq);
+void __idxd_wq_quiesce(struct idxd_wq *wq);
 void idxd_wq_quiesce(struct idxd_wq *wq);
 int idxd_wq_init_percpu_ref(struct idxd_wq *wq);
 


