Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48C9248164
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgHRJHd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJHc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:07:32 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583BCC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x25so9666007pff.4
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ssSSz7f3Ql8I/02L7v0dEm57rAmAG5QqUNmcYkmicic=;
        b=Y0Lxm4PsT6W6u90zOsXlf/mAM7vhsGT3kA9Upf6f3d/6KKrsfrlv2ttkzEQTU8NkmY
         diQh9FwhVG+Cjcoz4d9Xy4akunb2GY8a3uKd8fy+zadXO/yVXfHWJzYlIaUNIUKV4fkT
         zpfHHv2xpUzKo/i/IBnnsr0pEnXBKNwwc+OYOuALS8WiNZ/6oM3LxjvaOcVOPS9nqdbj
         BWblM2+3JfORIn7xrsQfqjRkIbtDnPRaaT48CJ9Xz2cH++HhzDnT2wg0ALoBWX3FraRm
         bJl4BAz9zPPlln6bSIS9nmj0ClDCwVch8KQI27yD+CgmYlxxIQBazs7Uss1vlHQbxyZQ
         hURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ssSSz7f3Ql8I/02L7v0dEm57rAmAG5QqUNmcYkmicic=;
        b=ZiN20r7jOh660U9nBWrPiXTJeOgk25ujXvsMae8p6ovenm9v5eb3DJ0Vs9ZDd/SG28
         RNs/JiZeWcqt2wYEIOxxeROjBtgNhS0e3R/Rwp0nf6jEihXeW7LW+4FeKZIVIj7jfqT5
         6S0K6gGelr+SOu6LrGl//Zzptk3Rz7ZcbuNU7B0uhe7jwHSC1Sq8UndlnC9PvDQFpXAO
         qv4m5fhEbskLdOYp+TJ+lrYhSLZlNZEwy5Hc5XN2/t1a8kFMly/pBIA2EovKHfruaPW9
         v1vD/KStxNmQFRBLH/t+Ycqa3afoz2+SuRCxSz+ghlnkC20H2XUIgKQGKiZx4+IuZ+8H
         OK0g==
X-Gm-Message-State: AOAM53191u7EyrFSLBni5OZG0qehWBihJomZBwT12BCwCAr/1Q0sr3kQ
        GSSjxkLK71tIRwrN/BD1F4k=
X-Google-Smtp-Source: ABdhPJyF3nlv5thmfkyqzLXjUD7uSIlcY3UvmnS4+ty2niTOnXQK5l++9iRNFLkYmzkS3glYHIHtlw==
X-Received: by 2002:a63:3d06:: with SMTP id k6mr13028660pga.316.1597741651856;
        Tue, 18 Aug 2020 02:07:31 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:07:31 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 08/35] dma: imx-dma: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:11 +0530
Message-Id: <20200818090638.26362-9-allen.lkml@gmail.com>
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
 drivers/dma/imx-dma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 5c0fb3134825..67b9f2bf35b7 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -613,9 +613,9 @@ static int imxdma_xfer_desc(struct imxdma_desc *d)
 	return 0;
 }
 
-static void imxdma_tasklet(unsigned long data)
+static void imxdma_tasklet(struct tasklet_struct *t)
 {
-	struct imxdma_channel *imxdmac = (void *)data;
+	struct imxdma_channel *imxdmac = from_tasklet(imxdmac, t, dma_tasklet);
 	struct imxdma_engine *imxdma = imxdmac->imxdma;
 	struct imxdma_desc *desc, *next_desc;
 	unsigned long flags;
@@ -1169,8 +1169,7 @@ static int __init imxdma_probe(struct platform_device *pdev)
 		INIT_LIST_HEAD(&imxdmac->ld_free);
 		INIT_LIST_HEAD(&imxdmac->ld_active);
 
-		tasklet_init(&imxdmac->dma_tasklet, imxdma_tasklet,
-			     (unsigned long)imxdmac);
+		tasklet_setup(&imxdmac->dma_tasklet, imxdma_tasklet);
 		imxdmac->chan.device = &imxdma->dma_device;
 		dma_cookie_init(&imxdmac->chan);
 		imxdmac->channel = i;
-- 
2.17.1

