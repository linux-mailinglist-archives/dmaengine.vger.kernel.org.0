Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5FB24816C
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgHRJH4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgHRJHz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:07:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D30C061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:55 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k18so9645655pfp.7
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LXAHZjWOCXqZNRFnEVorFd32pcE4Uer+STR5X7m1T40=;
        b=X+sLLobYkTiy/7qIne0NLSBQhNKTMkG5yZ7FhNmqJKavyNuCwGNlauW7vlJWe4zm7x
         yrhg07Rwt2fv62CoPsoPXVDOTfZiTUvUvTlFWqo0vrx541L8yfU4YDFxLqM2P5JLchwW
         +6tjwgFHq4cQVBauaDKjfPA0eGK3TouV4GnMcKJB6n9k2BZPbpPh1bHzD6FELYUaf+lb
         GFyGvFOaJ/jvObBe47IDTbmidD62te+mw5BJuQislhtftao/HaHal8R3HZkBrrslTGrV
         MlK3O2g1HkLevBkazBZF0p4tKT9/kGgaFh96xpRJ1Sg5CXUh2KyeIIfP6ovst3r4bvS/
         Qs7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LXAHZjWOCXqZNRFnEVorFd32pcE4Uer+STR5X7m1T40=;
        b=lTmqDMnJRWH7bT1Vvkhy7GkO1uL4yjIdFiR5ByqnnLdW/TGDrKDEjt7mKlW0Khp/Fg
         AoohzycRce+DrRCm116viskxTxs59u7Q02MsJT/a55Ks6mpmr2wHSIhDmJmNKsjhHLyW
         KpeV4hn6MSjjLEiH8XAzJxi2ZU25c3dSO0UOJqzc8jSGFbxlCM8VU736mbCJZugPA2r9
         E3JIN7FKHHPu9pZ49dkxKLqoEBh8Wmvp7Z4rLhd2ypo6YnXYrrhUrb9BdJr1PKAUKTw/
         HOnvuPG1e5UTlO2IZTjU4q+A1VJOvOhWt4HmQFMhx1KsvTsy78fxfGiIP6P+9QP0bYXb
         uCQQ==
X-Gm-Message-State: AOAM533jpvV/OGQMbCGEz9ZQJYTaBmA1r8y6HbzAJhQ/oAXasWuszB3B
        lkM+KDnpHE1GqHObuPhbRnQ=
X-Google-Smtp-Source: ABdhPJxGv/cZkX4FIlUhBJ9bgRjDcXrR5wsDXoRJA/MbJwpmnddHLdnu2ImEWvk0A3fh9/DDU1nBSg==
X-Received: by 2002:a62:31c7:: with SMTP id x190mr14790391pfx.100.1597741675158;
        Tue, 18 Aug 2020 02:07:55 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:07:54 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 13/35] dma: mediatek: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:16 +0530
Message-Id: <20200818090638.26362-14-allen.lkml@gmail.com>
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
 drivers/dma/mediatek/mtk-cqdma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 6bf838e63be1..41ef9f15d3d5 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -356,9 +356,9 @@ static struct mtk_cqdma_vdesc
 	return ret;
 }
 
-static void mtk_cqdma_tasklet_cb(unsigned long data)
+static void mtk_cqdma_tasklet_cb(struct tasklet_struct *t)
 {
-	struct mtk_cqdma_pchan *pc = (struct mtk_cqdma_pchan *)data;
+	struct mtk_cqdma_pchan *pc = from_tasklet(pc, t, tasklet);
 	struct mtk_cqdma_vdesc *cvd = NULL;
 	unsigned long flags;
 
@@ -878,8 +878,7 @@ static int mtk_cqdma_probe(struct platform_device *pdev)
 
 	/* initialize tasklet for each PC */
 	for (i = 0; i < cqdma->dma_channels; ++i)
-		tasklet_init(&cqdma->pc[i]->tasklet, mtk_cqdma_tasklet_cb,
-			     (unsigned long)cqdma->pc[i]);
+		tasklet_setup(&cqdma->pc[i]->tasklet, mtk_cqdma_tasklet_cb);
 
 	dev_info(&pdev->dev, "MediaTek CQDMA driver registered\n");
 
-- 
2.17.1

