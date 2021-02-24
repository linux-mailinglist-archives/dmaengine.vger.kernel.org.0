Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4673246F0
	for <lists+dmaengine@lfdr.de>; Wed, 24 Feb 2021 23:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbhBXWgF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Feb 2021 17:36:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:57330 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235409AbhBXWgD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Feb 2021 17:36:03 -0500
IronPort-SDR: ecWIrtAM/vryAwsgfmCB5OOOlMVBei5WzkOZEJc2o/L1OzuNEZM6awrOSiXGKbINvf9LMJ8SUT
 mANbP835nmfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="246744280"
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="246744280"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 14:35:20 -0800
IronPort-SDR: xAGeV3eQgftIyrHgtEZDMq5LZoV0ghEnNE7eoOaWT9n0CW0iW/ka5tDN6jy/9mbKFfOWuW00K5
 +ZjUp27Qubhg==
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="365177387"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 14:35:19 -0800
Subject: [PATCH v3] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Date:   Wed, 24 Feb 2021 15:35:19 -0700
Message-ID: <161420602220.1987219.16867019403434743794.stgit@djiang5-desk3.ch.intel.com>
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

Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
v3:
- Remove devm_* for irq request and cleanup related bits (Jason)
v2:
- Remove all devm_* alloc for idxd_device (Jason)
- Add kref dep for dma_dev (Jason)

 drivers/dma/idxd/device.c |   28 ++---
 drivers/dma/idxd/dma.c    |   13 ++
 drivers/dma/idxd/idxd.h   |    8 +
 drivers/dma/idxd/init.c   |  276 +++++++++++++++++++++++++++++++++------------
 drivers/dma/idxd/irq.c    |    6 -
 drivers/dma/idxd/sysfs.c  |   78 +++++++++----
 6 files changed, 290 insertions(+), 119 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 205156afeb54..292418d69b2d 100644
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
@@ -541,7 +541,7 @@ void idxd_device_wqs_clear_state(struct idxd_device *idxd)
 	lockdep_assert_held(&idxd->dev_lock);
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		if (wq->state == IDXD_WQ_ENABLED) {
 			idxd_wq_disable_cleanup(wq);
@@ -721,7 +721,7 @@ static int idxd_groups_config_write(struct idxd_device *idxd)
 		ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET));
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *group = &idxd->groups[i];
+		struct idxd_group *group = idxd->groups[i];
 
 		idxd_group_config_write(group);
 	}
@@ -793,7 +793,7 @@ static int idxd_wqs_config_write(struct idxd_device *idxd)
 	int i, rc;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		rc = idxd_wq_config_write(wq);
 		if (rc < 0)
@@ -809,7 +809,7 @@ static void idxd_group_flags_setup(struct idxd_device *idxd)
 
 	/* TC-A 0 and TC-B 1 should be defaults */
 	for (i = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *group = &idxd->groups[i];
+		struct idxd_group *group = idxd->groups[i];
 
 		if (group->tc_a == -1)
 			group->tc_a = group->grpcfg.flags.tc_a = 0;
@@ -836,12 +836,12 @@ static int idxd_engines_setup(struct idxd_device *idxd)
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
@@ -865,13 +865,13 @@ static int idxd_wqs_setup(struct idxd_device *idxd)
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
@@ -982,7 +982,7 @@ static void idxd_group_load_config(struct idxd_group *group)
 
 			/* Set group assignment for wq if wq bit is set */
 			if (group->grpcfg.wqs[i] & BIT(j)) {
-				wq = &idxd->wqs[id];
+				wq = idxd->wqs[id];
 				wq->group = group;
 			}
 		}
@@ -999,7 +999,7 @@ static void idxd_group_load_config(struct idxd_group *group)
 			break;
 
 		if (group->grpcfg.engines & BIT(i)) {
-			struct idxd_engine *engine = &idxd->engines[i];
+			struct idxd_engine *engine = idxd->engines[i];
 
 			engine->group = group;
 		}
@@ -1020,13 +1020,13 @@ int idxd_device_load_config(struct idxd_device *idxd)
 	idxd->token_limit = reg.token_limit;
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *group = &idxd->groups[i];
+		struct idxd_group *group = idxd->groups[i];
 
 		idxd_group_load_config(group);
 	}
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		rc = idxd_wq_load_config(wq);
 		if (rc < 0)
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
index a9386a66ab72..e90dbd664ec9 100644
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
@@ -181,9 +182,9 @@ struct idxd_device {
 
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
@@ -209,7 +210,6 @@ struct idxd_device {
 
 	union sw_err_reg sw_err;
 	wait_queue_head_t cmd_waitq;
-	struct msix_entry *msix_entries;
 	int num_wq_irqs;
 	struct idxd_irq_entry *irq_entries;
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 0bd7b33b436a..fc1db42873b4 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -61,32 +61,21 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 {
 	struct pci_dev *pdev = idxd->pdev;
 	struct device *dev = &pdev->dev;
-	struct msix_entry *msix;
 	struct idxd_irq_entry *irq_entry;
-	int i, msixcnt;
+	int i, j, msixcnt;
 	int rc = 0;
 	union msix_perm mperm;
 
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
 
 		if (idxd->hw.cmd_cap & BIT(IDXD_CMD_REQUEST_INT_HANDLE)) {
 			/*
@@ -154,7 +138,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 			rc = idxd_device_request_int_handle(idxd, i, &idxd->int_handles[i - 1],
 							    IDXD_IRQ_MSIX);
 			if (rc < 0)
-				goto err_no_irq;
+				goto err_irq_handle;
 			dev_dbg(dev, "int handle requested: %u\n", idxd->int_handles[i - 1]);
 		}
 	}
@@ -170,51 +154,148 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 
 	return 0;
 
- err_no_irq:
-	/* Disable error interrupt generation */
-	idxd_mask_error_interrupts(idxd);
-	pci_disable_msix(pdev);
+ err_irq_handle:
+	for (j = 1; j < i - 1; j++)
+		idxd_device_release_int_handle(idxd, idxd->int_handles[j - 1], IDXD_IRQ_MSIX);
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
 
+static int idxd_allocate_wqs(struct idxd_device *idxd)
+{
+	struct device *dev = &idxd->pdev->dev;
+	struct idxd_wq *wq;
+	int i, rc;
+
+	idxd->wqs = kcalloc_node(idxd->max_wqs, sizeof(struct idxd_wq *),
+				 GFP_KERNEL, dev_to_node(dev));
+	if (!idxd->wqs)
+		return -ENOMEM;
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
+		if (!wq) {
+			rc = -ENOMEM;
+			goto err;
+		}
+
+		idxd->wqs[i] = wq;
+	}
+
+	return 0;
+
+ err:
+	while (--i)
+		kfree(idxd->wqs[i]);
+	kfree(idxd->wqs);
+	idxd->wqs = NULL;
+	return rc;
+}
+
+static int idxd_allocate_engines(struct idxd_device *idxd)
+{
+	struct idxd_engine *engine;
+	struct device *dev = &idxd->pdev->dev;
+	int i, rc;
+
+	idxd->engines = kcalloc_node(idxd->max_engines, sizeof(struct idxd_engine *),
+				     GFP_KERNEL, dev_to_node(dev));
+	if (!idxd->engines)
+		return -ENOMEM;
+
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
 static int idxd_setup_internals(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
-	int i;
+	int i, rc;
 
 	init_waitqueue_head(&idxd->cmd_waitq);
 
 	if (idxd->hw.cmd_cap & BIT(IDXD_CMD_REQUEST_INT_HANDLE)) {
-		idxd->int_handles = devm_kcalloc(dev, idxd->max_wqs, sizeof(int), GFP_KERNEL);
+		idxd->int_handles = kcalloc_node(idxd->max_wqs, sizeof(int), GFP_KERNEL,
+						 dev_to_node(dev));
 		if (!idxd->int_handles)
 			return -ENOMEM;
 	}
 
-	idxd->groups = devm_kcalloc(dev, idxd->max_groups,
-				    sizeof(struct idxd_group), GFP_KERNEL);
-	if (!idxd->groups)
-		return -ENOMEM;
+	rc = idxd_allocate_groups(idxd);
+	if (rc < 0)
+		return rc;
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		idxd->groups[i].idxd = idxd;
-		idxd->groups[i].id = i;
-		idxd->groups[i].tc_a = -1;
-		idxd->groups[i].tc_b = -1;
-	}
+		struct idxd_group *group = idxd->groups[i];
 
-	idxd->wqs = devm_kcalloc(dev, idxd->max_wqs, sizeof(struct idxd_wq),
-				 GFP_KERNEL);
-	if (!idxd->wqs)
-		return -ENOMEM;
+		group->idxd = idxd;
+		group->id = i;
+		group->tc_a = -1;
+		group->tc_b = -1;
+	}
 
-	idxd->engines = devm_kcalloc(dev, idxd->max_engines,
-				     sizeof(struct idxd_engine), GFP_KERNEL);
-	if (!idxd->engines)
-		return -ENOMEM;
+	rc = idxd_allocate_wqs(idxd);
+	if (rc < 0)
+		return rc;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		wq->id = i;
 		wq->idxd = idxd;
@@ -222,15 +303,21 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 		wq->idxd_cdev.minor = -1;
 		wq->max_xfer_bytes = idxd->max_xfer_bytes;
 		wq->max_batch_size = idxd->max_batch_size;
-		wq->wqcfg = devm_kzalloc(dev, idxd->wqcfg_size, GFP_KERNEL);
+		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg)
 			return -ENOMEM;
 		init_completion(&wq->wq_dead);
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
@@ -318,7 +405,7 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev)
 	struct device *dev = &pdev->dev;
 	struct idxd_device *idxd;
 
-	idxd = devm_kzalloc(dev, sizeof(struct idxd_device), GFP_KERNEL);
+	idxd = kzalloc_node(sizeof(*idxd), GFP_KERNEL, dev_to_node(dev));
 	if (!idxd)
 		return NULL;
 
@@ -436,6 +523,34 @@ static void idxd_type_init(struct idxd_device *idxd)
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
+	kfree(idxd->int_handles);
+	kfree(idxd);
+}
+
 static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
@@ -453,21 +568,23 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
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
 
@@ -481,13 +598,15 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -496,6 +615,10 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		 idxd->hw.version);
 
 	return 0;
+
+ err:
+	idxd_free(idxd);
+	return rc;
 }
 
 static void idxd_flush_pending_llist(struct idxd_irq_entry *ie)
@@ -530,7 +653,7 @@ static void idxd_wqs_quiesce(struct idxd_device *idxd)
 	int i;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		wq = &idxd->wqs[i];
+		wq = idxd->wqs[i];
 		if (wq->state == IDXD_WQ_ENABLED && wq->type == IDXD_WQT_KERNEL)
 			idxd_wq_quiesce(wq);
 	}
@@ -572,13 +695,14 @@ static void idxd_shutdown(struct pci_dev *pdev)
 
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
 	idxd_release_int_handles(idxd);
 	destroy_workqueue(idxd->wq);
 }
@@ -586,15 +710,19 @@ static void idxd_shutdown(struct pci_dev *pdev)
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
index 6bf27529464c..d99a78e74447 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -16,26 +16,55 @@ static char *idxd_wq_type_names[] = {
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
+	kfree(idxd->int_handles);
+	kfree(idxd);
+}
+
 static struct device_type dsa_device_type = {
 	.name = "dsa",
 	.release = idxd_conf_device_release,
@@ -346,7 +375,7 @@ static int idxd_config_bus_remove(struct device *dev)
 		dev_dbg(dev, "%s removing dev %s\n", __func__,
 			dev_name(&idxd->conf_dev));
 		for (i = 0; i < idxd->max_wqs; i++) {
-			struct idxd_wq *wq = &idxd->wqs[i];
+			struct idxd_wq *wq = idxd->wqs[i];
 
 			if (wq->state == IDXD_WQ_DISABLED)
 				continue;
@@ -359,7 +388,7 @@ static int idxd_config_bus_remove(struct device *dev)
 		rc = idxd_device_disable(idxd);
 		if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
 			for (i = 0; i < idxd->max_wqs; i++) {
-				struct idxd_wq *wq = &idxd->wqs[i];
+				struct idxd_wq *wq = idxd->wqs[i];
 
 				mutex_lock(&wq->wq_lock);
 				idxd_wq_disable_cleanup(wq);
@@ -514,7 +543,7 @@ static ssize_t engine_group_id_store(struct device *dev,
 
 	if (prevg)
 		prevg->num_engines--;
-	engine->group = &idxd->groups[id];
+	engine->group = idxd->groups[id];
 	engine->group->num_engines++;
 
 	return count;
@@ -545,7 +574,7 @@ static void idxd_set_free_tokens(struct idxd_device *idxd)
 	int i, tokens;
 
 	for (i = 0, tokens = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *g = &idxd->groups[i];
+		struct idxd_group *g = idxd->groups[i];
 
 		tokens += g->tokens_reserved;
 	}
@@ -699,7 +728,7 @@ static ssize_t group_engines_show(struct device *dev,
 	struct idxd_device *idxd = group->idxd;
 
 	for (i = 0; i < idxd->max_engines; i++) {
-		struct idxd_engine *engine = &idxd->engines[i];
+		struct idxd_engine *engine = idxd->engines[i];
 
 		if (!engine->group)
 			continue;
@@ -726,7 +755,7 @@ static ssize_t group_work_queues_show(struct device *dev,
 	struct idxd_device *idxd = group->idxd;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		if (!wq->group)
 			continue;
@@ -918,7 +947,7 @@ static ssize_t wq_group_id_store(struct device *dev,
 		return count;
 	}
 
-	group = &idxd->groups[id];
+	group = idxd->groups[id];
 	prevg = wq->group;
 
 	if (prevg)
@@ -981,7 +1010,7 @@ static int total_claimed_wq_size(struct idxd_device *idxd)
 	int wq_size = 0;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		wq_size += wq->size;
 	}
@@ -1496,7 +1525,7 @@ static ssize_t clients_show(struct device *dev,
 
 	spin_lock_irqsave(&idxd->dev_lock, flags);
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		count += wq->client_count;
 	}
@@ -1660,7 +1689,7 @@ static int idxd_setup_engine_sysfs(struct idxd_device *idxd)
 	int i, rc;
 
 	for (i = 0; i < idxd->max_engines; i++) {
-		struct idxd_engine *engine = &idxd->engines[i];
+		struct idxd_engine *engine = idxd->engines[i];
 
 		engine->conf_dev.parent = &idxd->conf_dev;
 		dev_set_name(&engine->conf_dev, "engine%d.%d",
@@ -1681,7 +1710,7 @@ static int idxd_setup_engine_sysfs(struct idxd_device *idxd)
 
 cleanup:
 	while (i--) {
-		struct idxd_engine *engine = &idxd->engines[i];
+		struct idxd_engine *engine = idxd->engines[i];
 
 		device_unregister(&engine->conf_dev);
 	}
@@ -1694,7 +1723,7 @@ static int idxd_setup_group_sysfs(struct idxd_device *idxd)
 	int i, rc;
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		struct idxd_group *group = &idxd->groups[i];
+		struct idxd_group *group = idxd->groups[i];
 
 		group->conf_dev.parent = &idxd->conf_dev;
 		dev_set_name(&group->conf_dev, "group%d.%d",
@@ -1715,7 +1744,7 @@ static int idxd_setup_group_sysfs(struct idxd_device *idxd)
 
 cleanup:
 	while (i--) {
-		struct idxd_group *group = &idxd->groups[i];
+		struct idxd_group *group = idxd->groups[i];
 
 		device_unregister(&group->conf_dev);
 	}
@@ -1728,7 +1757,7 @@ static int idxd_setup_wq_sysfs(struct idxd_device *idxd)
 	int i, rc;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		wq->conf_dev.parent = &idxd->conf_dev;
 		dev_set_name(&wq->conf_dev, "wq%d.%d", idxd->id, wq->id);
@@ -1748,7 +1777,7 @@ static int idxd_setup_wq_sysfs(struct idxd_device *idxd)
 
 cleanup:
 	while (i--) {
-		struct idxd_wq *wq = &idxd->wqs[i];
+		struct idxd_wq *wq = idxd->wqs[i];
 
 		device_unregister(&wq->conf_dev);
 	}
@@ -1775,6 +1804,9 @@ static int idxd_setup_device_sysfs(struct idxd_device *idxd)
 		return rc;
 	}
 
+	/* Hold a kref for cleanup */
+	get_device(&idxd->conf_dev);
+
 	return 0;
 }
 
@@ -1818,19 +1850,19 @@ void idxd_cleanup_sysfs(struct idxd_device *idxd)
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


