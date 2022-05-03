Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5F4518E02
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 22:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbiECUMZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 16:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242208AbiECUMO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 16:12:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F21403EE
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 13:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651608493; x=1683144493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zJw+avBBfzNjSAH0rdstJtKW9T+bmcZv7PFzprtJRhE=;
  b=HywMcvMcZ28mhWEJ4RsStnFeqXjhPKJcpHqu4iaFazi8RmwvvY1E5HlW
   F25/arTidtTmWHzyIVAWNEOwkvpf5/Op5G6RLTlgFEO3rFSjPXT0F5mUj
   ESgOvkViE2MqXhvqdVp70KTIMnclGeyKghDTd/V78S/ejRDKj3M8NuojU
   mKsxDs92Ry5iwy53NfD7DHR9mE3EozMfKocGfZbn4H5ckt2ksUcqumIYR
   iXm2ykXf67w1OL5VClW2kkXaEArNo5tE5WLEtGniRRcDOW2TM/KVgUKSJ
   7pvvormm5CdawPMxv67hyFQq/9z2pVXlXRcXm2o1cOWwGFYBi0pY5PthH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248118212"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="248118212"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 13:08:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="516705307"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2022 13:08:13 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, mchehab@kernel.org,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v2 08/15] dmaengine: Remove dma_async_is_tx_complete
Date:   Tue,  3 May 2022 13:07:21 -0700
Message-Id: <20220503200728.2321188-9-benjamin.walker@intel.com>
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

Everything has now been converted over to
dmaengine_async_is_tx_complete, so this can be removed.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 include/linux/dmaengine.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 7143b2ecdd451..17f210adc14cb 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1432,33 +1432,6 @@ static inline void dma_async_issue_pending(struct dma_chan *chan)
 	chan->device->device_issue_pending(chan);
 }
 
-/**
- * dma_async_is_tx_complete - poll for transaction completion
- * @chan: DMA channel
- * @cookie: transaction identifier to check status of
- * @last: returns last completed cookie, can be NULL
- * @used: returns last issued cookie, can be NULL
- *
- * Note: This is deprecated. Use dmaengine_async_is_tx_complete instead.
- *
- * If @last and @used are passed in, upon return they reflect the most
- * recently submitted (used) cookie and the most recently completed
- * cookie.
- */
-static inline enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
-	dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
-{
-	struct dma_tx_state state;
-	enum dma_status status;
-
-	status = chan->device->device_tx_status(chan, cookie, &state);
-	if (last)
-		*last = state.last;
-	if (used)
-		*used = state.used;
-	return status;
-}
-
 /**
  * dmaengine_async_is_tx_complete - poll for transaction completion
  * @chan: DMA channel
-- 
2.35.1

