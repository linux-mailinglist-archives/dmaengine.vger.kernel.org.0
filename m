Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B696E361661
	for <lists+dmaengine@lfdr.de>; Fri, 16 Apr 2021 01:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbhDOXhx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Apr 2021 19:37:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:63568 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234762AbhDOXhw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Apr 2021 19:37:52 -0400
IronPort-SDR: JXZvIhtX7oZ+/BIgT6EdWsYqOk30oQnjHbdAsrpX+TxW+TnL20lnVM02XfeYRcLA0nqhArY8Uc
 S3z78JFviQjQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="258922634"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="258922634"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:37:28 -0700
IronPort-SDR: b19xun+zOT4D5aFXYvWbcFFnVnDD02v5KYeQsgrntXdHPBw6FXD7nYKmsTFVkgFcYWb/esnXas
 9oQjAsuC58YA==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="451287072"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:37:27 -0700
Subject: [PATCH v10 04/11] dmaengine: idxd: use ida for device instance
 enumeration
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>, dmaengine@vger.kernel.org
Date:   Thu, 15 Apr 2021 16:37:27 -0700
Message-ID: <161852984730.2203940.15032482460902003819.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161852959148.2203940.7484827367948091199.stgit@djiang5-desk3.ch.intel.com>
References: <161852959148.2203940.7484827367948091199.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The idr is only used for an device id, never to lookup context from that
id. Switch to plain ida.

Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/init.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 11a2e14b5b80..a4f0489515b4 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -34,8 +34,7 @@ MODULE_PARM_DESC(sva, "Toggle SVA support on/off");
 
 bool support_enqcmd;
 
-static struct idr idxd_idrs[IDXD_TYPE_MAX];
-static DEFINE_MUTEX(idxd_idr_lock);
+static struct ida idxd_idas[IDXD_TYPE_MAX];
 
 static struct pci_device_id idxd_pci_tbl[] = {
 	/* DSA ver 1.0 platforms */
@@ -348,12 +347,10 @@ static int idxd_probe(struct idxd_device *idxd)
 
 	dev_dbg(dev, "IDXD interrupt setup complete.\n");
 
-	mutex_lock(&idxd_idr_lock);
-	idxd->id = idr_alloc(&idxd_idrs[idxd->type], idxd, 0, 0, GFP_KERNEL);
-	mutex_unlock(&idxd_idr_lock);
+	idxd->id = ida_alloc(&idxd_idas[idxd->type], GFP_KERNEL);
 	if (idxd->id < 0) {
 		rc = -ENOMEM;
-		goto err_idr_fail;
+		goto err_ida_fail;
 	}
 
 	idxd->major = idxd_cdev_get_major(idxd);
@@ -361,7 +358,7 @@ static int idxd_probe(struct idxd_device *idxd)
 	dev_dbg(dev, "IDXD device %d probed successfully\n", idxd->id);
 	return 0;
 
- err_idr_fail:
+ err_ida_fail:
 	idxd_mask_error_interrupts(idxd);
 	idxd_mask_msix_vectors(idxd);
  err_setup:
@@ -518,9 +515,7 @@ static void idxd_remove(struct pci_dev *pdev)
 	idxd_shutdown(pdev);
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
-	mutex_lock(&idxd_idr_lock);
-	idr_remove(&idxd_idrs[idxd->type], idxd->id);
-	mutex_unlock(&idxd_idr_lock);
+	ida_free(&idxd_idas[idxd->type], idxd->id);
 }
 
 static struct pci_driver idxd_pci_driver = {
@@ -550,7 +545,7 @@ static int __init idxd_init_module(void)
 		support_enqcmd = true;
 
 	for (i = 0; i < IDXD_TYPE_MAX; i++)
-		idr_init(&idxd_idrs[i]);
+		ida_init(&idxd_idas[i]);
 
 	err = idxd_register_bus_type();
 	if (err < 0)


