Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30A4518DFF
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 22:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240991AbiECUMW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 16:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242229AbiECULq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 16:11:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9128A40A17
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 13:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651608478; x=1683144478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=prwrS1jSAxwYJXS6zrdVXKa0GwZvymzpmn7Mdh5vPkw=;
  b=CfTT/crKlKXyqx/vUfsmw2mBpolSKUhsOBrVL0ko2tsrf7mLMpns0Szy
   0JYi0I+toibEWysaD03dHb2KFxWy9A3duANjyrQXhR9t41TaZx3i/AOCz
   nAvRcO1r63eb8X61Hme6fJbw+Co2htWmPtUQIkRyoxJ0EmcNXnQWac4ly
   KiMg8CM0LmHb5HN9OQFKUxMdHIzTH0vka/T7cc+vFXKllwBbPgjKQ0nG4
   skQbSU+HX/YYrJ4XkKDNM9o9A66Gxl3qbMr61Z8zET9P4Uq2vOB/U1LpL
   xscmAoITGGNdP5AEyQ9bBVBaOMT/ZjrSibeqPucm4KARKEHeBDXy1fDdQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="328116024"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="328116024"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 13:07:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="516705169"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2022 13:07:58 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, mchehab@kernel.org,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v2 04/15] crypto: stm32/hash: Use dmaengine_async_is_tx_complete
Date:   Tue,  3 May 2022 13:07:17 -0700
Message-Id: <20220503200728.2321188-5-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200728.2321188-1-benjamin.walker@intel.com>
References: <20220503200728.2321188-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
 drivers/crypto/stm32/stm32-hash.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index d33006d43f761..aef447847c499 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -453,8 +453,7 @@ static int stm32_hash_xmit_dma(struct stm32_hash_dev *hdev,
 					 msecs_to_jiffies(100)))
 		err = -ETIMEDOUT;
 
-	if (dma_async_is_tx_complete(hdev->dma_lch, cookie,
-				     NULL, NULL) != DMA_COMPLETE)
+	if (dmaengine_async_is_tx_complete(hdev->dma_lch, cookie) != DMA_COMPLETE)
 		err = -ETIMEDOUT;
 
 	if (err) {
-- 
2.35.1

