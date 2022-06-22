Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04F05554AB
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 21:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiFVTi6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 15:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359276AbiFVTid (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 15:38:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE1C1E3DF;
        Wed, 22 Jun 2022 12:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655926705; x=1687462705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gbvWe3wuebpXvIG3UZFFzQ35e3K5lS8i3GMHJ5GABAs=;
  b=GbL3x+4mUkmP8wU9N1DeXcOo18uu6Sp+I8+RXC0SOyf7MUY1e4gd9c7Q
   3FLDEjf/3afHJzdQQDrm5bu0WA4eDZj25yLlI422pfozCkr9X2HddmTPY
   kJfk6iqovFon69W55Nfotsj/5fd3WCO1sJmGIygsMl2LdAb4u+IuSxpx/
   Xzf3a1qa9IFHOV/SiNwYcWgNLNNF3oDGMNG7Jv9KT9wVqpcf6JQpf4iG7
   fw4Bjxj/5jrbBvIbnmlaVP3LlwAuhPr/lfrS48iv4xmk8SWruSAVxVH6Y
   8LWm+0zsDzZvyr1bkaaGohA7jIllm+a3lscPAaI6GPO9y7rMRMS/KpKYK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="305983081"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="305983081"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 12:38:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="715542085"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2022 12:38:25 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v4 05/15] media: omap_vout: Use dmaengine_async_is_tx_complete
Date:   Wed, 22 Jun 2022 12:37:43 -0700
Message-Id: <20220622193753.3044206-6-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220622193753.3044206-1-benjamin.walker@intel.com>
References: <20220503200728.2321188-1-benjamin.walker@intel.com>
 <20220622193753.3044206-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Replace dma_async_is_tx_complete with dmaengine_async_is_tx_complete.
The previous API will be removed in favor of the new one.

Cc: linux-media@vger.kernel.org
Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/media/platform/ti/omap/omap_vout_vrfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/omap/omap_vout_vrfb.c b/drivers/media/platform/ti/omap/omap_vout_vrfb.c
index 0cfa0169875f0..b9d252d5ced7a 100644
--- a/drivers/media/platform/ti/omap/omap_vout_vrfb.c
+++ b/drivers/media/platform/ti/omap/omap_vout_vrfb.c
@@ -289,7 +289,7 @@ int omap_vout_prepare_vrfb(struct omap_vout_device *vout,
 					 vout->vrfb_dma_tx.tx_status == 1,
 					 VRFB_TX_TIMEOUT);
 
-	status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
+	status = dmaengine_async_is_tx_complete(chan, cookie);
 
 	if (vout->vrfb_dma_tx.tx_status == 0) {
 		pr_err("%s: Timeout while waiting for DMA\n", __func__);
-- 
2.35.1

