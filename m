Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E37C1195BA
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2019 01:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfEIXh0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 May 2019 19:37:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:12199 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfEIXh0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 9 May 2019 19:37:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 16:37:25 -0700
X-ExtLoop1: 1
Received: from djiang5-desk3.ch.intel.com ([143.182.137.59])
  by fmsmga005.fm.intel.com with ESMTP; 09 May 2019 16:37:25 -0700
Subject: [PATCH] dmaengine: ioatdma: fix unprotected timer deletion
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        fan.du@intel.com
Date:   Thu, 09 May 2019 16:37:25 -0700
Message-ID: <155744504539.8006.16459393524018173816.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When ioat_free_chan_resources() gets called, ioat_stop() is called without
chan->cleanup_lock. ioat_stop modifies IOAT_RUN bit.  It needs to be
protected by cleanup_lock. Also, in the __cleanup() path, if IOAT_RUN is
cleared, we should not touch the timer again. We observed that the timer
routine was run after timer was deleted.

Fixes: 3372de5813e ("dmaengine: ioatdma: removal of dma_v3.c and relevant ioat3
references")

Reported-by: Fan Du <fan.du@intel.com>
Tested-by: Fan Du <fan.du@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/ioat/dma.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index f373a139e0c3..78598ba5c73b 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -138,11 +138,14 @@ void ioat_stop(struct ioatdma_chan *ioat_chan)
 	struct pci_dev *pdev = ioat_dma->pdev;
 	int chan_id = chan_num(ioat_chan);
 	struct msix_entry *msix;
+	unsigned long flags;
 
-	/* 1/ stop irq from firing tasklets
-	 * 2/ stop the tasklet from re-arming irqs
-	 */
+	spin_lock_irqsave(&ioat_chan->cleanup_lock, flags);
 	clear_bit(IOAT_RUN, &ioat_chan->state);
+	spin_unlock_irqrestore(&ioat_chan->cleanup_lock, flags);
+
+	/* flush inflight timers */
+	del_timer_sync(&ioat_chan->timer);
 
 	/* flush inflight interrupts */
 	switch (ioat_dma->irq_mode) {
@@ -158,9 +161,6 @@ void ioat_stop(struct ioatdma_chan *ioat_chan)
 		break;
 	}
 
-	/* flush inflight timers */
-	del_timer_sync(&ioat_chan->timer);
-
 	/* flush inflight tasklet runs */
 	tasklet_kill(&ioat_chan->cleanup_task);
 
@@ -652,7 +652,9 @@ static void __cleanup(struct ioatdma_chan *ioat_chan, dma_addr_t phys_complete)
 	if (active - i == 0) {
 		dev_dbg(to_dev(ioat_chan), "%s: cancel completion timeout\n",
 			__func__);
-		mod_timer(&ioat_chan->timer, jiffies + IDLE_TIMEOUT);
+
+		if (test_bit(IOAT_RUN, &ioat_chan->state))
+			mod_timer(&ioat_chan->timer, jiffies + IDLE_TIMEOUT);
 	}
 
 	/* microsecond delay by sysfs variable  per pending descriptor */

