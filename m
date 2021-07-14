Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BE23C9372
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 23:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbhGNWAL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 18:00:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:15591 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhGNWAL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 18:00:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="190116164"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="190116164"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 14:57:19 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="654988494"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 14:57:19 -0700
Subject: [PATCH] dmaengine: idxd: fix sequence for pci driver remove() and
 shutdown()
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com
Date:   Wed, 14 Jul 2021 14:57:19 -0700
Message-ID: <162629983901.395844.17964803190905549615.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

->shutdown() call should only be responsible for quiescing the device.
Currently it is doing PCI device tear down. This causes issue when things
like MMIO mapping is removed while idxd_unregister_devices() will trigger
removal of idxd device sub-driver and still initiates MMIO writes to the
device. Another issue is with the unregistering of idxd 'struct device',
the memory context gets freed. So the teardown calls are accessing freed
memory and can cause kernel oops. Move all the teardown bits that doesn't
belong in shutdown to ->remove() call. Move unregistering of the idxd
conf_dev 'struct device' to after doing all the teardown to free all
the memory that's no longer needed.

Fixes: 47c16ac27d4c ("dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/init.c  |   26 +++++++++++++++++---------
 drivers/dma/idxd/sysfs.c |    2 --
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 4e32a4dcc3ab..c0f4c0422f32 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -760,32 +760,40 @@ static void idxd_shutdown(struct pci_dev *pdev)
 	for (i = 0; i < msixcnt; i++) {
 		irq_entry = &idxd->irq_entries[i];
 		synchronize_irq(irq_entry->vector);
-		free_irq(irq_entry->vector, irq_entry);
 		if (i == 0)
 			continue;
 		idxd_flush_pending_llist(irq_entry);
 		idxd_flush_work_list(irq_entry);
 	}
-
-	idxd_msix_perm_clear(idxd);
-	idxd_release_int_handles(idxd);
-	pci_free_irq_vectors(pdev);
-	pci_iounmap(pdev, idxd->reg_base);
-	pci_disable_device(pdev);
-	destroy_workqueue(idxd->wq);
+	flush_workqueue(idxd->wq);
 }
 
 static void idxd_remove(struct pci_dev *pdev)
 {
 	struct idxd_device *idxd = pci_get_drvdata(pdev);
+	struct idxd_irq_entry *irq_entry;
+	int msixcnt = pci_msix_vec_count(pdev);
+	int i;
 
 	dev_dbg(&pdev->dev, "%s called\n", __func__);
 	idxd_shutdown(pdev);
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
 	idxd_unregister_devices(idxd);
-	perfmon_pmu_remove(idxd);
+
+	for (i = 0; i < msixcnt; i++) {
+		irq_entry = &idxd->irq_entries[i];
+		free_irq(irq_entry->vector, irq_entry);
+	}
+	idxd_msix_perm_clear(idxd);
+	idxd_release_int_handles(idxd);
+	pci_free_irq_vectors(pdev);
+	pci_iounmap(pdev, idxd->reg_base);
 	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
+	pci_disable_device(pdev);
+	destroy_workqueue(idxd->wq);
+	perfmon_pmu_remove(idxd);
+	device_unregister(&idxd->conf_dev);
 }
 
 static struct pci_driver idxd_pci_driver = {
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 0460d58e3941..bb4df63906a7 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1744,8 +1744,6 @@ void idxd_unregister_devices(struct idxd_device *idxd)
 
 		device_unregister(&group->conf_dev);
 	}
-
-	device_unregister(&idxd->conf_dev);
 }
 
 int idxd_register_bus_type(void)


