Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF252AC011
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 16:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgKIPkR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 10:40:17 -0500
Received: from muru.com ([72.249.23.125]:47548 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgKIPkR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Nov 2020 10:40:17 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 80B8B80CD;
        Mon,  9 Nov 2020 15:40:22 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: ti: omap-dma: Block PM if SDMA is busy to fix audio
Date:   Mon,  9 Nov 2020 17:40:13 +0200
Message-Id: <20201109154013.11950-1-tony@atomide.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We now use cpu_pm for saving and restoring device context for deeper SoC
idle states. But for omap3, we must also block idle if SDMA is busy.

If we don't block idle when SDMA is busy, we eventually end up saving and
restoring SDMA register state on PER domain idle while SDMA is active and
that causes at least audio playback to fail.

Fixes: 4c74ecf79227 ("dmaengine: ti: omap-dma: Add device tree match data and use it for cpu_pm")
Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/dma/ti/omap-dma.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1522,29 +1522,38 @@ static void omap_dma_free(struct omap_dmadev *od)
 	}
 }
 
+/* Currently used by omap2 & 3 to block deeper SoC idle states */
+static bool omap_dma_busy(struct omap_dmadev *od)
+{
+	struct omap_chan *c;
+	int lch = -1;
+
+	while (1) {
+		lch = find_next_bit(od->lch_bitmap, od->lch_count, lch + 1);
+		if (lch >= od->lch_count)
+			break;
+		c = od->lch_map[lch];
+		if (!c)
+			continue;
+		if (omap_dma_chan_read(c, CCR) & CCR_ENABLE)
+			return true;
+	}
+
+	return false;
+}
+
 /* Currently only used for omap2. For omap1, also a check for lcd_dma is needed */
 static int omap_dma_busy_notifier(struct notifier_block *nb,
 				  unsigned long cmd, void *v)
 {
 	struct omap_dmadev *od;
-	struct omap_chan *c;
-	int lch = -1;
 
 	od = container_of(nb, struct omap_dmadev, nb);
 
 	switch (cmd) {
 	case CPU_CLUSTER_PM_ENTER:
-		while (1) {
-			lch = find_next_bit(od->lch_bitmap, od->lch_count,
-					    lch + 1);
-			if (lch >= od->lch_count)
-				break;
-			c = od->lch_map[lch];
-			if (!c)
-				continue;
-			if (omap_dma_chan_read(c, CCR) & CCR_ENABLE)
-				return NOTIFY_BAD;
-		}
+		if (omap_dma_busy(od))
+			return NOTIFY_BAD;
 		break;
 	case CPU_CLUSTER_PM_ENTER_FAILED:
 	case CPU_CLUSTER_PM_EXIT:
@@ -1595,6 +1604,8 @@ static int omap_dma_context_notifier(struct notifier_block *nb,
 
 	switch (cmd) {
 	case CPU_CLUSTER_PM_ENTER:
+		if (omap_dma_busy(od))
+			return NOTIFY_BAD;
 		omap_dma_context_save(od);
 		break;
 	case CPU_CLUSTER_PM_ENTER_FAILED:
-- 
2.29.2
