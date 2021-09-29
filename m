Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E80241CC7C
	for <lists+dmaengine@lfdr.de>; Wed, 29 Sep 2021 21:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344853AbhI2TRV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Sep 2021 15:17:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:14413 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344094AbhI2TRU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 29 Sep 2021 15:17:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="247551246"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="247551246"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 12:15:39 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="588189742"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 12:15:38 -0700
Subject: [PATCH] dmaengine: idxd: move out percpu_ref_exit() to ensure it's
 outside submission
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Kevin Tian <kevin.tian@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 29 Sep 2021 12:15:38 -0700
Message-ID: <163294293832.914350.10326422026738506152.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

percpu_ref_tryget_live() is safe to call as long as ref is between init and
exit according to the function comment. Move percpu_ref_exit() so it is
called after the dma channel is no longer valid to ensure this holds true.

Fixes: 93a40a6d7428 ("dmaengine: idxd: add percpu_ref to descriptor submission path")
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    1 -
 drivers/dma/idxd/dma.c    |    2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 83a5ff2ecf2a..cbbfa17d8d11 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -427,7 +427,6 @@ void idxd_wq_quiesce(struct idxd_wq *wq)
 {
 	percpu_ref_kill(&wq->wq_active);
 	wait_for_completion(&wq->wq_dead);
-	percpu_ref_exit(&wq->wq_active);
 }
 
 /* Device control bits */
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index e0f056c1d1f5..b90b085d18cf 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -311,6 +311,7 @@ static int idxd_dmaengine_drv_probe(struct idxd_dev *idxd_dev)
 
 err_dma:
 	idxd_wq_quiesce(wq);
+	percpu_ref_exit(&wq->wq_active);
 err_ref:
 	idxd_wq_free_resources(wq);
 err_res_alloc:
@@ -329,6 +330,7 @@ static void idxd_dmaengine_drv_remove(struct idxd_dev *idxd_dev)
 	idxd_wq_quiesce(wq);
 	idxd_unregister_dma_channel(wq);
 	__drv_disable_wq(wq);
+	percpu_ref_exit(&wq->wq_active);
 	idxd_wq_free_resources(wq);
 	wq->type = IDXD_WQT_NONE;
 	mutex_unlock(&wq->wq_lock);


