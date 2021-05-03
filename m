Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540D83717F2
	for <lists+dmaengine@lfdr.de>; Mon,  3 May 2021 17:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhECP13 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 May 2021 11:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhECP11 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 May 2021 11:27:27 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65346C061763
        for <dmaengine@vger.kernel.org>; Mon,  3 May 2021 08:26:34 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso5362663otb.13
        for <dmaengine@vger.kernel.org>; Mon, 03 May 2021 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:cc;
        bh=KYXKPtE2VZh6dALBmahX3Lb0HQq8HVq0AUpkoo7GpCQ=;
        b=xmbEQhxke5pWHBfmJSrThVbWD6yNloeA2luzWWZqnzEUacHlBE9+p5BdJi3ay7KHeM
         EuMcX5IaisYJBmG+magxxmg5YuD04Gmwg7zkDBgqouHeuxxIcMUOnP8AYfGwVW3DMeNz
         RsXqNHfeYCEYU4hJolnlkGJ72xZ+yP8N1Kv5W96RED8BM5BQucoNaDhHjUMwLQZC24wl
         ZVBvPEqsjSvYY4Ic+mnHQs4tgU0zinx9OPGvC9YH2wQzKGCs+fkp7h5Mh2BpLTxXdXBu
         RYgOmbb+6IJE9/Eyo2w/veS83rXtUE5tF3PnuxfyHB+uJGQkLVMfY+DoCXkit+rXY+mH
         tPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:cc;
        bh=KYXKPtE2VZh6dALBmahX3Lb0HQq8HVq0AUpkoo7GpCQ=;
        b=PG9FLejrSCDn2Z2IgnrDlcMx2cmqfyJ97xCz2DpPc/WClnYcu/ZZJL9EWldGW90RiM
         Tj0E8cG1I5veHz2vnLMkRDrdBO3dZiZFLRveWif59pwLFDKwyHmTCrFQtlkjvQLpVaCZ
         iweOXY7OOen0wYlNFMUZOgobWd/P4GsGscT3q39881e6BG/z8aMY5Kt8/jbIQDAJv+ag
         obaadqC9ug9LL9lsASMkgvyky5XBOLBRD6ZUlaKQU/VrEVeNH65BS+sTmqClO32S2hi7
         2n6RB8xk+DrhIgJX8hKQkgrQxrTXoGoJCQSxIzEvoMk7kDEqf1i38ejPwF1+16KBKs7+
         bWXg==
X-Gm-Message-State: AOAM530NQzPYMs7NzMwx9SS+Aiqea+j+/KQlcAomv8+d5IcaXUM+R4vk
        plJvUrlocZqC6yY298YxroWHdeXEnm0Nwww1QySauw==
MIME-Version: 1.0
X-Received: by 2002:a9d:4703:: with SMTP id a3mt12624905otf.136.1620055593857;
 Mon, 03 May 2021 08:26:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 May 2021 08:26:33 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Mon, 3 May 2021 08:26:33 -0700
Message-ID: <CABnWg9s9nbqm3bMv7oWgDw2zvaB3tcHttk9n9Jia4aZ_tdvK=g@mail.gmail.com>
Subject: [PATCH 4/4] dmaengine: mediatek: do not hold the spinlock for vchan_dma_desc_free_list
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

As there is no need to hold the spinlock for dma_desc_free_list,
Move it oustide the spinlock section.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c
b/drivers/dma/mediatek/mtk-uart-apdma.c
index 4711bec04b98..ba43708f2a93 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -431,8 +431,8 @@ static int mtk_uart_apdma_terminate_all(struct
dma_chan *chan)

 	spin_lock_irqsave(&c->vc.lock, flags);
 	vchan_get_all_descriptors(&c->vc, &head);
-	vchan_dma_desc_free_list(&c->vc, &head);
 	spin_unlock_irqrestore(&c->vc.lock, flags);
+	vchan_dma_desc_free_list(&c->vc, &head);

 	return 0;
 }
-- 
2.26.3
