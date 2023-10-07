Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31157BC70F
	for <lists+dmaengine@lfdr.de>; Sat,  7 Oct 2023 13:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbjJGLVC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 7 Oct 2023 07:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbjJGLVB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 7 Oct 2023 07:21:01 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78B01B6
        for <dmaengine@vger.kernel.org>; Sat,  7 Oct 2023 04:20:59 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id p5FLqUFvtkkaep5FPqw9oL; Sat, 07 Oct 2023 13:13:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1696677208;
        bh=SyXlzkufD32ONJRqEUudpUaKb11ktLKN0H131JCB37s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pa0Ht/+kirGb8FefDOjnr78UXIM/jKWvkUJW1HqJ1jqV7PCngyX3to4Qwqebkgm9K
         3keqCckP+l0pg1CZP9QpPxdvHMzp3RoDABNokHmtkj1SUaK2ZyKJV7/oknFCxppc46
         kzzfVDxSvYGwDoTWHYd54DNXfyDKjuC3mPB6jbK2jKFqomJRipzuC2iwChQczE8MxN
         YyBDLqCvyKmJQv9dQjlhwHIzLY2vGzlmlUh2waj4iT8JTurRZuc5uvUMuLi14Jki8C
         rfo7eAe+o2iy++uI6XfvE26dIt5fRBM1g1p6lAkk2tGCrKpszW9ummZdTZliNSyY2N
         ff9FzmYcnxY8w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 07 Oct 2023 13:13:28 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     keescook@chromium.org, gustavoars@kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Vinod Koul <vkoul@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH 2/2] dmaengine: pxa_dma: Annotate struct pxad_desc_sw with __counted_by
Date:   Sat,  7 Oct 2023 13:13:10 +0200
Message-Id: <1c9ef22826f449a3756bb13a83494e9fe3e0be8b.1696676782.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <c8fc5563c9593c914fde41f0f7d1489a21b45a9a.1696676782.git.christophe.jaillet@wanadoo.fr>
References: <c8fc5563c9593c914fde41f0f7d1489a21b45a9a.1696676782.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

To do so, the code needs a little shuffling related to how hw_desc is used
and nb_desc incremented.

The one by one increment is needed for the error handling path, calling
pxad_free_desc(), to work correctly.

So, add a new intermediate variable, desc, to store the result of the
dma_pool_alloc() call.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is part of a work done in parallel of what is currently worked
on by Kees Cook.

My patches are only related to corner cases that do NOT match the
semantic of his Coccinelle script[1].

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
---
 drivers/dma/pxa_dma.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 94cef2905940..c6e2862896e3 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -91,7 +91,8 @@ struct pxad_desc_sw {
 	bool			cyclic;
 	struct dma_pool		*desc_pool;	/* Channel's used allocator */
 
-	struct pxad_desc_hw	*hw_desc[];	/* DMA coherent descriptors */
+	struct pxad_desc_hw	*hw_desc[] __counted_by(nb_desc);
+						/* DMA coherent descriptors */
 };
 
 struct pxad_phy {
@@ -739,6 +740,7 @@ pxad_alloc_desc(struct pxad_chan *chan, unsigned int nb_hw_desc)
 {
 	struct pxad_desc_sw *sw_desc;
 	dma_addr_t dma;
+	void *desc;
 	int i;
 
 	sw_desc = kzalloc(struct_size(sw_desc, hw_desc, nb_hw_desc),
@@ -748,20 +750,21 @@ pxad_alloc_desc(struct pxad_chan *chan, unsigned int nb_hw_desc)
 	sw_desc->desc_pool = chan->desc_pool;
 
 	for (i = 0; i < nb_hw_desc; i++) {
-		sw_desc->hw_desc[i] = dma_pool_alloc(sw_desc->desc_pool,
-						     GFP_NOWAIT, &dma);
-		if (!sw_desc->hw_desc[i]) {
+		desc = dma_pool_alloc(sw_desc->desc_pool, GFP_NOWAIT, &dma);
+		if (!desc) {
 			dev_err(&chan->vc.chan.dev->device,
 				"%s(): Couldn't allocate the %dth hw_desc from dma_pool %p\n",
 				__func__, i, sw_desc->desc_pool);
 			goto err;
 		}
 
+		sw_desc->nb_desc++;
+		sw_desc->hw_desc[i] = desc;
+
 		if (i == 0)
 			sw_desc->first = dma;
 		else
 			sw_desc->hw_desc[i - 1]->ddadr = dma;
-		sw_desc->nb_desc++;
 	}
 
 	return sw_desc;
-- 
2.34.1

