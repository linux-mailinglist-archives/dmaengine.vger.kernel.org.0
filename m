Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8831C5553C7
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 20:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377462AbiFVSx4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 14:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377653AbiFVSxm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 14:53:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD7113D48;
        Wed, 22 Jun 2022 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655924022; x=1687460022;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AB3cAAcRQW4TmT5qekQ4d5dW7yS1CUxswfYcbNlIyZE=;
  b=ABx8DCn3qGnvHLsKQv9+9zYTJAci8IryEYmg1wm5hJcDN/srvw4Udane
   kw+dqxPZB5aNOAlxoLFM0V8I06gP6zAxC0IFzgPPhGCGyJJaE0NdzyIOt
   y6N+R6ngP7aalNKi+DS8bap0seLm/Z7slKtU1pRfpKLkv4o4fDoyswAzf
   1g63iSaBRA8ax7PJ2Tf1f5rw+h5FojHrKyenl5h87agfGHalCbVdzhyMi
   Q6qRgLwZSgkT4xvWq2/SdogYAWKlqfj2wvq4lNp3nEW9P7JoBQInXmuwj
   GJn+UNCJBQ5bkjiUnE0750L9RyBh3SXImr6A4FdkgurlWnuPGA4hpVXnQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="260949207"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="260949207"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 11:53:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="621030139"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2022 11:53:41 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v3 05/15] media: omap_vout: Use dmaengine_async_is_tx_complete
Date:   Wed, 22 Jun 2022 11:53:32 -0700
Message-Id: <20220622185332.3043574-1-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Replace dma_async_is_tx_complete with dmaengine_async_is_tx_complete.
The previous API will be removed in favor of the new one.

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

