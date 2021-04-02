Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED569353001
	for <lists+dmaengine@lfdr.de>; Fri,  2 Apr 2021 21:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhDBT5P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Apr 2021 15:57:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:2699 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236256AbhDBT5P (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 2 Apr 2021 15:57:15 -0400
IronPort-SDR: ztKmZNV/y71N0rOFF/lq3wlnihGvgPncOWfyKwq2qSsIlwlS8WvlAWq1keaFapnqPBh5cDiROs
 VlCCw59UjIjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="192008282"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="192008282"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 12:57:12 -0700
IronPort-SDR: alIL77B+DsBBgVmi78hsCt6KIFBpD4wnQdGOf139nVlbxxE0iJSLIq+mgmBV7KKhHGXjlfO38J
 HKTNeFp4QIwA==
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="528710001"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 12:57:11 -0700
Subject: [PATCH v9 03/11] dmaengine: idxd: removal of pcim managed mmio
 mapping
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Date:   Fri, 02 Apr 2021 12:57:11 -0700
Message-ID: <161739343139.2945060.2373784870221683543.stgit@djiang5-desk3.ch.intel.com>
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
driver 'struct device' lifetime. Remove pcim_* management of the PCI device
and the ioremap of MMIO BAR and replace with unmanaged versions. This is
for consistency of removing all the pcim/devm based calls.

Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dma/idxd/init.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index a7bf5daf6760..8133a01b36ab 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -392,32 +392,36 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct idxd_device *idxd;
 	int rc;
 
-	rc = pcim_enable_device(pdev);
+	rc = pci_enable_device(pdev);
 	if (rc)
 		return rc;
 
 	dev_dbg(dev, "Alloc IDXD context\n");
 	idxd = idxd_alloc(pdev);
-	if (!idxd)
-		return -ENOMEM;
+	if (!idxd) {
+		rc = -ENOMEM;
+		goto err_idxd_alloc;
+	}
 
 	dev_dbg(dev, "Mapping BARs\n");
-	idxd->reg_base = pcim_iomap(pdev, IDXD_MMIO_BAR, 0);
-	if (!idxd->reg_base)
-		return -ENOMEM;
+	idxd->reg_base = pci_iomap(pdev, IDXD_MMIO_BAR, 0);
+	if (!idxd->reg_base) {
+		rc = -ENOMEM;
+		goto err_iomap;
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
 
@@ -431,13 +435,13 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rc = idxd_probe(idxd);
 	if (rc) {
 		dev_err(dev, "Intel(R) IDXD DMA Engine init failed\n");
-		return -ENODEV;
+		goto err;
 	}
 
 	rc = idxd_setup_sysfs(idxd);
 	if (rc) {
 		dev_err(dev, "IDXD sysfs setup failed\n");
-		return -ENODEV;
+		goto err;
 	}
 
 	idxd->state = IDXD_DEV_CONF_READY;
@@ -446,6 +450,13 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		 idxd->hw.version);
 
 	return 0;
+
+ err:
+	pci_iounmap(pdev, idxd->reg_base);
+ err_iomap:
+ err_idxd_alloc:
+	pci_disable_device(pdev);
+	return rc;
 }
 
 static void idxd_flush_pending_llist(struct idxd_irq_entry *ie)
@@ -500,6 +511,8 @@ static void idxd_shutdown(struct pci_dev *pdev)
 	}
 
 	pci_free_irq_vectors(pdev);
+	pci_iounmap(pdev, idxd->reg_base);
+	pci_disable_device(pdev);
 	destroy_workqueue(idxd->wq);
 }
 


