Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0400440E8EE
	for <lists+dmaengine@lfdr.de>; Thu, 16 Sep 2021 20:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350123AbhIPRpc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Sep 2021 13:45:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:38186 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355905AbhIPRmO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 Sep 2021 13:42:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="202118455"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="202118455"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 10:37:21 -0700
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="545801480"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 10:37:20 -0700
Subject: [PATCH v2] dmaengine: idxd: fix calling wq quiesce inside spinlock
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, dmaengine@vger.kernel.org
Date:   Thu, 16 Sep 2021 10:37:19 -0700
Message-ID: <163181382406.3230977.5529152212158977884.stgit@djiang5-desk3.ch.intel.com>
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

v2:
Rebase against 5.15-rc dmaengine/fixes

 drivers/dma/idxd/irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index ca88fa7a328e..1fe24b1b24be 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -133,8 +133,8 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 			INIT_WORK(&idxd->work, idxd_device_reinit);
 			queue_work(idxd->wq, &idxd->work);
 		} else {
-			spin_lock(&idxd->dev_lock);
 			idxd_wqs_quiesce(idxd);
+			spin_lock(&idxd->dev_lock);
 			idxd_wqs_unmap_portal(idxd);
 			idxd_device_clear_state(idxd);
 			dev_err(&idxd->pdev->dev,


