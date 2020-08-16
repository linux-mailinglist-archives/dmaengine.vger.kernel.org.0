Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E25524566E
	for <lists+dmaengine@lfdr.de>; Sun, 16 Aug 2020 09:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgHPHXD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Aug 2020 03:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgHPHXC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 16 Aug 2020 03:23:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD12C061786;
        Sun, 16 Aug 2020 00:23:02 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u20so6617362pfn.0;
        Sun, 16 Aug 2020 00:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XsWzkI7b5pu8oXRoyOcjalYLcDw0bFRQKxSKHW3RdiE=;
        b=KnfhSjMIJRK9g0L1/TkVJwJ+MZLfx9QY8vyjsQeXdxMvc7pHJ+XF4PXGFngDemEagf
         uXHun+YRQygAj9a8L+WiXupgmh1V1GckbRqwBBfw6XxOPcpFyzyG34B0oB5q7XM+gurL
         hZh6j1HEy04Cd1nhn0g5ROqeIINp5tukMDDecpzBX0mT8uBa4hQ4082KYmFEJYfk5iql
         +g8QBDlUsDxY5rzo8jVgJwHc/WN0BLh4xSRkCyrSmh5b1PTt2uyNJnDYlyLe7vEtk+JA
         EeEyp9GCqH23grUC4k+powv+wo1ZaJ5la1nrnH0/k6SKrAQAOFvnuBBu2QSmUcf6+L++
         Z1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XsWzkI7b5pu8oXRoyOcjalYLcDw0bFRQKxSKHW3RdiE=;
        b=cCP/YPFut+oN/CRRrSb4XkaB7NB0x7ccW0H1PKl8DfkpWCQGHazZlM0uwWJNvYbu/n
         1xceoX0jcdf7GO4xlN1Z12Dl/RgTThRGm2iBZV6XYKf4f9y/XBNE+QzoN0Enpnt5Fhbw
         m6aabaa8yvwdK2+l/WBwlK3PdH584uCDz4AxqYLh93Gt6mtIfz28KR9jKBxIlTYDq9ng
         rgb8GUZGcwNCf2p1NU41X5L+uXfmjvvD3sVH85V+WHdpO3VaULZAeEXaK/309OAX6Iuq
         hgGhx/WfYjjWF4MbZb+wjhnEadBPfDeujfJAgSU6UxKhOoz5AAUkJP16p8DVuHqMJ50T
         ljeA==
X-Gm-Message-State: AOAM532ySIOdt9lKwnfX0i+l0qi0HiSsLzl2M4lOlAFBu29Kn/8FzSzP
        eK8n6FsqMTYzIdxNbmQU2Q==
X-Google-Smtp-Source: ABdhPJzFMl3/Ql1T3hd7ZrGzuMfN4t0G+fRolW4k2ewhaSOf7wlYHj/Nq/apWVEEHy02C1keDckxPA==
X-Received: by 2002:a62:3486:: with SMTP id b128mr7032696pfa.98.1597562581911;
        Sun, 16 Aug 2020 00:23:01 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:cea:9294:8100:367f:a3dd:e679])
        by smtp.gmail.com with ESMTPSA id b22sm14825962pfb.213.2020.08.16.00.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 00:23:01 -0700 (PDT)
From:   madhuparnabhowmik10@gmail.com
To:     paul@crapouillou.net, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrianov@ispras.ru, ldv-project@linuxtesting.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] drivers/dma/dma-jz4780: Fix race condition between probe and irq handler
Date:   Sun, 16 Aug 2020 12:52:53 +0530
Message-Id: <20200816072253.13817-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

In probe IRQ is requested before zchan->id is initialized which can be
read in the irq handler. Hence, shift request irq and enable clock after
other initializations complete. Here, enable clock part is not part of
the race, it is just shifted down after request_irq to keep the error
path same as before.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 drivers/dma/dma-jz4780.c | 44 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 448f663da89c..5cbc8c3bd6c7 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -879,28 +879,6 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = platform_get_irq(pdev, 0);
-	if (ret < 0)
-		return ret;
-
-	jzdma->irq = ret;
-
-	ret = request_irq(jzdma->irq, jz4780_dma_irq_handler, 0, dev_name(dev),
-			  jzdma);
-	if (ret) {
-		dev_err(dev, "failed to request IRQ %u!\n", jzdma->irq);
-		return ret;
-	}
-
-	jzdma->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(jzdma->clk)) {
-		dev_err(dev, "failed to get clock\n");
-		ret = PTR_ERR(jzdma->clk);
-		goto err_free_irq;
-	}
-
-	clk_prepare_enable(jzdma->clk);
-
 	/* Property is optional, if it doesn't exist the value will remain 0. */
 	of_property_read_u32_index(dev->of_node, "ingenic,reserved-channels",
 				   0, &jzdma->chan_reserved);
@@ -949,6 +927,28 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 		jzchan->vchan.desc_free = jz4780_dma_desc_free;
 	}
 
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+
+	jzdma->irq = ret;
+
+	ret = request_irq(jzdma->irq, jz4780_dma_irq_handler, 0, dev_name(dev),
+			  jzdma);
+	if (ret) {
+		dev_err(dev, "failed to request IRQ %u!\n", jzdma->irq);
+		return ret;
+	}
+
+	jzdma->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(jzdma->clk)) {
+		dev_err(dev, "failed to get clock\n");
+		ret = PTR_ERR(jzdma->clk);
+		goto err_free_irq;
+	}
+
+	clk_prepare_enable(jzdma->clk);
+
 	ret = dmaenginem_async_device_register(dd);
 	if (ret) {
 		dev_err(dev, "failed to register device\n");
-- 
2.17.1

