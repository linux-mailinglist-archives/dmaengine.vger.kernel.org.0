Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFDC5553AA
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 20:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377637AbiFVSx0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 14:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377455AbiFVSxY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 14:53:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415C514D0D;
        Wed, 22 Jun 2022 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655924004; x=1687460004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HyqXe3YpcG69L/CqKIXcDkqKitmqxyYJrgqY1yf4XoQ=;
  b=I0FPSNRoVqe/hgDm86MOJ7FuuIqpP12oKcAiRHav0R6M6UzcTNpkIs/8
   3Grs5MXk/4ET2CEKzxHgnLlZnspzqhkDFz42SXVnmo+BcDyahGygwt0WZ
   yFxlKkvyheXm13+BTzvN6EGGOpsAGYnKMWFnI29+m6Ym6yHYAOElD5D74
   jO0e8NNVLQESTkN5JA4gd/Uqm32eSSpqy2/LMlHqtA8ry02fd0CfGVc+G
   qPKZh8TJuprGjzzIpjFvMd5hOYQepVxhX4v37kIg0ZsA9q4w/opYiR5pz
   PPUb8s+TqZZ1gWUs68Vj8UKqTovIe6Z0K9cp1ifgXCEpTta6CE05Yt0Sa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="305971537"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="305971537"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 11:53:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="538592412"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2022 11:53:23 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/15] dmaengine: Move dma_set_tx_state to the provider API header
Date:   Wed, 22 Jun 2022 11:53:13 -0700
Message-Id: <20220622185313.3043550-1-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
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

This is only used by DMA providers, not DMA clients. Move it next
to the other cookie utility functions.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/dma/dmaengine.h   | 11 +++++++++++
 include/linux/dmaengine.h | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index a2ce377e9ed0f..e72876a512a39 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -90,6 +90,17 @@ static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
 	return DMA_IN_PROGRESS;
 }
 
+static inline void dma_set_tx_state(struct dma_tx_state *st,
+	dma_cookie_t last, dma_cookie_t used, u32 residue)
+{
+	if (!st)
+		return;
+
+	st->last = last;
+	st->used = used;
+	st->residue = residue;
+}
+
 static inline void dma_set_residue(struct dma_tx_state *state, u32 residue)
 {
 	if (state)
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index ea6ec2666eb15..f968f7671e22c 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1464,17 +1464,6 @@ static inline enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
 	return status;
 }
 
-static inline void
-dma_set_tx_state(struct dma_tx_state *st, dma_cookie_t last, dma_cookie_t used, u32 residue)
-{
-	if (!st)
-		return;
-
-	st->last = last;
-	st->used = used;
-	st->residue = residue;
-}
-
 #ifdef CONFIG_DMA_ENGINE
 struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type);
 enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie);
-- 
2.35.1

