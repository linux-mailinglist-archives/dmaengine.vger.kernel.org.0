Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1AB439987
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 17:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhJYPD6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 11:03:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:63626 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233744AbhJYPD5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 11:03:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="229613193"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="229613193"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 08:01:08 -0700
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="578146736"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 08:01:06 -0700
Subject: [PATCH v2] dmaengine: idxd: fix resource leak on dmaengine driver
 disable
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        dmaengine@vger.kernel.org
Date:   Mon, 25 Oct 2021 08:01:04 -0700
Message-ID: <163517405099.3484556.12521975053711345244.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The wq resources needs to be released before the kernel type is reset by
__drv_disable_wq(). With dma channels unregistered and wq quiesced, all the
wq resources for dmaengine can be freed. There is no need to wait until wq
is disabled. With the wq->type being reset to "unknown", the driver is
skipping the freeing of the resources.

Fixes: 0cda4f6986a3 ("dmaengine: idxd: create dmaengine driver for wq 'device'")
Reported-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Tested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v2: rebase against latest dmaengine/next

 drivers/dma/idxd/dma.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index b90b085d18cf..c39e9483206a 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -329,10 +329,9 @@ static void idxd_dmaengine_drv_remove(struct idxd_dev *idxd_dev)
 	mutex_lock(&wq->wq_lock);
 	idxd_wq_quiesce(wq);
 	idxd_unregister_dma_channel(wq);
+	idxd_wq_free_resources(wq);
 	__drv_disable_wq(wq);
 	percpu_ref_exit(&wq->wq_active);
-	idxd_wq_free_resources(wq);
-	wq->type = IDXD_WQT_NONE;
 	mutex_unlock(&wq->wq_lock);
 }
 


