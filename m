Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B0E390997
	for <lists+dmaengine@lfdr.de>; Tue, 25 May 2021 21:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhEYTZI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 May 2021 15:25:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:24454 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232539AbhEYTZH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 May 2021 15:25:07 -0400
IronPort-SDR: CjachwgkBCjWTMdoGJfBL0iaktTkdZstrf3DJgaqtk7B7a4snmqKyGYgtAJ8utybkC2W+5/f8l
 Zz7RjzBKaMHA==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="181920962"
X-IronPort-AV: E=Sophos;i="5.82,329,1613462400"; 
   d="scan'208";a="181920962"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 12:23:37 -0700
IronPort-SDR: MEjFD8hHyXeWKbeGQLWwPyXVQCDdC6/chKpRCeP0SVcg9yj1+fo1YLscMHfjbEHRZvbdCEhG4Q
 grE/s788KT1g==
X-IronPort-AV: E=Sophos;i="5.82,329,1613462400"; 
   d="scan'208";a="443561539"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 12:23:37 -0700
Subject: [PATCH] dmaengine: idxd: Add missing cleanup for early error out in
 probe call
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Nikhil Rao <nikhil.rao@intel.com>, dmaengine@vger.kernel.org
Date:   Tue, 25 May 2021 12:23:37 -0700
Message-ID: <162197061707.392656.15760573520817310791.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The probe call stack is missing some cleanup when things fail in the
middle. Add the appropriate cleanup routines to make sure we exit
gracefully.

Fixes: a39c7cd0438e ("dmaengine: idxd: removal of pcim managed mmio mapping")
Reported-by: Nikhil Rao <nikhil.rao@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/init.c |   61 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 6201f52f13f5..2286232ebc7b 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -168,6 +168,32 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 	return rc;
 }
 
+static void idxd_cleanup_interrupts(struct idxd_device *idxd)
+{
+	struct pci_dev *pdev = idxd->pdev;
+	struct idxd_irq_entry *irq_entry;
+	int i, msixcnt;
+
+	msixcnt = pci_msix_vec_count(pdev);
+	if (msixcnt <= 0)
+		return;
+
+	irq_entry = &idxd->irq_entries[0];
+	free_irq(irq_entry->vector, irq_entry);
+
+	for (i = 1; i < msixcnt; i++) {
+
+		irq_entry = &idxd->irq_entries[i];
+		if (idxd->hw.cmd_cap & BIT(IDXD_CMD_RELEASE_INT_HANDLE))
+			idxd_device_release_int_handle(idxd, idxd->int_handles[i],
+						       IDXD_IRQ_MSIX);
+		free_irq(irq_entry->vector, irq_entry);
+	}
+
+	idxd_mask_error_interrupts(idxd);
+	pci_free_irq_vectors(pdev);
+}
+
 static int idxd_setup_wqs(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -304,6 +330,19 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 	return rc;
 }
 
+static void idxd_cleanup_internals(struct idxd_device *idxd)
+{
+	int i;
+
+	for (i = 0; i < idxd->max_groups; i++)
+		put_device(&idxd->groups[i]->conf_dev);
+	for (i = 0; i < idxd->max_engines; i++)
+		put_device(&idxd->engines[i]->conf_dev);
+	for (i = 0; i < idxd->max_wqs; i++)
+		put_device(&idxd->wqs[i]->conf_dev);
+	destroy_workqueue(idxd->wq);
+}
+
 static int idxd_setup_internals(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -532,12 +571,12 @@ static int idxd_probe(struct idxd_device *idxd)
 		dev_dbg(dev, "Loading RO device config\n");
 		rc = idxd_device_load_config(idxd);
 		if (rc < 0)
-			goto err;
+			goto err_config;
 	}
 
 	rc = idxd_setup_interrupts(idxd);
 	if (rc)
-		goto err;
+		goto err_config;
 
 	dev_dbg(dev, "IDXD interrupt setup complete.\n");
 
@@ -550,6 +589,8 @@ static int idxd_probe(struct idxd_device *idxd)
 	dev_dbg(dev, "IDXD device %d probed successfully\n", idxd->id);
 	return 0;
 
+ err_config:
+	idxd_cleanup_internals(idxd);
  err:
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
@@ -557,6 +598,18 @@ static int idxd_probe(struct idxd_device *idxd)
 	return rc;
 }
 
+static void idxd_cleanup(struct idxd_device *idxd)
+{
+	struct device *dev = &idxd->pdev->dev;
+
+	perfmon_pmu_remove(idxd);
+	idxd_cleanup_interrupts(idxd);
+	idxd_cleanup_internals(idxd);
+	if (device_pasid_enabled(idxd))
+		idxd_disable_system_pasid(idxd);
+	iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
+}
+
 static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
@@ -609,7 +662,7 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rc = idxd_register_devices(idxd);
 	if (rc) {
 		dev_err(dev, "IDXD sysfs setup failed\n");
-		goto err;
+		goto err_dev_register;
 	}
 
 	idxd->state = IDXD_DEV_CONF_READY;
@@ -619,6 +672,8 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	return 0;
 
+ err_dev_register:
+	idxd_cleanup(idxd);
  err:
 	pci_iounmap(pdev, idxd->reg_base);
  err_iomap:


