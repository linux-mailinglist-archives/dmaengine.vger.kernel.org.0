Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8E2202B80
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2020 17:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbgFUP5u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 Jun 2020 11:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730390AbgFUP5u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 Jun 2020 11:57:50 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB83C061794
        for <dmaengine@vger.kernel.org>; Sun, 21 Jun 2020 08:57:50 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b4so13440692qkn.11
        for <dmaengine@vger.kernel.org>; Sun, 21 Jun 2020 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kb5+aZrzNx6tSI6L/Ms1DanPrl0vUL+IeDMeU6prOnU=;
        b=ZO1+qIyH0nQp/ljo0rnCFrFsFc4WQdkD+czFD0nuKMTgFIjbIq9vrCc6VVyXKWOf2B
         xTUygwZtr1j5jQhA/IuOQoTmrwGyUZNQE4Ynl4JuwBdOWxswhEwyS/WuoRTtt/MuCjDS
         OSDHF9uvbYGoejYse9YG/iZj1Ra6TQ3ApgSau5M2TjWKaAVOOmoxubv3HZXEz5rNKpBl
         6Czk8TArS/X2STiaKWuFCGY0j8hyCgapra8xKC4f6IiugwC8NbjpwBHdydITQ5zraUkH
         Vdv6rcgsTOieuDj+Ru+UoRVqbGjKdzx90xNh1LNIPmS+I9mvJOWpO8MjoPdUOFBkMDwK
         6qGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kb5+aZrzNx6tSI6L/Ms1DanPrl0vUL+IeDMeU6prOnU=;
        b=FTujdCydQTRnAeLytFGvBTWW5q4yLuSmcgBDM+oFJ2RscKvtCrGaCywjteP/EJ+10o
         u+9gnBkpY0F5M5yAA58YaehFugu6Eni/jh5q7IOy4JCCakGZhjsD1qRzrPJGoUerBgvY
         H5GnS/KHQArxSAMdxgvmobNi9l8se3suRZChwtpmpLahT6h0SUd0jH7yRorJ6tNYyo8d
         Guac/PKK1ArotDQbuDgLbmyuoruV+4SLQik7H3hnsVvKOlHWDdvWSAKb2753w8uil4ck
         n6mgW8VXv6397NPaPTZau5p17J0LVzMHhacDaGMZslKlCO1Pb3asnBOUzszKAOHCZK/3
         iDog==
X-Gm-Message-State: AOAM533rYAmi+cqabmAIc7ojIJmdu8oNxgdj63pADHG5xSLWT+uD5Byz
        Gb1KvB9kh1rnVIdAu1xI1Qs=
X-Google-Smtp-Source: ABdhPJx2WRPW9tE6une1UHHm2fK5tgAIYrpxF822hRAJ7Milj37p+bvnUpDBQ+1VEvPrvg5lbocRyw==
X-Received: by 2002:a37:e30a:: with SMTP id y10mr12167937qki.151.1592755069422;
        Sun, 21 Jun 2020 08:57:49 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:92b:9524:444f:ca0e:d637])
        by smtp.gmail.com with ESMTPSA id e11sm2267qtp.67.2020.06.21.08.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 08:57:48 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     vkoul@kernel.org
Cc:     frieder.schrempf@kontron.de, dmaengine@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] dmaengine: imx-sdma: Fix: Remove 'always true' comparison
Date:   Sun, 21 Jun 2020 12:57:30 -0300
Message-Id: <20200621155730.28766-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

event_id0 is defined as 'unsigned int', so it is always greater or
equal to zero.

Remove the unneeded comparisons to fix the following W=1 build
warning:

drivers/dma/imx-sdma.c: In function 'sdma_free_chan_resources':
drivers/dma/imx-sdma.c:1334:23: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
1334 |  if (sdmac->event_id0 >= 0)
|                       ^~
drivers/dma/imx-sdma.c: In function 'sdma_config':
drivers/dma/imx-sdma.c:1635:23: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
1635 |  if (sdmac->event_id0 >= 0) {
|               

Fixes: 25962e1a7f1d ("dmaengine: imx-sdma: Fix the event id check to include RX event for UART6")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/dma/imx-sdma.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 91774039ae5d..270992c4fe47 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1331,8 +1331,7 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdma_channel_synchronize(chan);
 
-	if (sdmac->event_id0 >= 0)
-		sdma_event_disable(sdmac, sdmac->event_id0);
+	sdma_event_disable(sdmac, sdmac->event_id0);
 	if (sdmac->event_id1)
 		sdma_event_disable(sdmac, sdmac->event_id1);
 
@@ -1632,11 +1631,9 @@ static int sdma_config(struct dma_chan *chan,
 	memcpy(&sdmac->slave_config, dmaengine_cfg, sizeof(*dmaengine_cfg));
 
 	/* Set ENBLn earlier to make sure dma request triggered after that */
-	if (sdmac->event_id0 >= 0) {
-		if (sdmac->event_id0 >= sdmac->sdma->drvdata->num_events)
-			return -EINVAL;
-		sdma_event_enable(sdmac, sdmac->event_id0);
-	}
+	if (sdmac->event_id0 >= sdmac->sdma->drvdata->num_events)
+		return -EINVAL;
+	sdma_event_enable(sdmac, sdmac->event_id0);
 
 	if (sdmac->event_id1) {
 		if (sdmac->event_id1 >= sdmac->sdma->drvdata->num_events)
-- 
2.17.1

