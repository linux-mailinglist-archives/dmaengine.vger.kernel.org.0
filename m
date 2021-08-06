Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EFC3E2EEB
	for <lists+dmaengine@lfdr.de>; Fri,  6 Aug 2021 19:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241554AbhHFRib (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Aug 2021 13:38:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:33530 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241257AbhHFRib (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Aug 2021 13:38:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10068"; a="211310895"
X-IronPort-AV: E=Sophos;i="5.84,301,1620716400"; 
   d="scan'208";a="211310895"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 10:37:41 -0700
X-IronPort-AV: E=Sophos;i="5.84,301,1620716400"; 
   d="scan'208";a="459434362"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 10:37:41 -0700
Subject: [PATCH] dmaengine: idxd: make submit failure path consistent on desc
 freeing
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Fri, 06 Aug 2021 10:37:40 -0700
Message-ID: <162827146072.3459011.10255348500504659810.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The submission path for dmaengine API does not do descriptor freeing on
failure. Also, with the abort mechanism, the freeing of desriptor happens
when the abort callback is completed. Therefore free descriptor on all
error paths for submission call to make things consistent. Also remove the
double free that would happen on abort in idxd_dma_tx_submit() call.

Fixes: 6b4b87f2c31a ("dmaengine: idxd: fix submission race window")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/dma.c    |    4 +---
 drivers/dma/idxd/submit.c |   11 +++++++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index a195225687bb..5c0a4d8a31f5 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -149,10 +149,8 @@ static dma_cookie_t idxd_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	cookie = dma_cookie_assign(tx);
 
 	rc = idxd_submit_desc(wq, desc);
-	if (rc < 0) {
-		idxd_free_desc(wq, desc);
+	if (rc < 0)
 		return rc;
-	}
 
 	return cookie;
 }
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 4b514c63af15..de76fb4abac2 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -139,11 +139,15 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	void __iomem *portal;
 	int rc;
 
-	if (idxd->state != IDXD_DEV_ENABLED)
+	if (idxd->state != IDXD_DEV_ENABLED) {
+		idxd_free_desc(wq, desc);
 		return -EIO;
+	}
 
-	if (!percpu_ref_tryget_live(&wq->wq_active))
+	if (!percpu_ref_tryget_live(&wq->wq_active)) {
+		idxd_free_desc(wq, desc);
 		return -ENXIO;
+	}
 
 	portal = idxd_wq_portal_addr(wq);
 
@@ -175,8 +179,11 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 		rc = enqcmds(portal, desc->hw);
 		if (rc < 0) {
 			percpu_ref_put(&wq->wq_active);
+			/* abort operation frees the descriptor */
 			if (ie)
 				llist_abort_desc(wq, ie, desc);
+			else
+				idxd_free_desc(wq, desc);
 			return rc;
 		}
 	}


