Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D13518E00
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 22:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242183AbiECUMX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 16:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242203AbiECULr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 16:11:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269EE40A22
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 13:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651608482; x=1683144482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ish3zyb3wTve90XvFtu1kIGKvniKF9Xm9CuOEXgIDNE=;
  b=Nv5qu3iz6fB8PT3IASL6KRGIYlcPqNUJicntgG02ZnnlaYEi7msUY3vV
   NQVdiKGJWGawmJ3m1Q1lxaBGNckY/bo10x38aQsFS9iyVopRZZo7PZotB
   LiY+ESjDZcS31uXy0PuuOvEpeHODrPPPcI0vI+g9TRI3SBBDO3vafj8U0
   iI5b8QTTWiHSdlLJbPyc1GTNjUPLZl2YY31WGF7+MHKBcxDedmB7MSBx8
   qrzjXbQSZkhpBncrksob16pBnIafR7LDH75yxXU2cLN0vVzw5nCTLjXdh
   mNYI46EFjzeRy31Qfe223BpW3H4Q2aerD9HXUooF2fFuhQLw8GdP23Jrj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="328116032"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="328116032"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 13:08:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="516705197"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2022 13:08:01 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, mchehab@kernel.org,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v2 05/15] media: omap_vout: Use dmaengine_async_is_tx_complete
Date:   Tue,  3 May 2022 13:07:18 -0700
Message-Id: <20220503200728.2321188-6-benjamin.walker@intel.com>
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
 drivers/media/platform/omap/omap_vout_vrfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/omap/omap_vout_vrfb.c b/drivers/media/platform/omap/omap_vout_vrfb.c
index 0cfa0169875f0..b9d252d5ced7a 100644
--- a/drivers/media/platform/omap/omap_vout_vrfb.c
+++ b/drivers/media/platform/omap/omap_vout_vrfb.c
@@ -289,7 +289,7 @@ int omap_vout_prepare_vrfb(struct omap_vout_device *vout,
 					 vout->vrfb_dma_tx.tx_status == 1,
 					 VRFB_TX_TIMEOUT);
 
-	status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
+	status = dmaengine_async_is_tx_complete(chan, cookie);
 
 	if (vout->vrfb_dma_tx.tx_status == 0) {
 		pr_err("%s: Timeout while waiting for DMA\n", __func__);
-- 
2.35.1

