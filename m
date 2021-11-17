Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD40454BEB
	for <lists+dmaengine@lfdr.de>; Wed, 17 Nov 2021 18:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239386AbhKQR2A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Nov 2021 12:28:00 -0500
Received: from mga17.intel.com ([192.55.52.151]:12749 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239381AbhKQR1z (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 17 Nov 2021 12:27:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="214720639"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="214720639"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 09:03:52 -0800
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="507004944"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 09:03:52 -0800
Subject: [PATCH v3] dmaengine: idxd: fix calling wq quiesce inside spinlock
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, dmaengine@vger.kernel.org
Date:   Wed, 17 Nov 2021 10:03:51 -0700
Message-ID: <163716858508.1721911.15051495873516709923.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dan reports that smatch has found idxd_wq_quiesce() is being called inside
the idxd->dev_lock. idxd_wq_quiesce() calls wait_for_completion() and
therefore it can sleep. Move the call outside of the spinlock as it does
not need device lock.

Fixes: 5b0c68c473a1 ("dmaengine: idxd: support reporting of halt interrupt")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v3:
Rebase against 5.16-rc dmaengine/fixes

v2:
Rebase against 5.15-rc dmaengine/fixes

 drivers/dma/idxd/irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 17f2f8a31b63..cf2c8bc4f147 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -137,10 +137,10 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 			INIT_WORK(&idxd->work, idxd_device_reinit);
 			queue_work(idxd->wq, &idxd->work);
 		} else {
-			spin_lock(&idxd->dev_lock);
 			idxd->state = IDXD_DEV_HALTED;
 			idxd_wqs_quiesce(idxd);
 			idxd_wqs_unmap_portal(idxd);
+			spin_lock(&idxd->dev_lock);
 			idxd_device_clear_state(idxd);
 			dev_err(&idxd->pdev->dev,
 				"idxd halted, need %s.\n",


