Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D2F25478F
	for <lists+dmaengine@lfdr.de>; Thu, 27 Aug 2020 16:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgH0OvX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Aug 2020 10:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbgH0N2S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Aug 2020 09:28:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17017C061264
        for <dmaengine@vger.kernel.org>; Thu, 27 Aug 2020 06:28:16 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ds1so2634495pjb.1
        for <dmaengine@vger.kernel.org>; Thu, 27 Aug 2020 06:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+qrEHr0zTCzeXf8VFLq2nBPA0b+vvbkTtN5icyLM91U=;
        b=IhgkZQ6y0Njxu1Iu8jk8jvm+r075xrVo7JM6srWU6dPjUzU/fFR1tR9NmdBrWP4JxB
         tlZraI6C33yMOP43RxMggSt4u1mYeNNpFeZuyh7AprGUaKX0daV8RLaLue3+AoR0/UtQ
         jf0LBekJM09TkKnee2/7AnVGhMpKS05ykdfm6vge6uKMHKz4ezWy/EfMmrMo3ubr1XmB
         CWUuVmeH9iM4KWK1+FdsJsqiDLdO/XBHPWZve8hnVx6C0pXYfpnJ+5HrF1hhdZueOiiE
         +EqRK/vTPID8jgq6IBO+LBaAHErCWaw0yE/IikRnsHZYWA8UZNcPxgQpTTfPYLcq/JZo
         daMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+qrEHr0zTCzeXf8VFLq2nBPA0b+vvbkTtN5icyLM91U=;
        b=oi0KfqwJXPQnN8eVDHOrtxREuSJuyIW7l1OLOyUdZV9IOWhDViWaqGaTPlFE2mPnYt
         zHDrH2KGm9UdszUyBXvyrqRI3xOe/0CfI/qrOti0c7IorjJqAIkeOYeldpxgr13JEOnS
         gizogaAM/MAVQu7EwAxHl6xkvVGsg2CYxMig0Emkv4Enj4dl91SzOFYjwTBddbeIT/Ke
         5sRokaZ/XkGd5mIddHkeJYuNrJVoMBAhpHZV2i1OmltebN6RK/rj3e5Ayvh0ScHnLJcW
         zTAna2tMPzl/VRyWjWk7jamuaD4g125oCjWdYEGyGXRMiEeUbxqpvTLm+nwwkfMLHWzH
         jz5g==
X-Gm-Message-State: AOAM533m4wfJpeiRDch72OjGddci9UTG8Uh61q2ZPbKrM7OQx/E2LqpD
        CrZGL5C1m4scimTivXKI9Fk6og==
X-Google-Smtp-Source: ABdhPJzvSj0UZI8tXiF6fV2xhoJMXviX5pNLRRCVI22EgnbDbkVEmTKfRv01FjBHLxjYO2G2t9CUCQ==
X-Received: by 2002:a17:90a:a792:: with SMTP id f18mr11144061pjq.65.1598534894383;
        Thu, 27 Aug 2020 06:28:14 -0700 (PDT)
Received: from localhost.localdomain ([210.91.70.133])
        by smtp.gmail.com with ESMTPSA id p11sm2815313pfn.109.2020.08.27.06.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 06:28:13 -0700 (PDT)
From:   Brad Kim <brad.kim@sifive.com>
X-Google-Original-From: Brad Kim <brad.kim@semifive.com>
To:     green.wan@sifive.com, koul@kernel.org
Cc:     dmaengine@vger.kernel.org, Brad Kim <brad.kim@semifive.com>
Subject: [PATCH] dmaengine: sf-pdma: Fix an error that calls callback twice
Date:   Thu, 27 Aug 2020 22:27:49 +0900
Message-Id: <20200827132749.17259-1-brad.kim@semifive.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Because a callback is called twice when DMA transfer complete
the second callback may be possible to access a freed memory
if the first callback routines perform the dma_release_channel function.
So this patch serialized the callback functions

Signed-off-by: Brad Kim <brad.kim@semifive.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 6e530dca6d9e..754994087e5f 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -295,7 +295,10 @@ static void sf_pdma_donebh_tasklet(unsigned long arg)
 	}
 	spin_unlock_irqrestore(&chan->lock, flags);
 
-	dmaengine_desc_get_callback_invoke(desc->async_tx, NULL);
+	spin_lock_irqsave(&chan->vchan.lock, flags);
+	list_del(&chan->desc->vdesc.node);
+	vchan_cookie_complete(&chan->desc->vdesc);
+	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 }
 
 static void sf_pdma_errbh_tasklet(unsigned long arg)
@@ -332,8 +335,7 @@ static irqreturn_t sf_pdma_done_isr(int irq, void *dev_id)
 	residue = readq(regs->residue);
 
 	if (!residue) {
-		list_del(&chan->desc->vdesc.node);
-		vchan_cookie_complete(&chan->desc->vdesc);
+		tasklet_hi_schedule(&chan->done_tasklet);
 	} else {
 		/* submit next trascatioin if possible */
 		struct sf_pdma_desc *desc = chan->desc;
@@ -347,8 +349,6 @@ static irqreturn_t sf_pdma_done_isr(int irq, void *dev_id)
 
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 
-	tasklet_hi_schedule(&chan->done_tasklet);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.17.1

