Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C521851C3AD
	for <lists+dmaengine@lfdr.de>; Thu,  5 May 2022 17:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381211AbiEEPUT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 May 2022 11:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381210AbiEEPUP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 May 2022 11:20:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B214847054
        for <dmaengine@vger.kernel.org>; Thu,  5 May 2022 08:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651763792; x=1683299792;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wf8v3+7ijoDTwUoqtBu9drYn0DKhQta4Nwo9ucoH3ow=;
  b=RY0nnOOLy6D6VF9NdgzWIj11uY8Faw9KsP068Uq5tDLRrn+xb7in3+DJ
   +Ktjfpa9djhsVR4+0jVUluf/bkFW1kzpDUY/pScyXoD5lUhu/sIy4QW6T
   oPi3BGZBWmm2fDqBBHQz4GLz7gD904Mr4fnxw1UWbcP0ts8v4TvbcSL3y
   k6q3MiUcBrTXddjPjK+SkhAwGWinAavb6Y2Dy7no+Xvb4RB4nimqil+Su
   Dyw4F4Il73E0Bt/ud/mKPGXgs/jFxch3b1jLIH1mFzzP8J3yL6gdYZu1Y
   iQhPbbo71IMcjqalM9BEiRGE1ySNkbTQV9bfMbEtgQERxTLWSqymoDkll
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266980041"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="266980041"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 08:05:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="585361104"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 08:05:11 -0700
Subject: [PATCH] dmaengine: idxd: skip irq free when wq type is not kernel
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Tony Zu <tony.zhu@intel.com>, Tony Zu <tony.zhu@intel.com>,
        dmaengine@vger.kernel.org
Date:   Thu, 05 May 2022 08:05:07 -0700
Message-ID: <165176310726.2112428.7474366910758522079.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Skip wq irq resources freeing when wq type is not kernel since the driver
skips the irq alloction during wq enable. Add check in wq type check in
idxd_wq_free_irq() to mirror idxd_wq_request_irq().

Fixes: 63c14ae6c161 ("dmaengine: idxd: refactor wq driver enable/disable operations")
Reported-by: Tony Zu <tony.zhu@intel.com>
Tested-by: Tony Zu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 93cbfd726904..19a6cfaf4371 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1177,6 +1177,9 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
 	struct idxd_device *idxd = wq->idxd;
 	struct idxd_irq_entry *ie = &wq->ie;
 
+	if (wq->type != IDXD_WQT_KERNEL)
+		return;
+
 	synchronize_irq(ie->vector);
 	free_irq(ie->vector, ie);
 	idxd_flush_pending_descs(ie);


