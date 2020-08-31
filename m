Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93181257777
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgHaKiN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHaKiJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:38:09 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD67C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:09 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d22so355791pfn.5
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M2redf3QtPNMUj6PMpxlDcNyjHYnRscVHIcuwYgV2R4=;
        b=o/J4NkKpQwaFWev9oTqZPnFiRYqyasTek85/uxBF5CNjMvzdGRpDX5ht5zGoHogweH
         xeY13sSlr1GUoeu//y1xVFbxM1dmKLdu0LavCHR4aqrqPtCLHr7sK33NrtHr5aS4NlXO
         bY0n6ieK08IApc85P7PDnhw1SSdoFthavccLOj9Ze/L0Fq4qGcjH7ytwvldxZEqXJqIP
         R0b+t3WIhfXvc72qEazy6/yGn54lVjiyDUr8TzQCEOgmTg8PL4kGvYA71eZUm4sScPFB
         PI0FFu8vqPjXafJGl+zKElkcsTgCiUmyxjgBaDEtsqhFUtRDvd0Aj19HbADhFxAv2rmd
         g70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M2redf3QtPNMUj6PMpxlDcNyjHYnRscVHIcuwYgV2R4=;
        b=spTFaWJiToB1mSCxB0peO8Ayy5TxPnlZlc4ka6k8iZTUS0ElcUuTC6DDRd51ly2N8U
         To95wqWdihhfttzVqW5XEgZvdS/HAAV/oZttJG+Gb1vh/lGj+1imZSs0M+K4xhMzg9Px
         72yPMyNuZ7/bzF0ilr096ArESQUf4szuPEBqdSw8E6MmIcbuO+AOxiUjDuAEKSIilRR8
         IVyLmthoDOlsUDPlR1ybEmLL2OPV3khqaSNp4kf2wboT2sBNUI3E/KGlx8w/eEjkrUw4
         QDVUlZ7NL9kAsuikyco/8EJVdVAoi88Y2Q4X0ZdOVjlhMsiPs3RHtuKrgKwmgjVAjUWZ
         +Q1g==
X-Gm-Message-State: AOAM533nhtyP4Fpb76yTsB3JW/1R7kfejUphsDaQnKE6FCOGDr3dUwxy
        az7zQJGvETl9TjlAYwFO1NZNHRx7MpVoFw==
X-Google-Smtp-Source: ABdhPJww+wnxIgZFS1i2LbfT4meonbDdfNuCij2flhXvXjJB1qUg7S34lTnv7WTdU9m5TpGWpODB7w==
X-Received: by 2002:a63:7a5b:: with SMTP id j27mr747231pgn.78.1598870288742;
        Mon, 31 Aug 2020 03:38:08 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:38:08 -0700 (PDT)
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
Subject: [PATCH v3 24/35] dmaengine: sirf-dma: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:31 +0530
Message-Id: <20200831103542.305571-25-allen.lkml@gmail.com>
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
2.25.1

