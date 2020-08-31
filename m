Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31556257761
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgHaKgl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgHaKgk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:36:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF94C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id nv17so2913476pjb.3
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5wsYyfm7fM3LtIoiLq6ovDcEJAfgMVeGP9t+wnye3g=;
        b=QCOJcXpdXZsZHxkkIqK/jQkjPCgSlxOOKVGBAQk680cYEU0wFfawo3V6CBRBh4z4Dw
         1oiZxYjJ20aJybaAH9OMKqWzERx144zjrPNWbeuvbR7X12vwJR/mIOuGIPdf3Rm+TgY7
         fadvRjeZb78o5bzaRGKSqe//XBRbAAzbPOicETZ/3X3eIQ/S1Osf0lT7LnriIVQ9oRY5
         yuspLVaCvsO0EcJyk6/6PTXc23Zc3XXzZo4AvUK4XEGn8mIFxwNaS7h5AkXc2XhnkEGn
         x9UsoylGDjewSgSyHPkx3qRcUMrUw8vqwUp/qhI3c514U7OUx8WE7LxpCosGf99V865S
         HX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5wsYyfm7fM3LtIoiLq6ovDcEJAfgMVeGP9t+wnye3g=;
        b=ASX7fY1eD3h3NkgbIf9lI3va+zPrwOtNwsKSIWGWYh7K3EaXSSXe7CYLUQ3HaLcvTB
         QfX+l/gK6KdkknjWkfviif49LzJB8AIlClpVi2NbheoDoTzjQtD08gvbeP+EaffQN1St
         fBZJUZSDrvoi6XAiWxfbPt5kUHVz2kuC980lfYLO3PTgGCD1n6kWsB8kdXiv2q3L7OhW
         2StK6EhTDMmsP+D3d+VbCJC8lffYEgIb5HLGjJe8G6hdJV3r8ipk67eL3eAzDFTh5nWE
         geYKtg78HluhAfFemZcj3tvDZvdaWB3IO12AejTe2p0afqY2SwQnrxfw/HXprDQDpWtU
         MQrA==
X-Gm-Message-State: AOAM533JZwFeiQLJCrhD8vwcxEd4iOwO/PRTrGdhMIC1umrlr6aPcdkF
        8g1TZFkpZ32Up//FH22wug4=
X-Google-Smtp-Source: ABdhPJxCVoKcWKJ9Z2QnI25AbLYsqI/au7cS/sPqf5gyVvEmM7WOocaqCvAc06oJGNr/cUjGvaWiFA==
X-Received: by 2002:a17:90a:5aa2:: with SMTP id n31mr774170pji.33.1598870199702;
        Mon, 31 Aug 2020 03:36:39 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:36:39 -0700 (PDT)
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
Subject: [PATCH v3 07/35] dmaengine: fsl: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:14 +0530
Message-Id: <20200831103542.305571-8-allen.lkml@gmail.com>
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
 drivers/dma/fsl_raid.c | 6 +++---
 drivers/dma/fsldma.c   | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
index 493dc6c59d1d..26764bf2fc6d 100644
--- a/drivers/dma/fsl_raid.c
+++ b/drivers/dma/fsl_raid.c
@@ -154,9 +154,9 @@ static void fsl_re_cleanup_descs(struct fsl_re_chan *re_chan)
 	fsl_re_issue_pending(&re_chan->chan);
 }
 
-static void fsl_re_dequeue(unsigned long data)
+static void fsl_re_dequeue(struct tasklet_struct *t)
 {
-	struct fsl_re_chan *re_chan;
+	struct fsl_re_chan *re_chan from_tasklet(re_chan, t, irqtask);
 	struct fsl_re_desc *desc, *_desc;
 	struct fsl_re_hw_desc *hwdesc;
 	unsigned long flags;
@@ -671,7 +671,7 @@ static int fsl_re_chan_probe(struct platform_device *ofdev,
 	snprintf(chan->name, sizeof(chan->name), "re_jr%02d", q);
 
 	chandev = &chan_ofdev->dev;
-	tasklet_init(&chan->irqtask, fsl_re_dequeue, (unsigned long)chandev);
+	tasklet_setup(&chan->irqtask, fsl_re_dequeue);
 
 	ret = request_irq(chan->irq, fsl_re_isr, 0, chan->name, chandev);
 	if (ret) {
diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index e342cf52d296..0feb323bae1e 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -976,9 +976,9 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void dma_do_tasklet(unsigned long data)
+static void dma_do_tasklet(struct tasklet_struct *t)
 {
-	struct fsldma_chan *chan = (struct fsldma_chan *)data;
+	struct fsldma_chan *chan = from_tasklet(chan, t, tasklet);
 
 	chan_dbg(chan, "tasklet entry\n");
 
@@ -1151,7 +1151,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	}
 
 	fdev->chan[chan->id] = chan;
-	tasklet_init(&chan->tasklet, dma_do_tasklet, (unsigned long)chan);
+	tasklet_setup(&chan->tasklet, dma_do_tasklet);
 	snprintf(chan->name, sizeof(chan->name), "chan%d", chan->id);
 
 	/* Initialize the channel */
-- 
2.25.1

