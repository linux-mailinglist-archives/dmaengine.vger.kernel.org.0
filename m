Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00535BD2C5
	for <lists+dmaengine@lfdr.de>; Mon, 19 Sep 2022 18:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiISQ7B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Sep 2022 12:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiISQ6n (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Sep 2022 12:58:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2B939BBF
        for <dmaengine@vger.kernel.org>; Mon, 19 Sep 2022 09:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663606722; x=1695142722;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=im/ElixXB1DbJzZ3C977f3GPpIOi2QpAoyJEqz2xBGI=;
  b=nYY+M6OjoBWNuKr65K7rLFYslzrOYc47214ITUgsTTtsSNjGQHp255Y8
   YZ8UIxGrXzmpipUkTw88uJQ1b6Z4tQ1TxCvGJ0JTUtMOXwCavmK1WvTh2
   hJw5JYOfsIO4Q3fe+wOtF56hMkHWfRSyWbVKeUCPYauLNxzKNcFsBq0uq
   y3Hw9sKq9moQEYDMISZUf01c/FndEu/GbTxqYHA+C8fCzSjPMRjP0pQOI
   oCaxm7wdGjEvlxdgKDWJvB33DGd3bPENvKw4ezaUTe8c8gwCDxmxDClYk
   8QJ+DEsX4gub827St8DecIszONefXmT7hatuBwxlIfCYmHhAU2MUXPMiG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="297049673"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="297049673"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 09:58:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="687049664"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 09:58:42 -0700
Subject: [PATCH] dmaengine: ioat: stop mod_timer from resurrecting deleted
 timer in __cleanup()
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Mon, 19 Sep 2022 09:58:42 -0700
Message-ID: <166360672197.3851724.17040290563764838369.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

User reports observing timer event report channel halted but no error
observed in CHANERR register. The driver finished self-test and released
channel resources. Debug shows that __cleanup() can call
mod_timer() after the timer has been deleted and thus resurrect the
timer. While harmless, it causes suprious error message to be emitted.
Use mod_timer_pending() call to prevent deleted timer from being
resurrected.

Fixes: 3372de5813e4 ("dmaengine: ioatdma: removal of dma_v3.c and relevant ioat3 references")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/ioat/dma.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 37ff4ec7db76..e2070df6cad2 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -656,7 +656,7 @@ static void __cleanup(struct ioatdma_chan *ioat_chan, dma_addr_t phys_complete)
 	if (active - i == 0) {
 		dev_dbg(to_dev(ioat_chan), "%s: cancel completion timeout\n",
 			__func__);
-		mod_timer(&ioat_chan->timer, jiffies + IDLE_TIMEOUT);
+		mod_timer_pending(&ioat_chan->timer, jiffies + IDLE_TIMEOUT);
 	}
 
 	/* microsecond delay by sysfs variable  per pending descriptor */
@@ -682,7 +682,7 @@ static void ioat_cleanup(struct ioatdma_chan *ioat_chan)
 
 		if (chanerr &
 		    (IOAT_CHANERR_HANDLE_MASK | IOAT_CHANERR_RECOVER_MASK)) {
-			mod_timer(&ioat_chan->timer, jiffies + IDLE_TIMEOUT);
+			mod_timer_pending(&ioat_chan->timer, jiffies + IDLE_TIMEOUT);
 			ioat_eh(ioat_chan);
 		}
 	}
@@ -879,7 +879,7 @@ static void check_active(struct ioatdma_chan *ioat_chan)
 	}
 
 	if (test_and_clear_bit(IOAT_CHAN_ACTIVE, &ioat_chan->state))
-		mod_timer(&ioat_chan->timer, jiffies + IDLE_TIMEOUT);
+		mod_timer_pending(&ioat_chan->timer, jiffies + IDLE_TIMEOUT);
 }
 
 static void ioat_reboot_chan(struct ioatdma_chan *ioat_chan)


