Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A294248177
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHRJIo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJIn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:08:43 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25166C061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:43 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kr4so9138024pjb.2
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QME4/rDj4IUPM5kJpeHXTQIgsJQOMifnZCInRk/A1C4=;
        b=r2jPdMK3SPMkpHSGD7zeVA5yl4wnB0wDnhW17VomnS+I2tLgwwKC6Hb56uGXpVMnWo
         3p/+YPtIfkqXw88JHyFL9NKDDj+LlQEX4DEgQzpoOOCRsm0fqpPgzd0SH8y/z3FjpmfB
         /UgmbSvL6dz7fARmhXPXr5h4MKWoyyFnZR6HHjCGVB9u5pSWEtL+hZuf8aSaBkUCCvGj
         2K7Edi7vd5BMpcWp3Zb2jC2GN9cShdS8i4AdrCyxDbmXtaHsX/pRO5rRGS8J4IKRdTGf
         tUJ8op+emYPwWFf4bRjMYlyGlegye2qvxtbDkBkYLLuKPbK50zq4V8tPL5v++pbcr3i6
         mqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QME4/rDj4IUPM5kJpeHXTQIgsJQOMifnZCInRk/A1C4=;
        b=L7DkbXreKeyDLVDeIL1PYXsHrfKGNV9v2b2gUkRkb/vhYAVdqrsUmN/C1wm5237csk
         6ORsQvcMsJLCW49dRXmqxnT9uqVzFXh0rOlf3kPRpNE+6WN3Yutnek643gkEcIJKvl0R
         cQ2IhaLKWIaU8kEY5/O4adUDEd2bl4GvK7+8NIaOVYBQ63RmmWSTPuQngljmlXWJkBdY
         avfhUJk9Y/gyGSkNpnnG+A9ZdjJsMd5TodWwqPuug7Gg62oJZJga11I3K2+x8MIkvpZr
         a6QDuDO+06LMOPv3uBNE45zhrPGy/cVW9SPoKSEu5ctptjebLvtsDRePZBjkb0HQYLXs
         5ipg==
X-Gm-Message-State: AOAM5329jVxCmUH2/0U8VxVZTsrpGeN2tE65CnkQQDJwGPd2LE0wlga6
        pqI4gfe9uixPLOfXRq0Dx0Q=
X-Google-Smtp-Source: ABdhPJzhPvyP6dQP3wgkEFg3KQClKL4gT6hROlPCseQglDhRZkq9GwGUhPzT2WIaCPYSemmdQoF8Dw==
X-Received: by 2002:a17:902:8a85:: with SMTP id p5mr14775137plo.193.1597741722741;
        Tue, 18 Aug 2020 02:08:42 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:08:42 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 23/35] dma: sa11x0: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:26 +0530
Message-Id: <20200818090638.26362-24-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818090638.26362-1-allen.lkml@gmail.com>
References: <20200818090638.26362-1-allen.lkml@gmail.com>
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
 drivers/dma/sa11x0-dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index 0fa7f14a65a1..1e918e284fc0 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -323,9 +323,9 @@ static void sa11x0_dma_start_txd(struct sa11x0_dma_chan *c)
 	}
 }
 
-static void sa11x0_dma_tasklet(unsigned long arg)
+static void sa11x0_dma_tasklet(struct tasklet_struct *t)
 {
-	struct sa11x0_dma_dev *d = (struct sa11x0_dma_dev *)arg;
+	struct sa11x0_dma_dev *d = from_tasklet(d, t, task);
 	struct sa11x0_dma_phy *p;
 	struct sa11x0_dma_chan *c;
 	unsigned pch, pch_alloc = 0;
@@ -928,7 +928,7 @@ static int sa11x0_dma_probe(struct platform_device *pdev)
 		goto err_ioremap;
 	}
 
-	tasklet_init(&d->task, sa11x0_dma_tasklet, (unsigned long)d);
+	tasklet_setup(&d->task, sa11x0_dma_tasklet);
 
 	for (i = 0; i < NR_PHY_CHAN; i++) {
 		struct sa11x0_dma_phy *p = &d->phy[i];
-- 
2.17.1

