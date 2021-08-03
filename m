Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E173DF800
	for <lists+dmaengine@lfdr.de>; Wed,  4 Aug 2021 00:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhHCWh1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Aug 2021 18:37:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:59289 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233171AbhHCWh1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 3 Aug 2021 18:37:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="235750610"
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="235750610"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 15:37:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="479863457"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 15:37:16 -0700
Subject: [PATCH] dmaengine: idxd: clear block on fault flag when clear wq
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 03 Aug 2021 15:37:15 -0700
Message-ID: <162803023553.3086015.8158952172068868803.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The block on fault flag is not cleared when we disable or reset wq. This
causes it to remain set if the user does not clear it on the next
configuration load. Add clear of flag in dxd_wq_disable_cleanup()
routine.

Fixes: da32b28c95a7 ("dmaengine: idxd: cleanup workqueue config after disabling")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 420b93fe5feb..d0b5222da0d9 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -396,6 +396,7 @@ void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	wq->priority = 0;
 	wq->ats_dis = 0;
 	clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
+	clear_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags);
 	memset(wq->name, 0, WQ_NAME_SIZE);
 }
 


