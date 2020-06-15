Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436211FA219
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2020 22:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbgFOUyR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Jun 2020 16:54:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:36796 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgFOUyQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 15 Jun 2020 16:54:16 -0400
IronPort-SDR: sM5Mtun9sUrTRP+w60RESw1pGYEDdq1fTwSvxtVgafQHHIJM84b/1Ei/JYqhE/g/LT0JVnePfD
 kDCZLG35up3Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 13:54:15 -0700
IronPort-SDR: tF1mCDx4+4odW013lV1xxu0FxwXD3sjeJh4tTKUBVFCX5x1WWTcaR891pp3TLnydTCUJCjQnwc
 ENFW8iTG9BMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,516,1583222400"; 
   d="scan'208";a="298652675"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2020 13:54:15 -0700
Subject: [PATCH] dmaengine: idxd: fix cdev locking for open and release
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Nikhil Rao <nikhil.rao@intel.com>, dmaengine@vger.kernel.org
Date:   Mon, 15 Jun 2020 13:54:15 -0700
Message-ID: <159225445529.68253.775183898115820961.stgit@djiang5-desk3.ch.intel.com>
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
 drivers/dma/idxd/cdev.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index ff49847e37a8..207555296913 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -74,6 +74,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	struct idxd_device *idxd;
 	struct idxd_wq *wq;
 	struct device *dev;
+	int rc;
 
 	wq = inode_wq(inode);
 	idxd = wq->idxd;
@@ -81,17 +82,29 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 
 	dev_dbg(dev, "%s called: %d\n", __func__, idxd_wq_refcount(wq));
 
-	if (idxd_wq_refcount(wq) > 0 && wq_dedicated(wq))
-		return -EBUSY;
+	mutex_lock(&wq->wq_lock);
+
+	if (idxd_wq_refcount(wq) > 0 && wq_dedicated(wq)) {
+		rc = -EBUSY;
+		goto failed;
+	}
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
+	if (!ctx) {
+		rc = -ENOMEM;
+		goto failed;
+	}
 
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
@@ -105,7 +118,9 @@ static int idxd_cdev_release(struct inode *node, struct file *filep)
 	filep->private_data = NULL;
 
 	kfree(ctx);
+	mutex_lock(&wq->wq_lock);
 	idxd_wq_put(wq);
+	mutex_unlock(&wq->wq_lock);
 	return 0;
 }
 

