Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEC1518E01
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 22:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiECUMY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 16:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238249AbiECUMO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 16:12:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7161840A33
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651608489; x=1683144489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xyHbfLI8a8CgyYpiH8fYGNSYJmN0GXzH1CH937wfWH8=;
  b=evNARNBfHyHkrAgzhMA33kYIRmYmyeSB1wd5Ej2nzMGM2gjYzM2dGtnr
   LHR3DrREm8h/1wODAJS/qCUliVtVvam2jH9jAUCX1Q3pCZT4CuW1qHYm2
   MtIMi/5XN+KOS9QWBdrZLdCVy08PUnejvegj+lafIOGLhMw9Un6LE8LuA
   ORV+2nxnrlpQc04YM8E5ebk4hUg4AkIZW98jjx29ruMT4n3p27YYHcEF9
   ir9chQQZ/EAIl/yHIf9yo00ljg+nHI3NhW8Zs6atng2MAYB6HdP4O8lAV
   vPVbtJerTFmCtzVqsCLfyOg4yOW6Gc8BMlwmI3LbU3xhnNZQQfKW5Gftv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248118185"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="248118185"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 13:08:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="516705260"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2022 13:08:08 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, mchehab@kernel.org,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v2 06/15] rapidio: Use dmaengine_async_is_tx_complete
Date:   Tue,  3 May 2022 13:07:19 -0700
Message-Id: <20220503200728.2321188-7-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200728.2321188-1-benjamin.walker@intel.com>
References: <20220503200728.2321188-1-benjamin.walker@intel.com>
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
 drivers/rapidio/devices/rio_mport_cdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 7df466e222820..ca66dbfef9c59 100644
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

