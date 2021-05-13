Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBFE37FE10
	for <lists+dmaengine@lfdr.de>; Thu, 13 May 2021 21:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhEMT2S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 May 2021 15:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbhEMT2R (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 May 2021 15:28:17 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B7CC06174A
        for <dmaengine@vger.kernel.org>; Thu, 13 May 2021 12:27:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o127so15097740wmo.4
        for <dmaengine@vger.kernel.org>; Thu, 13 May 2021 12:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j3rMCST+HXWYznkK+d1QOqqcV5rur8wbxkYAuvymJ68=;
        b=iXGsYQ3aCos5lh8Flu1CH3c2WhrNHPiobWA3CJU8S2Zz8hNAfgpCHFOZebov7jBkbF
         Wn2unDtn96RcYqNoxyyGGPD6cB7p5z7kbh+o7UPYKb92JhQHnaNnxLaRDB6euEqC2xlq
         WHPQdkleg4+U4bXIRxja/rnK9wDkRugP0Qlr3/pZ8An6N/QxpiV/2TpPtseqvZYh1bA9
         bJCWMYW4pHloFhJdImpV4B9182jUG7IbZlnadtCsoePmJ++T/G+eDes89+5sRrmhAh6r
         rfX2dOKLlck8NjWQv5xIlCbBzdsMzzO7PTmdmB315QSM3ttPdpjRwQBqT4rr7ld3o4+t
         xkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j3rMCST+HXWYznkK+d1QOqqcV5rur8wbxkYAuvymJ68=;
        b=PN+olHn+ZFYida02qApYqtuDE3TTp1QNrzMRYeamlfISqlitzmE1kp/kvcgpqWnYTG
         L7lVhZBY75XTV7gLUQ4iTotLdUUsDPrXZzNOTTd2zSMI8G/uZIf3vSK0CvdymNjAtCoS
         iAGBsuzSdkNnVNN5dNRSXtVxADb0H5mlS6S2Z3TP3HPf/0uKBBiZN2AtvQ6vRhtefzH3
         GGCUg4hBZRDJOt0FHJt8ZWk8ZIXGKWJCdcXCIHELiEYiiDAc5+4V7COS+8vzTP3UJ9Lc
         WzHDDoRfqGhDIWGBC5NqPC1h6MkiUr+JlY0iaRdZ1tQ/arwWbD8K4DVz0rQYJ6WeY/kG
         PknQ==
X-Gm-Message-State: AOAM533ZETC1EqAnfl4SdPts8BpbMfOmvYsKZoIUF6rVlh0UHq8wlRWY
        x3dgY5lax8/gLiVL4ISvgH6LBQ==
X-Google-Smtp-Source: ABdhPJyX9nit3J47iZ6CZSouR97dqQsMArptT4kaSpWbjbao2AoF2xLXk9D9A8B8xJ4iYXcXD+LbXA==
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr45992727wmq.4.1620934025298;
        Thu, 13 May 2021 12:27:05 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6341-d842-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6341:d842:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id h9sm3053621wmb.35.2021.05.13.12.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 12:27:04 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Cc:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dmaengine: mediatek: do not issue a new desc if one is still current
Date:   Thu, 13 May 2021 21:26:41 +0200
Message-Id: <20210513192642.29446-3-granquet@baylibre.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210513192642.29446-1-granquet@baylibre.com>
References: <20210513192642.29446-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Avoid issuing a new desc if one is still being processed as this can
lead to some desc never being marked as completed.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index e38b67fc0c0c..a09ab2dd3b46 100644
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
@@ -258,6 +261,7 @@ static irqreturn_t mtk_uart_apdma_irq_handler(int irq, void *dev_id)
 		mtk_uart_apdma_rx_handler(c);
 	else if (c->dir == DMA_MEM_TO_DEV)
 		mtk_uart_apdma_tx_handler(c);
+	mtk_uart_apdma_chan_complete_handler(c);
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 
 	return IRQ_HANDLED;
@@ -363,7 +367,7 @@ static void mtk_uart_apdma_issue_pending(struct dma_chan *chan)
 	unsigned long flags;
 
 	spin_lock_irqsave(&c->vc.lock, flags);
-	if (vchan_issue_pending(&c->vc)) {
+	if (vchan_issue_pending(&c->vc) && !c->desc) {
 		vd = vchan_next_desc(&c->vc);
 		c->desc = to_mtk_uart_apdma_desc(&vd->tx);
 
-- 
2.26.3

