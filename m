Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65E749FE07
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jan 2022 17:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245386AbiA1Q1H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jan 2022 11:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239651AbiA1Q1G (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Jan 2022 11:27:06 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F20C061714;
        Fri, 28 Jan 2022 08:27:05 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id i30so6571656pfk.8;
        Fri, 28 Jan 2022 08:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=bWZgK4gENKweviGq61XA/rmJYJGiVtxyhw5iXYJLZoY=;
        b=PECSZQYAYXkD3mMKIZKiVyZGl77cqLWt6A4lEn55N+rFQURGeKq8jaqXr4gW1LO378
         cnTWHmJyCVjtk8NFNxYiYEtNGxWgJZrDKvAwk2g8nWTVx/T/UQ/mC2IRk05UIE3RfIeI
         EdhXh0LMYwv1IzXfWS+UXnJurltqMC/W+4bDbzulXzbdnCWLf1E+vgTwFN6rPVl3DKpu
         eVCRgEdr70hJczKvvrapBPBsHGIEVx8EGS5DFFn2KzSrN/plkN7Cw33QaqJi9TKja64y
         InjkSWqU700p4wNcPuaonz5iO9r8ILwU+/hYnTH+oWStiEDADgPWoes5nk67hueEA3NR
         eS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bWZgK4gENKweviGq61XA/rmJYJGiVtxyhw5iXYJLZoY=;
        b=PGPMFGwdQK4dJE4elZimyFnj6y5044oYvV2ymEGtu2BCY3VpGkI5JVG9YTPtfDCIQZ
         ShQD1bc0yJx8I7DYqGlJ1PxOHHGTQrx1OO94mZr9hQc89FR4uN83TS2alnk/qiqLrxNY
         4157UOEPyhbW0H+jc31phxr9jFsv+geVnSczS7VmitZPQEZ6qG23LfUtvWLmC9gTFY1Z
         KudspjfVtefEUhvzXqP7ynrYp24mzgUprbUQZPhw3ANjHfeMb11Yc/SMBcQnayn2JPal
         XIiRLYWktQ6rKDXGXwqH/uuONEEmDsBEVR6FkHJE0aevCP63mS8/EOZCBKAlhL09T9n0
         BufA==
X-Gm-Message-State: AOAM530Vgxso2NQgiUtRAtU63tVQOtLb8eWd139zfo92CTSqkcpMBson
        tMwUi7HbESf6nWyMlUCkh4w=
X-Google-Smtp-Source: ABdhPJzHRxTaT1hQsyB8qF99mucheQrXgRw6cPvCMRIof35jPGSennqfsXHmoVidCMujs6Fu/M9nZg==
X-Received: by 2002:a05:6a00:a1f:: with SMTP id p31mr280079pfh.40.1643387225240;
        Fri, 28 Jan 2022 08:27:05 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id n186sm2588815pfn.91.2022.01.28.08.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 08:27:04 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] dmaengine: k3dma: Add missing IRQ check in k3_dma_probe
Date:   Fri, 28 Jan 2022 16:26:59 +0000
Message-Id: <20220128162659.14227-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This check misses checking for  platform_get_irq()'s call and may passes
the negative error codes to devm_request_irq(), which takes unsigned IRQ #,
causing it to fail with -EINVAL, overriding an original error code.
Stop calling devm_request_irq() with invalid IRQ #s.

Fixes: 8e6152bc660e ("dmaengine: Add hisilicon k3 DMA engine driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/dma/k3dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index ecdaada95120..3c2c44efc8f6 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -878,6 +878,8 @@ static int k3_dma_probe(struct platform_device *op)
 	}
 
 	irq = platform_get_irq(op, 0);
+	if (irq < 0)
+		return irq;
 	ret = devm_request_irq(&op->dev, irq,
 			k3_dma_int_handler, 0, DRIVER_NAME, d);
 	if (ret)
-- 
2.17.1

