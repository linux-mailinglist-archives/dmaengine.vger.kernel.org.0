Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255284CDF83
	for <lists+dmaengine@lfdr.de>; Fri,  4 Mar 2022 22:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiCDVDr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Mar 2022 16:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiCDVDq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Mar 2022 16:03:46 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576766D39B
        for <dmaengine@vger.kernel.org>; Fri,  4 Mar 2022 13:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646427778; x=1677963778;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nhzNjFupXuJWj8fd+YeWK+cCcO1djXdezt1YUNdS5ds=;
  b=kr1FgqQKPy4WHxPsYQGEDt56qkGi7WONEMXr59twRSplKBYfWkzEaQX0
   KiBclIwKCfN5EWqcEMzHBtNn9FjX67GM6Tcwj6yDcDLcqJVx5JtSQ70CJ
   tCwmp1EquQ2R2c1D5kAHZ81YKo5BohYyUVFc7O+fu0k7D7XcGGgK9asds
   p/FZ/UTIC0TTPLnSIPfuzGhFgxpecLvKs7QGgoav63SatVMvSuJI0wRjx
   g4Icla6Ahh9+1nATSOxR9oS+5lWyUSa6kZCRQyWu9vbjklZNVJ+w2UW1b
   XHSEZseRlk+1EVi4o7hKd6IidXfOIronbnFPULrY+IrFinLN2mxBLMOil
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="278755692"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="278755692"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 13:02:58 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="494445091"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 13:02:57 -0800
Subject: [PATCH] dmaengine: idxd: move wq irq enabling to after device enable
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Fri, 04 Mar 2022 14:02:57 -0700
Message-ID: <164642777730.179702.1880317757087484299.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move the calling of request_irq() and other related irq setup code until
after the WQ is successfully enabled. This reduces the amount of
setup/teardown if the wq is not configured correctly and cannot be enabled.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/dma.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index bfff59617d04..13a113ff9806 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -290,13 +290,6 @@ static int idxd_dmaengine_drv_probe(struct idxd_dev *idxd_dev)
 	mutex_lock(&wq->wq_lock);
 	wq->type = IDXD_WQT_KERNEL;
 
-	rc = idxd_wq_request_irq(wq);
-	if (rc < 0) {
-		idxd->cmd_status = IDXD_SCMD_WQ_IRQ_ERR;
-		dev_dbg(dev, "WQ %d irq setup failed: %d\n", wq->id, rc);
-		goto err_irq;
-	}
-
 	rc = __drv_enable_wq(wq);
 	if (rc < 0) {
 		dev_dbg(dev, "Enable wq %d failed: %d\n", wq->id, rc);
@@ -304,6 +297,13 @@ static int idxd_dmaengine_drv_probe(struct idxd_dev *idxd_dev)
 		goto err;
 	}
 
+	rc = idxd_wq_request_irq(wq);
+	if (rc < 0) {
+		idxd->cmd_status = IDXD_SCMD_WQ_IRQ_ERR;
+		dev_dbg(dev, "WQ %d irq setup failed: %d\n", wq->id, rc);
+		goto err_irq;
+	}
+
 	rc = idxd_wq_alloc_resources(wq);
 	if (rc < 0) {
 		idxd->cmd_status = IDXD_SCMD_WQ_RES_ALLOC_ERR;
@@ -335,10 +335,10 @@ static int idxd_dmaengine_drv_probe(struct idxd_dev *idxd_dev)
 err_ref:
 	idxd_wq_free_resources(wq);
 err_res_alloc:
-	__drv_disable_wq(wq);
-err:
 	idxd_wq_free_irq(wq);
 err_irq:
+	__drv_disable_wq(wq);
+err:
 	wq->type = IDXD_WQT_NONE;
 	mutex_unlock(&wq->wq_lock);
 	return rc;


