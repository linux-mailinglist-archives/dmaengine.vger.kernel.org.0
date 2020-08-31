Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0EB257780
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgHaKiy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHaKix (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:38:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71611C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ls14so2744429pjb.3
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YRxS8wCu+hvYEfOm0S7N9XHmjSRSh/dqORNSRMlU5Ws=;
        b=G1H9fxbfResuDWwAPlcONnCAKobKzBafYmDf2ZDuZkeTqHQvDEF1FRWzkQSgiwz5r+
         OnJzTJbhc7wgM7su+G7w8AGn263VM9LTFX+LwP2+mov8OAu+pTKFmptV8KppaXnmfC0s
         YZafUFG3cqhDHz2r+S9YDuvi/8u3LTANnOWXocxYaHXTVPRCygIRP/Pwqsx6QbqTdFVl
         apl+vCcgx4SA9nEMEYybxswU8qjE7qvMbIwyiwCxX0nPIKhwzMqyrh3Dy3pmVJDc02Rw
         2Hnt5rSFZ9PLMcdOPjSFQUNiMuRBQUtV8OSEnal8IEQuef3W/B95Nmk3Rmfv9/6fcdST
         nEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YRxS8wCu+hvYEfOm0S7N9XHmjSRSh/dqORNSRMlU5Ws=;
        b=irBhcbgzwVYq2gyS98rqCT6OqCaOHVW88tb03guaCAtHh5+spekTlHM9C8AnghEOmb
         YHnd+QoNkkYvxrxvmE+imyCCJL6WEcRAjoNdVTmomYNxMtg0Wb/ERxjmq2O2Zp2+6Sda
         xm5Ysy5MOxNey/x14ZkmyBKd0T01xtXE/YH4RvQbJDdOzYtCo/U/SDkyJytPVxbBdhgo
         bkrp7/a22MM0qruwncmBdqzCPnJW1d1UAsLqPKbN7HBYTAN0TexCjKs015MGByoR022O
         OsD+mtyECfiHfBMgxCURNyaWYlgAQ/xKluJAhC1PQFh5iyUJ0q5gClynAO5TL8dckwAH
         QRhQ==
X-Gm-Message-State: AOAM531fN5cDwAnQrTtf/n7dx+dodKPbcb/EFY/hGu2I0FdMWybdPaZG
        DnUMDgFblHNz/ZQOLuI56Ds=
X-Google-Smtp-Source: ABdhPJyTdB7dhNPC4e85IRk0IJmcm4mkYZTvTZFbVzCHtpj7ifk4RsG2Q8mnRxZ7guyhRpwrdMCyZg==
X-Received: by 2002:a17:90a:39c8:: with SMTP id k8mr835749pjf.19.1598870331074;
        Mon, 31 Aug 2020 03:38:51 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:38:50 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org
Cc:     linus.walleij@linaro.org, vireshk@kernel.org, leoyang.li@nxp.com,
        zw@zh-kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        logang@deltatee.com, agross@kernel.org, jorn.andersson@linaro.org,
        green.wan@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, dmaengine@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v3 32/35] dmaengine: xilinx: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:39 +0530
Message-Id: <20200831103542.305571-33-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831103542.305571-1-allen.lkml@gmail.com>
References: <20200831103542.305571-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.25.1

