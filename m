Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B0E257765
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHaKg6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgHaKgz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:36:55 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716BCC061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:55 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 7so366066pgm.11
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b1zOgcujLWbmq9DLHM2msso8Bm5fmlkU6E9gfDFZC/8=;
        b=bQghudm34wAhJ9eXnlaKKvSelpuCiWdosz5Su5DqFpuyIRo6u3zT7TvaS6fp7kHQ6y
         nW7KHqsDNPM3zbJUzBzO+X1objPNf9vmO5hQFjB4m629qaCI1ppZc3xJVyuXapPh3JZx
         Y6ueM0Z++3VuEb4eZoYKVXHEUEwPVAVpq7ndz6MEYXptUGldV1vmb58T4kb4o8CLM0ff
         5qoGl2/PjTZj9gzkkq8TL6swq8Y9Ui4HiCpocOquw4YM2bm5J4RJYHD/snYUB3faXVVX
         0TyZhSEh486ckP1fQW4XYVT7Tzz0dP46l6xjOFOOwr/+mCAS7DLQ+WKzZzIY9dkL2uKX
         rNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b1zOgcujLWbmq9DLHM2msso8Bm5fmlkU6E9gfDFZC/8=;
        b=bwlebyBhiJebOB1xj82hBgHCGFzOzW9Sab44ZIy511mWIhWAg3S/AcRvGd/wKNvtu5
         qU2kLp7jGrcmXgRJtv9jdchRmqkOQ5DuRhSX6qnpWssrZ1Ix3cwEyUCgjJ0t8dcYekjc
         4O7wPVAmmv1bdLVaXDw7qzXPw6uC3VY3fzeLGUM9pLmfMklqMG13DU7CfRSa2DI2QJ0x
         m2nZ5Vo//AjNhunpDYOpfDXcL1RoXmLPAgjFjKoJpbD4qwE2wuU94zaAdNQ5z6jXAt5q
         sf3o5K9Z891u+CAG9WH91pTM1Egc2b2DGpxb8c7frLukJGX/DkiVuYv2ukyp4Uy0ekg2
         /YSQ==
X-Gm-Message-State: AOAM532+XBk199kxAQqm9LBFd+wMWdj2GFHWY+wB//VtvC6YJh6n86uO
        JyJWgXfjYsTSHfty7NoQEFo=
X-Google-Smtp-Source: ABdhPJyxHCMXnrStp099DZx/ik9QAZFysvDoJK2v1mrO//tyCDI6whKe54xz3QAs/odzIkDP/VvKQg==
X-Received: by 2002:a63:4c:: with SMTP id 73mr778954pga.286.1598870215113;
        Mon, 31 Aug 2020 03:36:55 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:36:54 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org
Cc:     linus.walleij@linaro.org, vireshk@kernel.org, leoyang.li@nxp.com,
        zw@zh-kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        logang@deltatee.com, agross@kernel.org, jorn.andersson@linaro.org,
        green.wan@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, dmaengine@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v3 10/35] dmaengine: iop_adma: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:17 +0530
Message-Id: <20200831103542.305571-11-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831103542.305571-1-allen.lkml@gmail.com>
References: <20200831103542.305571-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/dma/iop-adma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index 3350bffb2e93..81f177894d1f 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -238,9 +238,10 @@ iop_adma_slot_cleanup(struct iop_adma_chan *iop_chan)
 	spin_unlock_bh(&iop_chan->lock);
 }
 
-static void iop_adma_tasklet(unsigned long data)
+static void iop_adma_tasklet(struct tasklet_struct *t)
 {
-	struct iop_adma_chan *iop_chan = (struct iop_adma_chan *) data;
+	struct iop_adma_chan *iop_chan = from_tasklet(iop_chan, t,
+						      irq_tasklet);
 
 	/* lockdep will flag depedency submissions as potentially
 	 * recursive locking, this is not the case as a dependency
@@ -1351,8 +1352,7 @@ static int iop_adma_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_free_iop_chan;
 	}
-	tasklet_init(&iop_chan->irq_tasklet, iop_adma_tasklet, (unsigned long)
-		iop_chan);
+	tasklet_setup(&iop_chan->irq_tasklet, iop_adma_tasklet);
 
 	/* clear errors before enabling interrupts */
 	iop_adma_device_clear_err_status(iop_chan);
-- 
2.25.1

