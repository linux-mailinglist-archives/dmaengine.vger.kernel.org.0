Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10631353000
	for <lists+dmaengine@lfdr.de>; Fri,  2 Apr 2021 21:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbhDBT5J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Apr 2021 15:57:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:35324 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236256AbhDBT5I (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 2 Apr 2021 15:57:08 -0400
IronPort-SDR: GUD2MtzZm8DSCPuPBNhbP2070ksBpE1Ga880pX5vNs602ihvfdVU4OqUn0BOLGKc65tZLxpA87
 P2hgXWUwwWcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="172561492"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="172561492"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 12:57:06 -0700
IronPort-SDR: CQi3fuWKxKA3acsT3cJ90JRUojYhxa8ippsMhYmVydPW+WPe/EssTe18AVuAh/YRcHbXrvWFBp
 dpP/MrxRYS/Q==
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="378187187"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 12:57:06 -0700
Subject: [PATCH v9 02/11] dmaengine: idxd: cleanup pci interrupt vector
 allocation management
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Date:   Fri, 02 Apr 2021 12:57:05 -0700
Message-ID: <161739342551.2945060.1811938685154786869.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
References: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The devm managed lifetime is incompatible with 'struct device' objects that
resides in idxd context. This is one of the series that clean up the idxd
driver 'struct device' lifetime. Remove devm managed pci interrupt vectors
and replace with unmanged allocators.

Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dma/idxd/device.c |    4 +--
 drivers/dma/idxd/idxd.h   |    2 +
 drivers/dma/idxd/init.c   |   64 +++++++++++++++++++--------------------------
 3 files changed, 30 insertions(+), 40 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 971a10a60093..a56af1d8b091 100644
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
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 40001c46d95c..3409a84b8674 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -36,6 +36,7 @@ struct idxd_device_driver {
 struct idxd_irq_entry {
 	struct idxd_device *idxd;
 	int id;
+	int vector;
 	struct llist_head pending_llist;
 	struct list_head work_list;
 	/*
@@ -219,7 +220,6 @@ struct idxd_device {
 
 	union sw_err_reg sw_err;
 	wait_queue_head_t cmd_waitq;
-	struct msix_entry *msix_entries;
 	int num_wq_irqs;
 	struct idxd_irq_entry *irq_entries;
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 085a0c3b62c6..a7bf5daf6760 100644
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
+		return -ENOSPC;
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
 
@@ -99,48 +88,41 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 					 GFP_KERNEL);
 	if (!idxd->irq_entries) {
 		rc = -ENOMEM;
-		goto err_no_irq;
+		goto err_irq_entries;
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
 
-	dev_dbg(dev, "Allocated idxd-misc handler on msix vector %d\n",
-		msix->vector);
+	dev_dbg(dev, "Allocated idxd-misc handler on msix vector %d\n", irq_entry->vector);
 
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
-			dev_err(dev, "Failed to allocate irq %d.\n",
-				msix->vector);
-			goto err_no_irq;
+			dev_err(dev, "Failed to allocate irq %d.\n", irq_entry->vector);
+			goto err_wq_irqs;
 		}
-		dev_dbg(dev, "Allocated idxd-msix %d for vector %d\n",
-			i, msix->vector);
+		dev_dbg(dev, "Allocated idxd-msix %d for vector %d\n", i, irq_entry->vector);
 	}
 
 	idxd_unmask_error_interrupts(idxd);
@@ -154,10 +136,16 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 
 	return 0;
 
- err_no_irq:
+ err_wq_irqs:
+	while (--i >= 0) {
+		irq_entry = &idxd->irq_entries[i];
+		free_irq(irq_entry->vector, irq_entry);
+	}
+ err_misc_irq:
 	/* Disable error interrupt generation */
 	idxd_mask_error_interrupts(idxd);
-	pci_disable_msix(pdev);
+ err_irq_entries:
+	pci_free_irq_vectors(pdev);
 	dev_err(dev, "No usable interrupts\n");
 	return rc;
 }
@@ -503,13 +491,15 @@ static void idxd_shutdown(struct pci_dev *pdev)
 
 	for (i = 0; i < msixcnt; i++) {
 		irq_entry = &idxd->irq_entries[i];
-		synchronize_irq(idxd->msix_entries[i].vector);
+		synchronize_irq(irq_entry->vector);
+		free_irq(irq_entry->vector, irq_entry);
 		if (i == 0)
 			continue;
 		idxd_flush_pending_llist(irq_entry);
 		idxd_flush_work_list(irq_entry);
 	}
 
+	pci_free_irq_vectors(pdev);
 	destroy_workqueue(idxd->wq);
 }
 


