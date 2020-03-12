Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79ADC183610
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2020 17:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgCLQYF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Mar 2020 12:24:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:44334 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727414AbgCLQYF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 12 Mar 2020 12:24:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 09:23:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="289768355"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Mar 2020 09:23:53 -0700
Subject: [PATCH v2] dmaengine: idxd: fix off by one on cdev dwq refcount
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Thu, 12 Mar 2020 09:23:53 -0700
Message-ID: <158403020187.10208.14117394394540710774.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The refcount check for dedicated workqueue (dwq) is off by one and allows
more than 1 user to open the char device. Fix check so only a single user
can open the device.

Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v2: Vinod: Fix spelling error in commit message.

 drivers/dma/idxd/cdev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index d58144eca6e8..ff49847e37a8 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -79,9 +79,9 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	idxd = wq->idxd;
 	dev = &idxd->pdev->dev;
 
-	dev_dbg(dev, "%s called\n", __func__);
+	dev_dbg(dev, "%s called: %d\n", __func__, idxd_wq_refcount(wq));
 
-	if (idxd_wq_refcount(wq) > 1 && wq_dedicated(wq))
+	if (idxd_wq_refcount(wq) > 0 && wq_dedicated(wq))
 		return -EBUSY;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);

