Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52842545FE
	for <lists+dmaengine@lfdr.de>; Thu, 27 Aug 2020 15:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgH0Ndg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Aug 2020 09:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgH0Nd2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Aug 2020 09:33:28 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EE4C061264
        for <dmaengine@vger.kernel.org>; Thu, 27 Aug 2020 06:33:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s2so2015328pjr.4
        for <dmaengine@vger.kernel.org>; Thu, 27 Aug 2020 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+qrEHr0zTCzeXf8VFLq2nBPA0b+vvbkTtN5icyLM91U=;
        b=FvLds+qTqQy0s/keU5Aqbn9ch+Oh7dDoPonDYGzVROvEkGFAPIPDIrhpjmpL/rZ80F
         6AXCbM02dVFnf5v51a/7JBCyLrdlJ613TEsw+/1DucsgX3K+DfEgP2c2IO8rLdz1PYFC
         +ZWRyRm8+Xig1/5YvC//DjPtOblsMEEhJWJcaPSMXEZSbASKHz5bOPJ4xVrpico8g5j7
         h4RRyMD+BX1EDg63Scog5MwGzo8c1LKZnBDVCNoIa56zxIq8yrAErRmL+H3O2hrsxn9m
         VOtOGG9mSXiNEnFb7jUysf6n89QLqVdzA92RHremC4uj5lW/FL5pzbbDMYWm0iF82e8X
         jj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+qrEHr0zTCzeXf8VFLq2nBPA0b+vvbkTtN5icyLM91U=;
        b=pM4/LksoHYieBz59WbxqfgQCHJHgcClhWDiJAu8MeykR1Af1dvwprrsr39EEig1TFe
         CLckw0mcKaxlsTmTq1qZuAPPlpPLJa8h1P0KtMe3MigrsB8JUI8gPheFMelzBkj9KnrG
         +thGoAMTX2MXRC3rQ0UVyPKf6p0/Y6YGVMSpiSM1mBobOGmNcpRi0jC7qlgftbwXovgB
         SHCH4P+3+SZQOPHdKRZxEmuq6wanGImSK4rZlgkcr07Xn2OB12JHQPDMTWeEVgqQIuZC
         csrwNqT7LAlQokDox+brVIBpWWV3fb0OBTCAooUimxAPA1r1jUB3GLWtfU8ag67JS4sY
         rsOw==
X-Gm-Message-State: AOAM530VlOy95GpbPoPxjooNcx/jlo1tcJtrCoGoX09qU8UeAAQG/fyv
        0BsU+xx3zp4lOqsVZpxOO88OkxzLsDrZX7K3
X-Google-Smtp-Source: ABdhPJyt7oKbO29cbXVPwqA/1kn9r7o+oxCSnwws8fr+DfNMUQ0NmXBE2OvvORK7ZZuHi6AiQrlPbg==
X-Received: by 2002:a17:90b:60f:: with SMTP id gb15mr10323039pjb.38.1598535199468;
        Thu, 27 Aug 2020 06:33:19 -0700 (PDT)
Received: from localhost.localdomain ([210.91.70.133])
        by smtp.gmail.com with ESMTPSA id t25sm2901680pfe.51.2020.08.27.06.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 06:33:18 -0700 (PDT)
From:   Brad Kim <brad.kim@sifive.com>
X-Google-Original-From: Brad Kim <brad.kim@semifive.com>
To:     green.wan@sifive.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, Brad Kim <brad.kim@semifive.com>
Subject: [PATCH] dmaengine: sf-pdma: Fix an error that calls callback twice
Date:   Thu, 27 Aug 2020 22:33:09 +0900
Message-Id: <20200827133309.17362-1-brad.kim@semifive.com>
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

