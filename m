Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E90B899E6
	for <lists+dmaengine@lfdr.de>; Mon, 12 Aug 2019 11:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfHLJge (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Aug 2019 05:36:34 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:33571 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHLJge (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Aug 2019 05:36:34 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MsZif-1iHOUK1HEh-00u1ou; Mon, 12 Aug 2019 11:36:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma: ti: unexport filter functions
Date:   Mon, 12 Aug 2019 11:36:03 +0200
Message-Id: <20190812093623.992757-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iHoKzkx8FxpNNjHjNARDge07F2F1gIdlZvyjKllLCMxtH7U7qRf
 xDOxNP6Xg7nQdTnaNW/bpikUISl1FT8XmAVGvWd0muxyq/35hRTqAy/I0o57ghw6WcUcey6
 0GULuES/ojGaCrEYuiBnvTjY95ZxUi4YF5tXP/oOfRC+b7WKugl6XRgiSU3XJnDX5vxwXYy
 ZkG6uCEAL+tyBbZ5PKqow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:162hD8IolNI=:DPQ4Pvt6me0yBKPmjd/Z6F
 bqJ+ckMUBy2YWjbp9gTOpFanU6y8PyA7Nh+aWJYdS/Cfo4G0fLzDgLhXqoE+ksYNDGrNwCnWX
 nS+/BRGrZAyM3eNekYWYLluy7QMfUM2nSOUjwjTxrNqGbJzzLDKA183h1PS6lEMAMCfBNkWwZ
 H+lkWv9EXJx4njUx/1VyoBAkeC4egkTluey59A/Jei0dJLIxEasRgxX/nG+hGEa5Vn6kr1zb1
 tq8RkJoqbby8FJVuxw08dVoL1TGgV+6kZD2i15kObG4H9+JfOYB0omSVRgp7juqUXnOSGOm08
 hIxS9njeDLEySckVsLjSNm5DvOUqyB8yz00wdINxUfBlee0NPp2dz6Cs9Nvk8XFGmAZKLr0Rl
 BU/SQkxwOD9J9HQdFYgi9IoHgTHpEy0KL3Bon3JQaNfKewNdr7SqIRyZIEp3r/m3RiIvhDakE
 ipxeY8ZLBKkQoSH0iKz4BohpOYimNXG/QPojVKVp/5ColA6WQMgsftO+2dZGewV5eirPTqYwA
 jTnPn++xY7sRiiLLQhs58MR2D7BlYHj+VVxOWR1LSJlVLlScaVCsquNLnINmn+W1o/xb59JPl
 yDAYmga7nQSvTz+z7VwvzOdaf3XE/xIPp/Z+Og4XjtPui+Nqs6P1XuP7iPGi33V6YcVonVn1W
 ZPHrs7dgp0qdCCqDsbMZE5cvblKMe8aq9nCpK4IlLsxd/CfWWcRFQ2a6renqxC3pkDTv4bjrs
 2xAe/UQewB/CrwryXKferhLGQ/Bwfg/W4frp9Q==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The two filter functions are now marked stable, but still exported,
which triggers a coming build-time check:

WARNING: "omap_dma_filter_fn" [vmlinux] is a static EXPORT_SYMBOL_GPL
WARNING: "edma_filter_fn" [vmlinux] is a static EXPORT_SYMBOL

Remove the unneeded exports as well, as originally intended.

Fixes: 9c71b9eb3cb2 ("dmaengine: omap-dma: make omap_dma_filter_fn private")
Fixes: d2bfe7b5d182 ("dmaengine: edma: make edma_filter_fn private")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/ti/edma.c     | 1 -
 drivers/dma/ti/omap-dma.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index f2549ee3fb49..ea028388451a 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2540,7 +2540,6 @@ static bool edma_filter_fn(struct dma_chan *chan, void *param)
 	}
 	return match;
 }
-EXPORT_SYMBOL(edma_filter_fn);
 
 static int edma_init(void)
 {
diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 49da402a1927..98b39bcb7b37 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1652,7 +1652,6 @@ static bool omap_dma_filter_fn(struct dma_chan *chan, void *param)
 	}
 	return false;
 }
-EXPORT_SYMBOL_GPL(omap_dma_filter_fn);
 
 static int omap_dma_init(void)
 {
-- 
2.20.0

