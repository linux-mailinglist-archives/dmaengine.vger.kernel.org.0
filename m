Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07F532C281
	for <lists+dmaengine@lfdr.de>; Thu,  4 Mar 2021 01:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhCCW1H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Mar 2021 17:27:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:47564 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1442670AbhCCPAe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 3 Mar 2021 10:00:34 -0500
IronPort-SDR: 7l+nlYOKnT1fzVpe3GWNqjcofhbExDi72xyryZ7AUi+Fy56pXPr6TnTbKR32S0WWbCuHbpq+HS
 E4BV/wNr6dVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="183827908"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="183827908"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 06:56:30 -0800
IronPort-SDR: c57swsNsA+YyoIUGPdCySXgMg/e/lnnsaLNN/K0+qdwVEIHxeA1sVzzE7bowjpMDXC6A3VswaQ
 i5xi71JkKKMA==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="428295586"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 06:56:30 -0800
Subject: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Date:   Wed, 03 Mar 2021 07:56:30 -0700
Message-ID: <161478326635.3900104.2067961356060195664.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove devm_* allocation of memory of 'struct device' objects.
The devm_* lifetime is incompatible with device->release() lifetime.
Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
functions for each component in order to free the allocated memory at
the appropriate time. Each component such as wq, engine, and group now
needs to be allocated individually in order to setup the lifetime properly.
In the process also fix up issues from the fallout of the changes.

Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
v5:
- Rebased against 5.12-rc dmaengine/fixes
v4:
- fix up the life time of cdev creation/destruction (Jason)
- Tested with KASAN and other memory allocation leak detections. (Jason)

v3:
- Remove devm_* for irq request and cleanup related bits (Jason)
v2:
- Remove all devm_* alloc for idxd_device (Jason)
- Add kref dep for dma_dev (Jason)

 drivers/dma/idxd/cdev.c   |   32 +++---
 drivers/dma/idxd/device.c |   20 ++-
 drivers/dma/idxd/dma.c    |   13 ++
 drivers/dma/idxd/idxd.h   |    8 +
 drivers/dma/idxd/init.c   |  261 +++++++++++++++++++++++++++++++++------------
 drivers/dma/idxd/irq.c    |    6 +
 drivers/dma/idxd/sysfs.c  |   77 +++++++++----
 7 files changed, 290 insertions(+), 127 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 0db9b82ed8cf..1b98e06fa228 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -259,6 +259,7 @@ static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
 		return -ENOMEM;
 
 	dev = idxd_cdev->dev;
+	device_initialize(dev);
 	dev->parent = &idxd->pdev->dev;
 	dev_set_name(dev, "%s/wq%u.%u", idxd_get_dev_name(idxd),
 		     idxd->id, wq->id);
@@ -268,25 +269,17 @@ static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
 	minor = ida_simple_get(&cdev_ctx->minor_ida, 0, MINORMASK, GFP_KERNEL);
 	if (minor < 0) {
 		rc = minor;
-		kfree(dev);
 		goto ida_err;
 	}
 
 	dev->devt = MKDEV(MAJOR(cdev_ctx->devt), minor);
 	dev->type = &idxd_cdev_device_type;
-	rc = device_register(dev);
-	if (rc < 0) {
-		dev_err(&idxd->pdev->dev, "device register failed\n");
-		goto dev_reg_err;
-	}
 	idxd_cdev->minor = minor;
 
 	return 0;
 
- dev_reg_err:
-	ida_simple_remove(&cdev_ctx->minor_ida, MINOR(dev->devt));
-	put_device(dev);
  ida_err:
+	put_device(dev);
 	idxd_cdev->dev = NULL;
 	return rc;
 }
@@ -296,18 +289,24 @@ static void idxd_wq_cdev_cleanup(struct idxd_wq *wq,
 {
 	struct idxd_cdev *idxd_cdev = &wq->idxd_cdev;
 	struct idxd_cdev_context *cdev_ctx;
+	struct device *dev;
+	int minor;
 
 	cdev_ctx = &ictx[wq->idxd->type];
-	if (cdev_state == CDEV_NORMAL)
-		cdev_del(&idxd_cdev->cdev);
-	device_unregister(idxd_cdev->dev);
+	minor = idxd_cdev->minor;
+	dev = idxd_cdev->dev;
+	if (cdev_state == CDEV_NORMAL) {
+		cdev_device_del(&idxd_cdev->cdev, dev);
+		put_device(dev);
+	} else {
+		device_unregister(dev);
+	}
+
 	/*
 	 * The device_type->release() will be called on the device and free
 	 * the allocated struct device. We can just forget it.
 	 */
-	ida_simple_remove(&cdev_ctx->minor_ida, idxd_cdev->minor);
-	idxd_cdev->dev = NULL;
-	idxd_cdev->minor = -1;
+	ida_simple_remove(&cdev_ctx->minor_ida, minor);
 }
 
 int idxd_wq_add_cdev(struct idxd_wq *wq)
@@ -323,8 +322,7 @@ int idxd_wq_add_cdev(struct idxd_wq *wq)
 
 	dev = idxd_cdev->dev;
 	cdev_init(cdev, &idxd_cdev_fops);
-	cdev_set_parent(cdev, &dev->kobj);
-	rc = cdev_add(cdev, dev->devt, 1);
+	rc = cdev_device_add(cdev, dev);
 	if (rc) {
 		dev_dbg(&wq->idxd->pdev->dev, "cdev_add failed: %d\n", rc);
 		idxd_wq_cdev_cleanup(wq, CDEV_FAILED);
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 84a6ea60ecf0..ef2816e930c9 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -19,7 +19,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 /* Interrupt control bits */
 void idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id)
 {
-	struct irq_data *data = irq_get_irq_data(idxd->msix_entries[vec_id].vector);
+	struct irq_data *data = irq_get_irq_data(idxd->irq_entries[vec_id].vector);
 
 	pci_msi_mask_irq(data);
 }
@@ -36,7 +36,7 @@ void idxd_mask_msix_vectors(struct idxd_device *idxd)
 
 void idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id)
 {
-	struct irq_data *data = irq_get_irq_data(idxd->msix_entries[vec_id].vector);
+	struct irq_data *data = irq_get_irq_data(idxd->irq_entries[vec_id].vector);
 
 	pci_msi_unmask_irq(data);
 }
@@ -515,7 +515,7 @@ void idxd_device_wqs_clear_state(struct idxd_device *idxd)
 	lockdep_assert_held(&idxd->dev_lock);
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		if (wq->state == IDXD_WQ_ENABLED) {
 			idxd_wq_disable_cleanup(wq);
@@ -624,7 +624,7 @@ static int idxd_groups_config_write(struct idxd_device *idxd)
 		ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET));
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *group = &idxd->groups[i];
+		struct idxd_group *group = idxd->groups[i];
 
 		idxd_group_config_write(group);
 	}
@@ -696,7 +696,7 @@ static int idxd_wqs_config_write(struct idxd_device *idxd)
 	int i, rc;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		rc = idxd_wq_config_write(wq);
 		if (rc < 0)
@@ -712,7 +712,7 @@ static void idxd_group_flags_setup(struct idxd_device *idxd)
 
 	/* TC-A 0 and TC-B 1 should be defaults */
 	for (i = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *group = &idxd->groups[i];
+		struct idxd_group *group = idxd->groups[i];
 
 		if (group->tc_a == -1)
 			group->tc_a = group->grpcfg.flags.tc_a = 0;
@@ -739,12 +739,12 @@ static int idxd_engines_setup(struct idxd_device *idxd)
 	struct idxd_group *group;
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		group = &idxd->groups[i];
+		group = idxd->groups[i];
 		group->grpcfg.engines = 0;
 	}
 
 	for (i = 0; i < idxd->max_engines; i++) {
-		eng = &idxd->engines[i];
+		eng = idxd->engines[i];
 		group = eng->group;
 
 		if (!group)
@@ -768,13 +768,13 @@ static int idxd_wqs_setup(struct idxd_device *idxd)
 	struct device *dev = &idxd->pdev->dev;
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		group = &idxd->groups[i];
+		group = idxd->groups[i];
 		for (j = 0; j < 4; j++)
 			group->grpcfg.wqs[j] = 0;
 	}
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		wq = &idxd->wqs[i];
+		wq = idxd->wqs[i];
 		group = wq->group;
 
 		if (!wq->group)
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index a15e50126434..dd834764852c 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -156,11 +156,15 @@ dma_cookie_t idxd_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 
 static void idxd_dma_release(struct dma_device *device)
 {
+	struct idxd_device *idxd = container_of(device, struct idxd_device, dma_dev);
+
+	put_device(&idxd->conf_dev);
 }
 
 int idxd_register_dma_device(struct idxd_device *idxd)
 {
 	struct dma_device *dma = &idxd->dma_dev;
+	int rc;
 
 	INIT_LIST_HEAD(&dma->channels);
 	dma->dev = &idxd->pdev->dev;
@@ -178,8 +182,15 @@ int idxd_register_dma_device(struct idxd_device *idxd)
 	dma->device_issue_pending = idxd_dma_issue_pending;
 	dma->device_alloc_chan_resources = idxd_dma_alloc_chan_resources;
 	dma->device_free_chan_resources = idxd_dma_free_chan_resources;
+	get_device(&idxd->conf_dev);
 
-	return dma_async_device_register(&idxd->dma_dev);
+	rc = dma_async_device_register(&idxd->dma_dev);
+	if (rc < 0) {
+		put_device(&idxd->conf_dev);
+		return rc;
+	}
+
+	return 0;
 }
 
 void idxd_unregister_dma_device(struct idxd_device *idxd)
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 81a0e65fd316..bb6168c09910 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -33,6 +33,7 @@ struct idxd_device_driver {
 struct idxd_irq_entry {
 	struct idxd_device *idxd;
 	int id;
+	int vector;
 	struct llist_head pending_llist;
 	struct list_head work_list;
 	/*
@@ -178,9 +179,9 @@ struct idxd_device {
 
 	spinlock_t dev_lock;	/* spinlock for device */
 	struct completion *cmd_done;
-	struct idxd_group *groups;
-	struct idxd_wq *wqs;
-	struct idxd_engine *engines;
+	struct idxd_group **groups;
+	struct idxd_wq **wqs;
+	struct idxd_engine **engines;
 
 	struct iommu_sva *sva;
 	unsigned int pasid;
@@ -206,7 +207,6 @@ struct idxd_device {
 
 	union sw_err_reg sw_err;
 	wait_queue_head_t cmd_waitq;
-	struct msix_entry *msix_entries;
 	int num_wq_irqs;
 	struct idxd_irq_entry *irq_entries;
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 085a0c3b62c6..e13d4d31c288 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -61,7 +61,6 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 {
 	struct pci_dev *pdev = idxd->pdev;
 	struct device *dev = &pdev->dev;
-	struct msix_entry *msix;
 	struct idxd_irq_entry *irq_entry;
 	int i, msixcnt;
 	int rc = 0;
@@ -70,23 +69,13 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 	msixcnt = pci_msix_vec_count(pdev);
 	if (msixcnt < 0) {
 		dev_err(dev, "Not MSI-X interrupt capable.\n");
-		goto err_no_irq;
+		return -ENXIO;
 	}
 
-	idxd->msix_entries = devm_kzalloc(dev, sizeof(struct msix_entry) *
-			msixcnt, GFP_KERNEL);
-	if (!idxd->msix_entries) {
-		rc = -ENOMEM;
-		goto err_no_irq;
-	}
-
-	for (i = 0; i < msixcnt; i++)
-		idxd->msix_entries[i].entry = i;
-
-	rc = pci_enable_msix_exact(pdev, idxd->msix_entries, msixcnt);
-	if (rc) {
-		dev_err(dev, "Failed enabling %d MSIX entries.\n", msixcnt);
-		goto err_no_irq;
+	rc = pci_alloc_irq_vectors(pdev, msixcnt, msixcnt, PCI_IRQ_MSIX);
+	if (rc != msixcnt) {
+		dev_err(dev, "Failed enabling %d MSIX entries: %d\n", msixcnt, rc);
+		return -ENOSPC;
 	}
 	dev_dbg(dev, "Enabled %d msix vectors\n", msixcnt);
 
@@ -94,53 +83,48 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 	 * We implement 1 completion list per MSI-X entry except for
 	 * entry 0, which is for errors and others.
 	 */
-	idxd->irq_entries = devm_kcalloc(dev, msixcnt,
-					 sizeof(struct idxd_irq_entry),
-					 GFP_KERNEL);
+	idxd->irq_entries = kcalloc_node(msixcnt, sizeof(struct idxd_irq_entry),
+					 GFP_KERNEL, dev_to_node(dev));
 	if (!idxd->irq_entries) {
 		rc = -ENOMEM;
-		goto err_no_irq;
+		goto err_ie_alloc;
 	}
 
 	for (i = 0; i < msixcnt; i++) {
 		idxd->irq_entries[i].id = i;
 		idxd->irq_entries[i].idxd = idxd;
+		idxd->irq_entries[i].vector = pci_irq_vector(pdev, i);
 		spin_lock_init(&idxd->irq_entries[i].list_lock);
 	}
 
-	msix = &idxd->msix_entries[0];
 	irq_entry = &idxd->irq_entries[0];
-	rc = devm_request_threaded_irq(dev, msix->vector, idxd_irq_handler,
-				       idxd_misc_thread, 0, "idxd-misc",
-				       irq_entry);
+	rc = request_threaded_irq(irq_entry->vector, idxd_irq_handler, idxd_misc_thread,
+				  0, "idxd-misc", irq_entry);
 	if (rc < 0) {
 		dev_err(dev, "Failed to allocate misc interrupt.\n");
-		goto err_no_irq;
+		goto err_misc_irq;
 	}
 
 	dev_dbg(dev, "Allocated idxd-misc handler on msix vector %d\n",
-		msix->vector);
+		irq_entry->vector);
 
 	/* first MSI-X entry is not for wq interrupts */
 	idxd->num_wq_irqs = msixcnt - 1;
 
 	for (i = 1; i < msixcnt; i++) {
-		msix = &idxd->msix_entries[i];
 		irq_entry = &idxd->irq_entries[i];
 
 		init_llist_head(&idxd->irq_entries[i].pending_llist);
 		INIT_LIST_HEAD(&idxd->irq_entries[i].work_list);
-		rc = devm_request_threaded_irq(dev, msix->vector,
-					       idxd_irq_handler,
-					       idxd_wq_thread, 0,
-					       "idxd-portal", irq_entry);
+		rc = request_threaded_irq(irq_entry->vector, idxd_irq_handler,
+					  idxd_wq_thread, 0, "idxd-portal", irq_entry);
 		if (rc < 0) {
 			dev_err(dev, "Failed to allocate irq %d.\n",
-				msix->vector);
-			goto err_no_irq;
+				irq_entry->vector);
+			goto err_wq_irqs;
 		}
 		dev_dbg(dev, "Allocated idxd-msix %d for vector %d\n",
-			i, msix->vector);
+			i, irq_entry->vector);
 	}
 
 	idxd_unmask_error_interrupts(idxd);
@@ -154,44 +138,137 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 
 	return 0;
 
- err_no_irq:
-	/* Disable error interrupt generation */
-	idxd_mask_error_interrupts(idxd);
-	pci_disable_msix(pdev);
+ err_wq_irqs:
+	while (--i) {
+		irq_entry = &idxd->irq_entries[i];
+		free_irq(irq_entry->vector, irq_entry);
+	}
+ err_misc_irq:
+	kfree(idxd->irq_entries);
+ err_ie_alloc:
+	pci_free_irq_vectors(pdev);
 	dev_err(dev, "No usable interrupts\n");
 	return rc;
 }
 
-static int idxd_setup_internals(struct idxd_device *idxd)
+static int idxd_allocate_wqs(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
-	int i;
+	struct idxd_wq *wq;
+	int i, rc;
 
-	init_waitqueue_head(&idxd->cmd_waitq);
-	idxd->groups = devm_kcalloc(dev, idxd->max_groups,
-				    sizeof(struct idxd_group), GFP_KERNEL);
-	if (!idxd->groups)
+	idxd->wqs = kcalloc_node(idxd->max_wqs, sizeof(struct idxd_wq *),
+				 GFP_KERNEL, dev_to_node(dev));
+	if (!idxd->wqs)
 		return -ENOMEM;
 
-	for (i = 0; i < idxd->max_groups; i++) {
-		idxd->groups[i].idxd = idxd;
-		idxd->groups[i].id = i;
-		idxd->groups[i].tc_a = -1;
-		idxd->groups[i].tc_b = -1;
+	for (i = 0; i < idxd->max_wqs; i++) {
+		wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
+		if (!wq) {
+			rc = -ENOMEM;
+			goto err;
+		}
+
+		idxd->wqs[i] = wq;
 	}
 
-	idxd->wqs = devm_kcalloc(dev, idxd->max_wqs, sizeof(struct idxd_wq),
-				 GFP_KERNEL);
-	if (!idxd->wqs)
-		return -ENOMEM;
+	return 0;
+
+ err:
+	while (--i)
+		kfree(idxd->wqs[i]);
+	kfree(idxd->wqs);
+	idxd->wqs = NULL;
+	return rc;
+}
 
-	idxd->engines = devm_kcalloc(dev, idxd->max_engines,
-				     sizeof(struct idxd_engine), GFP_KERNEL);
+static int idxd_allocate_engines(struct idxd_device *idxd)
+{
+	struct idxd_engine *engine;
+	struct device *dev = &idxd->pdev->dev;
+	int i, rc;
+
+	idxd->engines = kcalloc_node(idxd->max_engines, sizeof(struct idxd_engine *),
+				     GFP_KERNEL, dev_to_node(dev));
 	if (!idxd->engines)
 		return -ENOMEM;
 
+	for (i = 0; i < idxd->max_engines; i++) {
+		engine = kzalloc_node(sizeof(*engine), GFP_KERNEL, dev_to_node(dev));
+		if (!engine) {
+			rc = -ENOMEM;
+			goto err;
+		}
+
+		idxd->engines[i] = engine;
+	}
+
+	return 0;
+
+ err:
+	while (--i)
+		kfree(idxd->engines[i]);
+	kfree(idxd->engines);
+	idxd->engines = NULL;
+	return rc;
+}
+
+static int idxd_allocate_groups(struct idxd_device *idxd)
+{
+	struct device *dev = &idxd->pdev->dev;
+	struct idxd_group *group;
+	int i, rc;
+
+	idxd->groups = kcalloc_node(idxd->max_groups, sizeof(struct idxd_group *),
+				    GFP_KERNEL, dev_to_node(dev));
+	if (!idxd->groups)
+		return -ENOMEM;
+
+	for (i = 0; i < idxd->max_groups; i++) {
+		group = kzalloc_node(sizeof(*group), GFP_KERNEL, dev_to_node(dev));
+		if (!group) {
+			rc = -ENOMEM;
+			goto err;
+		}
+
+		idxd->groups[i] = group;
+	}
+
+	return 0;
+
+ err:
+	while (--i)
+		kfree(idxd->groups[i]);
+	kfree(idxd->groups);
+	idxd->groups = NULL;
+	return rc;
+}
+
+static int idxd_setup_internals(struct idxd_device *idxd)
+{
+	struct device *dev = &idxd->pdev->dev;
+	int i, rc;
+
+	init_waitqueue_head(&idxd->cmd_waitq);
+	rc = idxd_allocate_groups(idxd);
+	if (rc < 0)
+		return rc;
+
+	for (i = 0; i < idxd->max_groups; i++) {
+		struct idxd_group *group = idxd->groups[i];
+
+		group->idxd = idxd;
+		group->id = i;
+		group->tc_a = -1;
+		group->tc_b = -1;
+	}
+
+	rc = idxd_allocate_wqs(idxd);
+	if (rc < 0)
+		return rc;
+
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		wq->id = i;
 		wq->idxd = idxd;
@@ -199,14 +276,20 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 		wq->idxd_cdev.minor = -1;
 		wq->max_xfer_bytes = idxd->max_xfer_bytes;
 		wq->max_batch_size = idxd->max_batch_size;
-		wq->wqcfg = devm_kzalloc(dev, idxd->wqcfg_size, GFP_KERNEL);
+		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg)
 			return -ENOMEM;
 	}
 
+	rc = idxd_allocate_engines(idxd);
+	if (rc < 0)
+		return rc;
+
 	for (i = 0; i < idxd->max_engines; i++) {
-		idxd->engines[i].idxd = idxd;
-		idxd->engines[i].id = i;
+		struct idxd_engine *engine = idxd->engines[i];
+
+		engine->idxd = idxd;
+		engine->id = i;
 	}
 
 	idxd->wq = create_workqueue(dev_name(dev));
@@ -288,7 +371,7 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev)
 	struct device *dev = &pdev->dev;
 	struct idxd_device *idxd;
 
-	idxd = devm_kzalloc(dev, sizeof(struct idxd_device), GFP_KERNEL);
+	idxd = kzalloc_node(sizeof(*idxd), GFP_KERNEL, dev_to_node(dev));
 	if (!idxd)
 		return NULL;
 
@@ -398,6 +481,33 @@ static void idxd_type_init(struct idxd_device *idxd)
 		idxd->compl_size = sizeof(struct iax_completion_record);
 }
 
+static void idxd_free(struct idxd_device *idxd)
+{
+	int i;
+
+	if (idxd->wqs) {
+		for (i = 0; i < idxd->max_wqs; i++) {
+			kfree(idxd->wqs[i]->wqcfg);
+			kfree(idxd->wqs[i]);
+		}
+		kfree(idxd->wqs);
+	}
+
+	if (idxd->engines) {
+		for (i = 0; i < idxd->max_engines; i++)
+			kfree(idxd->engines[i]);
+		kfree(idxd->engines);
+	}
+
+	if (idxd->groups) {
+		for (i = 0; i < idxd->max_groups; i++)
+			kfree(idxd->groups[i]);
+		kfree(idxd->groups);
+	}
+
+	kfree(idxd);
+}
+
 static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
@@ -415,21 +525,23 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_dbg(dev, "Mapping BARs\n");
 	idxd->reg_base = pcim_iomap(pdev, IDXD_MMIO_BAR, 0);
-	if (!idxd->reg_base)
-		return -ENOMEM;
+	if (!idxd->reg_base) {
+		rc = -ENOMEM;
+		goto err;
+	}
 
 	dev_dbg(dev, "Set DMA masks\n");
 	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
 	if (rc)
 		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
 	if (rc)
-		return rc;
+		goto err;
 
 	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
 	if (rc)
 		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
 	if (rc)
-		return rc;
+		goto err;
 
 	idxd_set_type(idxd);
 
@@ -443,13 +555,15 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rc = idxd_probe(idxd);
 	if (rc) {
 		dev_err(dev, "Intel(R) IDXD DMA Engine init failed\n");
-		return -ENODEV;
+		rc = -ENODEV;
+		goto err;
 	}
 
 	rc = idxd_setup_sysfs(idxd);
 	if (rc) {
 		dev_err(dev, "IDXD sysfs setup failed\n");
-		return -ENODEV;
+		rc = -ENODEV;
+		goto err;
 	}
 
 	idxd->state = IDXD_DEV_CONF_READY;
@@ -458,6 +572,10 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		 idxd->hw.version);
 
 	return 0;
+
+ err:
+	idxd_free(idxd);
+	return rc;
 }
 
 static void idxd_flush_pending_llist(struct idxd_irq_entry *ie)
@@ -503,28 +621,33 @@ static void idxd_shutdown(struct pci_dev *pdev)
 
 	for (i = 0; i < msixcnt; i++) {
 		irq_entry = &idxd->irq_entries[i];
-		synchronize_irq(idxd->msix_entries[i].vector);
+		free_irq(irq_entry->vector, irq_entry);
 		if (i == 0)
 			continue;
 		idxd_flush_pending_llist(irq_entry);
 		idxd_flush_work_list(irq_entry);
 	}
 
+	pci_free_irq_vectors(pdev);
 	destroy_workqueue(idxd->wq);
 }
 
 static void idxd_remove(struct pci_dev *pdev)
 {
 	struct idxd_device *idxd = pci_get_drvdata(pdev);
+	int id = idxd->id;
+	enum idxd_type type = idxd->type;
 
 	dev_dbg(&pdev->dev, "%s called\n", __func__);
-	idxd_cleanup_sysfs(idxd);
 	idxd_shutdown(pdev);
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
+	idxd_cleanup_sysfs(idxd);
 	mutex_lock(&idxd_idr_lock);
-	idr_remove(&idxd_idrs[idxd->type], idxd->id);
+	idr_remove(&idxd_idrs[type], id);
 	mutex_unlock(&idxd_idr_lock);
+	/* Release to free everything */
+	put_device(&idxd->conf_dev);
 }
 
 static struct pci_driver idxd_pci_driver = {
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index f1463fc58112..7b0181532f77 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -45,7 +45,7 @@ static void idxd_device_reinit(struct work_struct *work)
 		goto out;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		if (wq->state == IDXD_WQ_ENABLED) {
 			rc = idxd_wq_enable(wq);
@@ -130,7 +130,7 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 
 		if (idxd->sw_err.valid && idxd->sw_err.wq_idx_valid) {
 			int id = idxd->sw_err.wq_idx;
-			struct idxd_wq *wq = &idxd->wqs[id];
+			struct idxd_wq *wq = idxd->wqs[id];
 
 			if (wq->type == IDXD_WQT_USER)
 				wake_up_interruptible(&wq->idxd_cdev.err_queue);
@@ -138,7 +138,7 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 			int i;
 
 			for (i = 0; i < idxd->max_wqs; i++) {
-				struct idxd_wq *wq = &idxd->wqs[i];
+				struct idxd_wq *wq = idxd->wqs[i];
 
 				if (wq->type == IDXD_WQT_USER)
 					wake_up_interruptible(&wq->idxd_cdev.err_queue);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 4dbb03c545e4..e978d1e27cf3 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -16,26 +16,54 @@ static char *idxd_wq_type_names[] = {
 	[IDXD_WQT_USER]		= "user",
 };
 
-static void idxd_conf_device_release(struct device *dev)
+static void idxd_conf_group_release(struct device *dev)
 {
-	dev_dbg(dev, "%s for %s\n", __func__, dev_name(dev));
+	struct idxd_group *group = container_of(dev, struct idxd_group, conf_dev);
+
+	kfree(group);
 }
 
 static struct device_type idxd_group_device_type = {
 	.name = "group",
-	.release = idxd_conf_device_release,
+	.release = idxd_conf_group_release,
 };
 
+static void idxd_conf_wq_release(struct device *dev)
+{
+	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+
+	kfree(wq->wqcfg);
+	kfree(wq);
+}
+
 static struct device_type idxd_wq_device_type = {
 	.name = "wq",
-	.release = idxd_conf_device_release,
+	.release = idxd_conf_wq_release,
 };
 
+static void idxd_conf_engine_release(struct device *dev)
+{
+	struct idxd_engine *engine = container_of(dev, struct idxd_engine, conf_dev);
+
+	kfree(engine);
+}
+
 static struct device_type idxd_engine_device_type = {
 	.name = "engine",
-	.release = idxd_conf_device_release,
+	.release = idxd_conf_engine_release,
 };
 
+static void idxd_conf_device_release(struct device *dev)
+{
+	struct idxd_device *idxd = container_of(dev, struct idxd_device, conf_dev);
+
+	kfree(idxd->groups);
+	kfree(idxd->wqs);
+	kfree(idxd->engines);
+	kfree(idxd->irq_entries);
+	kfree(idxd);
+}
+
 static struct device_type dsa_device_type = {
 	.name = "dsa",
 	.release = idxd_conf_device_release,
@@ -327,7 +355,7 @@ static int idxd_config_bus_remove(struct device *dev)
 		dev_dbg(dev, "%s removing dev %s\n", __func__,
 			dev_name(&idxd->conf_dev));
 		for (i = 0; i < idxd->max_wqs; i++) {
-			struct idxd_wq *wq = &idxd->wqs[i];
+			struct idxd_wq *wq = idxd->wqs[i];
 
 			if (wq->state == IDXD_WQ_DISABLED)
 				continue;
@@ -339,7 +367,7 @@ static int idxd_config_bus_remove(struct device *dev)
 		idxd_unregister_dma_device(idxd);
 		rc = idxd_device_disable(idxd);
 		for (i = 0; i < idxd->max_wqs; i++) {
-			struct idxd_wq *wq = &idxd->wqs[i];
+			struct idxd_wq *wq = idxd->wqs[i];
 
 			mutex_lock(&wq->wq_lock);
 			idxd_wq_disable_cleanup(wq);
@@ -493,7 +521,7 @@ static ssize_t engine_group_id_store(struct device *dev,
 
 	if (prevg)
 		prevg->num_engines--;
-	engine->group = &idxd->groups[id];
+	engine->group = idxd->groups[id];
 	engine->group->num_engines++;
 
 	return count;
@@ -524,7 +552,7 @@ static void idxd_set_free_tokens(struct idxd_device *idxd)
 	int i, tokens;
 
 	for (i = 0, tokens = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *g = &idxd->groups[i];
+		struct idxd_group *g = idxd->groups[i];
 
 		tokens += g->tokens_reserved;
 	}
@@ -679,7 +707,7 @@ static ssize_t group_engines_show(struct device *dev,
 	struct idxd_device *idxd = group->idxd;
 
 	for (i = 0; i < idxd->max_engines; i++) {
-		struct idxd_engine *engine = &idxd->engines[i];
+		struct idxd_engine *engine = idxd->engines[i];
 
 		if (!engine->group)
 			continue;
@@ -708,7 +736,7 @@ static ssize_t group_work_queues_show(struct device *dev,
 	struct idxd_device *idxd = group->idxd;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		if (!wq->group)
 			continue;
@@ -901,7 +929,7 @@ static ssize_t wq_group_id_store(struct device *dev,
 		return count;
 	}
 
-	group = &idxd->groups[id];
+	group = idxd->groups[id];
 	prevg = wq->group;
 
 	if (prevg)
@@ -965,7 +993,7 @@ static int total_claimed_wq_size(struct idxd_device *idxd)
 	int wq_size = 0;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		wq_size += wq->size;
 	}
@@ -1485,7 +1513,7 @@ static ssize_t clients_show(struct device *dev,
 
 	spin_lock_irqsave(&idxd->dev_lock, flags);
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		count += wq->client_count;
 	}
@@ -1649,7 +1677,7 @@ static int idxd_setup_engine_sysfs(struct idxd_device *idxd)
 	int i, rc;
 
 	for (i = 0; i < idxd->max_engines; i++) {
-		struct idxd_engine *engine = &idxd->engines[i];
+		struct idxd_engine *engine = idxd->engines[i];
 
 		engine->conf_dev.parent = &idxd->conf_dev;
 		dev_set_name(&engine->conf_dev, "engine%d.%d",
@@ -1670,7 +1698,7 @@ static int idxd_setup_engine_sysfs(struct idxd_device *idxd)
 
 cleanup:
 	while (i--) {
-		struct idxd_engine *engine = &idxd->engines[i];
+		struct idxd_engine *engine = idxd->engines[i];
 
 		device_unregister(&engine->conf_dev);
 	}
@@ -1683,7 +1711,7 @@ static int idxd_setup_group_sysfs(struct idxd_device *idxd)
 	int i, rc;
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *group = &idxd->groups[i];
+		struct idxd_group *group = idxd->groups[i];
 
 		group->conf_dev.parent = &idxd->conf_dev;
 		dev_set_name(&group->conf_dev, "group%d.%d",
@@ -1704,7 +1732,7 @@ static int idxd_setup_group_sysfs(struct idxd_device *idxd)
 
 cleanup:
 	while (i--) {
-		struct idxd_group *group = &idxd->groups[i];
+		struct idxd_group *group = idxd->groups[i];
 
 		device_unregister(&group->conf_dev);
 	}
@@ -1717,7 +1745,7 @@ static int idxd_setup_wq_sysfs(struct idxd_device *idxd)
 	int i, rc;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		wq->conf_dev.parent = &idxd->conf_dev;
 		dev_set_name(&wq->conf_dev, "wq%d.%d", idxd->id, wq->id);
@@ -1737,7 +1765,7 @@ static int idxd_setup_wq_sysfs(struct idxd_device *idxd)
 
 cleanup:
 	while (i--) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		device_unregister(&wq->conf_dev);
 	}
@@ -1764,6 +1792,9 @@ static int idxd_setup_device_sysfs(struct idxd_device *idxd)
 		return rc;
 	}
 
+	/* Hold a kref for cleanup */
+	get_device(&idxd->conf_dev);
+
 	return 0;
 }
 
@@ -1807,19 +1838,19 @@ void idxd_cleanup_sysfs(struct idxd_device *idxd)
 	int i;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		device_unregister(&wq->conf_dev);
 	}
 
 	for (i = 0; i < idxd->max_engines; i++) {
-		struct idxd_engine *engine = &idxd->engines[i];
+		struct idxd_engine *engine = idxd->engines[i];
 
 		device_unregister(&engine->conf_dev);
 	}
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *group = &idxd->groups[i];
+		struct idxd_group *group = idxd->groups[i];
 
 		device_unregister(&group->conf_dev);
 	}


