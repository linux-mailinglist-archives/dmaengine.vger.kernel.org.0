Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5193652F24C
	for <lists+dmaengine@lfdr.de>; Fri, 20 May 2022 20:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349256AbiETSOy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 May 2022 14:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344415AbiETSOx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 May 2022 14:14:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4071900D3;
        Fri, 20 May 2022 11:14:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 055C51F4675C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653070491;
        bh=x/OOyFHTqKvvNw+5fLLflE2enF2X0UELX4BA2pQVGII=;
        h=From:To:Cc:Subject:Date:From;
        b=be1dlzwgyznSiKw4DhsBnAbpQs4W46+0yvn2g9+eaTZt3f6Kxo5t+ZIV4qsuBJJzX
         Q90pkkkJtwtTW8vh2TG/KZBD1Rk+86FYaG16JoIBmq14OQ4TYPbTRTpfWG2wc6Afls
         QxGLdsQVoJzYyQH4b1aJP/0YUX8nq8yIvQrLsw/Dkh2gqq9gLZS7CQoZGayOw0FKop
         jqIFjt6zYHgXgpOPmCOAFgLGcUS46/Of7V75uXhhYSemVVgnMX25uj6lpngJarb/3s
         ppX70pUiPsyMzXXaBYVCOCv0E5gxlDxnI8MuANXb4vhsAgjL+wTiwfx+8zqppYb7xR
         Q0PQqIyoCwUZA==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] dmaengine: pl330: Fix lockdep warning about non-static key
Date:   Fri, 20 May 2022 21:14:32 +0300
Message-Id: <20220520181432.149904-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DEFINE_SPINLOCK() macro shouldn't be used for dynamically allocated
spinlocks. The lockdep warns about this and disables locking validator.
Fix the warning by making lock static.

 INFO: trying to register non-static key.
 The code is fine but needs lockdep annotation, or maybe
 you didn't initialize this object before use?
 turning off the locking correctness validator.
 Hardware name: Radxa ROCK Pi 4C (DT)
 Call trace:
  dump_backtrace.part.0+0xcc/0xe0
  show_stack+0x18/0x6c
  dump_stack_lvl+0x8c/0xb8
  dump_stack+0x18/0x34
  register_lock_class+0x4a8/0x4cc
  __lock_acquire+0x78/0x20cc
  lock_acquire.part.0+0xe0/0x230
  lock_acquire+0x68/0x84
  _raw_spin_lock_irqsave+0x84/0xc4
  add_desc+0x44/0xc0
  pl330_get_desc+0x15c/0x1d0
  pl330_prep_dma_cyclic+0x100/0x270
  snd_dmaengine_pcm_trigger+0xec/0x1c0
  dmaengine_pcm_trigger+0x18/0x24
  ...

Fixes: e588710311ee ("dmaengine: pl330: fix descriptor allocation fail")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/dma/pl330.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 858400e42ec0..09915a5cba3e 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2589,7 +2589,7 @@ static struct dma_pl330_desc *pl330_get_desc(struct dma_pl330_chan *pch)
 
 	/* If the DMAC pool is empty, alloc new */
 	if (!desc) {
-		DEFINE_SPINLOCK(lock);
+		static DEFINE_SPINLOCK(lock);
 		LIST_HEAD(pool);
 
 		if (!add_desc(&pool, &lock, GFP_ATOMIC, 1))
-- 
2.35.3

