Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5BE24816E
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgHRJIG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgHRJIF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:08:05 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106F9C061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:05 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m71so9667841pfd.1
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ciey4QNzrHRDVKJ8tzpjEmlmjYecYc8dBp9iK+FHt5M=;
        b=gp5b7/SGHzlYzZW+c+n/TcP1QFPKcdizQhz/9rgHufe+WGP/z+Gp1CsyFcIPa0qVak
         s+JbKVbWam+6geUQIvnk6UedH9zf4+X5MnCTniTo4ADhWrO+eRLNX8kSSb48o5hDxKam
         qtxZZgiOImtxAPGYgo0F3Nv0rm+yjoeDoAjaQqEY4Ur4uw2yFfEDoaAhse9kl4AGKZhT
         tlQZ20MUmq+BcI3CXwjX5xoziff1yR79KuyPTdnYwFXXgI9uxaHLc0Ge6FC/6z3A3ehH
         aoHs2CnicCtv7FoqC/ziHH7pxI7770u3mg0ru7gkU5NTr30uwFppTPq2Ph8Zjbv4uGxS
         WODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ciey4QNzrHRDVKJ8tzpjEmlmjYecYc8dBp9iK+FHt5M=;
        b=ZNY+CQvzkEvx+ql7f2AwtNtieOoKuYPkkOOnffaYx5DSmzhdsudNbsKCo/40K4Zx31
         wSqZ4OoeYi8D668hUvuWdqbRzcbMso0Ugh2w4rNm9UG/HZRSDLjcZvdhVoAlJiNJU5Gf
         TVyRm7JnVZQoD49IraECwwQKXKvz4pNVdRk2fP7Jb8QbGUiqrSvHkPoeZPmmJ3kzAuCJ
         WgvJUuZMg0nWE9fVRd97dl2tpoW8P7f/sQ4MEwq+aQs2ppK6MhgdEnVAaTR7aqDcq31B
         Wmlb5VSEcF2FYU1xDOAwcwjYDxdL1bInH4THRg6u/B1AMHpW9o9RjxiOVMdHOALq9UBx
         CZgw==
X-Gm-Message-State: AOAM530s0rY3pB6SflpQN/MK9eBsGjYDYAjeuqcSORz9/5Apev6lJR0O
        9qSCdQyxXnqOd4BjqVevp4g=
X-Google-Smtp-Source: ABdhPJxTD6skjQAkABEx1SJ0Ynt3ruBCN3v1bhE+KYqKtMvV+/Fd4ULmENiwK2j7y8AgSx1VioBaXg==
X-Received: by 2002:a63:6c8:: with SMTP id 191mr12757821pgg.117.1597741684649;
        Tue, 18 Aug 2020 02:08:04 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:08:04 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 15/35] dma: mpc512x: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:18 +0530
Message-Id: <20200818090638.26362-16-allen.lkml@gmail.com>
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
 drivers/dma/mpc512x_dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index dc2cae7bcf69..c1a69149c8bf 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -414,9 +414,9 @@ static void mpc_dma_process_completed(struct mpc_dma *mdma)
 }
 
 /* DMA Tasklet */
-static void mpc_dma_tasklet(unsigned long data)
+static void mpc_dma_tasklet(struct tasklet_struct *t)
 {
-	struct mpc_dma *mdma = (void *)data;
+	struct mpc_dma *mdma = from_tasklet(mdma, t, tasklet);
 	unsigned long flags;
 	uint es;
 
@@ -1009,7 +1009,7 @@ static int mpc_dma_probe(struct platform_device *op)
 		list_add_tail(&mchan->chan.device_node, &dma->channels);
 	}
 
-	tasklet_init(&mdma->tasklet, mpc_dma_tasklet, (unsigned long)mdma);
+	tasklet_setup(&mdma->tasklet, mpc_dma_tasklet);
 
 	/*
 	 * Configure DMA Engine:
-- 
2.17.1

