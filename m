Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CEB4FE7A5
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 20:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345409AbiDLSMN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 14:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbiDLSMM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 14:12:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AE82714F
        for <dmaengine@vger.kernel.org>; Tue, 12 Apr 2022 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649786994; x=1681322994;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QAYE7DLErcZRkwsTKhBGQm53zzDRercy7J40a30NITU=;
  b=cx1Nm7AEOQmzdP8FSO9WYSUcPUjAA+g8D3s0cb5x5aLhSoQBHHyOtO2u
   yWs1CfUbl0Z51HLG34MiI4SEvZ689av2hBxJ3K6vPAnNWsmBo7y4Ydi5s
   2MBtVLpX97xLWMp03o9PUKVMbPM0dC7zQ2F0J+BGSEEiyW+rxDsO1SCRW
   BuP8gsWb58LbOKhzaE8aEa5JVDRQhEtgwcONFkBKRXH1jS3YcxSDXq4Hv
   dosJGDW4mIzGJedxuLm50ECxnYzWxh7o6KaiVnpZ3EKie1w8iKfYYgWwh
   hDkHpD8JyLcY7buIzyRheCFMa07JTqAOvcJnVEUkcQ5uktKnlO3kfzsHC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262646107"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="262646107"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 11:06:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="559439816"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 11:06:32 -0700
Subject: [PATCH] dmaengine: add verification of DMA_INTERRUPT capability for
 dmatest
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 12 Apr 2022 11:06:32 -0700
Message-ID: <164978679251.2361020.5856734256126725993.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Looks like I forgot to add DMA_INTERRUPT cap setting to the idxd driver and
dmatest is still working regardless of this mistake. Add an explicit check
of DMA_INTERRUPT capability for dmatest to make sure the DMA device being used
actually supports interrupt before the test is launched and also that the
driver is programmed correctly.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/dmatest.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index f696246f57fd..0a2168a4ccb0 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -675,10 +675,16 @@ static int dmatest_func(void *data)
 	/*
 	 * src and dst buffers are freed by ourselves below
 	 */
-	if (params->polled)
+	if (params->polled) {
 		flags = DMA_CTRL_ACK;
-	else
-		flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
+	} else {
+		if (dma_has_cap(DMA_INTERRUPT, dev->cap_mask)) {
+			flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
+		} else {
+			pr_err("Channel does not support interrupt!\n");
+			goto err_pq_array;
+		}
+	}
 
 	ktime = ktime_get();
 	while (!(kthread_should_stop() ||
@@ -906,6 +912,7 @@ static int dmatest_func(void *data)
 	runtime = ktime_to_us(ktime);
 
 	ret = 0;
+err_pq_array:
 	kfree(dma_pq);
 err_srcs_array:
 	kfree(srcs);


