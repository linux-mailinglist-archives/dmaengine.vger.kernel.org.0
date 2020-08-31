Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A2F257770
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHaKhj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgHaKhd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:37:33 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D6EC061575
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l191so379270pgd.5
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/q+jN7eUmJ+jsCxGtL0suK3XAr3/P3hSWNfyxsfbPD4=;
        b=Llbt895gSsADzv7hOlLR+iGFUpfoxdk5EoKriMvfkYPegqllHMm3fbUynhh0BLI4Q8
         r6L2Ekasc6x1AY7X42PVOWFFuCHJ0uWS+QAG1/qmwGkHiKUxsQokrDHwtuByhLIjRZ1F
         x3gbD3T0zmBqgOBqnYRvL14LH2sNlQl8r1RETUVuYoLDp6WBn63q8a+iNPRWG54kQV0V
         JG9HlhbICqn6jbHYqEK5AD1ObDzQ5SbHKd1OyB+cHoX0gYVvgX4c3vg6yNAswTGU+YzZ
         xv8STlWyafiJtTvgUFR8DKXvss2lHw1DZawBSd3fh6WyU5nx1xx/ltlV8EEHoEG3KlRA
         SLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/q+jN7eUmJ+jsCxGtL0suK3XAr3/P3hSWNfyxsfbPD4=;
        b=q8HwPQfub0QI0vIVkNlSAC5CO/iPwJPOLajObWy2RtzpX8NLn0l4kxYembFS8kSRoT
         8njNytVNGBnqULYR5vgzYkDtlfSMuhIcoBI5IVazdk5kN3etmospvc9iG6JEEb+75W06
         55opBCJN24L5QaUBmUtZVwuNu4rtfH6RMwyOmfQRR8YG9XrdWp7wOLkDYyp4WpTFSLv/
         F4tYNsGHvFoLt8++AFR7+UYWTSH8aA9Tocz3N6TU3ZO3lb+zbqC7SLGzsMZsbgdjDi2B
         UU/LitN7/JXseqXJW+u1aLIk4uPQ7c/0p32q22mBSDQoUjJIE0sY1f8UaQUa0nbHAyU+
         G+Bw==
X-Gm-Message-State: AOAM532BCP+tni4FKK+D8tman1dbPJn3Nvs6lO0YuJMVEkfAPAOqooX4
        ZtNoDLMp3uvJ6Aa96IVtR60=
X-Google-Smtp-Source: ABdhPJxkCZFVDUzS4GunkEvuf2ibzAtVT2E6yA2AAklLnQM+rb/gQBkkKFvokjVM4cecwYB1DhxtNg==
X-Received: by 2002:a62:5212:: with SMTP id g18mr756641pfb.8.1598870251777;
        Mon, 31 Aug 2020 03:37:31 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:37:31 -0700 (PDT)
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
Subject: [PATCH v3 17/35] dmaengine: mxs-dma: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:24 +0530
Message-Id: <20200831103542.305571-18-allen.lkml@gmail.com>
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
2.25.1

