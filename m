Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC3237FE0E
	for <lists+dmaengine@lfdr.de>; Thu, 13 May 2021 21:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhEMT2Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 May 2021 15:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhEMT2P (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 May 2021 15:28:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5651BC061756
        for <dmaengine@vger.kernel.org>; Thu, 13 May 2021 12:27:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so378690wmf.1
        for <dmaengine@vger.kernel.org>; Thu, 13 May 2021 12:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eRxz/pWXTALO6H3I0wjEAHHa6qtt4usgfqtoKz5U3Bw=;
        b=SDoVIViQbUjjhanbrPpBJslUuhhXuGOUixKLM4aM/Xni8UB3PfZUwBqSdnqyXcHmOE
         QWegUOH0EPxlW+QrYpS4iyzpXPEZoGmDQzlxAglfvi6Y1N6q4Dn67gbq7WZQRM5drQXL
         rmrjV3vScos/2VteiR6GuJdaSi0YT8btL3MaVof9zulzqm7UOk9M+9IIDdkkAcm2BlQ7
         5M1mJ8U+FCQyn8PDVJwjITjPifC5lD21oM5IVKdHUghZ6Dt/gM+NI029xI4uAJDlae5F
         QHLJODjN4XMl7VO4eNkJxB/yi/CjBPnHCwWn4qymufqvhK+nWYB9o8ueMSXS3ZdbfrPz
         s8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eRxz/pWXTALO6H3I0wjEAHHa6qtt4usgfqtoKz5U3Bw=;
        b=N13EFj9MEACYi6wQIfPKe6v+RNilEn3V019QFfkt+rV1p6esu09PfCRpev5IQXyqx4
         7BLht9HV5ijUYAt87eAaeM7abJR0PdsWfEei+F6xbQPXGPxcA67nRmA9Ykhz8lO5cCV+
         7ecy1B9BMq1rfgZHwcRr8P84m39wKPim6ejR+d9Te5NfCLzGelcSUFn48gKuzyPNrbEN
         ZqJ+EMFyf3ccs/R5hmujCgWt7wF6rBMtJcy3qz9JrAEyNCdZ8a11tnYUGc02PtRd9Rb2
         K3elQsp4S6BeTlDsrVYXQI2xrcfa5N8NUKXo/fWDdVymasMq0XbScPYDe5RFZRLBbCjV
         5UVg==
X-Gm-Message-State: AOAM531FZ+gg/uqpxY7SO+xgPbdpDekbzqay0c6Fp3c4VrKqU8E4/sIe
        Gdbg1ZuWlSt2qobExOZmzDJMaQ==
X-Google-Smtp-Source: ABdhPJzyMLZTPcPNKyhY5TxDvljyGM7Bn/ftFSKMJZJ7ETtYuncFkrWBVj7udx7AfFFx7pB9Mel9Nw==
X-Received: by 2002:a05:600c:4f04:: with SMTP id l4mr45170585wmq.18.1620934024035;
        Thu, 13 May 2021 12:27:04 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6341-d842-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6341:d842:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id h9sm3053621wmb.35.2021.05.13.12.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 12:27:03 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Cc:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dmaengine: mediatek: free the proper desc in desc_free handler
Date:   Thu, 13 May 2021 21:26:40 +0200
Message-Id: <20210513192642.29446-2-granquet@baylibre.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210513192642.29446-1-granquet@baylibre.com>
References: <20210513192642.29446-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The desc_free handler assumed that the desc we want to free was always
 the current one associated with the channel.

This is seldom the case and this is causing use after free crashes in
 multiple places (tx/rx/terminate...).

  BUG: KASAN: use-after-free in mtk_uart_apdma_rx_handler+0x120/0x304

  Call trace:
   dump_backtrace+0x0/0x1b0
   show_stack+0x24/0x34
   dump_stack+0xe0/0x150
   print_address_description+0x8c/0x55c
   __kasan_report+0x1b8/0x218
   kasan_report+0x14/0x20
   __asan_load4+0x98/0x9c
   mtk_uart_apdma_rx_handler+0x120/0x304
   mtk_uart_apdma_irq_handler+0x50/0x80
   __handle_irq_event_percpu+0xe0/0x210
   handle_irq_event+0x8c/0x184
   handle_fasteoi_irq+0x1d8/0x3ac
   __handle_domain_irq+0xb0/0x110
   gic_handle_irq+0x50/0xb8
   el0_irq_naked+0x60/0x6c

  Allocated by task 3541:
   __kasan_kmalloc+0xf0/0x1b0
   kasan_kmalloc+0x10/0x1c
   kmem_cache_alloc_trace+0x90/0x2dc
   mtk_uart_apdma_prep_slave_sg+0x6c/0x1a0
   mtk8250_dma_rx_complete+0x220/0x2e4
   vchan_complete+0x290/0x340
   tasklet_action_common+0x220/0x298
   tasklet_action+0x28/0x34
   __do_softirq+0x158/0x35c

  Freed by task 3541:
   __kasan_slab_free+0x154/0x224
   kasan_slab_free+0x14/0x24
   slab_free_freelist_hook+0xf8/0x15c
   kfree+0xb4/0x278
   mtk_uart_apdma_desc_free+0x34/0x44
   vchan_complete+0x1bc/0x340
   tasklet_action_common+0x220/0x298
   tasklet_action+0x28/0x34
   __do_softirq+0x158/0x35c

  The buggy address belongs to the object at ffff000063606800
   which belongs to the cache kmalloc-256 of size 256
  The buggy address is located 176 bytes inside of
   256-byte region [ffff000063606800, ffff000063606900)
  The buggy address belongs to the page:
  page:fffffe00016d8180 refcount:1 mapcount:0 mapping:ffff00000302f600 index:0x0 compound_mapcount: 0
  flags: 0xffff00000010200(slab|head)
  raw: 0ffff00000010200 dead000000000100 dead000000000122 ffff00000302f600
  raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
  page dumped because: kasan: bad access detected

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index 27c07350971d..e38b67fc0c0c 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -131,10 +131,7 @@ static unsigned int mtk_uart_apdma_read(struct mtk_chan *c, unsigned int reg)
 
 static void mtk_uart_apdma_desc_free(struct virt_dma_desc *vd)
 {
-	struct dma_chan *chan = vd->tx.chan;
-	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
-
-	kfree(c->desc);
+	kfree(container_of(vd, struct mtk_uart_apdma_desc, vd));
 }
 
 static void mtk_uart_apdma_start_tx(struct mtk_chan *c)
-- 
2.26.3

