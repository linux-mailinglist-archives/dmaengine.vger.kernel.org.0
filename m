Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88B44BC173
	for <lists+dmaengine@lfdr.de>; Fri, 18 Feb 2022 21:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbiBRU4W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Feb 2022 15:56:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239578AbiBRU4V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Feb 2022 15:56:21 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09A4189AB1
        for <dmaengine@vger.kernel.org>; Fri, 18 Feb 2022 12:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645217764; x=1676753764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ye5S5Fhti5NDHBTOu0VS5+fU2jdSdbDIiMwIOSV02UY=;
  b=MkbB3nw52L3cn6DBQO7SW+AeZHrUxkqekOiLP5hi39BJ1uQI7VpZu+d9
   1CiC9ttj3Azal3zHEtugBvUvRZK3R47aN5y2txopEMEaZwqGvWMmeLV+L
   XGLyP86yLPRQaaeEFv2hl7nsezhqJgP7c6nunV15qE8v4W4xzoEzdGi6f
   PsGl2jBY8nyX1uO9HAfsfG47+H1AK41gc1yP16T33O/ALjdVqyJ7GAZb9
   gjAU4EIRDpCWL4enjJqj82qFiuIFEI7IVBS1OX3oCErR7XiUFd/hV48Kx
   7pGX2M94/PrIjigwNt9CrrpSvtHa5hlgfrPZWv5/kpp0FahK/FAaJ7C7V
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="231840025"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="231840025"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 12:56:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="626735643"
Received: from bwalker-desk.ch.intel.com ([143.182.137.126])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Feb 2022 12:56:02 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        okaya@kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v2 4/4] dmaengine: hidma: In hidma_prep_dma_memset treat value as a single byte
Date:   Fri, 18 Feb 2022 13:55:57 -0700
Message-Id: <20220218205557.486208-5-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218205557.486208-1-benjamin.walker@intel.com>
References: <20220218205557.486208-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The value parameter is a single byte, so duplicate it to the 8 byte
range that is used as the pattern.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
Cc: Sinan Kaya <okaya@kernel.org>
---
 drivers/dma/qcom/hidma.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 65d054bb11aaa..d8aa6c0abe126 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -431,6 +431,7 @@ hidma_prep_dma_memset(struct dma_chan *dmach, dma_addr_t dest, int value,
 	struct hidma_desc *mdesc = NULL;
 	struct hidma_dev *mdma = mchan->dmadev;
 	unsigned long irqflags;
+	u64 pattern;
 
 	/* Get free descriptor */
 	spin_lock_irqsave(&mchan->lock, irqflags);
@@ -443,9 +444,19 @@ hidma_prep_dma_memset(struct dma_chan *dmach, dma_addr_t dest, int value,
 	if (!mdesc)
 		return NULL;
 
+	pattern = (unsigned char)value;
+	pattern = (pattern << 56) |
+		  (pattern << 48) |
+		  (pattern << 40) |
+		  (pattern << 32) |
+		  (pattern << 24) |
+		  (pattern << 16) |
+		  (pattern << 8) |
+		  pattern;
+
 	mdesc->desc.flags = flags;
 	hidma_ll_set_transfer_params(mdma->lldev, mdesc->tre_ch,
-				     value, dest, len, flags,
+				     pattern, dest, len, flags,
 				     HIDMA_TRE_MEMSET);
 
 	/* Place descriptor in prepared list */
-- 
2.33.1

