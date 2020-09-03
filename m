Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A1625C00B
	for <lists+dmaengine@lfdr.de>; Thu,  3 Sep 2020 13:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgICLSK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Sep 2020 07:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbgICLRz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Sep 2020 07:17:55 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D311C061245
        for <dmaengine@vger.kernel.org>; Thu,  3 Sep 2020 04:17:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u128so2062436pfb.6
        for <dmaengine@vger.kernel.org>; Thu, 03 Sep 2020 04:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Y8IEUfLS7XYJg3Xo5PCBf4dRoFAgQoQgNY02UB3/kSw=;
        b=ifUMM+iijvuhIsIB45daAftNlPkck+FFZxiL77GDxuLu0y1HvyQSir5bcJQD/mYvCz
         hilNW4yxvk9O7gsyOU7Bh6z0UChjvzB4w5WKZHqijCiMozJuXgQIgJ7Hvq6lijzt431G
         odg13M9/4xmyhjPi2lVlEJlzyxrUJqVIj0/g2cGDf/inz30Id1xpQkI9bwu8+W2aBr0r
         inEd9+3bl+D9ZbyWQ80k0N29X3Yqc9Mv4Y3qa3YwPeS0E8Cf/6aRro+1Oq2lEaFATfIN
         IXRB+4dsT4neXM+u5agwh9F2XHEz0bvXZ8D0U1XP2CoH6YQe5bSDVoBjRUWghvuNXIrq
         Ckyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y8IEUfLS7XYJg3Xo5PCBf4dRoFAgQoQgNY02UB3/kSw=;
        b=HDMMYytV0Tuo2YDkapxxr3ONhS1rFKb8BXaKnFJdE8t/jU//UIeLWFVXF5F/CDmZfJ
         1SHG+n24wiQMn0cAiakOrNDH8tpUC7hEA+3FwG4GlTjJTsHuFfZP0LEs9fBcEiB1ID6D
         0RRdKvhdoC3eifxwUvHr7CrunFF1azeN29prat1KvdpJD5VyFO/wbGkaQcPFsKku+Ofh
         6Wf62Alz14hhapxIE5SP96mGEy+bplLWbVJ/4w2Z91t7JF7/QSRTBAGnjpOLzWjzzA3P
         ede0Q51qv9j4yl3cSYrp0L+FxR2oEMiByGqbIkCDJNs3ZLjvAZ50LoUboVA/Vp/uGykM
         J6cw==
X-Gm-Message-State: AOAM531ScHb2BbvYqhYFBwnbtG41nz5P4TVOItIhOeN9lAVKETU0UuWb
        rNk7PXF7wLaKNfODa31Ey28wmA==
X-Google-Smtp-Source: ABdhPJzg6UdRnyJZ9hcF1DJcqPvExc9ERofZxEmowjNatPJekxVciMo88GZi7VQbYUR997QLGjZKTA==
X-Received: by 2002:aa7:942a:: with SMTP id y10mr2348158pfo.68.1599131865859;
        Thu, 03 Sep 2020 04:17:45 -0700 (PDT)
Received: from localhost.localdomain ([210.91.70.133])
        by smtp.gmail.com with ESMTPSA id md10sm2297492pjb.45.2020.09.03.04.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 04:17:44 -0700 (PDT)
From:   Brad Kim <brad.kim@sifive.com>
To:     vkoul@kernel.org, green.wan@sifive.com
Cc:     dmaengine@vger.kernel.org, Brad Kim <brad.kim@sifive.com>,
        Brad Kim <brad.kim@semifive.com>
Subject: [PATCH] dmaengine: sf-pdma: Fix an error that calls callback twice
Date:   Thu,  3 Sep 2020 20:17:26 +0900
Message-Id: <20200903111726.3413-1-brad.kim@sifive.com>
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
Tested-and-Reviewed-by: Green Wan <green.wan@sifive.com>
Signed-off-by: Brad Kim <brad.kim@sifive.com>
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

