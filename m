Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B372E24816A
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHRJHv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgHRJHu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:07:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40A4C061342
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u128so9656440pfb.6
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C5F0nnOTh5Z2C3fK8ewqMRIq3Z/HzN1bhDJR1BeVHS8=;
        b=Dtjdi4bMg/CZhY+QKSvEhCg7SHozlAjt0H9ZF8mHE+NugDzHitF3obYBprvOstCBfo
         Cp0pI/9h/G6lAAVCvdJnXvWrWZpFVG+ciHqAQZaHw0oat2UBXzD5OfePufwtK5ftAW1N
         VUbj/BnSd7LEZk4HcTx8bEnbxBFDyhj4h9nRgkVC2tuBeklfl6p2M8LfgchasoGbc1IN
         YxhHb3ONVfb9UKyFXLRhlYLuopUyEm/ePLZ7SdT1y2g08S//TE3LwMtNPT4RN6hfygc9
         O+H9FQqLef5va/lLEXvPgGBY8DRPbnEg0CXzO3wExnUksbNlSVlMqZ1wmXQc/81rgy9D
         G4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C5F0nnOTh5Z2C3fK8ewqMRIq3Z/HzN1bhDJR1BeVHS8=;
        b=TcAmfKysSdqgID3crSHQCw73cbFAHIK9y5yk35TiPCVJKU5j2Ghb/uh/AU/wB0mQPk
         IRc/PmfPm37mCqX6j3KrZajbmaNOzNq58QoJyLZTV7pKTc/0oUvKQmETHJs1aT6KajnM
         lFzxZiEiabBno/V38ky6nF/PDGHPNrU5toO7mADt/MezyCpsW3xWJOZgX/fm2gFnhsDS
         zXV1GBQqDb+fiwh89DogvbpSI5sbrGKJ7KGmcgYfAdd0sx/77+u1UvYKqhgKwKZJV1mC
         OCP8ZCuTH/nxAoKPdJcRuu4g/wXntZCWi78GY2lH/VYViEuREdtCXG6lFjrmDO8bPMVD
         zYqg==
X-Gm-Message-State: AOAM5311IWP11kJSKNybAZM/XPKY7GO2oOuIHtOud99oYeqdFevzDJqY
        TDQEM2M6jRuxnJXmJejjUGg=
X-Google-Smtp-Source: ABdhPJzIpNZqHAEC/0ItJL643nEWdt2LmkfqczaEP3YmqLo7rPuNQVB106u3gMvdjn+t04yY6PZkCA==
X-Received: by 2002:a62:fcc6:: with SMTP id e189mr14255614pfh.25.1597741670210;
        Tue, 18 Aug 2020 02:07:50 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:07:49 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 12/35] dma: k3dma: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:15 +0530
Message-Id: <20200818090638.26362-13-allen.lkml@gmail.com>
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
 drivers/dma/k3dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index c5c1aa0dcaed..f609a84c493c 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -297,9 +297,9 @@ static int k3_dma_start_txd(struct k3_dma_chan *c)
 	return -EAGAIN;
 }
 
-static void k3_dma_tasklet(unsigned long arg)
+static void k3_dma_tasklet(struct tasklet_struct *t)
 {
-	struct k3_dma_dev *d = (struct k3_dma_dev *)arg;
+	struct k3_dma_dev *d = from_tasklet(d, t, task);
 	struct k3_dma_phy *p;
 	struct k3_dma_chan *c, *cn;
 	unsigned pch, pch_alloc = 0;
@@ -962,7 +962,7 @@ static int k3_dma_probe(struct platform_device *op)
 
 	spin_lock_init(&d->lock);
 	INIT_LIST_HEAD(&d->chan_pending);
-	tasklet_init(&d->task, k3_dma_tasklet, (unsigned long)d);
+	tasklet_setup(&d->task, k3_dma_tasklet);
 	platform_set_drvdata(op, d);
 	dev_info(&op->dev, "initialized\n");
 
-- 
2.17.1

