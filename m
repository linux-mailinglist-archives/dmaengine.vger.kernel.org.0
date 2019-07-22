Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFE66FB1A
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2019 10:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfGVIRa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jul 2019 04:17:30 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:33887 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfGVIRa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Jul 2019 04:17:30 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Md6dH-1iP5RM2jn1-00aFLR; Mon, 22 Jul 2019 10:17:19 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 2/2] [RESEND] dmaengine: edma: make edma_filter_fn private
Date:   Mon, 22 Jul 2019 10:16:45 +0200
Message-Id: <20190722081705.2084961-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190722081705.2084961-1-arnd@arndb.de>
References: <20190722081705.2084961-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Dnr5n+ZItdHytTchgOkzFl+KTT+XSHwDwbPeg+P7EMEMi4HQWHS
 NtjJDJQK5Nl0CZMrhaENiYUQ6y/NdV5X1Ki2oAhiwkHDdr9kQVU6956cR9tw7Bbk0QIvOsr
 EU4KMoXlP7kD6k0sdJE6VfeTesAXOdaY8TmS0qKTmj4LD11rDUjIKKUbUXwTwR/DtfD8eSm
 t0aouriRLQKQkYLtStXwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:c/l2lO7keco=:m9a6Mm+tfPiM4ACkSiJbuX
 ASYKmmC//imkpregzHbJz+IgnbO8+7qZcXDz7QvHhy5gvOUcz8ZKANfcAFVobYV+R2Dm5XCqU
 noEeq+0ccMUGc6/np3/94r3S+hV8+zDGCxC6UlOckq8hH94jvMQVZZypj4yJceP1u8GkfBoRn
 dsVtu6uTllWxXRxVzMeG4FzxcW44Gnc9Pcwm6snFpIJB5YqNLqNv21/L6kt/2GcLl2uhOvp1E
 1mmDqSf95ADz3lM4wgnHuwXbGhvo2RwrsAP/HJBO/wtGBA4r2Ihr7YNgt9cl94ZTWWZOFiI5H
 DMLGBV9uHo8Ne8uRjqS0oJQtePX1hxEgVIxT0st/aHixUZf8QHIZN2Zd1Svw57ndBNtNtGJye
 ZPQnxgTruse15JTdOoWowqHUajDRhmNOW3FkvRs/TkApCSSSQCyIPwwk+FuEmpTXjjluGL6BJ
 q9uWuUOv61irCz8TMjhR7RbcjbXfjANrIfa7Te8hp6PPHh6TV3DddUanokK2zhjbZ5HEFuMcP
 xlI5dFonS+aYvSX/pJhg5mrONIwNzU4OGKQbsmOoFLks1VS4vMgVCzTBnRo4bm0nkDuNfk38N
 uPDXiWc67hZQuXVUBE2F4dmrcG6dPw/DMdBIQ1Ywg9l8351TBk/bDs/sGdZjqkddtFN8iyW2o
 wbsxVFBfUBjlbL8dLGQWdeajGtAELWp2Oq+sHjGsu4JAL3lYscmXvck1qdSWfTkXWtN/QivMv
 9yCD9UWv9ibycEN4lec+BXuZ01qzXCsvJl+yNA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

With the audio driver no longer referring to this function, it
can be made private to the dmaengine driver itself, and the
header file removed.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/ti/edma.c |  5 +++--
 include/linux/edma.h  | 29 -----------------------------
 2 files changed, 3 insertions(+), 31 deletions(-)
 delete mode 100644 include/linux/edma.h

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index ceabdea40ae0..f2549ee3fb49 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -15,7 +15,6 @@
 
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
-#include <linux/edma.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -2185,6 +2184,8 @@ static struct dma_chan *of_edma_xlate(struct of_phandle_args *dma_spec,
 }
 #endif
 
+static bool edma_filter_fn(struct dma_chan *chan, void *param);
+
 static int edma_probe(struct platform_device *pdev)
 {
 	struct edma_soc_info	*info = pdev->dev.platform_data;
@@ -2524,7 +2525,7 @@ static struct platform_driver edma_tptc_driver = {
 	},
 };
 
-bool edma_filter_fn(struct dma_chan *chan, void *param)
+static bool edma_filter_fn(struct dma_chan *chan, void *param)
 {
 	bool match = false;
 
diff --git a/include/linux/edma.h b/include/linux/edma.h
deleted file mode 100644
index a1307e7827e8..000000000000
--- a/include/linux/edma.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * TI EDMA DMA engine driver
- *
- * Copyright 2012 Texas Instruments
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef __LINUX_EDMA_H
-#define __LINUX_EDMA_H
-
-struct dma_chan;
-
-#if defined(CONFIG_TI_EDMA) || defined(CONFIG_TI_EDMA_MODULE)
-bool edma_filter_fn(struct dma_chan *, void *);
-#else
-static inline bool edma_filter_fn(struct dma_chan *chan, void *param)
-{
-	return false;
-}
-#endif
-
-#endif
-- 
2.20.0

