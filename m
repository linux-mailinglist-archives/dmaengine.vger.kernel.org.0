Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D17525776E
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgHaKh3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgHaKhQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:37:16 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CB5C061755
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:16 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t11so2829180plr.5
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOTI1twXkR9IST37RK4t1NWadLD5UjwHaqtPbpGaV5Y=;
        b=hngzz/vpDdBMejfS7dkv8Y2KTe879hj3q+vK+GU5pRWgBjR1DTkeyy9QtIi4IxzBNe
         GLK12RGsHJciSM4ci2Btz3fQX1qXRdnZGe/QM/cpkGrm/YTwA7so2SbOj9QoiXEbi1Fj
         42653u59nIoCNpi/RoEYXQrKNxF5aNcOhPYthSK59RK9Jb2FV5QHWTAdJqVKCrLCUPuj
         fM/TU4GpbmXGBJRCfqnVL2Df3MknR4HeE9ehixXHBHdrXJ8jIwDg8mCFA0hU3WXbTlLr
         M4gQ65iwQIjLu6zDYG0vXCdqOGquz9qJ+C3a5UuHuUzasNWBdHR9DTOApeZP4G6QVqDk
         klUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOTI1twXkR9IST37RK4t1NWadLD5UjwHaqtPbpGaV5Y=;
        b=STOmpLkoUfBvUg448guHQYgFcsVJ/9va6gdCWkz2TlcpDu05jdS2YuvAuvqPgI9vNe
         mc5rgl36HzDTKCpOa1MabkpdHs3B7euMqZeqPSEgU96SAOvrWcRKvsszOv+nCMi8cgYP
         FeoMwzZr4cV+FkhkqnkiHPzahc4E82zNBxT6/psrGESQTT0VNiie4LscCG4LmoCjIXQa
         MyGUr7zr5d3o6TE9b6Efoz6V2DnrEm656fd3ZVMkQeL13zev+NFi2RMg2vtYJTmBve5e
         QqRieq15PT7Y//FlRL/ld0bLIjoBa7p+dqzQf2zzIj0hSlBNHeELFKDe8sO5ztVyTV1u
         8ygg==
X-Gm-Message-State: AOAM533t5vSYk54AKepIBm+PuhBRhKVja+yzKa6Gz4ZgBKM1jCvh+7Mr
        xWRemYtsrSYBtkTfRBsjApc=
X-Google-Smtp-Source: ABdhPJw7k9FOSDCeHu2T1iadTJtQZCQmdo0QD3KOBd+tErrN8DzZGP9fig5YZnHnS+uz545VLFeM0g==
X-Received: by 2002:a17:90a:f28a:: with SMTP id fs10mr744943pjb.219.1598870236000;
        Mon, 31 Aug 2020 03:37:16 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:37:15 -0700 (PDT)
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
Subject: [PATCH v3 14/35] dmaengine: mmp: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:21 +0530
Message-Id: <20200831103542.305571-15-allen.lkml@gmail.com>
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
 drivers/dma/mmp_pdma.c | 6 +++---
 drivers/dma/mmp_tdma.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index f42f792db277..b84303be8edf 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -873,9 +873,9 @@ static void mmp_pdma_issue_pending(struct dma_chan *dchan)
  * Do call back
  * Start pending list
  */
-static void dma_do_tasklet(unsigned long data)
+static void dma_do_tasklet(struct tasklet_struct *t)
 {
-	struct mmp_pdma_chan *chan = (struct mmp_pdma_chan *)data;
+	struct mmp_pdma_chan *chan = from_tasklet(chan, t, tasklet);
 	struct mmp_pdma_desc_sw *desc, *_desc;
 	LIST_HEAD(chain_cleanup);
 	unsigned long flags;
@@ -993,7 +993,7 @@ static int mmp_pdma_chan_init(struct mmp_pdma_device *pdev, int idx, int irq)
 	spin_lock_init(&chan->desc_lock);
 	chan->dev = pdev->dev;
 	chan->chan.device = &pdev->device;
-	tasklet_init(&chan->tasklet, dma_do_tasklet, (unsigned long)chan);
+	tasklet_setup(&chan->tasklet, dma_do_tasklet);
 	INIT_LIST_HEAD(&chan->chain_pending);
 	INIT_LIST_HEAD(&chan->chain_running);
 
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 960c7c40aef7..a262e0eb4cc9 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -346,9 +346,9 @@ static irqreturn_t mmp_tdma_int_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 }
 
-static void dma_do_tasklet(unsigned long data)
+static void dma_do_tasklet(struct tasklet_struct *t)
 {
-	struct mmp_tdma_chan *tdmac = (struct mmp_tdma_chan *)data;
+	struct mmp_tdma_chan *tdmac = from_tasklet(tdmac, t, tasklet);
 
 	dmaengine_desc_get_callback_invoke(&tdmac->desc, NULL);
 }
@@ -586,7 +586,7 @@ static int mmp_tdma_chan_init(struct mmp_tdma_device *tdev,
 	tdmac->pool	   = pool;
 	tdmac->status = DMA_COMPLETE;
 	tdev->tdmac[tdmac->idx] = tdmac;
-	tasklet_init(&tdmac->tasklet, dma_do_tasklet, (unsigned long)tdmac);
+	tasklet_setup(&tdmac->tasklet, dma_do_tasklet);
 
 	/* add the channel to tdma_chan list */
 	list_add_tail(&tdmac->chan.device_node,
-- 
2.25.1

