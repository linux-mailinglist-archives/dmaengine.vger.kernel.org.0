Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF34248180
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgHRJJN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJJL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:09:11 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7102BC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:09:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 2so9124993pjx.5
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VoLKiIOVUrOaN4l287TMDMySry9ropfMxje6XIuCNNc=;
        b=OQvI1sTlAuDUC/oDI7nsEn5BAcaYnL+MEjxwp5AxTbz76veOtUchwbJIJJLtoqf0FQ
         QSQPOT/IPjN6s+CkK+UAOxy0D09BG+UMGJ/RcWoriX6ggcZtFJKTSm7MWzR66V92Jojd
         k1+W+y89q4Z+/FUxT2Sj6fkS9kYH8BYdRM2ExWMvvcKWgkn+CykJmAI3MBMweu1E5qQg
         LUqY7wCNhdtI0IlQ0BZoxZRcith9R3EtTw0z9WZJk05d5r1Ogn3IobKCx/VBQ8pD5vxN
         H/+hxBbmjU/Yyi2TPqA6TRhT3lya9cN8ThDvTMtG5DMCLyDOd44arPJZ60y77fGYCbLK
         YYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VoLKiIOVUrOaN4l287TMDMySry9ropfMxje6XIuCNNc=;
        b=MOfFk0cmCGEcdEyFrtwOoGpB5hGkZkY9uI0uH5TrTrtvwGrvC3ewdBZVRjW2Fp46DS
         CqAJIylceZhyGrb3sbOBeqO6Us3zIrAqnGr/5syNlnWOIDI9i+FdHj/OYiAnbcusGUyG
         /oFm7tNQcu2TwYd3aSkjJ4g7DQZShOomk4K35sh6QPNSkyKGsw9Oqg0sRB81/GFVpYXj
         ntOOTyYjZxpezk2SLFJdLQonwntS0tzNSUIgK3EO+XCJ9QHysSKN9DrHc293gFzS4jGV
         86hVpBfAYWTbRfNn1fvNpoNn0rYa3Y18V8FulOB6DVcKS1GwafLXk/AJDVGCKam2UFKK
         QQ8w==
X-Gm-Message-State: AOAM530A4onP/R2YbBkyYAwlKdSjGWcTeb0Gm09k/9gdXF9Dcv5QEaNC
        tkqXHX0jN30/SLo8DY62b8M=
X-Google-Smtp-Source: ABdhPJz6YMB3k0WoOEraV2pQ1uKFkDgRta44zz/58L4zUcMKxJmvttJUzWuw40/7ne2kS3EO2b0WjQ==
X-Received: by 2002:a17:902:8685:: with SMTP id g5mr14516020plo.201.1597741751055;
        Tue, 18 Aug 2020 02:09:11 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:09:10 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 29/35] dma: txx9dmac: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:32 +0530
Message-Id: <20200818090638.26362-30-allen.lkml@gmail.com>
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
 drivers/dma/txx9dmac.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index 628bdf4430c7..5b6b375a257e 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -601,13 +601,13 @@ static void txx9dmac_scan_descriptors(struct txx9dmac_chan *dc)
 	}
 }
 
-static void txx9dmac_chan_tasklet(unsigned long data)
+static void txx9dmac_chan_tasklet(struct tasklet_struct *t)
 {
 	int irq;
 	u32 csr;
 	struct txx9dmac_chan *dc;
 
-	dc = (struct txx9dmac_chan *)data;
+	dc = from_tasklet(dc, t, tasklet);
 	csr = channel_readl(dc, CSR);
 	dev_vdbg(chan2dev(&dc->chan), "tasklet: status=%x\n", csr);
 
@@ -638,13 +638,13 @@ static irqreturn_t txx9dmac_chan_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void txx9dmac_tasklet(unsigned long data)
+static void txx9dmac_tasklet(struct tasklet_struct *t)
 {
 	int irq;
 	u32 csr;
 	struct txx9dmac_chan *dc;
 
-	struct txx9dmac_dev *ddev = (struct txx9dmac_dev *)data;
+	struct txx9dmac_dev *ddev = from_tasklet(ddev, t, tasklet);
 	u32 mcr;
 	int i;
 
@@ -1113,8 +1113,7 @@ static int __init txx9dmac_chan_probe(struct platform_device *pdev)
 		irq = platform_get_irq(pdev, 0);
 		if (irq < 0)
 			return irq;
-		tasklet_init(&dc->tasklet, txx9dmac_chan_tasklet,
-				(unsigned long)dc);
+		tasklet_setup(&dc->tasklet, txx9dmac_chan_tasklet);
 		dc->irq = irq;
 		err = devm_request_irq(&pdev->dev, dc->irq,
 			txx9dmac_chan_interrupt, 0, dev_name(&pdev->dev), dc);
@@ -1200,8 +1199,7 @@ static int __init txx9dmac_probe(struct platform_device *pdev)
 
 	ddev->irq = platform_get_irq(pdev, 0);
 	if (ddev->irq >= 0) {
-		tasklet_init(&ddev->tasklet, txx9dmac_tasklet,
-				(unsigned long)ddev);
+		tasklet_setup(&ddev->tasklet, txx9dmac_tasklet);
 		err = devm_request_irq(&pdev->dev, ddev->irq,
 			txx9dmac_interrupt, 0, dev_name(&pdev->dev), ddev);
 		if (err)
-- 
2.17.1

