Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746D6640D15
	for <lists+dmaengine@lfdr.de>; Fri,  2 Dec 2022 19:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiLBSZW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Dec 2022 13:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiLBSZS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Dec 2022 13:25:18 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEA1D968C;
        Fri,  2 Dec 2022 10:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670005517; x=1701541517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DcNpbgzbhgDxbBHlo+d3SX0ORto3+aP3skhZTZ4ZTMg=;
  b=hXSgSOnY4hP0HNGYRFAYldou87uKicvA3lblLscr6hfdAAB4PvYoG9qO
   Ix8sTKFK9zjYwZ7+2PuHerXYeL/RUpsMhn8n5NJkVdw1sznHTG6j4BJ5J
   La8xmHgxFuyDQOPjB7fBFSOZHCJlHQ+NAJPT/o6Ce1BgA570n9iPjyALW
   8CIprwxS7Gt+ueeW4FR/3fHEGfcG1CHjFtUsk0r4dEIrQvzM6AcRT4PVm
   j9WNxFkemYV5PgZo3kp6HTs5ojxOfXOmLnOc3BIxcrbGFVRH3kHXC+b6U
   d9eRh8wcaRdd5WhrKNFOPZ3g24B52XsOGEe9/eBQq0DMuE6ZQVXdQWu7I
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="378166719"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="378166719"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:25:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="622786440"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="622786440"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:25:15 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     fenghua.yu@intel.com, dave.jiang@intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dmaengine: idxd: Prevent use after free on completion memory
Date:   Fri,  2 Dec 2022 10:25:05 -0800
Message-Id: <96e5bcd4b97445227837c3a73e1a1abd93d26175.1670005163.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1670005163.git.reinette.chatre@intel.com>
References: <cover.1670005163.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On driver unload any pending descriptors are flushed at the
time the interrupt is freed:
idxd_dmaengine_drv_remove() ->
	drv_disable_wq() ->
		idxd_wq_free_irq() ->
			idxd_flush_pending_descs().

If there are any descriptors present that need to be flushed this
flow triggers a "not present" page fault as below:

 BUG: unable to handle page fault for address: ff391c97c70c9040
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page

The address that triggers the fault is the address of the
descriptor that was freed moments earlier via:
drv_disable_wq()->idxd_wq_free_resources()

Fix the use after free by freeing the descriptors after any possible
usage. This is done after idxd_wq_reset() to ensure that the memory
remains accessible during possible completion writes by the device.

Fixes: 63c14ae6c161 ("dmaengine: idxd: refactor wq driver enable/disable operations")
Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 drivers/dma/idxd/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index fcd03d29a941..b4d7bb923a40 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1408,11 +1408,11 @@ void drv_disable_wq(struct idxd_wq *wq)
 		dev_warn(dev, "Clients has claim on wq %d: %d\n",
 			 wq->id, idxd_wq_refcount(wq));
 
-	idxd_wq_free_resources(wq);
 	idxd_wq_unmap_portal(wq);
 	idxd_wq_drain(wq);
 	idxd_wq_free_irq(wq);
 	idxd_wq_reset(wq);
+	idxd_wq_free_resources(wq);
 	percpu_ref_exit(&wq->wq_active);
 	wq->type = IDXD_WQT_NONE;
 	wq->client_count = 0;
-- 
2.34.1

