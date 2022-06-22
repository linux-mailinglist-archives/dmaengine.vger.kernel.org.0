Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BF25554C3
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 21:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359030AbiFVTi7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 15:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359422AbiFVTie (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 15:38:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5333FBDC;
        Wed, 22 Jun 2022 12:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655926707; x=1687462707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rxtiNyNtO5EyD9cgkO5xlvGIWGQfoth0aAfPim6bRtk=;
  b=Zz/xgudcs9GuUm5GHzhGvnww0QTGSv4PeIQOBuRggsKN2zwzAAxmtOYO
   0ZjoyvREB5uVHEugoVpAt2oozlou0eYeH4Lai20vJtKjkdjCvNUhRPD9f
   ghep/E3sYffz8QAZ4whKhTBMPMJD/nbh5/n5iX+M+C98JeCSBFCfDC3Sf
   Hlc+UTz4wh8hF7zRc4gPdam0moUaQ/spTSOGiwad/+JhqsX7LwTWS5hCs
   nH+P9YU86sBfk/e53WOpc1ssHB0NV6ayf+xrNFAfC8xsu8sPjVI1tpS3W
   sAAPb0TVXQV2nxH0soH0yIwblmwU+sx6RnZ6YuzZmmMDUGB0tEQYLhil9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="305983085"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="305983085"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 12:38:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="715542088"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2022 12:38:26 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        mporter@kernel.crashing.org
Subject: [PATCH v4 06/15] rapidio: Use dmaengine_async_is_tx_complete
Date:   Wed, 22 Jun 2022 12:37:44 -0700
Message-Id: <20220622193753.3044206-7-benjamin.walker@intel.com>
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

Cc: mporter@kernel.crashing.org
Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 2cdc054e53a53..d4108ff2bb74c 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -597,8 +597,7 @@ static void dma_xfer_callback(void *param)
 	struct mport_dma_req *req = (struct mport_dma_req *)param;
 	struct mport_cdev_priv *priv = req->priv;
 
-	req->status = dma_async_is_tx_complete(priv->dmach, req->cookie,
-					       NULL, NULL);
+	req->status = dmaengine_async_is_tx_complete(priv->dmach, req->cookie);
 	complete(&req->req_comp);
 	kref_put(&req->refcount, dma_req_free);
 }
-- 
2.35.1

