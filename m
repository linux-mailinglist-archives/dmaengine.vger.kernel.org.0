Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BB13FE4C8
	for <lists+dmaengine@lfdr.de>; Wed,  1 Sep 2021 23:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbhIAVTU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Sep 2021 17:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243130AbhIAVTM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Sep 2021 17:19:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D3AC061575
        for <dmaengine@vger.kernel.org>; Wed,  1 Sep 2021 14:18:14 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z19so904730edi.9
        for <dmaengine@vger.kernel.org>; Wed, 01 Sep 2021 14:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsj7VKNm1/45GUu+7ej+X+gh2q1WwYaSbQDEwk9lCrQ=;
        b=X7NoMvSyhPNax/+H6N/fuzKn9S68KQKw9FT2w9mog1ZOSsWtL1MBOIwjeGvboX6DEN
         zWKLMzNoK6s4Y18m0YRUAlFvib+rc1RJg4IpfcZqL9+xN6Iv4RoWuWJsRR/2folNjREL
         f48SeAMI3afeu6ZmR/6sXf+x7g01iiYZqJjXNKHzOvyaBDe5pS2a595auEb3P7JqmWYb
         3v+tlJ9pklEMv4HloGoeoNRPeZ4lIkgkGxDGrHJXYkoXWKYcq1QYeG79Baj9kOFlr4Jt
         DJ4e0ABMP57KxQzTrGwx9gK3G8GsVNTe/LR9g9rkeGRBi+9G7BTsFDzoEYZSX/fdwYjH
         ORJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsj7VKNm1/45GUu+7ej+X+gh2q1WwYaSbQDEwk9lCrQ=;
        b=E4vqWCjpT79Wlk2QQBCOVceGQXKp8TTCAMlZ9TcSUxsN0Svoy5/gBLQco2osmt3Vez
         E/t9zQfTMWPLb6S5YexBbhSgdE6MrvlJvQQpqxeCyjz1NvrOxY3uU2Df3X0vKdaCsKEc
         HVpuU7ETth2SP4DY1mO87t7CJ5nVYN7l+eMFrArOtKEzknB2D3+XzmyjU3Hvz9tmWbqf
         QAqV7Qf4o+kd/fcYMVF/GfS6PaCNwe4T0DerwT1EW41PhymjE8lh+s+cP0QucCBD4sbw
         XzdgcC4h449ESeB+Gvwg9zoGkvARQMeJOklzXnT+xqbymmhKDcb/pvBs7tHEDcTxk+Nt
         Hibw==
X-Gm-Message-State: AOAM5331/cwe4XNnDM9LAagOs5fxOc0jiLY4RR4WaSq9vW7mGjOvx0WJ
        zj+qmWNokNtjDks65BaKyKjJyA==
X-Google-Smtp-Source: ABdhPJyrNU0a5bN91zXXF+UzBB8yapuMNUdvNSLwLCCaO2tpGRw71zpDSUwVAF0L/ssLICsj+yPOGQ==
X-Received: by 2002:a50:ab42:: with SMTP id t2mr1630804edc.113.1630531093249;
        Wed, 01 Sep 2021 14:18:13 -0700 (PDT)
Received: from dfj.1.1.1.1 (host-87-5-14-18.retail.telecomitalia.it. [87.5.14.18])
        by smtp.gmail.com with ESMTPSA id n13sm389406edq.91.2021.09.01.14.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 14:18:12 -0700 (PDT)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     vinod.koul@linaro.org
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-m68k@vger.kernel.org,
        Angelo Dureghello <angelo.dureghello@timesys.com>
Subject: [PATCH] dmaengine: fsl-edma: fix for missing dmamux module
Date:   Wed,  1 Sep 2021 23:16:10 +0200
Message-Id: <20210901211610.662077-1-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix following panic on system halt:

Requesting system halt
[   10.600000] spi spi0.1: spi_device 0.1 cleanup
[   10.630000] fsl_edma_chan_mux() fsl_chan->edma->n_chans 64 dmamux_nr 0
[   10.630000] *** ZERO DIVIDE ***   FORMAT=4
[   10.630000] Current process id is 38
[   10.630000] BAD KERNEL TRAP: 00000000
[   10.630000] PC: [<402f09ba>] fsl_edma_chan_mux+0x7c/0x12e
...

Some architecture as mcf5441x (ColdFire) may not have
a dmamux, so dmamux_nr is set to 0. This patch considers this case.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
---
 drivers/dma/fsl-edma-common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 930ae268c497..009c75ff1320 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -638,12 +638,14 @@ EXPORT_SYMBOL_GPL(fsl_edma_alloc_chan_resources);
 void fsl_edma_free_chan_resources(struct dma_chan *chan)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
+	struct fsl_edma_engine *edma = fsl_chan->edma;
 	unsigned long flags;
 	LIST_HEAD(head);
 
 	spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 	fsl_edma_disable_request(fsl_chan);
-	fsl_edma_chan_mux(fsl_chan, 0, false);
+	if (edma->drvdata->dmamuxs)
+		fsl_edma_chan_mux(fsl_chan, 0, false);
 	fsl_chan->edesc = NULL;
 	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
 	fsl_edma_unprep_slave_dma(fsl_chan);
-- 
2.32.0

