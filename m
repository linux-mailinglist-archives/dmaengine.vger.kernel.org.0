Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04530180275
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2020 16:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgCJPwb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Mar 2020 11:52:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:59804 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgCJPwb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Mar 2020 11:52:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 08:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="260830305"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002.jf.intel.com with ESMTP; 10 Mar 2020 08:52:30 -0700
Subject: [PATCH] dmaengine: idxd: fix off by one on cdev dwq refcount
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 10 Mar 2020 08:52:30 -0700
Message-ID: <158385554998.72352.12513554686212831620.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The refcount check for dedicuated workqueue (dwq) is off by one and allows
more than 1 user to open the char device. Fix check so only a single user
can open the device.

Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/cdev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index e4379ba04a9a..f5e43f65a5ed 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -84,9 +84,9 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	dev = &idxd->pdev->dev;
 	idxd_cdev = &wq->idxd_cdev;
 
-	dev_dbg(dev, "%s called\n", __func__);
+	dev_dbg(dev, "%s called: %d\n", __func__, idxd_wq_refcount(wq));
 
-	if (idxd_wq_refcount(wq) > 1 && wq_dedicated(wq))
+	if (idxd_wq_refcount(wq) > 0 && wq_dedicated(wq))
 		return -EBUSY;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);

