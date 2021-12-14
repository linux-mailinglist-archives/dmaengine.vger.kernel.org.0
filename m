Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3499F474C83
	for <lists+dmaengine@lfdr.de>; Tue, 14 Dec 2021 21:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbhLNUPS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Dec 2021 15:15:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:25493 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229795AbhLNUPS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Dec 2021 15:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639512918; x=1671048918;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NFIXCYcFEwBbOGpuni9SswRm98iTOgbpK/74BEb+ZV0=;
  b=ZdRynlzpACWuJoxYv0bHphidqBxwMpmesWLelpRzgYyxV8FyKsfV+KJN
   3AsZTWSvO+AjQ4gXOttSObWuujOSjZt5v+spc/zpWOtPBdZeSm+QZ+DcC
   4tWWxNW5Llhpyytc2HUu3BiGArKtFJrEo0+vaKmdC8wyjnGuCjF9YApPh
   fiQAi/uvxvV8ICX/C6OkaIPtszdRf9RPL70Gy32vEsQWOD90+CPKuOudr
   JAmiTcMvzEjbnQcc4FIjKqoJRvVLfsi+6vOU0vhdSZ7UnCCTwX4lG8wmZ
   pcBHqGfNJoZ7vB4flAvPA3hWLo4dnacTLDvJ+OyPXJgghmmMUzbZ+kILJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="302454500"
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="302454500"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 12:15:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="463941113"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 12:15:17 -0800
Subject: [PATCH] dmaengine: idxd: fix wq settings post wq disable
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Lucas Van <lucas.van@intel.com>, Lucas Van <lucas.van@intel.com>,
        dmaengine@vger.kernel.org
Date:   Tue, 14 Dec 2021 13:15:17 -0700
Message-ID: <163951291732.2987775.13576571320501115257.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

By the spec, wq size and group association is not changeable unless device
is disabled. Exclude clearing the shadow copy on wq disable/reset. This
allows wq type to be changed after disable to be re-enabled.

Move the size and group association to its own cleanup and only call it
during device disable.

Fixes: 0dcfe41e9a4c ("dmanegine: idxd: cleanup all device related bits after disabling device")
Reported-by: Lucas Van <lucas.van@intel.com>
Tested-by: Lucas Van <lucas.van@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 280b41417f41..3fce7629daa7 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -358,8 +358,6 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	lockdep_assert_held(&wq->wq_lock);
 	memset(wq->wqcfg, 0, idxd->wqcfg_size);
 	wq->type = IDXD_WQT_NONE;
-	wq->size = 0;
-	wq->group = NULL;
 	wq->threshold = 0;
 	wq->priority = 0;
 	wq->ats_dis = 0;
@@ -371,6 +369,15 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	wq->max_batch_size = WQ_DEFAULT_MAX_BATCH;
 }
 
+static void idxd_wq_device_reset_cleanup(struct idxd_wq *wq)
+{
+	lockdep_assert_held(&wq->wq_lock);
+
+	idxd_wq_disable_cleanup(wq);
+	wq->size = 0;
+	wq->group = NULL;
+}
+
 static void idxd_wq_ref_release(struct percpu_ref *ref)
 {
 	struct idxd_wq *wq = container_of(ref, struct idxd_wq, wq_active);
@@ -689,6 +696,7 @@ static void idxd_device_wqs_clear_state(struct idxd_device *idxd)
 
 		if (wq->state == IDXD_WQ_ENABLED) {
 			idxd_wq_disable_cleanup(wq);
+			idxd_wq_device_reset_cleanup(wq);
 			wq->state = IDXD_WQ_DISABLED;
 		}
 	}


