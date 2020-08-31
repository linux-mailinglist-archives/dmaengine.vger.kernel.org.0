Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AE6257774
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHaKhz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHaKhx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:37:53 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43998C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:53 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id v15so377747pgh.6
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X4SDrq7HnKkUYae0qk/zKfsqOWvUrO0HJ9v060n8FOA=;
        b=XGKHgCAqH1AmLGsk2vERDFvjY6cffH8ZE+0VmOgGnDC7wDEyc9FeXVQSEi4NNW0NXj
         9gfJcfgHqA6B8r2Fb/YnDAm4FTuMyFELqq7Utzvn28Rrei6qGs5Qhn7SbsD30j5lFbSD
         xpNBCYcFW6wRhlpQk5T381bjBmK1HgBQfh86B/xNLjVxmLdOfrIpcv9th7aRE5esPqrT
         w5AZ6PrDb+c+EUrJN4+fTtWGRgC9OnODS/Hw80V7I8/Pk5nVlmjYyuVLYtO3QxrclN2X
         /IkiayudOkpsh/q9bhU2/p8TZYjpPYC0KGSGCnkmC24sDaXJWvP0HpGb0WlPFfNww5ng
         7ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X4SDrq7HnKkUYae0qk/zKfsqOWvUrO0HJ9v060n8FOA=;
        b=rtCzjx8Jxet3hfIzasMlX3/ddNCSbR2lNrGF2YP0iUGHg9nQPa4ozsxsui6+NxEoUt
         GYNVgKsJrpIIz2LPxin7QRWiBuZ8QjO3JHP8b03TgfTE7AMnxoqj2xq+aRgAx215z6Um
         qs8blUasQP2E5PQFrhnGJnTApEvTG+/u2whVYAjHbAhuhfedhkrNJXssxpP9LBklCt8X
         tNgeMW/glY/AD5JMjLHDyGKzCb7p2LL6cN1Z9Y0aeymCfqJkhwrn4qo+EoJR3a7J0a7U
         O8oliDX+YE4dqruf/kizbINnrGgPFYfM4UDo/tnlTzWOsTKU0CdJ+B414KPnhU3AR3zw
         1fKg==
X-Gm-Message-State: AOAM531zol/HqE9ev1hN5SMKRW1DUGku3pPvrt4/uv7b7l1CR7IVwvDP
        QlxZ6lnxoCAAW6eiWqeX578=
X-Google-Smtp-Source: ABdhPJy4OAFo1nT+fncGlLYNh7Tynxq3TiYwxvHeSW3qPKDW1Ts8/4VSFqeknQNs0Y0QQwjHPbnvKA==
X-Received: by 2002:aa7:9aa4:: with SMTP id x4mr633254pfi.141.1598870272867;
        Mon, 31 Aug 2020 03:37:52 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:37:52 -0700 (PDT)
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
Subject: [PATCH v3 21/35] dmaengine: ppc4xx: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:28 +0530
Message-Id: <20200831103542.305571-22-allen.lkml@gmail.com>
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
 drivers/dma/ppc4xx/adma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 4db000d5f01c..71cdaaa8134c 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -1660,9 +1660,9 @@ static void __ppc440spe_adma_slot_cleanup(struct ppc440spe_adma_chan *chan)
 /**
  * ppc440spe_adma_tasklet - clean up watch-dog initiator
  */
-static void ppc440spe_adma_tasklet(unsigned long data)
+static void ppc440spe_adma_tasklet(struct tasklet_struct *t)
 {
-	struct ppc440spe_adma_chan *chan = (struct ppc440spe_adma_chan *) data;
+	struct ppc440spe_adma_chan *chan = from_tasklet(chan, t, irq_tasklet);
 
 	spin_lock_nested(&chan->lock, SINGLE_DEPTH_NESTING);
 	__ppc440spe_adma_slot_cleanup(chan);
@@ -4141,8 +4141,7 @@ static int ppc440spe_adma_probe(struct platform_device *ofdev)
 	chan->common.device = &adev->common;
 	dma_cookie_init(&chan->common);
 	list_add_tail(&chan->common.device_node, &adev->common.channels);
-	tasklet_init(&chan->irq_tasklet, ppc440spe_adma_tasklet,
-		     (unsigned long)chan);
+	tasklet_setup(&chan->irq_tasklet, ppc440spe_adma_tasklet);
 
 	/* allocate and map helper pages for async validation or
 	 * async_mult/async_sum_product operations on DMA0/1.
-- 
2.25.1

