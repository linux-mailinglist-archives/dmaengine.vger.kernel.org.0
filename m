Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA72248184
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHRJJ3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJJ0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:09:26 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36D1C061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:09:25 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i92so9122759pje.0
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7u/2cva1X+qYdcICcawfSm0XBYmeJIpXUg7S7BH2D4c=;
        b=b6kyfT5PZCgRRKvqOysGM/ep8AFpNiQvan+fPJEQswNIh+iA3/F0m+VlAwJIjzoAqq
         5CWrPEsmaRsNqrA+/tcUXxtZ1lTr63SzH6cl9VWMDwAS3doTi2XhRRTG8ijHAGLSAkzq
         hlBUV3XsMkGg07jHQlZm1//nSWq2BwUdlPbktzjdwUTfMbsc2PGdH0ZLmr1Ta5+F1PqI
         r1jAJK1yp7/bcs987g4+QTMoqjz8IYh0x5CRIuBvyepBw5Sm0KwrsioU3qMP9fkacRbt
         8AiRN8ZZ5c6XFSmG/XaQk1xy8LyIfOV4qUVnpYSLp1E0jb/XghMCqjf1ufuhJ/Z8FVzb
         q8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7u/2cva1X+qYdcICcawfSm0XBYmeJIpXUg7S7BH2D4c=;
        b=s+yrtBzqNaDeoxZ8GSUqbQ96NMkwSnDHZVzh7LhBGchM/rMncxPt9CQSohNBaFnNeT
         opWHz+NXu8CKQsN3dGbsDWM31Yr7h/TSd94yPFbErepFsoA4y+TyGlDbQT95RmetUi25
         L/vFNFLSBQ+Cz6YEIDE7kR3qpyGOrtDtg/J9OvFOKK9dyBAPOHunZpJmdOg4rls1fXsM
         3ziTtimba+B3VagU5h8eYkxNH0jFkTLz3gVsKXcy+2o7gsbKWCZR20EtpTqNBS/DLwfe
         2ABw/tIL5J1+6HxJurQXk5/jMp14N+ujkWKxDx1QV1bLIV7jdRLAH6Q7dG5u4oymCsAZ
         M3Ew==
X-Gm-Message-State: AOAM5319zZh50X8ejYeJjbfyVDKVOFrEbfH1HWv4+lipQLgk7a0In32n
        6M61fT8f7KkH4SOf35IQzxA=
X-Google-Smtp-Source: ABdhPJynnmp8aMI7rc/OOPx8HkofUZ98N4V0BzHehvZpqdRlVO/6QWXLOYBZIZSjhUnol59j6n0HOQ==
X-Received: by 2002:a17:90a:c291:: with SMTP id f17mr16117323pjt.92.1597741765564;
        Tue, 18 Aug 2020 02:09:25 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:09:25 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 32/35] dma: xilinx: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:35 +0530
Message-Id: <20200818090638.26362-33-allen.lkml@gmail.com>
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
 drivers/dma/xilinx/xilinx_dma.c | 7 +++----
 drivers/dma/xilinx/zynqmp_dma.c | 6 +++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 5429497d3560..48aa78785f4d 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1046,9 +1046,9 @@ static void xilinx_dma_chan_desc_cleanup(struct xilinx_dma_chan *chan)
  * xilinx_dma_do_tasklet - Schedule completion tasklet
  * @data: Pointer to the Xilinx DMA channel structure
  */
-static void xilinx_dma_do_tasklet(unsigned long data)
+static void xilinx_dma_do_tasklet(struct tasklet_struct *t)
 {
-	struct xilinx_dma_chan *chan = (struct xilinx_dma_chan *)data;
+	struct xilinx_dma_chan *chan = from_tasklet(chan, t, tasklet);
 
 	xilinx_dma_chan_desc_cleanup(chan);
 }
@@ -2866,8 +2866,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	}
 
 	/* Initialize the tasklet */
-	tasklet_init(&chan->tasklet, xilinx_dma_do_tasklet,
-			(unsigned long)chan);
+	tasklet_setup(&chan->tasklet, xilinx_dma_do_tasklet);
 
 	/*
 	 * Initialize the DMA channel and add it to the DMA engine channels
diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index ff253696d183..15b0f961fdf8 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -744,9 +744,9 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, void *data)
  * zynqmp_dma_do_tasklet - Schedule completion tasklet
  * @data: Pointer to the ZynqMP DMA channel structure
  */
-static void zynqmp_dma_do_tasklet(unsigned long data)
+static void zynqmp_dma_do_tasklet(struct tasklet_struct *t)
 {
-	struct zynqmp_dma_chan *chan = (struct zynqmp_dma_chan *)data;
+	struct zynqmp_dma_chan *chan = from_tasklet(chan, t, tasklet);
 	u32 count;
 	unsigned long irqflags;
 
@@ -908,7 +908,7 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
 
 	chan->is_dmacoherent =  of_property_read_bool(node, "dma-coherent");
 	zdev->chan = chan;
-	tasklet_init(&chan->tasklet, zynqmp_dma_do_tasklet, (ulong)chan);
+	tasklet_setup(&chan->tasklet, zynqmp_dma_do_tasklet);
 	spin_lock_init(&chan->lock);
 	INIT_LIST_HEAD(&chan->active_list);
 	INIT_LIST_HEAD(&chan->pending_list);
-- 
2.17.1

