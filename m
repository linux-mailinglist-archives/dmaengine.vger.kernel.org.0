Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CEF5553AD
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 20:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377567AbiFVSxk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 14:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377661AbiFVSxi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 14:53:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF1C3BF91;
        Wed, 22 Jun 2022 11:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655924012; x=1687460012;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=prwrS1jSAxwYJXS6zrdVXKa0GwZvymzpmn7Mdh5vPkw=;
  b=FQX95MJLIWgFPJCsvKbwwKf0PUMhEVSE2ag9OflQxHYam5urSdSSuCxI
   X3fMT6QsyWwJPbmCaJtPCYSF0u4nyoZdAGE08TIRz9P1qgBKyXgJp/YOp
   ZaJQhC4UvyngGGKo2H3miV85o8zP6TEZRvyMHe2BKAURkeOYAYSaq+LPU
   VXhfwjjYeXWN/KZG4Gs9aCxYBHQZa9ieytdfVFNIjZC9k6UWGuWhj11kW
   Px+lwoOWUG41yc07akVdyLmah2gjKV8iHFh/pFm6otq8vlJS5p+2I/kIs
   SSKGj/z5vvGurzPrMocw6tjBoDhe+fVdAXPmqUQjh+gwVKxl37+Ri9U5G
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="305971559"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="305971559"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 11:53:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="677700660"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2022 11:53:32 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 04/15] crypto: stm32/hash: Use dmaengine_async_is_tx_complete
Date:   Wed, 22 Jun 2022 11:53:30 -0700
Message-Id: <20220622185330.3043566-1-benjamin.walker@intel.com>
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

