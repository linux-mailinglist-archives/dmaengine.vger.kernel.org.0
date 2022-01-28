Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E86D49FDFF
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jan 2022 17:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245420AbiA1QYp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jan 2022 11:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350190AbiA1QYC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Jan 2022 11:24:02 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A32C061748;
        Fri, 28 Jan 2022 08:24:02 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so6895811pjp.0;
        Fri, 28 Jan 2022 08:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=cYD+QaDMmhVFmHVyK5zY8vTMje6fb0+VO33EZ6d8Ibk=;
        b=ErEs6Uspe83hsPa+EChcIicSrkgK7KHPxX0PszN2yn4SfLYeUzRbo50VGuqKLt5O7b
         nKfVL7FbmhobIzQr0uSDHo1Kq+gOfErJNm1jnJQi47mznW8urIUro9taAOPwTW613P4z
         AP+F05ASGtB/jknnLRvk7SnVFzfkGkdEksMRArsKnb0pXnrCWefNXNDBxg+AbnNFgJzX
         pxAswcr1OHr4WUoFSJjMIGesnMuXWOmOqjuxXKu13SDFnEIrnI5Y7klxbIrekSUab/be
         8RO1d9nmmvKusnaNqspxqswDpw22rWnCA/a43nDx2RauQfUdfKcOOn6fXjPWP1QzEKTT
         4gVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cYD+QaDMmhVFmHVyK5zY8vTMje6fb0+VO33EZ6d8Ibk=;
        b=6scYu4yYQYrX/Z44njiTzb7k/abuDGLoYR6b+E+6GaEk05GYJucuqlRyKMNi4+6t5z
         21ioeXG3izQXnzl8ky8Wq7tRRMEOox+7gHlW8xviHDdIWKLvk3mJbVVnHuocGQND8/3Q
         ajI5Da7uPeJy0fCM7e0pFSxBQ1C4XZURquYHpVs/SDbJQWyXOuQp4GD8E94FVPYypKjy
         +XP8wpDkZgWlFgKYMwD3AXw7FbpSYUXufKLESDuxhrbNx+UMrjQ56kjin93pwQmHXsQu
         tysSALLVhu9NTCrFadaQaeWN5cxHzq35iNCavtCRx/rz5H40vZEQd7ZiuuV+e9dD0tJy
         XXFA==
X-Gm-Message-State: AOAM530qkxtyYzM6or+iEiLQ3QqVdR3Bz5Cif4GB4qqafTKd/E7NY5IC
        8o1k9iKdjHAZoHXYfhbJBUE=
X-Google-Smtp-Source: ABdhPJzA5dqI9Mz/0GouB0TsvaxTfylcTvGIQHkSJ/QLrdPrHrTYSFNx/UfzHnoGTCaN12GYPfY9Hw==
X-Received: by 2002:a17:902:da86:: with SMTP id j6mr8971765plx.65.1643387041920;
        Fri, 28 Jan 2022 08:24:01 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id l14sm10365506pjf.1.2022.01.28.08.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 08:24:01 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Zhangfei Gao <zhangfei.gao@marvell.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] dmaengine: mmp_tdma: Add missing IRQ check in mmp_tdma_probe
Date:   Fri, 28 Jan 2022 16:23:56 +0000
Message-Id: <20220128162357.12540-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This func misses checking for  platform_get_irq()'s call and may passes
the negative error codes to devm_request_irq(), which takes unsigned IRQ #,
causing it to fail with -EINVAL, overriding an original error code.
Stop calling devm_request_irq() with invalid IRQ #s.

Fixes: f1a7757008b8 ("dmaengine: mmp_tdma: add dt support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/dma/mmp_tdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index a262e0eb4cc9..68f533ff7711 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -681,6 +681,8 @@ static int mmp_tdma_probe(struct platform_device *pdev)
 
 	if (irq_num != chan_num) {
 		irq = platform_get_irq(pdev, 0);
+		if (irq < 0)
+			return irq;
 		ret = devm_request_irq(&pdev->dev, irq,
 			mmp_tdma_int_handler, IRQF_SHARED, "tdma", tdev);
 		if (ret)
-- 
2.17.1

