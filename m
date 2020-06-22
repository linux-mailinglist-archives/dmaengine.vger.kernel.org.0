Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F4220420A
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2020 22:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgFVUii (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jun 2020 16:38:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:63493 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728336AbgFVUih (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Jun 2020 16:38:37 -0400
IronPort-SDR: obvhFr+Y3HyJjqA6JcSDduzaagjXkg2DCWH2KYou555Vli4XQK4K2NO6kpbxIPHz076q6omEJq
 NF8MuQ93OHSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="209061904"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="209061904"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 13:38:35 -0700
IronPort-SDR: b9uDrulWsyEMjOxz9tP/+Q2io3zVm4u8wrmFQTGn9vDa/i1H8acvZ/cNFOtqc1aOrNvEfn/K7b
 VTtJ/jjP+Q4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="451965409"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2020 13:38:34 -0700
Subject: [PATCH v3] dmaengine: idxd: fix cdev locking for open and release
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Nikhil Rao <nikhil.rao@intel.com>, dmaengine@vger.kernel.org
Date:   Mon, 22 Jun 2020 13:38:34 -0700
Message-ID: <159285824892.64944.2905413694915141834.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Nikhil Rao <nikhil.rao@intel.com>

add the wq lock in cdev open and release call. This fixes
race conditions observed in the open and close routines.

Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")

Signed-off-by: Nikhil Rao <nikhil.rao@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Caught uninit rc variable.

v2:
- Added kbuild fix from Dan Carpenter re:
smatch warnings:
drivers/dma/idxd/cdev.c:106 idxd_cdev_open() error: uninitialized symbol 'ctx'.

 drivers/dma/idxd/cdev.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index ff49847e37a8..cb376cf6a2d2 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -74,6 +74,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	struct idxd_device *idxd;
 	struct idxd_wq *wq;
 	struct device *dev;
+	int rc = 0;
 
 	wq = inode_wq(inode);
 	idxd = wq->idxd;
@@ -81,17 +82,27 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 
 	dev_dbg(dev, "%s called: %d\n", __func__, idxd_wq_refcount(wq));
 
-	if (idxd_wq_refcount(wq) > 0 && wq_dedicated(wq))
-		return -EBUSY;
-
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
+	mutex_lock(&wq->wq_lock);
+
+	if (idxd_wq_refcount(wq) > 0 && wq_dedicated(wq)) {
+		rc = -EBUSY;
+		goto failed;
+	}
+
 	ctx->wq = wq;
 	filp->private_data = ctx;
 	idxd_wq_get(wq);
+	mutex_unlock(&wq->wq_lock);
 	return 0;
+
+ failed:
+	mutex_unlock(&wq->wq_lock);
+	kfree(ctx);
+	return rc;
 }
 
 static int idxd_cdev_release(struct inode *node, struct file *filep)
@@ -105,7 +116,9 @@ static int idxd_cdev_release(struct inode *node, struct file *filep)
 	filep->private_data = NULL;
 
 	kfree(ctx);
+	mutex_lock(&wq->wq_lock);
 	idxd_wq_put(wq);
+	mutex_unlock(&wq->wq_lock);
 	return 0;
 }
 

