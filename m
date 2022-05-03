Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42229518E13
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 22:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242228AbiECUMf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 16:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237700AbiECUMU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 16:12:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5134092C
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 13:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651608500; x=1683144500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8kVLYvPbcNoatEokGPXxnoQICDXSPYXK/lbnKDbF9mc=;
  b=DRd0yvl0HLrlHR4L1ZsPsHnUGE76ipqoM7olwtsTltK+Ne9DmilgCkOk
   GFJ2E2cpjBF7cFeP0FNtqKCVS8bVnoY7iU2MK0S2vcxHOylV35FpNyCXQ
   Z7XSri0DvA/20ZwVhJ0Bv4pqL+gzyej0gRL/OJASCMq+RLNsbxxFm9CD8
   OZPtOA9ZZ+Wa0dpYo/q2QKFweaTW/i8oXOcAFsV498eYskbrDspsci6I6
   VDaaG8oo5+kyUGiG60w4gEj6wdR7cXwve6mdeVccX8QpI+HK72gKVHMWb
   K397+L4DDEoW7CmF4qdvyNDbTzk/tmUnJqLloeXl6W3zCp1LBadPpFLqQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248118233"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="248118233"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 13:08:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="516705352"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2022 13:08:20 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, mchehab@kernel.org,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v2 10/15] dmaengine: Providers should prefer dma_set_residue over dma_set_tx_state
Date:   Tue,  3 May 2022 13:07:23 -0700
Message-Id: <20220503200728.2321188-11-benjamin.walker@intel.com>
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

The dma_set_tx_state function will go away shortly. The two functions
are functionally equivalent.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/dma/imx-sdma.c | 3 +--
 drivers/dma/mmp_tdma.c | 3 +--
 drivers/dma/mxs-dma.c  | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 70c0aa931ddf4..f1ef059da4652 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1750,8 +1750,7 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 
 	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 
-	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
-			 residue);
+	dma_set_residue(txstate, residue);
 
 	return sdmac->status;
 }
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index a262e0eb4cc94..753b431ca206b 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -539,8 +539,7 @@ static enum dma_status mmp_tdma_tx_status(struct dma_chan *chan,
 	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
 
 	tdmac->pos = mmp_tdma_get_pos(tdmac);
-	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
-			 tdmac->buf_len - tdmac->pos);
+	dma_set_residue(txstate, tdmac->buf_len - tdmac->pos);
 
 	return tdmac->status;
 }
diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 994fc4d2aca42..ab9eca6d682dc 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -664,8 +664,7 @@ static enum dma_status mxs_dma_tx_status(struct dma_chan *chan,
 		residue -= bar;
 	}
 
-	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
-			residue);
+	dma_set_residue(txstate, residue);
 
 	return mxs_chan->status;
 }
-- 
2.35.1

