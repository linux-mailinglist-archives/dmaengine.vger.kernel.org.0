Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34343717EF
	for <lists+dmaengine@lfdr.de>; Mon,  3 May 2021 17:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhECP12 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 May 2021 11:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhECP1Y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 May 2021 11:27:24 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05507C06138C
        for <dmaengine@vger.kernel.org>; Mon,  3 May 2021 08:26:31 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id m13so5713034oiw.13
        for <dmaengine@vger.kernel.org>; Mon, 03 May 2021 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:cc;
        bh=+0TCMPSPgNnKaQLcoOaFiNFXoz3PHgbrfotliZuGoqU=;
        b=z7g3kLcgZlbrRBtb8CCRI1h9u/bLF74VDrbBqfM72Yarr8dimSBTyLlvUTL1zBDjYN
         lUG3Ju6NPYHf5r9ez9mmShBUiODfIb5zLctDXgickNqHAmb9FYvkTtbaOcAeSCmLL6RF
         g72P90/Eo9OBv9wMPqHUnoSlImhyJfoORfu6cs4gBVwqyJXzTp2GrVLfydcz2RZQVVPy
         X1wtYXCDqm3Ak2HWImonIZaWp9hRBpxduRgoVQttGQLnLOArw9nGHcD8De5dH1AqtumN
         QR7EGAOUt+E3AHUmsk8vYJC1ZN+G9VKPvxF6sHmUrxXfgZT/HGfEYUWIKp+TTwM6dhES
         kMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:cc;
        bh=+0TCMPSPgNnKaQLcoOaFiNFXoz3PHgbrfotliZuGoqU=;
        b=Po3gAYqaW7PhJMG8DK7YxF1IteKX4FxubUbBjiuM6Gbe36nYExeGlg0JlNRtPJgFSQ
         58P1kUZ3PZsqgiZvjcv1SIivZhb6GkwIBEOBZxduByA3Qanut9ptP570uRgkeUWsEbpu
         W29E1XmrmY6UhNAUx60I7uOj05lbLQQJqLg/BQeQU51WgagcZknms5Y8vBz+gvY+xHf8
         E276ucpj4uF0ngd5X+DkI4uRuIEidRdI/y3d1dZag1yQmZcH6hmDpTO4hgNC2VeslTd8
         NABkYJpSwpjvjO5eSfr+xYILBmUi6M5vJXO74o9tlmkYvOS82yjHIQkwD73sEpp9lT23
         sTEw==
X-Gm-Message-State: AOAM531Z+bSsWQdv0QH6evf6etaqffj34j1XtPDq5SQ244+A6y91j3TH
        7v9EhX4F9E1B2fbkobKblY6IsXQwsCF24xxm9Q043A==
MIME-Version: 1.0
X-Received: by 2002:a54:4f07:: with SMTP id e7mt10487610oiy.140.1620055590361;
 Mon, 03 May 2021 08:26:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 May 2021 08:26:29 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Mon, 3 May 2021 08:26:29 -0700
Message-ID: <CABnWg9vHxXSxDeBxjMCOHtCDogL+jUXMq9-SCC8x3zmaV8wL0g@mail.gmail.com>
Subject: [PATCH 2/4] dmaengine: mediatek: do not issue a new desc if one is
 still current
Cc:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Avoid issuing a new desc if one is still being processed as this can
lead to some desc never being marked as completed.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c
b/drivers/dma/mediatek/mtk-uart-apdma.c
index 4610dbdde75e..249cabddb7ee 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -204,14 +204,9 @@ static void mtk_uart_apdma_start_rx(struct mtk_chan *c)

 static void mtk_uart_apdma_tx_handler(struct mtk_chan *c)
 {
-	struct mtk_uart_apdma_desc *d = c->desc;
-
 	mtk_uart_apdma_write(c, VFF_INT_FLAG, VFF_TX_INT_CLR_B);
 	mtk_uart_apdma_write(c, VFF_INT_EN, VFF_INT_EN_CLR_B);
 	mtk_uart_apdma_write(c, VFF_EN, VFF_EN_CLR_B);
-
-	list_del(&d->vd.node);
-	vchan_cookie_complete(&d->vd);
 }

 static void mtk_uart_apdma_rx_handler(struct mtk_chan *c)
@@ -242,9 +237,17 @@ static void mtk_uart_apdma_rx_handler(struct mtk_chan *c)

 	c->rx_status = d->avail_len - cnt;
 	mtk_uart_apdma_write(c, VFF_RPT, wg);
+}

-	list_del(&d->vd.node);
-	vchan_cookie_complete(&d->vd);
+static void mtk_uart_apdma_chan_complete_handler(struct mtk_chan *c)
+{
+	struct mtk_uart_apdma_desc *d = c->desc;
+
+	if (d) {
+		list_del(&d->vd.node);
+		vchan_cookie_complete(&d->vd);
+		c->desc = NULL;
+	}
 }

 static irqreturn_t mtk_uart_apdma_irq_handler(int irq, void *dev_id)
@@ -258,6 +261,7 @@ static irqreturn_t mtk_uart_apdma_irq_handler(int
irq, void *dev_id)
 		mtk_uart_apdma_rx_handler(c);
 	else if (c->dir == DMA_MEM_TO_DEV)
 		mtk_uart_apdma_tx_handler(c);
+	mtk_uart_apdma_chan_complete_handler(c);
 	spin_unlock_irqrestore(&c->vc.lock, flags);

 	return IRQ_HANDLED;
@@ -363,7 +367,7 @@ static void mtk_uart_apdma_issue_pending(struct
dma_chan *chan)
 	unsigned long flags;

 	spin_lock_irqsave(&c->vc.lock, flags);
-	if (vchan_issue_pending(&c->vc)) {
+	if (vchan_issue_pending(&c->vc) && !c->desc) {
 		vd = vchan_next_desc(&c->vc);
 		c->desc = to_mtk_uart_apdma_desc(&vd->tx);

-- 
2.26.3
