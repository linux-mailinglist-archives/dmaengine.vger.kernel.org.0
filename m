Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1723E38736D
	for <lists+dmaengine@lfdr.de>; Tue, 18 May 2021 09:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245301AbhERHpb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 May 2021 03:45:31 -0400
Received: from muru.com ([72.249.23.125]:57048 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239746AbhERHpL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 18 May 2021 03:45:11 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id A67E580F5;
        Tue, 18 May 2021 07:43:56 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Adam Ford <aford173@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: [PATCH] dmaengine: ti: omap-dma: Skip pointless cpu_pm context restore on errors
Date:   Tue, 18 May 2021 10:43:47 +0300
Message-Id: <20210518074347.16908-1-tony@atomide.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There's no need to restore DMA context on CPU_CLUSTER_PM_ENTER_FAILED as
the DMA context won't be lost on errors.

Note that this does not cause invalid context restore as we already check
for busy DMA with omap_dma_busy() in CPU_CLUSTER_PM_ENTER, and block any
deeper idle states for the SoC by returning NOTIFY_BAD if busy.

If other drivers block deeper idle states with cpu_pm, we now just do a
pointless restore, but only if dma was not busy on CPU_CLUSTER_PM_ENTER.

Let's update the CPU_CLUSTER_PM_ENTER_FAILED handling for correctness,
and add a comment.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Adam Ford <aford173@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/dma/ti/omap-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1608,7 +1608,8 @@ static int omap_dma_context_notifier(struct notifier_block *nb,
 			return NOTIFY_BAD;
 		omap_dma_context_save(od);
 		break;
-	case CPU_CLUSTER_PM_ENTER_FAILED:
+	case CPU_CLUSTER_PM_ENTER_FAILED:	/* No need to restore context */
+		break;
 	case CPU_CLUSTER_PM_EXIT:
 		omap_dma_context_restore(od);
 		break;
-- 
2.31.1
