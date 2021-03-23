Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EA734664C
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 18:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhCWR2X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Mar 2021 13:28:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:7558 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhCWR2T (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 23 Mar 2021 13:28:19 -0400
IronPort-SDR: hFBbWcu4mMr8u4gu4ShflTkJixRE5qhGkolZjYDU8IVA0WgKRsOta6VIA/+piYqOZxvgoQY/Ks
 EP7Ir9pv+bqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="170492251"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="170492251"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 10:28:18 -0700
IronPort-SDR: gwPKr27QTKi71Nmi0Crnq5PwRGeRnMml12Tcb2cRmMD8EFxyKdEbD/EPUJJuhyqKbHpQey0hgx
 ZTg/b/XYwZbQ==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="442610659"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 10:28:16 -0700
Subject: [PATCH] dmaengine: idxd: enable SVA feature for IOMMU
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, jsnitsel@redhat.com, ashok.raj@intel.com
Date:   Tue, 23 Mar 2021 10:28:16 -0700
Message-ID: <161652049651.2021092.18045804638424119164.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Enable IOMMU_DEV_FEAT_SVA before attempt to bind pasid. This is needed
according to iommu_sva_bind_device() comment. Currently Intel IOMMU code
does this before bind call. It really needs to be controlled by the driver.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/init.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 0bd7b33b436a..083facb301b8 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -376,11 +376,18 @@ static int idxd_probe(struct idxd_device *idxd)
 	dev_dbg(dev, "IDXD reset complete\n");
 
 	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
-		rc = idxd_enable_system_pasid(idxd);
-		if (rc < 0)
-			dev_warn(dev, "Failed to enable PASID. No SVA support: %d\n", rc);
-		else
-			set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
+		rc = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA);
+		if (rc == 0) {
+			rc = idxd_enable_system_pasid(idxd);
+			if (rc < 0) {
+				iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
+				dev_warn(dev, "Failed to enable PASID. No SVA support: %d\n", rc);
+			} else {
+				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
+			}
+		} else {
+			dev_warn(dev, "Unable to turn on SVA feature.\n");
+		}
 	} else if (!sva) {
 		dev_warn(dev, "User forced SVA off via module param.\n");
 	}
@@ -425,6 +432,7 @@ static int idxd_probe(struct idxd_device *idxd)
  err_setup:
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
+	iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
 	return rc;
 }
 
@@ -595,6 +603,7 @@ static void idxd_remove(struct pci_dev *pdev)
 	mutex_lock(&idxd_idr_lock);
 	idr_remove(&idxd_idrs[idxd->type], idxd->id);
 	mutex_unlock(&idxd_idr_lock);
+	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
 }
 
 static struct pci_driver idxd_pci_driver = {


