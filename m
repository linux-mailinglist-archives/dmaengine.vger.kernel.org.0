Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCCC3F1DEB
	for <lists+dmaengine@lfdr.de>; Thu, 19 Aug 2021 18:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhHSQeo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Aug 2021 12:34:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:8773 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhHSQeo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 19 Aug 2021 12:34:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="277616347"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="277616347"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:34:07 -0700
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="681846461"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:34:07 -0700
Subject: [PATCH] dmaengine: idxd: fix setting up priv mode for dwq
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Ramesh Thomas <ramesh.thomas@intel.com>, dmaengine@vger.kernel.org,
        mona.hossain@intel.com
Date:   Thu, 19 Aug 2021 09:34:06 -0700
Message-ID: <162939084657.903168.14160019185148244596.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DSA spec says WQ priv bit is 0 if the Privileged Mode Enable field of the
PCI Express PASID capability is 0 and pasid is enabled. Make sure that the
WQCFG priv field is set correctly according to usage type. Reject config if
setting up kernel WQ type and no support. Also add the correct priv setup
for a descriptor.

Fixes: 484f910e93b4 ("dmaengine: idxd: fix wq config registers offset programming")
Cc: Ramesh Thomas <ramesh.thomas@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/Kconfig       |    1 +
 drivers/dma/idxd/device.c |   29 ++++++++++++++++++++++++++++-
 drivers/dma/idxd/dma.c    |    6 +++++-
 include/uapi/linux/idxd.h |    1 +
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index ceb41be0505e..a623da679fd4 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -285,6 +285,7 @@ config INTEL_IDXD
 	tristate "Intel Data Accelerators support"
 	depends on PCI && X86_64 && !UML
 	depends on PCI_MSI
+	depends on PCI_PASID
 	depends on SBITMAP
 	select DMA_ENGINE
 	help
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index e093cf225a5c..241df74fc047 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -818,6 +818,15 @@ static int idxd_groups_config_write(struct idxd_device *idxd)
 	return 0;
 }
 
+static bool idxd_device_pasid_priv_enabled(struct idxd_device *idxd)
+{
+	struct pci_dev *pdev = idxd->pdev;
+
+	if (pdev->pasid_enabled && (pdev->pasid_features & PCI_PASID_CAP_PRIV))
+		return true;
+	return false;
+}
+
 static int idxd_wq_config_write(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
@@ -850,7 +859,6 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 	wq->wqcfg->wq_thresh = wq->threshold;
 
 	/* byte 8-11 */
-	wq->wqcfg->priv = !!(wq->type == IDXD_WQT_KERNEL);
 	if (wq_dedicated(wq))
 		wq->wqcfg->mode = 1;
 
@@ -860,6 +868,25 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 			wq->wqcfg->pasid = idxd->pasid;
 	}
 
+	/*
+	 * Here the priv bit is set depending on the WQ type. priv = 1 if the
+	 * WQ type is kernel to indicate privileged access. This setting only
+	 * matters for dedicated WQ. According to the DSA spec:
+	 * If the WQ is in dedicated mode, WQ PASID Enable is 1, and the
+	 * Privileged Mode Enable field of the PCI Express PASID capability
+	 * is 0, this field must be 0.
+	 *
+	 * In the case of a dedicated kernel WQ that is not able to support
+	 * the PASID cap, then the configuration will be rejected.
+	 */
+	wq->wqcfg->priv = !!(wq->type == IDXD_WQT_KERNEL);
+	if (wq_dedicated(wq) && wq->wqcfg->pasid_en &&
+	    !idxd_device_pasid_priv_enabled(idxd) &&
+	    wq->type == IDXD_WQT_KERNEL) {
+		idxd->cmd_status = IDXD_SCMD_WQ_NO_PRIV;
+		return -EOPNOTSUPP;
+	}
+
 	wq->wqcfg->priority = wq->priority;
 
 	if (idxd->hw.gen_cap.block_on_fault &&
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index 5c0a4d8a31f5..e0f056c1d1f5 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -69,7 +69,11 @@ static inline void idxd_prep_desc_common(struct idxd_wq *wq,
 	hw->src_addr = addr_f1;
 	hw->dst_addr = addr_f2;
 	hw->xfer_size = len;
-	hw->priv = !!(wq->type == IDXD_WQT_KERNEL);
+	/*
+	 * For dedicated WQ, this field is ignored and HW will use the WQCFG.priv
+	 * field instead. This field should be set to 1 for kernel descriptors.
+	 */
+	hw->priv = 1;
 	hw->completion_addr = compl;
 }
 
diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index ca24c25252fb..c750eac09fc9 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -27,6 +27,7 @@ enum idxd_scmd_stat {
 	IDXD_SCMD_WQ_NO_SWQ_SUPPORT = 0x800c0000,
 	IDXD_SCMD_WQ_NONE_CONFIGURED = 0x800d0000,
 	IDXD_SCMD_WQ_NO_SIZE = 0x800e0000,
+	IDXD_SCMD_WQ_NO_PRIV = 0x800f0000,
 };
 
 #define IDXD_SCMD_SOFTERR_MASK	0x80000000


