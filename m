Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D315553C0
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 20:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358714AbiFVSy3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 14:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377667AbiFVSyJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 14:54:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211D840902;
        Wed, 22 Jun 2022 11:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655924043; x=1687460043;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EnJ5Su7RR3jjj7To4p4p1aGGCrzCsNhKtD7qZhiBzvo=;
  b=nyi1EGTdLrp67ot4+y7E9W6yoJ7y0Q5NR2GLRNqOIVuY2DRuRB2VeYkp
   sqH05QsYgb4+lLFN3OFNSAt827kAn9nPSS8YgfMVGmNo5wSv0RoYgX4ov
   qx09hojMa+Je/2uY475UH8ZFCVw51b0tFWK+YZQVLP9FIwd+4YX/skJlm
   i03SADXwDuYAQMlfT3dTlNCkYXH8bBSFQpdlIzv3AZMqi80FQ4gSlrx2j
   1VXKr9IMg4Sa2UwAvlz6giDmsVtn4EllICWaYiopYWBaauOyiUFBisP4K
   ImYDpfuIE9lYDEOOX2/LocDowuL3xULF105KGx2UTB6cV0zWTqpTT7BJ6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="260949295"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="260949295"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 11:54:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="914820425"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2022 11:54:02 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/15] dmaengine: Remove dma_set_tx_state
Date:   Wed, 22 Jun 2022 11:54:00 -0700
Message-Id: <20220622185400.3043622-1-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
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

