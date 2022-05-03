Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF28518E17
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 22:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbiECUMe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 16:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242244AbiECUMO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 16:12:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D5C40A34
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 13:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651608490; x=1683144490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X9OIsEa+Ng5SJEUvwml16YClX2VsWtViESe/ytijsDQ=;
  b=Wt2fluMbo6ljL4/STBjyjDQcxXP8YhNLElmbB/5a8wbx22iaEIWivjC+
   89lkwQc8yBErtVjnA7EeZFvcQ8LB58KVmjwn9sL/MV/AeFPP4bnMPDrzh
   2WUfA0ykJiagXXVP/1ZFjJrVtWRbfTFp1dfxuVeIKabOY6SUeTL7YNLey
   wkmPntxBdZ0tMEIaHLQjjMqqEZDlnQ6AUhAfInlKu+oxoTofWFlq6VRid
   PhTugeasVatJQqyYwSmVAJ/J2EJ2S/ub+zE3Pu1XrAcX9ZXMt3Ger19LD
   xsT2ahgNFxqUrG2tQ6ElqX+q+woGRxjE+bfMRINUX7fLtW7e0StGB5wCu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248118194"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="248118194"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 13:08:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="516705277"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2022 13:08:09 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, mchehab@kernel.org,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v2 07/15] media: pxa_camera: Use dmaengine_async_is_tx_complete
Date:   Tue,  3 May 2022 13:07:20 -0700
Message-Id: <20220503200728.2321188-8-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200728.2321188-1-benjamin.walker@intel.com>
References: <20220503200728.2321188-1-benjamin.walker@intel.com>
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

Replace dma_async_is_tx_complete with dmaengine_async_is_tx_complete.
The previous PAI will be removed in favor of the new one.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/media/platform/pxa_camera.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/pxa_camera.c b/drivers/media/platform/pxa_camera.c
index 3ba00b0f93200..29406b4c77406 100644
--- a/drivers/media/platform/pxa_camera.c
+++ b/drivers/media/platform/pxa_camera.c
@@ -1048,9 +1048,18 @@ static void pxa_camera_dma_irq(struct pxa_camera_dev *pcdev,
 	}
 	last_buf = list_entry(pcdev->capture.prev,
 			      struct pxa_buffer, queue);
-	last_status = dma_async_is_tx_complete(pcdev->dma_chans[chan],
-					       last_buf->cookie[chan],
-					       NULL, &last_issued);
+	last_status = dmaengine_async_is_tx_complete(pcdev->dma_chans[chan],
+					       last_buf->cookie[chan]);
+	/*
+	 * Peek into the channel and read the last cookie that was issued.
+	 * This is a layering violation - the dmaengine API does not officially
+	 * provide this information. Since this camera driver is tightly coupled
+	 * with a specific DMA device we know exactly how this cookie value will
+	 * behave. Otherwise, this wouldn't be safe.
+	 */
+	last_issued = pcdev->dma_chans[chan]->cookie;
+	barrier();
+
 	if (camera_status & overrun &&
 	    last_status != DMA_COMPLETE) {
 		dev_dbg(pcdev_to_dev(pcdev), "FIFO overrun! CISR: %x\n",
-- 
2.35.1

