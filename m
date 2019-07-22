Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A63C6FB18
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2019 10:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfGVIRS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jul 2019 04:17:18 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:58353 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfGVIRS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Jul 2019 04:17:18 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N0WwO-1iapR13BiO-00wRIY; Mon, 22 Jul 2019 10:17:07 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 1/2] [RESEND] dmaengine: omap-dma: make omap_dma_filter_fn private
Date:   Mon, 22 Jul 2019 10:16:44 +0200
Message-Id: <20190722081705.2084961-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LKbwgWIj99FT91eh3WOwgz3gfMVv38yDY9pLODrS9xdzX3TdFjV
 sFyqqjXOs2vi7MeJORJiXvPYE0nqYIIMrSQg+DpC+H487tn0ovRPidXyNIjBl3gbBa/2Qt9
 GlYqd/ES7eUpSkYyKi1Wzyxh2uC2cRirVml1x018NBxF2jDP1iyy+PW6GKXsVTyZeFJ2CYr
 fYJ0X6D8vRlMD9YdCf/PQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OV4ZnAdg0O0=:m7QYF8tm2fgfGSeNLShlKm
 f8+Fr36c1zaf1fVJO0OGKEXPqdY2xAnHCKMvC39HLGQ8KbGj5pBKn9bRZT7CQKjaidSFPw8h8
 oAsLPq/3OayiF2JDUvc7tI1YL6e0D4aKcT1X8qwQi3Ny9rRsjn8QpljjS1/deKcvlcWZPuiK/
 Fcp3CqoFZxGFiCWQ2tbEd5iukje6r0hg9ulo4MHZXPEl9Dwmcy2BdOHQ9Zd+1pUkwF47T2D4E
 HelDflpgbXqD5vNRKyQleEX3TvIt5HNG4f2DXyQuMZO5Ma9K+Rikh+pMfBHAB0SNZN5JONzzz
 EIIyHhgcx45nWsEnhYsRJ5+/qMC0MdyDgI1YQMlYA/qo95Bu+xJJ8nsEo+cN5JmLGEFcI/xRm
 1pkTQ1yEhExyTFWaypb0QGJBxAoKJ1NER5AjUI0QoWAKCQYrAHjuobOHV7Q+ny15q2+phA56G
 aXvG/ysBO9bJRnBOQX2xzRrMJmaaX73VU4C7Kf05RwKXAF5DvUKYotGNdqEt+voGEKllleijA
 8Hljb7zaf1FJGZ9Cb4QK+1NXRqn29OdzT/4/oyETH0KJqqogU4hldbgvW0khaTgMXTk3Q/omG
 ezCodrRF4Nu32XOE9BZPPXwTv3zE/9kZZiGzdKSFE/k6RknIiPaDgbvbLPmQ8/qCQxE8ApBat
 I2HA7QGvIZrWUoVlDQHE6H9Nd+vRJR9mjxq/W20aTYWIkjdg/JO2PudG6OGpSxxvXxdWSjxKa
 RGo4ctJZap340ayVbfWPCRRrf2YHYT8P5hfDlw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

With the audio driver no longer referring to this function, it
can be made private to the dmaengine driver itself, and the
header file removed.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/lkml/20190307151646.1016966-1-arnd@arndb.de/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Sent originally in March, but had some dependency problems
back then, please apply these now.
---
 drivers/dma/ti/omap-dma.c      |  3 ++-
 include/linux/omap-dma.h       |  2 --
 include/linux/omap-dmaengine.h | 21 ---------------------
 3 files changed, 2 insertions(+), 24 deletions(-)
 delete mode 100644 include/linux/omap-dmaengine.h

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index ba2489d4ea24..49da402a1927 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -202,6 +202,7 @@ static const unsigned es_bytes[] = {
 	[CSDP_DATA_TYPE_32] = 4,
 };
 
+static bool omap_dma_filter_fn(struct dma_chan *chan, void *param);
 static struct of_dma_filter_info omap_dma_info = {
 	.filter_fn = omap_dma_filter_fn,
 };
@@ -1637,7 +1638,7 @@ static struct platform_driver omap_dma_driver = {
 	},
 };
 
-bool omap_dma_filter_fn(struct dma_chan *chan, void *param)
+static bool omap_dma_filter_fn(struct dma_chan *chan, void *param)
 {
 	if (chan->device->dev->driver == &omap_dma_driver.driver) {
 		struct omap_dmadev *od = to_omap_dma_dev(chan->device);
diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
index 840ce551e773..ba3cfbb52312 100644
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -1,8 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __LINUX_OMAP_DMA_H
 #define __LINUX_OMAP_DMA_H
-#include <linux/omap-dmaengine.h>
-
 /*
  *  Legacy OMAP DMA handling defines and functions
  *
diff --git a/include/linux/omap-dmaengine.h b/include/linux/omap-dmaengine.h
deleted file mode 100644
index 8e6906c72e90..000000000000
--- a/include/linux/omap-dmaengine.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * OMAP DMA Engine support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __LINUX_OMAP_DMAENGINE_H
-#define __LINUX_OMAP_DMAENGINE_H
-
-struct dma_chan;
-
-#if defined(CONFIG_DMA_OMAP) || (defined(CONFIG_DMA_OMAP_MODULE) && defined(MODULE))
-bool omap_dma_filter_fn(struct dma_chan *, void *);
-#else
-static inline bool omap_dma_filter_fn(struct dma_chan *c, void *d)
-{
-	return false;
-}
-#endif
-#endif /* __LINUX_OMAP_DMAENGINE_H */
-- 
2.20.0

