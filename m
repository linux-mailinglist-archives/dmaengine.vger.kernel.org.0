Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EACA248161
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgHRJH0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJHY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:07:24 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C0CC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r11so9642443pfl.11
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KmEcBHcde06arqa/qnAKRl0EaY2afCtuj8GLj4ZTRM0=;
        b=bZ/AbLcU4peYS14nlM8GKxILzOXrYnd1aYpvPvAMBTduX7rToNtVCwqY5EqNFX7rZ2
         lty9n5IzunpgQoElFOgLovPh0bt4JsXLLGmyHwc6K1qC9kG4L4rq6vNtRSdv8cV2R4e9
         3kPYTKjHF23WV31E3FlsZsMfXZMChJ3pTSCo8PQq1wGRQDkaNyyGL0OBNP2ezehW3n4t
         3DwdfWW6hYzi5jtL3exgrlhQlMZJ2IMctQgfbNKeRawgKJEsXKa/tZXoYQosoK+JA0UW
         biXcprUWmWHAGi/sta0HXDX0C1E+SlUksHfPLYW7+3jaWTrCcMtGIX0TkR1p2de63mIY
         JqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KmEcBHcde06arqa/qnAKRl0EaY2afCtuj8GLj4ZTRM0=;
        b=f4fgNcFGoL5ZzEJTgIbU5263LNYbC0ynhzDBL85vOpbwoYQKhijo+K0tWy3GePZ8ox
         v+9cqHbR+PU2oBiA8xLpM5fmM+L2h8T7N7n4qF8i4b4CpG3plp101Hta+Dtzo/U076qe
         0AHlkw+x/nNHwL3uDayohEINJREIE8JcrAOlefm/m8NC76lMTyVN4GY+3zU83R1U++Q/
         Amv9x9C5dB1gNnoIRmxILFhLVWn0f9T1BgfpPubVTzKQZUdgOqB7GHeU06m74Z32+xus
         eq+ourUykEvdYAS6xdCc07afMATwNiF6Nw0e+3h2BcEvgrWmQLDEwp3oQOPgIhEU0Lba
         hkVg==
X-Gm-Message-State: AOAM531gr41q8eu00o0+dsuq9OgCzmYKSbqRBZTPZpMqkgqtsw0dgjoG
        kd+02/W0zNoN8CnqyqIX5Xs=
X-Google-Smtp-Source: ABdhPJya9K3B3Jr3/OPnXNVXxciy7HURiYzfwEXQif6tDsqifYKccRwmM8TBY/pRpIebURnotw7ikQ==
X-Received: by 2002:a63:5961:: with SMTP id j33mr6787761pgm.130.1597741642533;
        Tue, 18 Aug 2020 02:07:22 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:07:22 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 06/35] dma: ep93xx: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:09 +0530
Message-Id: <20200818090638.26362-7-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818090638.26362-1-allen.lkml@gmail.com>
References: <20200818090638.26362-1-allen.lkml@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/dma/ep93xx_dma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 87a246012629..01027779beb8 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -745,9 +745,9 @@ static void ep93xx_dma_advance_work(struct ep93xx_dma_chan *edmac)
 	spin_unlock_irqrestore(&edmac->lock, flags);
 }
 
-static void ep93xx_dma_tasklet(unsigned long data)
+static void ep93xx_dma_tasklet(struct tasklet_struct *t)
 {
-	struct ep93xx_dma_chan *edmac = (struct ep93xx_dma_chan *)data;
+	struct ep93xx_dma_chan *edmac = from_tasklet(edmac, t, tasklet);
 	struct ep93xx_dma_desc *desc, *d;
 	struct dmaengine_desc_callback cb;
 	LIST_HEAD(list);
@@ -1353,8 +1353,7 @@ static int __init ep93xx_dma_probe(struct platform_device *pdev)
 		INIT_LIST_HEAD(&edmac->active);
 		INIT_LIST_HEAD(&edmac->queue);
 		INIT_LIST_HEAD(&edmac->free_list);
-		tasklet_init(&edmac->tasklet, ep93xx_dma_tasklet,
-			     (unsigned long)edmac);
+		tasklet_setup(&edmac->tasklet, ep93xx_dma_tasklet);
 
 		list_add_tail(&edmac->chan.device_node,
 			      &dma_dev->channels);
-- 
2.17.1

