Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE333F6707
	for <lists+dmaengine@lfdr.de>; Tue, 24 Aug 2021 19:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbhHXRaH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Aug 2021 13:30:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:20509 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238998AbhHXR2T (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Aug 2021 13:28:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="197604594"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="197604594"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 10:07:19 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="473561673"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 10:07:19 -0700
Subject: [PATCH] dmaengine: idxd: fix calling wq quiesce inside spinlock
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, dmaengine@vger.kernel.org
Date:   Tue, 24 Aug 2021 10:07:18 -0700
Message-ID: <162982483862.1664188.875626872795324832.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dan reports that smatch has found idxd_wq_quiesce() is being called inside
the idxd->dev_lock. idxd_wq_quiesce() calls wait_for_completion() and
therefore it can sleep. Move the call outside of the spinlock.

Fixes: 5b0c68c473a1 ("dmaengine: idxd: support reporting of halt interrupt")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 4e3a7198c0ca..70705f0bd92c 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -189,8 +189,8 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 			INIT_WORK(&idxd->work, idxd_device_reinit);
 			queue_work(idxd->wq, &idxd->work);
 		} else {
-			spin_lock_bh(&idxd->dev_lock);
 			idxd_wqs_quiesce(idxd);
+			spin_lock_bh(&idxd->dev_lock);
 			idxd_wqs_unmap_portal(idxd);
 			idxd_device_wqs_clear_state(idxd);
 			dev_err(&idxd->pdev->dev,


