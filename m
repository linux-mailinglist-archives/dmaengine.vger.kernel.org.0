Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72326257782
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHaKjF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHaKjD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:39:03 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C3BC061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:39:01 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f18so347444pfa.10
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BlxUGoukCjm70xKxvzQeb0nmcoaCF5xpWFkEwsqHqdQ=;
        b=eeUTcnaXPHnEm1o3imFXfv0DiWjFnxDmz1D+ajV/fJxw6HxjX/GnEltoS/9B33E0gO
         MMfi8tdNKD7To1Ck4lYGfxUQPWX1jO/cDqCaPwZDqJWcBayNk0u6f+UsNZ2DbDPjyeNY
         2r3V4aQHaufpLXsSwasQk6POYxhMsMuX4Io/EZdP1GHfGOF7FW2iVns/VY9D3907f+pY
         7bw5P3wZGt6LoBhB7b2pVQYtW719zbTSX0ozsjSLjHsZ+YdvvjapAAET6WUyWGiqlTW/
         5lits3JQCskpoH8gxTk5PH46zzyxxzhqkg9X6axiyHqH43TE1laspQ4w64ntEOd2Bb2c
         rzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BlxUGoukCjm70xKxvzQeb0nmcoaCF5xpWFkEwsqHqdQ=;
        b=kBJM/4GsOfj3eDc1RkMbKjv9GG7YZ9ewf2TUZBKZ7xZAfxOGKsVEvj58abE+tkN4eg
         yPov7ayEOZ+h5xXTR2BSUyx/uhpSjZnxwU0MBZmkej1aS9yBlxI4QxR6SGY0MRqGi2Nc
         d788UKBIk8y9o4aJ2kIoYvn3v+fSuyoKFg58zGipE7YQ/MQkKbNVnHR+PtKphy4STPAI
         /JYr5e6cxK88Ysycrv3sDuJeU6DSSbkvWqPlWwr22rjc9dkD6CR5mfx6UTL10jvY55cz
         qWamFmZnR+ZBDt0YM1I71PSh6d0epLt1Kv7x+ymuEv1ZV5QK3rMwPGmY8742tYWPM1TE
         juBQ==
X-Gm-Message-State: AOAM5311Ax+nXdrkIG9QtY6+P/toPj4w0gwbXv4fEgKaKas/mAQFIlez
        wcIKh3wYM5IH0FcUhCpbaLI=
X-Google-Smtp-Source: ABdhPJyIDW0vgNoU2rgvRA2dfY8MC6MZUjTOU6EuM9RRW/JmV64nVrMlYyTZtjMmVnNxdg3VkZHxzA==
X-Received: by 2002:a62:e10b:: with SMTP id q11mr752420pfh.117.1598870341141;
        Mon, 31 Aug 2020 03:39:01 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:39:00 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org
Cc:     linus.walleij@linaro.org, vireshk@kernel.org, leoyang.li@nxp.com,
        zw@zh-kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        logang@deltatee.com, agross@kernel.org, jorn.andersson@linaro.org,
        green.wan@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, dmaengine@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH v3 34/35] dmaengine: sf-pdma: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:41 +0530
Message-Id: <20200831103542.305571-35-allen.lkml@gmail.com>
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

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 6e530dca6d9e..a2d91074bc6f 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -281,9 +281,9 @@ static void sf_pdma_free_desc(struct virt_dma_desc *vdesc)
 	desc->in_use = false;
 }
 
-static void sf_pdma_donebh_tasklet(unsigned long arg)
+static void sf_pdma_donebh_tasklet(struct tasklet_struct *t)
 {
-	struct sf_pdma_chan *chan = (struct sf_pdma_chan *)arg;
+	struct sf_pdma_chan *chan = from_tasklet(chan, t, done_tasklet);
 	struct sf_pdma_desc *desc = chan->desc;
 	unsigned long flags;
 
@@ -298,9 +298,9 @@ static void sf_pdma_donebh_tasklet(unsigned long arg)
 	dmaengine_desc_get_callback_invoke(desc->async_tx, NULL);
 }
 
-static void sf_pdma_errbh_tasklet(unsigned long arg)
+static void sf_pdma_errbh_tasklet(struct tasklet_struct *t)
 {
-	struct sf_pdma_chan *chan = (struct sf_pdma_chan *)arg;
+	struct sf_pdma_chan *chan = from_tasklet(chan, t, err_tasklet);
 	struct sf_pdma_desc *desc = chan->desc;
 	unsigned long flags;
 
@@ -476,10 +476,8 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
 
 		writel(PDMA_CLEAR_CTRL, chan->regs.ctrl);
 
-		tasklet_init(&chan->done_tasklet,
-			     sf_pdma_donebh_tasklet, (unsigned long)chan);
-		tasklet_init(&chan->err_tasklet,
-			     sf_pdma_errbh_tasklet, (unsigned long)chan);
+		tasklet_setup(&chan->done_tasklet, sf_pdma_donebh_tasklet);
+		tasklet_setup(&chan->err_tasklet, sf_pdma_errbh_tasklet);
 	}
 }
 
-- 
2.25.1

