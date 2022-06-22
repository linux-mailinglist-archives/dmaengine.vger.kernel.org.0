Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3565554C4
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 21:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359261AbiFVTjB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 15:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359510AbiFVTie (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 15:38:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559503FBF2;
        Wed, 22 Jun 2022 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655926708; x=1687462708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z4XHvCp2tz/HRUiqGeVSctq6Lz1nKjefH4McWG6X49M=;
  b=fz/j4/JnaOve+KD0Of3TAwoyO/U1onwrg7Qirut7x6ybfQDDpR4NSlln
   /qz6sOWbNn3NHSHLb2sSUkJexLlQfhxGFXuJbPMICBQxH87eSogGZMlHv
   hEnoiMzrPan+/KkMmhDZljBj51QArquVvHshsUc1UXlRq/VMuowYC7XT8
   wDAaFx4c/7srcBoRHbr8DwAf4A9EMaUXmEOmqF6Us0VAxl4H9KQ38htoN
   CiXBwdpg7FJp6Ezu1VYsxO3rabM8ac0CIWXqTTpSmyyMTyLUsXyYPOtcq
   b/VeO0GkTUQK99ZpK9nAfHv7hQm5a/atMLqtpYgUdI/CZnogqfyZM/fST
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="305983091"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="305983091"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 12:38:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="715542092"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2022 12:38:27 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v4 07/15] media: pxa_camera: Use dmaengine_async_is_tx_complete
Date:   Wed, 22 Jun 2022 12:37:45 -0700
Message-Id: <20220622193753.3044206-8-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220622193753.3044206-1-benjamin.walker@intel.com>
References: <20220503200728.2321188-1-benjamin.walker@intel.com>
 <20220622193753.3044206-1-benjamin.walker@intel.com>
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
The previous PAI will be removed in favor of the new one.

Cc: linux-media@vger.kernel.org
Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/media/platform/intel/pxa_camera.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/intel/pxa_camera.c b/drivers/media/platform/intel/pxa_camera.c
index 35145e3348f0e..0880bf2baa339 100644
--- a/drivers/media/platform/intel/pxa_camera.c
+++ b/drivers/media/platform/intel/pxa_camera.c
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

