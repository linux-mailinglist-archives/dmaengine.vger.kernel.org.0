Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2853C8B19
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 20:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239842AbhGNSle (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 14:41:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:33901 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhGNSle (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 14:41:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="271519510"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="271519510"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 11:38:42 -0700
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="494612254"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 11:38:41 -0700
Subject: [PATCH] dmaengine: idxd: fix desc->vector that isn't being updated
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Wed, 14 Jul 2021 11:38:41 -0700
Message-ID: <162628784374.353761.4736602409627820431.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Missing update for desc->vector when the wq vector gets updated. This
causes the desc->vector to always be at 0.

Fixes: da435aedb00a ("dmaengine: idxd: fix array index when int_handles are being used")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

Hi Vinod,
Found this testing the fixes branch. Not sure if you can just squash it
with da435aedb00a. Thanks.

 drivers/dma/idxd/submit.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index e29887528077..21d7d09f73dd 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -25,11 +25,10 @@ static struct idxd_desc *__get_desc(struct idxd_wq *wq, int idx, int cpu)
 	 * Descriptor completion vectors are 1...N for MSIX. We will round
 	 * robin through the N vectors.
 	 */
-	wq->vec_ptr = (wq->vec_ptr % idxd->num_wq_irqs) + 1;
+	wq->vec_ptr = desc->vector = (wq->vec_ptr % idxd->num_wq_irqs) + 1;
 	if (!idxd->int_handles) {
 		desc->hw->int_handle = wq->vec_ptr;
 	} else {
-		desc->vector = wq->vec_ptr;
 		/*
 		 * int_handles are only for descriptor completion. However for device
 		 * MSIX enumeration, vec 0 is used for misc interrupts. Therefore even


