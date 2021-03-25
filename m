Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55990349629
	for <lists+dmaengine@lfdr.de>; Thu, 25 Mar 2021 16:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhCYPzS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Mar 2021 11:55:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:48787 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhCYPyt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 25 Mar 2021 11:54:49 -0400
IronPort-SDR: A7LqfP509HG/6ZqPrgvCcQoXNRfgBuBI0vTsyyOOBDUW5vJA4HFTJ/UjPyTzxpd54e4325skbu
 QJdDhncOnEyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="178079680"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="178079680"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 08:54:49 -0700
IronPort-SDR: Lay1bgEKThU+HnlQFuBbf2lAcyYZtEPgAzs9YxP8Cd3DvoF2xkWCh4Vpxf8b71pfWU0t279lUT
 zdDqyu7BDpzQ==
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="409427427"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 08:54:48 -0700
Subject: [PATCH v8 3/8] dmaengine: idxd: removal of pcim managed mmio mapping
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, dan.carpenter@oracle.com
Date:   Thu, 25 Mar 2021 08:54:48 -0700
Message-ID: <161668768861.2670112.14907071146034023321.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161668743322.2670112.2302120522403482843.stgit@djiang5-desk3.ch.intel.com>
References: <161668743322.2670112.2302120522403482843.stgit@djiang5-desk3.ch.intel.com>
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
index 72f319dd52fc..080d31bf5b33 100644
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
 


