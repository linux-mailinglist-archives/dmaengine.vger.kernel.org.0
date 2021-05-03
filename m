Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B563717EE
	for <lists+dmaengine@lfdr.de>; Mon,  3 May 2021 17:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhECP11 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 May 2021 11:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhECP1W (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 May 2021 11:27:22 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE11C061763
        for <dmaengine@vger.kernel.org>; Mon,  3 May 2021 08:26:29 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id b5-20020a9d5d050000b02902a5883b0f4bso5414818oti.2
        for <dmaengine@vger.kernel.org>; Mon, 03 May 2021 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:cc;
        bh=DsCC9gqqI3YCW9ovP0n+UcVOJC+7xZwxFoiL/RkkmZQ=;
        b=dTvWlgasNphbykbaGHMLyLlxm27D+XIBOlYNgL84vlKQzIt2kjc4Kpa53LEJlK56fH
         CfhhR/nv/DMZ2I5AUGXMjc4GWmsxBfA0tdkAV2H3leyucCOxjQHnq7nh3uGC8MLPG01f
         waYCxbw9lruqFE0t9nb6eIhAr0jK8vdtTLpyf8Smyux4w3GaYaegAA8OqvMev6QDvrsZ
         4pRtlb4cXCcLWcnEVOL/Gr5Xf/XZM+GLQDWWPFsg6cKOSOdNiwgC8uV4kjIZeNNQIgJy
         Q+awveaVeyz4b4ewr4Iy8AariywFauLqvXNBeUKB5aSNAn51R5lMo3k/com9ahoxXTWE
         fm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:cc;
        bh=DsCC9gqqI3YCW9ovP0n+UcVOJC+7xZwxFoiL/RkkmZQ=;
        b=rvI00F2CwlAeLiHxcrGhK1Jib2VIebi9NxL79mUBvms6IIOcDW0hbY7FOCDSV8TzbQ
         fOa78fVxdo+RJjAk5CCNWWKHVMYvNdlgvQ3Yd3lPI8QxZ5aM4ypUsEJLDO/E0lFfCHgc
         RxgaHMwECutevCyXl/MRW26gIBMky8snQ4DQycY9I24hYpOkX81N/kgBBYqRqsqPKbZi
         Jng1P7HGE8N1vib7GShiBfxvWW3T5LVfTStN7DuEuFHY6h5/LJ0nxx3PE5wM6Stm0Usb
         Ci7QpvkJ32pPAFWALHoLvqSDgyELAy9J9nEbZxKx3DRLw3pQAj8r+RBZPkVe9nKCrzuh
         36Iw==
X-Gm-Message-State: AOAM5314GKOHDVc5d1jYvtk9Wq+IDZsbdx/E7iFfq20vfg4wpYaN31+2
        JEHsM+MoN2p/zj/2MPvYhLEQlTKqRNphEyVpsd7eQg==
MIME-Version: 1.0
X-Received: by 2002:a9d:2de3:: with SMTP id g90mt12928705otb.274.1620055588708;
 Mon, 03 May 2021 08:26:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 May 2021 08:26:27 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Mon, 3 May 2021 08:26:27 -0700
Message-ID: <CABnWg9sHzqZ-fYpe3cc8iQDBYm9=5yXEYV2Qiaa0Eoqt8UOG6w@mail.gmail.com>
Subject: [PATCH 1/4] dmaengine: mediatek: free the proper desc in desc_free handler
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

The desc_free handler assumed that the desc we want to free was always
 the current one associated with the channel.

This is seldom the case and this is causing use after free crashes in
 multiple places (tx/rx/terminate...).

  BUG: KASAN: use-after-free in mtk_uart_apdma_rx_handler+0x120/0x304

  Hardware name: GEA MT8167 ManeFaces (DT)
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
  page:fffffe00016d8180 refcount:1 mapcount:0 mapping:ffff00000302f600
index:0x0 compound_mapcount: 0
  flags: 0xffff00000010200(slab|head)
  raw: 0ffff00000010200 dead000000000100 dead000000000122 ffff00000302f600
  raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
  page dumped because: kasan: bad access detected

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c
b/drivers/dma/mediatek/mtk-uart-apdma.c
index 6bef40f0c9dc..4610dbdde75e 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -131,10 +131,7 @@ static unsigned int mtk_uart_apdma_read(struct
mtk_chan *c, unsigned int reg)

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
