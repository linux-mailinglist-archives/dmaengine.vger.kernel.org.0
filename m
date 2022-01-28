Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F2849FE36
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jan 2022 17:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350199AbiA1Qhg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jan 2022 11:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiA1Qhe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Jan 2022 11:37:34 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A22C061714;
        Fri, 28 Jan 2022 08:37:34 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so11400891pju.2;
        Fri, 28 Jan 2022 08:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=8NpNTyzXaPOru+fKu1mGcn33D0Qv904UK9Hdbsi3Sss=;
        b=MrbsNCACjKM+81UsxwFKwcXB93V7v3ZDIAT173RYe/230N9GRyP+JcELZd83NNys1u
         fapT/Wbfco5ekvXiOubYXVYAgvAn3QxcQ3Vy4gLubIagq29+SM4tT26ZSTKQl530IEGI
         gI9vRdprSXsTzyor8vGObLLZhzoLGufXhdOTj6mhDVQnOo2vOw9iWvE/LE5LBoNnjXwD
         MdA4EyBfkOLluUQxUG/YJsZq5vK6iWp9eJ+ER44PnSWRU47fesp6GGLQSqV7wIaWszXj
         2B16jycFkyXEc4Cb6wLkO5eLayj5KfcfnrTc+bwC2v3b++HS6434MT20UiN3y8IYOXHB
         jt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8NpNTyzXaPOru+fKu1mGcn33D0Qv904UK9Hdbsi3Sss=;
        b=nvc+o5NxPhJtf015QW0jsQdFcnLxytxAF0yLCkJh0Rk02i1fixCDg9cIIiOW9FRWUw
         zAyJNM23U9CrDKNKOjH/QsIfKC8FvT9C3aRk1FH6n8C+lKZszpeqfOdYbwczlgWJgZ5f
         k5a2pxbgQeKuFcEB0J/8NvKJx7+mniLiEk6NXkqZrWvuYWKCd+Yk84+mHpz4RhcBxeyh
         QCAwGm2yARCqUowpZ1lmBEQLDIEwu6TSxt83pftfmdBd+vyzXRJ0aV+vWKgjXkn5htjB
         iQlsL7uFZz39QOM+XfyTcqSskko9uruuoe5AHG3ogRjbBaF90LwC6velXfKxTcURAi2K
         HvQw==
X-Gm-Message-State: AOAM530M+rpEWsS1Esd/+La7k5MHN6up3ONu6xSIMGIVRpB9ud7htJ1T
        0bgK4LUdjKE8bhfI6+h8qGE=
X-Google-Smtp-Source: ABdhPJx++JiubuM1CAKmCY2Q7XMLB6wV78gt80KFR20tvQB+N7LMInX0RIssb158rQJH2lt3mJXAfw==
X-Received: by 2002:a17:902:c946:: with SMTP id i6mr8916130pla.17.1643387854372;
        Fri, 28 Jan 2022 08:37:34 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id g9sm6144124pgi.84.2022.01.28.08.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 08:37:33 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] dmaengine: owl-dma: Add missing IRQ check in owl_dma_probe
Date:   Fri, 28 Jan 2022 16:37:27 +0000
Message-Id: <20220128163728.21255-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This func misses checking for platform_get_irq()'s call and may passes the
negative error codes to request_threaded_irq(), which takes unsigned IRQ #,
causing it to fail with -EINVAL, overriding an original error code.
Stop calling request_threaded_irq() with invalid IRQ #s.

Fixes: 47e20577c24d ("dmaengine: Add Actions Semi Owl family S900 DMA driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/dma/owl-dma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 1f0bbaed4643..09cdaecee635 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -1160,6 +1160,11 @@ static int owl_dma_probe(struct platform_device *pdev)
 	 * simplification.
 	 */
 	od->irq = platform_get_irq(pdev, 0);
+	if (od->irq < 0) {
+		dev_err(&pdev->dev, "unable to get IRQ\n");
+		return od->irq;
+	}
+
 	ret = devm_request_irq(&pdev->dev, od->irq, owl_dma_interrupt, 0,
 			       dev_name(&pdev->dev), od);
 	if (ret) {
-- 
2.17.1

