Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A37352414A
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 02:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349515AbiELABP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 May 2022 20:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiELABP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 May 2022 20:01:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4674254680
        for <dmaengine@vger.kernel.org>; Wed, 11 May 2022 17:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652313674; x=1683849674;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HCHC7nijNKk9kMDLR+OraHFjGqatMBrbmvrqSA3+pqI=;
  b=eE8wvVykRvzUfzJuf55EDvs/TURhS2eYkjf/tBhlxDNK6blRjBvsyUkn
   /Qrfwhq930mqUPvT/GSkMEwrLVHfZPStkIskHfalwLcWmj5Y+8p2iA3bS
   vjmmCmySBgxMcXSuJj9O/z/8YBhytU6U91oRNqv0wSdJZ2q01AZr3AW1I
   gXx0vwOpRj7VTSgvGUT2/dWX84hlaQ/E5mTUrqNtQjO4rzGM++3QsV/+M
   hYKJ+icyq3Xnn5DPmszUXh7Swi9DLY4WhGTrDappsMmlZlGhpSwbabl7C
   vQQ2XarGwZE02E/IDLOXsCpzU9Iw+xtyRWxyVMahINdpshd17a4GnQD3n
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="267429922"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="267429922"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:01:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="542529528"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:01:13 -0700
Subject: [PATCH] dmaengine: idxd: free irq before wq type is reset
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Wed, 11 May 2022 17:01:13 -0700
Message-ID: <165231367316.986407.11001767338124941736.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Call idxd_wq_free_irq() in the drv_disable_wq() function before
idxd_wq_reset() is called. Otherwise the wq type is reset and the irq does
not get freed.

Fixes: 63c14ae6c161 ("dmaengine: idxd: refactor wq driver enable/disable operations")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 4617219376f7..d1dba2a3af5d 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1385,9 +1385,9 @@ void drv_disable_wq(struct idxd_wq *wq)
 	idxd_wq_free_resources(wq);
 	idxd_wq_unmap_portal(wq);
 	idxd_wq_drain(wq);
+	idxd_wq_free_irq(wq);
 	idxd_wq_reset(wq);
 	percpu_ref_exit(&wq->wq_active);
-	idxd_wq_free_irq(wq);
 	wq->type = IDXD_WQT_NONE;
 	wq->client_count = 0;
 }


