Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935C116EBB3
	for <lists+dmaengine@lfdr.de>; Tue, 25 Feb 2020 17:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbgBYQrs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Feb 2020 11:47:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:16096 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731178AbgBYQrs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Feb 2020 11:47:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 08:47:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; 
   d="scan'208";a="226402389"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007.jf.intel.com with ESMTP; 25 Feb 2020 08:47:46 -0800
Subject: [PATCH] dmaengine: idxd: check return result from check_vma() in
 cdev
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 25 Feb 2020 09:47:46 -0700
Message-ID: <158264926659.9387.14325163515683047959.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The returned result from the check_vma() function in the cdev ->mmap() call
needs to be handled. Add the check and returning error.

Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
Reported-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/cdev.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 1d7347825b95..1706a48d8bbe 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -139,6 +139,8 @@ static int idxd_cdev_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	dev_dbg(&pdev->dev, "%s called\n", __func__);
 	rc = check_vma(wq, vma, __func__);
+	if (rc < 0)
+		return rc;
 
 	vma->vm_flags |= VM_DONTCOPY;
 	pfn = (base + idxd_get_wq_portal_full_offset(wq->id,

