Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9816248178
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgHRJIs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHRJIr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:08:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C26C061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:47 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r4so8929076pls.2
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uH6lh/wm+k3oIhHiZx2SeVnKtHemKJugMwQhBtWwEsY=;
        b=oDWb73LNzETi1pKpwN6aHysFSoClCqXwuvV7X3l2mzv2Rr6AboCl36PNGgoKbCBvGo
         Y+w8R89TqG00gN3JW7jGP2ReiLmvDujZEl43yOWbOf9sccf5AHGVGaq3dMzVFnc4O5oT
         QdsFkIWug6fq02hCJvEbQoCYbpAz9TdgSAmq1aZOd6BPZv0EYTOxzqv+dbQKY7puVk/p
         9kpNLugj76ZEqW+o0wTb0BxiBzMSJIavEjjwzVhHV4bPJpGz6+7mpWKZZyDWfRTCbLYw
         +IgP7eD7L6CVV89Xt7XRfikTQTAcXj8l9edatoFxMkeOhABXMhtI3DL2+5SUc29f72z9
         wOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uH6lh/wm+k3oIhHiZx2SeVnKtHemKJugMwQhBtWwEsY=;
        b=Z+OdkoOvc6zqB5TUkRSxoMOgVT9kicyEoReLTwwL9wkSMY52n07yCSFN39Vi/5eNbA
         /vpIBZ9e3v7Hs6UzOKBOmqEE6uySzJxWanW3Qll2Z/3Un8TQ0Ku2dKTiRcm5o4cfmWR+
         zBi4aPx6X+BCjGUEqQ0ydKrt2Xjnvm1P2TQswuH6cI5x5aVyRY43tCF7JRAp1wl47WAj
         5p9jo8QBbw0RT/Vf/RKw9cxlvfcrbcsQ/1FZZ3nHxGaQRcchfBxY/j4iurSB7ssKDKlN
         Dc8LJWo9QCXXPWs29X8nbPy+v1rQmgE6xcT8LLC4Zhd5348cPCaoQh6f2KqbNd9hWulv
         Wx3Q==
X-Gm-Message-State: AOAM533sWR5uPOooIfJ4PNrgImawLanHvIaoamCuH1aRed0RtDf+AwXQ
        C61BP6Qpu5QahO0SWTeCN3E=
X-Google-Smtp-Source: ABdhPJyvV8dTtuKOyhpF32MZ05D+c+Vx0TSeP4nLS5D8IWlVgryYJQFSgOUHmUGBWK77oHp1piZiow==
X-Received: by 2002:a17:902:714c:: with SMTP id u12mr14578929plm.290.1597741727159;
        Tue, 18 Aug 2020 02:08:47 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:08:46 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 24/35] dma: sirf-dma: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:27 +0530
Message-Id: <20200818090638.26362-25-allen.lkml@gmail.com>
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
 drivers/dma/sirf-dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 30064689d67f..a5c2843384fd 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -393,9 +393,9 @@ static void sirfsoc_dma_process_completed(struct sirfsoc_dma *sdma)
 }
 
 /* DMA Tasklet */
-static void sirfsoc_dma_tasklet(unsigned long data)
+static void sirfsoc_dma_tasklet(struct tasklet_struct *t)
 {
-	struct sirfsoc_dma *sdma = (void *)data;
+	struct sirfsoc_dma *sdma = from_tasklet(sdma, t, tasklet);
 
 	sirfsoc_dma_process_completed(sdma);
 }
@@ -938,7 +938,7 @@ static int sirfsoc_dma_probe(struct platform_device *op)
 		list_add_tail(&schan->chan.device_node, &dma->channels);
 	}
 
-	tasklet_init(&sdma->tasklet, sirfsoc_dma_tasklet, (unsigned long)sdma);
+	tasklet_setup(&sdma->tasklet, sirfsoc_dma_tasklet);
 
 	/* Register DMA engine */
 	dev_set_drvdata(dev, sdma);
-- 
2.17.1

