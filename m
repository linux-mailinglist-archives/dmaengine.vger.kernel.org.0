Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD994C9301
	for <lists+dmaengine@lfdr.de>; Tue,  1 Mar 2022 19:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiCAS0v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Mar 2022 13:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbiCAS0u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Mar 2022 13:26:50 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6365652EE
        for <dmaengine@vger.kernel.org>; Tue,  1 Mar 2022 10:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646159168; x=1677695168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kZrSr49I3pBw2GyviO8mj5JC8QqGYy6NSU4Xu8j1i4s=;
  b=eX1QDOXXaAM0GiCODmWwhXkYFp7wOW4n9+ArH0feuVm8yAhOVnsezHT3
   KWlM/vPfm0ofHwh/AEE5B6reBB9VGbXP9WFxLBti3YIFNWukz9zrxoa/G
   6cMEmnu+D4t8Ep2hzwPrpo+08ri2vFGulhHTFt/Uy/drZHfVu951XvH1b
   HaYjMMaOcQ5dLfT5I9/phjUBJi0wjSGZ/phUCaX9SdlqJNwElbCGMNEe9
   Ds3LiRslfD6V1gPfm8vMp4uV4i2vYjWFpLGBKuqf1B7p9KKuFuc+U2N9r
   IosGP+64SB0SIbsWBvCSUyrqcBtjr8jB1bxheqgzLsfevWo1dQJx5JkND
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="252940746"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="252940746"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 10:26:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="630110245"
Received: from bwalker-desk.ch.intel.com ([143.182.137.126])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Mar 2022 10:26:07 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        okaya@kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v3 4/4] dmaengine: hidma: In hidma_prep_dma_memset treat value as a single byte
Date:   Tue,  1 Mar 2022 11:25:51 -0700
Message-Id: <20220301182551.883474-5-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301182551.883474-1-benjamin.walker@intel.com>
References: <20220301182551.883474-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 65d054bb11aaa..e455957e3ff98 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -431,6 +431,7 @@ hidma_prep_dma_memset(struct dma_chan *dmach, dma_addr_t dest, int value,
 	struct hidma_desc *mdesc = NULL;
 	struct hidma_dev *mdma = mchan->dmadev;
 	unsigned long irqflags;
+	u64 byte_pattern, fill_pattern;
 
 	/* Get free descriptor */
 	spin_lock_irqsave(&mchan->lock, irqflags);
@@ -443,9 +444,19 @@ hidma_prep_dma_memset(struct dma_chan *dmach, dma_addr_t dest, int value,
 	if (!mdesc)
 		return NULL;
 
+	byte_pattern = (char)value;
+	fill_pattern =	(byte_pattern << 56) |
+			(byte_pattern << 48) |
+			(byte_pattern << 40) |
+			(byte_pattern << 32) |
+			(byte_pattern << 24) |
+			(byte_pattern << 16) |
+			(byte_pattern << 8) |
+			byte_pattern;
+
 	mdesc->desc.flags = flags;
 	hidma_ll_set_transfer_params(mdma->lldev, mdesc->tre_ch,
-				     value, dest, len, flags,
+				     fill_pattern, dest, len, flags,
 				     HIDMA_TRE_MEMSET);
 
 	/* Place descriptor in prepared list */
-- 
2.35.1

