Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136C2353002
	for <lists+dmaengine@lfdr.de>; Fri,  2 Apr 2021 21:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhDBT5U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Apr 2021 15:57:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:62559 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236256AbhDBT5T (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 2 Apr 2021 15:57:19 -0400
IronPort-SDR: Ak3gn7SLGhdAfP5xNc89h5jZ9g0IgsWDzjsnVeMkyQNEkennjOLiYKgZHJaiCTh5mC6e4d3ntl
 1F0t3/2ZG5CA==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="180055269"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="180055269"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 12:57:17 -0700
IronPort-SDR: PGhKEaVpCpnrvC1MdxjG1mMAgcKMUZhN2NEC4k1AaJQvvAFRBuib7X2CjwePMoo2YocdbsTXKn
 kYrAVZivTbmQ==
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="385331263"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 12:57:17 -0700
Subject: [PATCH v9 04/11] dmaengine: idxd: use ida for device instance
 enumeration
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>, dmaengine@vger.kernel.org
Date:   Fri, 02 Apr 2021 12:57:17 -0700
Message-ID: <161739343728.2945060.10057683949900149896.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
References: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
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
index 8133a01b36ab..f582fba32a56 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -34,8 +34,7 @@ MODULE_PARM_DESC(sva, "Toggle SVA support on/off");
 
 bool support_enqcmd;
 
-static struct idr idxd_idrs[IDXD_TYPE_MAX];
-static DEFINE_MUTEX(idxd_idr_lock);
+static struct ida idxd_idas[IDXD_TYPE_MAX];
 
 static struct pci_device_id idxd_pci_tbl[] = {
 	/* DSA ver 1.0 platforms */
@@ -356,12 +355,10 @@ static int idxd_probe(struct idxd_device *idxd)
 
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
@@ -369,7 +366,7 @@ static int idxd_probe(struct idxd_device *idxd)
 	dev_dbg(dev, "IDXD device %d probed successfully\n", idxd->id);
 	return 0;
 
- err_idr_fail:
+ err_ida_fail:
 	idxd_mask_error_interrupts(idxd);
 	idxd_mask_msix_vectors(idxd);
  err_setup:
@@ -525,9 +522,7 @@ static void idxd_remove(struct pci_dev *pdev)
 	idxd_shutdown(pdev);
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
-	mutex_lock(&idxd_idr_lock);
-	idr_remove(&idxd_idrs[idxd->type], idxd->id);
-	mutex_unlock(&idxd_idr_lock);
+	ida_free(&idxd_idas[idxd->type], idxd->id);
 }
 
 static struct pci_driver idxd_pci_driver = {
@@ -557,7 +552,7 @@ static int __init idxd_init_module(void)
 		support_enqcmd = true;
 
 	for (i = 0; i < IDXD_TYPE_MAX; i++)
-		idr_init(&idxd_idrs[i]);
+		ida_init(&idxd_idas[i]);
 
 	err = idxd_register_bus_type();
 	if (err < 0)


