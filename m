Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF6725777F
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHaKis (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHaKir (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:38:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E974C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c15so2833277plq.4
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3zvpyaUeMuakm0b3Mljvy2ZKXhDewVkWirv/ZgFsgys=;
        b=Z4RdppuP1afMebQ8KABcuFqVAc4ZeT3H4k8jpsYzq7zoFpw2ZGXy2xYQmrLk4LB7qE
         a2Styo7bFCgBHM8CR1VTmxkgXhu4zcSzx0bdBLNKBkGn6luhEFqbia/YAKcpOS4xi9ol
         FnNHreV7hIk/F+kkjTLG7nJrPKpENV88BLhV0A2R6ZOKW2NbEZBtVGkJ39kDUOcvs/2I
         CzdFb7JrLvM9gjTNNFbOjFLLlldFsBEmX779THv9QHjiU2lm898Wg9/3s/JVmH9uBN7g
         qN9QjthlXW/5eY+NR1jWrkKISHCnr9XSs/82Nem3/1MvLLTdedKf99au4lbEFnbIrEQ5
         2OPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3zvpyaUeMuakm0b3Mljvy2ZKXhDewVkWirv/ZgFsgys=;
        b=VBtGXPZULDmZJi6FPFrWdaOF/Lb7Jz1hNl92CTFOMpbHFKEkhBD8BGgEkF3tTWP3Y8
         zn3a08MxLccYTC9co/gyHbwFyBCo43EVpGsalepRoeh9IkLtVPvovehbg/4jegAH0109
         gUKxlT2v4HIEVQ4dki3qiDs/i8/bJ7ZSytiZ8XAXoHbrJVvbRgMnE4+i9tXN2YMuAvdh
         61BXL/pM9qDCc4idqGNyHVmnA4Hi/1TFiTgoWEKxdeOKTttk+AxvONv7gaIZN7yO8tiy
         Q3YIgxHvGWUi4NXYIv/4fqgOI5V1lX/G1B3JNodIVJgoLoO+z7nRZsUpgTYo0Bb6bjFN
         psvg==
X-Gm-Message-State: AOAM533rZ5CvuBua0PPzTND+F1HnAmsK91Lw76sESV8vnK58zlWLvLxU
        yVRYy2cIZfWwwqT67iORWbw=
X-Google-Smtp-Source: ABdhPJyrOouMsGvpZgGX1766QkOMXufbqhrdUTpxk6QZBrgijELLPmOl7Ug3+BMhm6AifTOFvt8syQ==
X-Received: by 2002:a17:90b:4c03:: with SMTP id na3mr827483pjb.29.1598870325811;
        Mon, 31 Aug 2020 03:38:45 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:38:45 -0700 (PDT)
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
Subject: [PATCH v3 31/35] dmaengine: xgene: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:38 +0530
Message-Id: <20200831103542.305571-32-allen.lkml@gmail.com>
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
 drivers/dma/xgene-dma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index 4f733d37a22e..3589b4ef50b8 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -975,9 +975,9 @@ static enum dma_status xgene_dma_tx_status(struct dma_chan *dchan,
 	return dma_cookie_status(dchan, cookie, txstate);
 }
 
-static void xgene_dma_tasklet_cb(unsigned long data)
+static void xgene_dma_tasklet_cb(struct tasklet_struct *t)
 {
-	struct xgene_dma_chan *chan = (struct xgene_dma_chan *)data;
+	struct xgene_dma_chan *chan = from_tasklet(chan, t, tasklet);
 
 	/* Run all cleanup for descriptors which have been completed */
 	xgene_dma_cleanup_descriptors(chan);
@@ -1539,8 +1539,7 @@ static int xgene_dma_async_register(struct xgene_dma *pdma, int id)
 	INIT_LIST_HEAD(&chan->ld_pending);
 	INIT_LIST_HEAD(&chan->ld_running);
 	INIT_LIST_HEAD(&chan->ld_completed);
-	tasklet_init(&chan->tasklet, xgene_dma_tasklet_cb,
-		     (unsigned long)chan);
+	tasklet_setup(&chan->tasklet, xgene_dma_tasklet_cb);
 
 	chan->pending = 0;
 	chan->desc_pool = NULL;
-- 
2.25.1

