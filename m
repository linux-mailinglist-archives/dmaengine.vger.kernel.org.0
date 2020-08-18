Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB4F248170
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgHRJIR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgHRJIO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:08:14 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E2DC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 74so9638392pfx.13
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EzH+Sxo0+kwwV/JFv4Jtew4uUPj7pfAWvGnBJqZX2kA=;
        b=Q32VZYvjsR2o8aOdDuQEZFBT2/kb9zU+DHs4gpAXuxAM08/zoLcrVFbisxbV8reLp6
         ZbpaFRwunZLzM3nTyy4NYAdYGBB/9nh8qr6yXwFznBezcT1De/byzdgLgQAZuA89JjQS
         LxSmUk3lnvM9sMH6iY2VhDGY9G/WeGB9j0QL4g7NYdAK2xF4i3aoNKJVfrJXzBZK4q2p
         CK1ompjCPvQAHJQ41J2Esz7morj6PszBE6vWou53F4Ie1xG97d7qGHuOdHIYuh7JYRYh
         mZ/lLQLzPiId+/SkrWAltQyvSNDmXT+wxPEB1BGynQheAtrP5/JdqlzT/0rI8r5kewFQ
         MUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EzH+Sxo0+kwwV/JFv4Jtew4uUPj7pfAWvGnBJqZX2kA=;
        b=Fompg3BZmmpDHxXFLouJefnpbdh20o/Q0wIASBSB7joDD0GrntTeGZt+RpIlx/CSJt
         tLDRkrIrFVRkMcmowJVwOk4LiC2U87sKijBObZI18SZcTbaDHhZ4XkLpANbuQI27BBpK
         HesRtpEw6WH28HklGvd7Xo9686/qrMY/lwf5MWb5Lxs+aVPQ5NcuhHS5ynPzeBZ3Qq4L
         v9q06vJxmBVOMAk02RmoyReCDcSfbP7x/dHzhf5hXOqp/Jhgo+GkASGvRVDy9xcOQi6p
         ith7uR3G28f3+ONRD8aDnSiDOrBZ5BChZeGuCXrjcL9ysmHf1dLmefFjZVknuzoTi++6
         q7bA==
X-Gm-Message-State: AOAM532MXCsuTpEu4OBLUn/qtGjEJaQpbavriGcqbr+B8w/eidphBf+e
        3Q0ATPDbch7Cn9Bkdiw2o7E=
X-Google-Smtp-Source: ABdhPJzxOg/6MuqaURtHQYxj8/maHKkqGNEOA4ZzTg7/+QaYAB4p4E5us3kXzuKWbIiHErRPdl7NIg==
X-Received: by 2002:a62:c541:: with SMTP id j62mr14608751pfg.257.1597741694494;
        Tue, 18 Aug 2020 02:08:14 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:08:14 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 17/35] dma: mxs-dma: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:20 +0530
Message-Id: <20200818090638.26362-18-allen.lkml@gmail.com>
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
 drivers/dma/mxs-dma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 3039bba0e4d5..6f296a137543 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -320,9 +320,9 @@ static dma_cookie_t mxs_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	return dma_cookie_assign(tx);
 }
 
-static void mxs_dma_tasklet(unsigned long data)
+static void mxs_dma_tasklet(struct tasklet_struct *t)
 {
-	struct mxs_dma_chan *mxs_chan = (struct mxs_dma_chan *) data;
+	struct mxs_dma_chan *mxs_chan = from_tasklet(mxs_chan, t, tasklet);
 
 	dmaengine_desc_get_callback_invoke(&mxs_chan->desc, NULL);
 }
@@ -812,8 +812,7 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 		mxs_chan->chan.device = &mxs_dma->dma_device;
 		dma_cookie_init(&mxs_chan->chan);
 
-		tasklet_init(&mxs_chan->tasklet, mxs_dma_tasklet,
-			     (unsigned long) mxs_chan);
+		tasklet_setup(&mxs_chan->tasklet, mxs_dma_tasklet);
 
 
 		/* Add the channel to mxs_chan list */
-- 
2.17.1

