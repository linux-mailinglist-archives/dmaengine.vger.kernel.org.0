Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2FD361660
	for <lists+dmaengine@lfdr.de>; Fri, 16 Apr 2021 01:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbhDOXhr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Apr 2021 19:37:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:28045 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234762AbhDOXhr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Apr 2021 19:37:47 -0400
IronPort-SDR: Bw+Q9kr+zzLwKAtTblzn5cjfO4rSa9GPul6m+GUv2KhFxLmWBz8bdZp5O2OP+kl125FgjyRzrH
 5zzvQzTmGaVQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="194523276"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="194523276"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:37:23 -0700
IronPort-SDR: ZKhzZm5FVVvgocctz00w/orID4zLuvZon/P2xtjPTCURgCdAI+uYkyWwXnlraCnOJBPRLwPn6L
 pPCA6wTB2H2w==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="382891568"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:37:21 -0700
Subject: [PATCH v10 03/11] dmaengine: idxd: removal of pcim managed mmio
 mapping
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Date:   Thu, 15 Apr 2021 16:37:21 -0700
Message-ID: <161852984150.2203940.8043988289748519056.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161852959148.2203940.7484827367948091199.stgit@djiang5-desk3.ch.intel.com>
References: <161852959148.2203940.7484827367948091199.stgit@djiang5-desk3.ch.intel.com>
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
index 5cf1bf095ae1..11a2e14b5b80 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -384,32 +384,36 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
 
@@ -423,13 +427,13 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -438,6 +442,13 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -493,6 +504,8 @@ static void idxd_shutdown(struct pci_dev *pdev)
 
 	idxd_msix_perm_clear(idxd);
 	pci_free_irq_vectors(pdev);
+	pci_iounmap(pdev, idxd->reg_base);
+	pci_disable_device(pdev);
 	destroy_workqueue(idxd->wq);
 }
 


