Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57F0365FB0
	for <lists+dmaengine@lfdr.de>; Tue, 20 Apr 2021 20:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhDTSrU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Apr 2021 14:47:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:3903 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233510AbhDTSrS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Apr 2021 14:47:18 -0400
IronPort-SDR: bYbjN0nkKdCdo6CxLyGYvGygqFSxtcJ74pTfQeMUTWS9ZMGc2gZ5Pkw7x89m3n2Mk5kmHqcBgX
 SPmsfSMwEGFg==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="193445172"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="193445172"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 11:46:46 -0700
IronPort-SDR: X7/RqaO3ExNa0rMfiOnElP5fLKPwnkt0KTgW10LeEeeByOTK2m+EGy0zy5TyDUbdy0GtncEnJh
 w13xHTU98x2g==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="454975860"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 11:46:46 -0700
Subject: [PATCH 5/6] dmaengine: idxd: enable SVA feature for IOMMU
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 20 Apr 2021 11:46:46 -0700
Message-ID: <161894440621.3202472.17644507396206848134.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161894424826.3202472.897357148671784604.stgit@djiang5-desk3.ch.intel.com>
References: <161894424826.3202472.897357148671784604.stgit@djiang5-desk3.ch.intel.com>
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
index ef58750c24cc..eb0b3a00a2d7 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -501,11 +501,18 @@ static int idxd_probe(struct idxd_device *idxd)
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
@@ -539,6 +546,7 @@ static int idxd_probe(struct idxd_device *idxd)
  err:
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
+	iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
 	return rc;
 }
 
@@ -699,6 +707,7 @@ static void idxd_remove(struct pci_dev *pdev)
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
 	idxd_unregister_devices(idxd);
+	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
 }
 
 static struct pci_driver idxd_pci_driver = {


