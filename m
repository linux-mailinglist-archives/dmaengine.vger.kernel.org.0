Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0BF71251C
	for <lists+dmaengine@lfdr.de>; Fri, 26 May 2023 12:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbjEZKzM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 May 2023 06:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjEZKzK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 May 2023 06:55:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EA7F7;
        Fri, 26 May 2023 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685098509; x=1716634509;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gsACS33QqbMepIsxf09vMS4nFee3rE52HroENxd1Rt4=;
  b=KlQSrhS7Pu5r4Ojt79iRpGYe7Y+93C9EVAINnOiNy+O3qOSipPyurDnD
   OEVKdfysKjUT2lqtf6Ocu3YW6QOMLcAmE99SA2hCwUPDnfklc4R5A00wf
   Y9FpzeFm2Erm7yRCk4ecRHzt+kNrU0tA6vbkouAw/IhL4xLHM/twamHS7
   uey1CpekNfJM5MSiKNfypeNwwar0vNutsr/sYEGyiDWX28yTlcidaqIe/
   J8EHDNDcGPmPjfFUVVd+5JKM892cghSZ/3v2PXq31+Vk05DQ80FIuFmo0
   J6K8GkeeaLrDqD9dn82GNLToCsX2pmTgelRuyA9llVX36JfPGv7ASgO1+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="353018168"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="353018168"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 03:55:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="655599733"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="655599733"
Received: from eandrei-mobl5.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.53.213])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 03:55:05 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Robert Baldyga <r.baldyga@samsung.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Richard Tresidder <rtresidd@electromag.com.au>,
        stable@vger.kernel.org
Subject: [PATCH] dmaengine: pl330: Return DMA_PAUSED when transaction is paused
Date:   Fri, 26 May 2023 13:54:34 +0300
Message-Id: <20230526105434.14959-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

pl330_pause() does not set anything to indicate paused condition which
causes pl330_tx_status() to return DMA_IN_PROGRESS. This breaks 8250
DMA flush after the fix in commit 57e9af7831dc ("serial: 8250_dma: Fix
DMA Rx rearm race"). The function comment for pl330_pause() claims
pause is supported but resume is not which is enough for 8250 DMA flush
to work as long as DMA status reports DMA_PAUSED when appropriate.

Add PAUSED state for descriptor and mark BUSY descriptors with PAUSED
in pl330_pause(). Return DMA_PAUSED from pl330_tx_status() when the
descriptor is PAUSED.

Reported-by: Richard Tresidder <rtresidd@electromag.com.au>
Tested-by: Richard Tresidder <rtresidd@electromag.com.au>
Fixes: 88987d2c7534 ("dmaengine: pl330: add DMA_PAUSE feature")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-serial/f8a86ecd-64b1-573f-c2fa-59f541083f1a@electromag.com.au/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

$ diff -u <(git grep -l -e '\.device_pause' -e '->device_pause') <(git grep -l DMA_PAUSED)

...tells there might a few other drivers which do not properly return
DMA_PAUSED status despite having a pause function.

 drivers/dma/pl330.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 0d9257fbdfb0..daad25f2c498 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -403,6 +403,12 @@ enum desc_status {
 	 * of a channel can be BUSY at any time.
 	 */
 	BUSY,
+	/*
+	 * Pause was called while descriptor was BUSY. Due to hardware
+	 * limitations, only termination is possible for descriptors
+	 * that have been paused.
+	 */
+	PAUSED,
 	/*
 	 * Sitting on the channel work_list but xfer done
 	 * by PL330 core
@@ -2041,7 +2047,7 @@ static inline void fill_queue(struct dma_pl330_chan *pch)
 	list_for_each_entry(desc, &pch->work_list, node) {
 
 		/* If already submitted */
-		if (desc->status == BUSY)
+		if (desc->status == BUSY || desc->status == PAUSED)
 			continue;
 
 		ret = pl330_submit_req(pch->thread, desc);
@@ -2326,6 +2332,7 @@ static int pl330_pause(struct dma_chan *chan)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
 	struct pl330_dmac *pl330 = pch->dmac;
+	struct dma_pl330_desc *desc;
 	unsigned long flags;
 
 	pm_runtime_get_sync(pl330->ddma.dev);
@@ -2335,6 +2342,10 @@ static int pl330_pause(struct dma_chan *chan)
 	_stop(pch->thread);
 	spin_unlock(&pl330->lock);
 
+	list_for_each_entry(desc, &pch->work_list, node) {
+		if (desc->status == BUSY)
+			desc->status = PAUSED;
+	}
 	spin_unlock_irqrestore(&pch->lock, flags);
 	pm_runtime_mark_last_busy(pl330->ddma.dev);
 	pm_runtime_put_autosuspend(pl330->ddma.dev);
@@ -2425,7 +2436,7 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 		else if (running && desc == running)
 			transferred =
 				pl330_get_current_xferred_count(pch, desc);
-		else if (desc->status == BUSY)
+		else if (desc->status == BUSY || desc->status == PAUSED)
 			/*
 			 * Busy but not running means either just enqueued,
 			 * or finished and not yet marked done
@@ -2442,6 +2453,9 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 			case DONE:
 				ret = DMA_COMPLETE;
 				break;
+			case PAUSED:
+				ret = DMA_PAUSED;
+				break;
 			case PREP:
 			case BUSY:
 				ret = DMA_IN_PROGRESS;
-- 
2.30.2

