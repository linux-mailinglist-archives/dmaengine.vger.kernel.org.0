Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AD45554BA
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 21:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359139AbiFVTjF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 15:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359791AbiFVTig (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 15:38:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4863FD9C;
        Wed, 22 Jun 2022 12:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655926712; x=1687462712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EnJ5Su7RR3jjj7To4p4p1aGGCrzCsNhKtD7qZhiBzvo=;
  b=Sjze+mQBQsh2D+dsaQwdj8Ddsp+xiVrKOrGsEY49cxito6hnpeHb4R/u
   cnAZdByUX6o0oJmgeCEoqKKKuwwOilNrmNDT3TAQNc5wSqrrpq1xYRkE7
   PBgdwuvTkxJDOjIyjw6UeQjTACMu9JkVTVvc1FJLAzOAiIpfIJrjDVZP0
   FcdeqedqrzgsDFVuVlne/Lpcw5xLt9YJzjvwJMdt4KU17ldsQplPHWO5q
   kiM+O9vUmj6As/1HC8iCcUk19QwqbUEtGkjKs8pykMc1cFO2Ej+1UT3o9
   QKt7MWAWgCN++HPS2pCBZ2Dkyag+qedAN7LWaE3r6d0Zunp9xfBZk60de
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="305983108"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="305983108"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 12:38:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="715542102"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2022 12:38:31 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/15] dmaengine: Remove dma_set_tx_state
Date:   Wed, 22 Jun 2022 12:37:49 -0700
Message-Id: <20220622193753.3044206-12-benjamin.walker@intel.com>
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

