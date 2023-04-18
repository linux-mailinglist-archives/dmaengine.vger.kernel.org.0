Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EF66E6CE5
	for <lists+dmaengine@lfdr.de>; Tue, 18 Apr 2023 21:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjDRTXG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Apr 2023 15:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjDRTWq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Apr 2023 15:22:46 -0400
X-Greylist: delayed 222 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Apr 2023 12:22:42 PDT
Received: from out-9.mta1.migadu.com (out-9.mta1.migadu.com [IPv6:2001:41d0:203:375::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DBD8694
        for <dmaengine@vger.kernel.org>; Tue, 18 Apr 2023 12:22:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681845439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QzMcqFYscz72KP3TmeLDjijPd9/k3SLnhV2/G7k5hR8=;
        b=mviSc7RbCH2D7fFCZ9rb4DUG+OC0BByXxKZzp9FI0XGUGpNEmKKzfNI4NNVirpnlTdbfsf
        0lwGO5AA+0GTfmQA7K4m0jss0ktsI05wf/4E28QTmrI4KZ8wPO4aSi3XIR0MlxygdklAWz
        1C/mP+kVhjZAWTGXhQrFQfeLCx44Pa8=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH] dmaengine: virt-dma: fix a potential NULL-pointer dereference
Date:   Tue, 18 Apr 2023 12:16:03 -0700
Message-Id: <20230418191603.2291521-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

vchan_complete() contains a potential NULL-pointer dereference:
the vd variable is checked for being non-NULL under a spinlock,
but few lines below &vd->tx_result is passed as a second arg to
dmaengine_desc_callback_invoke() unconditionally.

This issue was spotted by looking into the code, I'm not aware of
any real world consequences. It seems like dmaengine_desc_callback_invoke()
is never using the second argument in cases when vd is NULL, this is
why we haven't seen any crashes.

To make it safer, let's pass NULL to dmaengine_desc_callback_invoke()
if vd is NULL.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 drivers/dma/virt-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index a6f4265be0c9..0c46ad18dae1 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -98,7 +98,7 @@ static void vchan_complete(struct tasklet_struct *t)
 	}
 	spin_unlock_irq(&vc->lock);
 
-	dmaengine_desc_callback_invoke(&cb, &vd->tx_result);
+	dmaengine_desc_callback_invoke(&cb, vd ? &vd->tx_result : NULL);
 
 	list_for_each_entry_safe(vd, _vd, &head, node) {
 		dmaengine_desc_get_callback(&vd->tx, &cb);
-- 
2.40.0

