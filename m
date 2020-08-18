Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644DE248168
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgHRJHs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgHRJHr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:07:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DA8C061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f10so8915028plj.8
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hn4KAQ3gCFoOl9r0ujaoL0SRctsTF3JFLZ2Rz0kI31Y=;
        b=DaFan3Un0yq35b230ATUQecEzpB6m87v/Ko/ZxxkoR3uhMTrWnmlkTu+EsHFrZ9DJw
         II7CtjwcaOTKbTnZoChUzMXTJBKJuriE3ty7vio3NGKsBu62QN7OO0b6hDnXFZR/bdmx
         +cdSNIV5NslnNVpbS0JY8eWVY0xy9KIjOrmrOjau0Fe52iHwcjZzcfyhPTotRZonI9KS
         6wq2m1KUKhMzPCTs5pRRFxgCCuCXPEfwJKI/Ua7un5R5BK5cMicTq75hsJpmp+NbflXd
         bEPDDQA3AwlNMEyeXTb6rLUyi+bzBpsLjugAYaCdzLNuovd/gkx+aaR5YPkE01XedsMC
         5RGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hn4KAQ3gCFoOl9r0ujaoL0SRctsTF3JFLZ2Rz0kI31Y=;
        b=qO2nLkAM4RHNasvvRaxqgp7aSuKato/uIQnmnr/UbWXQ+gQ/cjFvBiyDz4rECsLQ1T
         lF/0Esz2atXul+b+2EgtrahfUU7cVi1CaR15l8uVlfuJEDhbC0M2V7pNe0ieDRN/tYce
         xWGHm43+AbD7DpaPi4vZ4se9ibPRWmXuprOYTYzDxZuZUNeufAOvdvOv1ko2xnVwZi1x
         yAjv9M0uWYyl4AwLf6gxG20EM96zofFzS+w2cqRbYDUk8ZwXgkE4DzDr7tou235SOI4F
         wmuYdq0xXCtfaMrinKHYau0u4KXRKGa06OuOl49hK8NyYTss9z4cOKhXQw72bZETap7e
         YYew==
X-Gm-Message-State: AOAM531RBW1tXRuP388vOQfJmEAWPKGyyIoYUuvEe2TLoquineHL0Urc
        6uYbv2EoXL8IDSKvvQupYXk=
X-Google-Smtp-Source: ABdhPJxRm+mXa1EzuIYesoHWDwF3qHQdH7CDoZetfnkA28nhRpOXws6qsGfQruPFOFsI3lCcKg+5lg==
X-Received: by 2002:a17:90a:f313:: with SMTP id ca19mr16489019pjb.226.1597741665590;
        Tue, 18 Aug 2020 02:07:45 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:07:45 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 11/35] dma: ipu: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:14 +0530
Message-Id: <20200818090638.26362-12-allen.lkml@gmail.com>
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
 drivers/dma/ipu/ipu_idmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index 0457b1f26540..38036db284cb 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -1299,9 +1299,9 @@ static irqreturn_t idmac_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void ipu_gc_tasklet(unsigned long arg)
+static void ipu_gc_tasklet(struct tasklet_struct *t)
 {
-	struct ipu *ipu = (struct ipu *)arg;
+	struct ipu *ipu = from_tasklet(ipu, t, tasklet);
 	int i;
 
 	for (i = 0; i < IPU_CHANNELS_NUM; i++) {
@@ -1740,7 +1740,7 @@ static int __init ipu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_idmac_init;
 
-	tasklet_init(&ipu_data.tasklet, ipu_gc_tasklet, (unsigned long)&ipu_data);
+	tasklet_setup(&ipu_data.tasklet, ipu_gc_tasklet);
 
 	ipu_data.dev = &pdev->dev;
 
-- 
2.17.1

