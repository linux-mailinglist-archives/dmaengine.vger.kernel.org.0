Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A52252C209
	for <lists+dmaengine@lfdr.de>; Wed, 18 May 2022 20:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241349AbiERSRk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 May 2022 14:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241344AbiERSRj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 May 2022 14:17:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1894E185412;
        Wed, 18 May 2022 11:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652897858; x=1684433858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bzje02YdvCwfEdXd4VLSz7VQ2pQZoJC0EJfVFm1lN80=;
  b=K9oLTWBYi/4hg6aJ8MivRJbc99JN3Pk/MYYPtsKpk3a7cROmqLtq2ITm
   mBW0E8arwCbNKI/Cdvkoe8YNRg9FmAVVoNg+2v0RxHYef8woiWS5KIT4f
   qRM21Wj1XsIy+hDYFUhuv9JpoGBAHEY9pbL7NtDljPc+8X8FFQxYU64gZ
   XRgXdjfnErXG7GxZnS0p0F2VyXsOBHBV7VNWufFsiKKySSfrYPSasfzpp
   SyjZlJqtTKkB/v7coLLyySl5lU/dxkGJu+Yn3Q65cdU8mxcc5uVlHJcLe
   R6CGGBHxq/Y/eklu8/dViscFOO7lYg2i+338H1/lX4csP5NJYjaPjXsHt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="270648744"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="270648744"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 11:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="639405505"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by fmsmga004.fm.intel.com with ESMTP; 18 May 2022 11:17:33 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org
Cc:     Yi Liu <yi.l.liu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 5/6] dmaengine: idxd: Use DMA API for in-kernel DMA with PASID
Date:   Wed, 18 May 2022 11:21:19 -0700
Message-Id: <20220518182120.1136715-6-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

