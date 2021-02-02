Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEE630CFB9
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 00:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbhBBXLe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Feb 2021 18:11:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:16715 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236083AbhBBXLe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 2 Feb 2021 18:11:34 -0500
IronPort-SDR: 09sVmZPXiI1VAIbLZ/OBj1NJI8W3TLJ8+yNI+y00AhhRUchAdRCjEPN5/C/atspn3H5re4uUe7
 yIPRJ39bbktQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="181025351"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="181025351"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 15:10:52 -0800
IronPort-SDR: NxV/y4ja0Bm5+2zt20lBJnJxX1/UmVNiH2GsG6kIJc3s1pQk41u3F9u1pe080qhg/Rbn8zouJZ
 Mx/O+W9DM/ug==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="413440639"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 15:10:52 -0800
Subject: [PATCH] dmaengine: idxd: add percpu_ref to descriptor submission path
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 02 Feb 2021 16:10:51 -0700
Message-ID: <161230745094.3446217.12069381681972312918.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Current submission path has no way to restrict the submitter from
stop submiting on shutdown path or wq disable path. This provides a way to
quiesce the submission path.

Modeling after 'struct reqeust_queue' usage of percpu_ref. One of the
abilities of per_cpu reference counting is the ability to stop new
references from being taken while awaiting outstanding references to be
dropped. On wq shutdown, we want to block any new submissions to the kernel
workqueue and quiesce before disabling. The percpu_ref allows us to block
any new submissions and wait for any current submission calls to finish
submitting to the workqueue.

A percpu_ref is embedded in each idxd_wq context to allow control for
individual wq. The wq->wq_active counter is elevated before calling
movdir64b() or enqcmds() to submit a descriptor to the wq and dropped once
the submission call completes. The function is gated by
percpu_ref_tryget_live(). On shutdown with percpu_ref_kill() called, any
new submission would be blocked from acquiring a ref and failed. Once all
references are dropped for the wq, shutdown can continue.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |   26 +++++
 drivers/dma/idxd/idxd.h   |    4 +
 drivers/dma/idxd/init.c   |   15 +++
 drivers/dma/idxd/submit.c |    5 +
 drivers/dma/idxd/sysfs.c  |  233 ++++++++++++++++++++++++---------------------
 5 files changed, 175 insertions(+), 108 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 95f94a3ed6be..b7227f2abe78 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -386,6 +386,32 @@ void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	}
 }
 
+static void idxd_wq_ref_release(struct percpu_ref *ref)
+{
+	struct idxd_wq *wq = container_of(ref, struct idxd_wq, wq_active);
+
+	complete(&wq->wq_dead);
+}
+
+int idxd_wq_init_percpu_ref(struct idxd_wq *wq)
+{
+	int rc;
+
+	memset(&wq->wq_active, 0, sizeof(wq->wq_active));
+	rc = percpu_ref_init(&wq->wq_active, idxd_wq_ref_release, 0, GFP_KERNEL);
+	if (rc < 0)
+		return rc;
+	reinit_completion(&wq->wq_dead);
+	return 0;
+}
+
+void idxd_wq_quiesce(struct idxd_wq *wq)
+{
+	percpu_ref_kill(&wq->wq_active);
+	wait_for_completion(&wq->wq_dead);
+	percpu_ref_exit(&wq->wq_active);
+}
+
 /* Device control bits */
 static inline bool idxd_is_enabled(struct idxd_device *idxd)
 {
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 5a50e91c71bf..d1d56b1fae37 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -98,6 +98,8 @@ enum idxd_complete_type {
 
 struct idxd_wq {
 	void __iomem *portal;
+	struct percpu_ref wq_active;
+	struct completion wq_dead;
 	struct device conf_dev;
 	struct idxd_cdev idxd_cdev;
 	struct idxd_device *idxd;
@@ -346,6 +348,8 @@ void idxd_wq_unmap_portal(struct idxd_wq *wq);
 void idxd_wq_disable_cleanup(struct idxd_wq *wq);
 int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid);
 int idxd_wq_disable_pasid(struct idxd_wq *wq);
+void idxd_wq_quiesce(struct idxd_wq *wq);
+int idxd_wq_init_percpu_ref(struct idxd_wq *wq);
 
 /* submission */
 int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 9687a24ff982..ee203fdebac3 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -192,6 +192,7 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 
 	for (i = 0; i < idxd->max_wqs; i++) {
 		struct idxd_wq *wq = &idxd->wqs[i];
+		int rc;
 
 		wq->id = i;
 		wq->idxd = idxd;
@@ -202,6 +203,7 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 		wq->wqcfg = devm_kzalloc(dev, idxd->wqcfg_size, GFP_KERNEL);
 		if (!wq->wqcfg)
 			return -ENOMEM;
+		init_completion(&wq->wq_dead);
 	}
 
 	for (i = 0; i < idxd->max_engines; i++) {
@@ -483,6 +485,18 @@ static void idxd_flush_work_list(struct idxd_irq_entry *ie)
 	}
 }
 
+static void idxd_wqs_quiesce(struct idxd_device *idxd)
+{
+	struct idxd_wq *wq;
+	int i;
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		wq = &idxd->wqs[i];
+		if (wq->state == IDXD_WQ_ENABLED && wq->type == IDXD_WQT_KERNEL)
+			idxd_wq_quiesce(wq);
+	}
+}
+
 static void idxd_shutdown(struct pci_dev *pdev)
 {
 	struct idxd_device *idxd = pci_get_drvdata(pdev);
@@ -490,6 +504,7 @@ static void idxd_shutdown(struct pci_dev *pdev)
 	struct idxd_irq_entry *irq_entry;
 	int msixcnt = pci_msix_vec_count(pdev);
 
+	idxd_wqs_quiesce(idxd);
 	rc = idxd_device_disable(idxd);
 	if (rc)
 		dev_err(&pdev->dev, "Disabling device failed\n");
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index a7a61bcc17d5..eaacac36979a 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -86,6 +86,9 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	if (idxd->state != IDXD_DEV_ENABLED)
 		return -EIO;
 
+	if (!percpu_ref_tryget_live(&wq->wq_active))
+		return -ENXIO;
+
 	portal = wq->portal;
 
 	/*
@@ -108,6 +111,8 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 			return rc;
 	}
 
+	percpu_ref_put(&wq->wq_active);
+
 	/*
 	 * Pending the descriptor to the lockless list for the irq_entry
 	 * that we designated the descriptor to.
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 266423a2cabc..f4e93db8e26e 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -110,6 +110,127 @@ static int idxd_config_bus_match(struct device *dev,
 	return matched;
 }
 
+static int enable_wq(struct idxd_wq *wq)
+{
+	struct idxd_device *idxd = wq->idxd;
+	struct device *dev = &idxd->pdev->dev;
+	unsigned long flags;
+	int rc;
+
+	mutex_lock(&wq->wq_lock);
+
+	if (idxd->state != IDXD_DEV_ENABLED) {
+		mutex_unlock(&wq->wq_lock);
+		dev_warn(dev, "Enabling while device not enabled.\n");
+		return -EPERM;
+	}
+
+	if (wq->state != IDXD_WQ_DISABLED) {
+		mutex_unlock(&wq->wq_lock);
+		dev_warn(dev, "WQ %d already enabled.\n", wq->id);
+		return -EBUSY;
+	}
+
+	if (!wq->group) {
+		mutex_unlock(&wq->wq_lock);
+		dev_warn(dev, "WQ not attached to group.\n");
+		return -EINVAL;
+	}
+
+	if (strlen(wq->name) == 0) {
+		mutex_unlock(&wq->wq_lock);
+		dev_warn(dev, "WQ name not set.\n");
+		return -EINVAL;
+	}
+
+	/* Shared WQ checks */
+	if (wq_shared(wq)) {
+		if (!device_swq_supported(idxd)) {
+			dev_warn(dev, "PASID not enabled and shared WQ.\n");
+			mutex_unlock(&wq->wq_lock);
+			return -ENXIO;
+		}
+		/*
+		 * Shared wq with the threshold set to 0 means the user
+		 * did not set the threshold or transitioned from a
+		 * dedicated wq but did not set threshold. A value
+		 * of 0 would effectively disable the shared wq. The
+		 * driver does not allow a value of 0 to be set for
+		 * threshold via sysfs.
+		 */
+		if (wq->threshold == 0) {
+			dev_warn(dev, "Shared WQ and threshold 0.\n");
+			mutex_unlock(&wq->wq_lock);
+			return -EINVAL;
+		}
+	}
+
+	rc = idxd_wq_alloc_resources(wq);
+	if (rc < 0) {
+		mutex_unlock(&wq->wq_lock);
+		dev_warn(dev, "WQ resource alloc failed\n");
+		return rc;
+	}
+
+	spin_lock_irqsave(&idxd->dev_lock, flags);
+	rc = idxd_device_config(idxd);
+	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	if (rc < 0) {
+		mutex_unlock(&wq->wq_lock);
+		dev_warn(dev, "Writing WQ %d config failed: %d\n", wq->id, rc);
+		return rc;
+	}
+
+	rc = idxd_wq_enable(wq);
+	if (rc < 0) {
+		mutex_unlock(&wq->wq_lock);
+		dev_warn(dev, "WQ %d enabling failed: %d\n", wq->id, rc);
+		return rc;
+	}
+
+	rc = idxd_wq_map_portal(wq);
+	if (rc < 0) {
+		dev_warn(dev, "wq portal mapping failed: %d\n", rc);
+		rc = idxd_wq_disable(wq);
+		if (rc < 0)
+			dev_warn(dev, "IDXD wq disable failed\n");
+		mutex_unlock(&wq->wq_lock);
+		return rc;
+	}
+
+	wq->client_count = 0;
+
+	if (wq->type == IDXD_WQT_KERNEL) {
+		rc = idxd_wq_init_percpu_ref(wq);
+		if (rc < 0) {
+			dev_dbg(dev, "percpu_ref setup failed\n");
+			mutex_unlock(&wq->wq_lock);
+			return rc;
+		}
+	}
+
+	if (is_idxd_wq_dmaengine(wq)) {
+		rc = idxd_register_dma_channel(wq);
+		if (rc < 0) {
+			dev_dbg(dev, "DMA channel register failed\n");
+			mutex_unlock(&wq->wq_lock);
+			return rc;
+		}
+	} else if (is_idxd_wq_cdev(wq)) {
+		rc = idxd_wq_add_cdev(wq);
+		if (rc < 0) {
+			dev_dbg(dev, "Cdev creation failed\n");
+			mutex_unlock(&wq->wq_lock);
+			return rc;
+		}
+	}
+
+	mutex_unlock(&wq->wq_lock);
+	dev_info(dev, "wq %s enabled\n", dev_name(&wq->conf_dev));
+
+	return 0;
+}
+
 static int idxd_config_bus_probe(struct device *dev)
 {
 	int rc;
@@ -157,115 +278,8 @@ static int idxd_config_bus_probe(struct device *dev)
 		return 0;
 	} else if (is_idxd_wq_dev(dev)) {
 		struct idxd_wq *wq = confdev_to_wq(dev);
-		struct idxd_device *idxd = wq->idxd;
-
-		mutex_lock(&wq->wq_lock);
-
-		if (idxd->state != IDXD_DEV_ENABLED) {
-			mutex_unlock(&wq->wq_lock);
-			dev_warn(dev, "Enabling while device not enabled.\n");
-			return -EPERM;
-		}
-
-		if (wq->state != IDXD_WQ_DISABLED) {
-			mutex_unlock(&wq->wq_lock);
-			dev_warn(dev, "WQ %d already enabled.\n", wq->id);
-			return -EBUSY;
-		}
-
-		if (!wq->group) {
-			mutex_unlock(&wq->wq_lock);
-			dev_warn(dev, "WQ not attached to group.\n");
-			return -EINVAL;
-		}
-
-		if (strlen(wq->name) == 0) {
-			mutex_unlock(&wq->wq_lock);
-			dev_warn(dev, "WQ name not set.\n");
-			return -EINVAL;
-		}
-
-		/* Shared WQ checks */
-		if (wq_shared(wq)) {
-			if (!device_swq_supported(idxd)) {
-				dev_warn(dev,
-					 "PASID not enabled and shared WQ.\n");
-				mutex_unlock(&wq->wq_lock);
-				return -ENXIO;
-			}
-			/*
-			 * Shared wq with the threshold set to 0 means the user
-			 * did not set the threshold or transitioned from a
-			 * dedicated wq but did not set threshold. A value
-			 * of 0 would effectively disable the shared wq. The
-			 * driver does not allow a value of 0 to be set for
-			 * threshold via sysfs.
-			 */
-			if (wq->threshold == 0) {
-				dev_warn(dev,
-					 "Shared WQ and threshold 0.\n");
-				mutex_unlock(&wq->wq_lock);
-				return -EINVAL;
-			}
-		}
-
-		rc = idxd_wq_alloc_resources(wq);
-		if (rc < 0) {
-			mutex_unlock(&wq->wq_lock);
-			dev_warn(dev, "WQ resource alloc failed\n");
-			return rc;
-		}
-
-		spin_lock_irqsave(&idxd->dev_lock, flags);
-		rc = idxd_device_config(idxd);
-		spin_unlock_irqrestore(&idxd->dev_lock, flags);
-		if (rc < 0) {
-			mutex_unlock(&wq->wq_lock);
-			dev_warn(dev, "Writing WQ %d config failed: %d\n",
-				 wq->id, rc);
-			return rc;
-		}
 
-		rc = idxd_wq_enable(wq);
-		if (rc < 0) {
-			mutex_unlock(&wq->wq_lock);
-			dev_warn(dev, "WQ %d enabling failed: %d\n",
-				 wq->id, rc);
-			return rc;
-		}
-
-		rc = idxd_wq_map_portal(wq);
-		if (rc < 0) {
-			dev_warn(dev, "wq portal mapping failed: %d\n", rc);
-			rc = idxd_wq_disable(wq);
-			if (rc < 0)
-				dev_warn(dev, "IDXD wq disable failed\n");
-			mutex_unlock(&wq->wq_lock);
-			return rc;
-		}
-
-		wq->client_count = 0;
-
-		dev_info(dev, "wq %s enabled\n", dev_name(&wq->conf_dev));
-
-		if (is_idxd_wq_dmaengine(wq)) {
-			rc = idxd_register_dma_channel(wq);
-			if (rc < 0) {
-				dev_dbg(dev, "DMA channel register failed\n");
-				mutex_unlock(&wq->wq_lock);
-				return rc;
-			}
-		} else if (is_idxd_wq_cdev(wq)) {
-			rc = idxd_wq_add_cdev(wq);
-			if (rc < 0) {
-				dev_dbg(dev, "Cdev creation failed\n");
-				mutex_unlock(&wq->wq_lock);
-				return rc;
-			}
-		}
-
-		mutex_unlock(&wq->wq_lock);
-		return 0;
+		return enable_wq(wq);
 	}
 
 	return -ENODEV;
@@ -284,6 +298,9 @@ static void disable_wq(struct idxd_wq *wq)
 		return;
 	}
 
+	if (wq->type == IDXD_WQT_KERNEL)
+		idxd_wq_quiesce(wq);
+
 	if (is_idxd_wq_dmaengine(wq))
 		idxd_unregister_dma_channel(wq);
 	else if (is_idxd_wq_cdev(wq))


