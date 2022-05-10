Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A50C522608
	for <lists+dmaengine@lfdr.de>; Tue, 10 May 2022 23:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiEJVDZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 May 2022 17:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiEJVDY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 May 2022 17:03:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023A1291CFA;
        Tue, 10 May 2022 14:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652216603; x=1683752603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bzje02YdvCwfEdXd4VLSz7VQ2pQZoJC0EJfVFm1lN80=;
  b=CsWvEQ6a4SfKzUArItoLxGis2qGLykhN5FkJygBO2s3aDWIsZO0dih8a
   DiOp1hVREHHEl3eWeThBefzJSHc3ioCIQVw8js7eR/PQBWiZ7k2zGdptX
   xkCe8pwsD6Ru8ysYx4QJnonCQENeEdPL56e+X/q0UQdbkOOr14YFZ+AsX
   BkGz/XnN1mM/LHvZ+YjQhntIdjYcEk51s5fTciTt5lVFQCNTM97+LosNU
   OFnhZ5rSmjzKlfkbHLDJwxalY6mk2d9r6NOR18A0UKyzJlszdKkqa+gRo
   pL2YPGvrZbHjRvyQpQjjDo/OUs72dMnbxPJYPXjd6HnBnVwT+9RaI+nw3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="332538558"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="332538558"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 14:03:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="553017131"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by orsmga002.jf.intel.com with ESMTP; 10 May 2022 14:03:22 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org
Cc:     Yi Liu <yi.l.liu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 3/4] dmaengine: idxd: Use DMA API for in-kernel DMA with PASID
Date:   Tue, 10 May 2022 14:07:03 -0700
Message-Id: <20220510210704.3539577-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The current in-kernel supervisor PASID support is based on the SVM/SVA
machinery in SVA lib. The binding between a kernel PASID and kernel
mapping has many flaws. See discussions in the link below.

This patch enables in-kernel DMA by switching from SVA lib to the
standard DMA mapping APIs. Since both DMA requests with and without
PASIDs are mapped identically, there is no change to how DMA APIs are
used after the kernel PASID is enabled.

Link: https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/dma/idxd/idxd.h  |  1 -
 drivers/dma/idxd/init.c  | 34 +++++++++-------------------------
 drivers/dma/idxd/sysfs.c |  7 -------
 3 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index ccbefd0be617..190b08bd7c08 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -277,7 +277,6 @@ struct idxd_device {
 	struct idxd_wq **wqs;
 	struct idxd_engine **engines;
 
-	struct iommu_sva *sva;
 	unsigned int pasid;
 
 	int num_groups;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index e1b5d1e4a949..e2e1c0eae6d6 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -16,6 +16,7 @@
 #include <linux/idr.h>
 #include <linux/intel-svm.h>
 #include <linux/iommu.h>
+#include <linux/dma-iommu.h>
 #include <uapi/linux/idxd.h>
 #include <linux/dmaengine.h>
 #include "../dmaengine.h"
@@ -466,36 +467,22 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 
 static int idxd_enable_system_pasid(struct idxd_device *idxd)
 {
-	int flags;
-	unsigned int pasid;
-	struct iommu_sva *sva;
+	u32 pasid;
+	int ret;
 
-	flags = SVM_FLAG_SUPERVISOR_MODE;
-
-	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, &flags);
-	if (IS_ERR(sva)) {
-		dev_warn(&idxd->pdev->dev,
-			 "iommu sva bind failed: %ld\n", PTR_ERR(sva));
-		return PTR_ERR(sva);
-	}
-
-	pasid = iommu_sva_get_pasid(sva);
-	if (pasid == IOMMU_PASID_INVALID) {
-		iommu_sva_unbind_device(sva);
-		return -ENODEV;
+	ret = iommu_attach_dma_pasid(&idxd->pdev->dev, &pasid);
+	if (ret) {
+		dev_err(&idxd->pdev->dev, "No DMA PASID %d\n", ret);
+		return ret;
 	}
-
-	idxd->sva = sva;
 	idxd->pasid = pasid;
-	dev_dbg(&idxd->pdev->dev, "system pasid: %u\n", pasid);
+
 	return 0;
 }
 
 static void idxd_disable_system_pasid(struct idxd_device *idxd)
 {
-
-	iommu_sva_unbind_device(idxd->sva);
-	idxd->sva = NULL;
+	iommu_detach_dma_pasid(&idxd->pdev->dev);
 }
 
 static int idxd_probe(struct idxd_device *idxd)
@@ -527,10 +514,7 @@ static int idxd_probe(struct idxd_device *idxd)
 			else
 				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
 		}
-	} else if (!sva) {
-		dev_warn(dev, "User forced SVA off via module param.\n");
 	}
-
 	idxd_read_caps(idxd);
 	idxd_read_table_offsets(idxd);
 
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index dfd549685c46..a48928973bd4 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -839,13 +839,6 @@ static ssize_t wq_name_store(struct device *dev,
 	if (strlen(buf) > WQ_NAME_SIZE || strlen(buf) == 0)
 		return -EINVAL;
 
-	/*
-	 * This is temporarily placed here until we have SVM support for
-	 * dmaengine.
-	 */
-	if (wq->type == IDXD_WQT_KERNEL && device_pasid_enabled(wq->idxd))
-		return -EOPNOTSUPP;
-
 	memset(wq->name, 0, WQ_NAME_SIZE + 1);
 	strncpy(wq->name, buf, WQ_NAME_SIZE);
 	strreplace(wq->name, '\n', '\0');
-- 
2.25.1

