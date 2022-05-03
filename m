Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988ED518E10
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 22:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242165AbiECUM2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 16:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242212AbiECUMV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 16:12:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED80B4093F
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 13:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651608503; x=1683144503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EnJ5Su7RR3jjj7To4p4p1aGGCrzCsNhKtD7qZhiBzvo=;
  b=iRWN7xeMTdOnrb6jpT2W/WwaGw83veYD2yM4pwof3sY0dGkeJs+hhxdn
   CHQ2ep+DpS2yYc5wYji77DagM1FTAh6kUhgYybYyl8vX3ziYAW1ULfZI5
   jEcQDH2tLdx0Lc1H/KKWzdxwcc8zaXThoRBo9XXUvGtP0jQr2MU+PA5Zz
   H3yzwV8O50EY75jWm87WymsBo7RYQD3FHF8Bc5B5TPhSh+t88G4D/SpXu
   lhai+UBE3ohMeF2SOuEzKf6qg8o82gPJ7p8CaX4uVLQ/J7aT1iyKR0SQ1
   q6fdYZLf0sXZhgjrvpmNs7uZ+Sla0Gdhc3kGqtXt/LNLBOsPYiQbIhxGq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248118243"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="248118243"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 13:08:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="516705365"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2022 13:08:23 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, mchehab@kernel.org,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v2 11/15] dmaengine: Remove dma_set_tx_state
Date:   Tue,  3 May 2022 13:07:24 -0700
Message-Id: <20220503200728.2321188-12-benjamin.walker@intel.com>
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

Nothing calls this anymore.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/dma/dmaengine.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index 08c7bd7cfc229..7a5203175e6a8 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -88,15 +88,6 @@ static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
 	return DMA_IN_PROGRESS;
 }
 
-static inline void dma_set_tx_state(struct dma_tx_state *st,
-	dma_cookie_t last, dma_cookie_t used, u32 residue)
-{
-	if (!st)
-		return;
-
-	st->residue = residue;
-}
-
 static inline void dma_set_residue(struct dma_tx_state *state, u32 residue)
 {
 	if (state)
-- 
2.35.1

