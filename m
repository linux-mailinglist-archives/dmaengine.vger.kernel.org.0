Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1434350BD
	for <lists+dmaengine@lfdr.de>; Wed, 20 Oct 2021 18:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhJTQ4K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Oct 2021 12:56:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:31660 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230187AbhJTQ4I (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Oct 2021 12:56:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="227600132"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="227600132"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:53:53 -0700
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="575406155"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:53:53 -0700
Subject: [PATCH 3/7] dmaengine: idxd: move interrupt handle assignment
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Kevin Tian <kevin.tian@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 20 Oct 2021 09:53:52 -0700
Message-ID: <163474883286.2608004.1409032440538989377.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <163474864017.2608004.10983485368237365990.stgit@djiang5-desk3.ch.intel.com>
References: <163474864017.2608004.10983485368237365990.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In preparation of supporting interrupt handle revoke event, move the
interrupt handle assignment to right before the descriptor to be submitted.
This allows the interrupt handle revoke logic to assign the latest
interrupt handle on submission.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/submit.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index d4688f369bc2..df02c5c814e7 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -21,15 +21,6 @@ static struct idxd_desc *__get_desc(struct idxd_wq *wq, int idx, int cpu)
 	if (device_pasid_enabled(idxd))
 		desc->hw->pasid = idxd->pasid;
 
-	/*
-	 * On host, MSIX vecotr 0 is used for misc interrupt. Therefore when we match
-	 * vector 1:1 to the WQ id, we need to add 1
-	 */
-	if (wq->ie->int_handle == INVALID_INT_HANDLE)
-		desc->hw->int_handle = wq->id + 1;
-	else
-		desc->hw->int_handle = wq->ie->int_handle;
-
 	return desc;
 }
 
@@ -160,6 +151,11 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	 */
 	if (desc->hw->flags & IDXD_OP_FLAG_RCI) {
 		ie = wq->ie;
+		if (ie->int_handle == INVALID_INT_HANDLE)
+			desc->hw->int_handle = ie->id;
+		else
+			desc->hw->int_handle = ie->int_handle;
+
 		llist_add(&desc->llnode, &ie->pending_llist);
 	}
 


