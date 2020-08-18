Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDE8248167
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHRJHm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgHRJHl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:07:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A156C061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g15so5026513plj.6
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SduS7GYrzCMOuDhMx/Gh1w2hqriGD/sY89ZovbEjnFE=;
        b=lBs1RDRDhVPdtNttuXeEKQi8WQj/Bmt3HpItP4QIYxSEiGip5EnypVd/UFICp6GZgA
         q1iUyFkqagkTIS4JeOYa9IFBmL4aSe9rSkdMqrQ9uoi/rbLKzaFWv9MSKl0uD/kxcpIQ
         99UjLRTh+CZHeGXgSTWthila31aT6SCsemovhOwz+XQoujlnQvI+TGmLSGkAsSAQVdEp
         zL0atYbwCwxoHpQmIlQqggRr+Y8MmZUipZ1BLp+3U9itIr5qwT1g8YqpL11spq9+4X4p
         XsTX4FtxYBC19Ou6PhoVCoSa/FV/NY3yTHGxMi5/1wwgIc1cz/x9SS0iVqQ/IOifShgQ
         4Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SduS7GYrzCMOuDhMx/Gh1w2hqriGD/sY89ZovbEjnFE=;
        b=OWSFMLAyOaZyEnPI38UCkt3xBZOOO0oq6NgABIgG7GOQY649i9Y4a6A4h/4SuKckQC
         PQwkzjSaI7zcAW674mJhui68XMnYpDmujzn+GlAtIf5b2FXoD6UX/9P+zq4NSr7+pRmq
         aKqHb5aSlNHhRLw+nhNAbMiVvYSsmgq+oSsVako7t3bSJz3Ba8UVOiYGuXi/bAIQ5U79
         D4z+7ix8Hsz+buXyYeH1at4G6EQBw844vdMxypR9zWlchmbfs4rWN4iAFVjAC37EVrKy
         6UTneulGQz7jdT9UEyX0mZ7z86Y3t22509N3v3Slo97mnzJB94N9T6qJPyTvGcTpglhk
         CkuA==
X-Gm-Message-State: AOAM531ZAq3w6Zit+RZbsJBysF9iMdEcExQ3QeOKd0wJtEIk7Cq2EOIz
        il54SWBn+ZisaCQGJwBcHaOKMAwLqvz55g==
X-Google-Smtp-Source: ABdhPJxbesHf7946RsLsgo9dFgI3dSMBHjA8KpJZTvLz2uwH/Pfo4cUUu2IWIuxi10cZ7xwAF8xooQ==
X-Received: by 2002:a17:90a:f83:: with SMTP id 3mr15607822pjz.7.1597741660994;
        Tue, 18 Aug 2020 02:07:40 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:07:40 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 10/35] dma: iop_adma: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:13 +0530
Message-Id: <20200818090638.26362-11-allen.lkml@gmail.com>
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
 drivers/dma/iop-adma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index 3350bffb2e93..81f177894d1f 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -238,9 +238,10 @@ iop_adma_slot_cleanup(struct iop_adma_chan *iop_chan)
 	spin_unlock_bh(&iop_chan->lock);
 }
 
-static void iop_adma_tasklet(unsigned long data)
+static void iop_adma_tasklet(struct tasklet_struct *t)
 {
-	struct iop_adma_chan *iop_chan = (struct iop_adma_chan *) data;
+	struct iop_adma_chan *iop_chan = from_tasklet(iop_chan, t,
+						      irq_tasklet);
 
 	/* lockdep will flag depedency submissions as potentially
 	 * recursive locking, this is not the case as a dependency
@@ -1351,8 +1352,7 @@ static int iop_adma_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_free_iop_chan;
 	}
-	tasklet_init(&iop_chan->irq_tasklet, iop_adma_tasklet, (unsigned long)
-		iop_chan);
+	tasklet_setup(&iop_chan->irq_tasklet, iop_adma_tasklet);
 
 	/* clear errors before enabling interrupts */
 	iop_adma_device_clear_err_status(iop_chan);
-- 
2.17.1

