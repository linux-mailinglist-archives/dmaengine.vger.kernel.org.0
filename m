Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E740F518E1C
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 22:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242243AbiECUMh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 16:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242248AbiECUMO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 16:12:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809B54091F
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 13:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651608497; x=1683144497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EbbEXh7fqV+Eq+U9c5rTacCPFidH3eYK07jxNFHa2K0=;
  b=QoRzrzJUJe14YgiaeU68ZurJ56vDBlfMaxntRMiTcNCQvJY9wMQO/pk2
   5kUGs4jV5b5X819toKbzMQoj4IkMtBEoaEr9J1Sfe5US+ThwfpK+CSThu
   jXKvOiOoPnsZEHXSqwzVqtkmK+mLglZUaIbcLl49nbhGkgMC1inmZOIQP
   ynx5N7oFINRxrNUvDSztgXHKqhX0Ns+WBBkyaqt4NYuMR/wEpanh9iUMZ
   WmHqU/GukdatUkftvglVnanQm3CueLnkam5v+qTc01XsjYc/8E1ceWfOV
   hEPmiuKwWGhFge8nOWyVx2FpKepXUeOcQYzqYLQ4jPMz9IDxLsENPHQXi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248118230"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="248118230"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 13:08:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="516705338"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2022 13:08:16 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, mchehab@kernel.org,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v2 09/15] dmaengine: Remove last, used from dma_tx_state
Date:   Tue,  3 May 2022 13:07:22 -0700
Message-Id: <20220503200728.2321188-10-benjamin.walker@intel.com>
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

Nothing uses these and they don't convey usable information.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/dma/dmaengine.h   | 4 ----
 include/linux/dmaengine.h | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index e72876a512a39..08c7bd7cfc229 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -74,8 +74,6 @@ static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
 	complete = chan->completed_cookie;
 	barrier();
 	if (state) {
-		state->last = complete;
-		state->used = used;
 		state->residue = 0;
 		state->in_flight_bytes = 0;
 	}
@@ -96,8 +94,6 @@ static inline void dma_set_tx_state(struct dma_tx_state *st,
 	if (!st)
 		return;
 
-	st->last = last;
-	st->used = used;
 	st->residue = residue;
 }
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 17f210adc14cb..827007146eb94 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -716,16 +716,12 @@ static inline struct dma_async_tx_descriptor *txd_next(struct dma_async_tx_descr
 /**
  * struct dma_tx_state - filled in to report the status of
  * a transfer.
- * @last: last completed DMA cookie
- * @used: last issued DMA cookie (i.e. the one in progress)
  * @residue: the remaining number of bytes left to transmit
  *	on the selected transfer for states DMA_IN_PROGRESS and
  *	DMA_PAUSED if this is implemented in the driver, else 0
  * @in_flight_bytes: amount of data in bytes cached by the DMA.
  */
 struct dma_tx_state {
-	dma_cookie_t last;
-	dma_cookie_t used;
 	u32 residue;
 	u32 in_flight_bytes;
 };
-- 
2.35.1

