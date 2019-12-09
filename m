Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 697271168B5
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2019 09:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfLII51 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Dec 2019 03:57:27 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38263 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLII51 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Dec 2019 03:57:27 -0500
Received: by mail-pl1-f194.google.com with SMTP id o8so5518533pls.5;
        Mon, 09 Dec 2019 00:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Rd94SkExxWILtJkUpqFvUuCN5ndixKS4EI5Ogpk9Yg=;
        b=p77BOAzq5Iit9ISix0BGN4EVWb0tlTSTswlSK87610dz0mxFxOFxaYQSeSdaCuLX1+
         VNaDd8onkZYsjTRyeSww8VGyi71LzBgUAKRqYnbDqBcEzlHeh+DOgy3j9oZsIyVqlJX7
         fcPUnpfOLzOYDEAmbdu2iMloIECzLWS9Pex4nCTM9QGAoBOWeKIPlpvRvMnsaSE1uWKV
         G7WUI1hhxgJEFY3xHg8NRS+p71JhPzEGNAIAHSUKAET1TJpxjyn45mB4c8H1p+aC+pwM
         3gcGujU3kWOY5E8tHY89oBrTujPklCegcjmoHz1YCZrJ0LDz8nvzWNYjUQ6LSUKR3T5D
         77/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Rd94SkExxWILtJkUpqFvUuCN5ndixKS4EI5Ogpk9Yg=;
        b=TcPDWUr4f086jk2zaZDErHMzVpRb7HC4qIAXz+6poA62GnvtyvYN9TkiUUVuT2E3HV
         a+pOx314s2QDw5W+6ri/gnuSk4e/lyyKbQ70RP1q4nlwE9oL4RVk3Rrk3HwT1B6LUGy1
         z7JPAFuxEgkhJRoil4pqJdqGJC0bGP81gkYksiIkru2wY7GELOEl8XOzbTNtY5ArGuw8
         xGAyjajFJ7GxiYB8ewJ/ldOqUyut5ZiZ0LXD9m2TQCLFv8y/wnbG09+4RNitJdIn0VgH
         JihTPnQ4RmVHhYPGKIOIYcqYDjzhvV1hy0utQzyK1c/aY4i+uEm7Ot7kfgxDSSsY0rHL
         izlw==
X-Gm-Message-State: APjAAAVsV4668EUF3jZfqaFp9sNhKus/U/g7e+U6J87C1HcwhOvW5wrG
        c+bj19tYgCb6JYh76IP1vY5+nPqy
X-Google-Smtp-Source: APXvYqw6IqyvWGIcjS1oug7cS9BjUh2segQpwi1o/FAEO7jrgL7mxGnzV7TTZuv66b+jGsMzek56MQ==
X-Received: by 2002:a17:902:9302:: with SMTP id bc2mr28656852plb.148.1575881846841;
        Mon, 09 Dec 2019 00:57:26 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id u26sm25078305pfn.46.2019.12.09.00.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 00:57:26 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] dmaengine: axi-dmac: add a check for devm_regmap_init_mmio
Date:   Mon,  9 Dec 2019 16:57:11 +0800
Message-Id: <20191209085711.16001-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver misses checking the result of devm_regmap_init_mmio().
Add a check to fix it.

Fixes: fc15be39a827 ("dmaengine: axi-dmac: add regmap support")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/dma/dma-axi-dmac.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index a0ee404b736e..cf4f892562cc 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -830,6 +830,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	struct dma_device *dma_dev;
 	struct axi_dmac *dmac;
 	struct resource *res;
+	struct regmap *regmap;
 	int ret;
 
 	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
@@ -921,10 +922,17 @@ static int axi_dmac_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dmac);
 
-	devm_regmap_init_mmio(&pdev->dev, dmac->base, &axi_dmac_regmap_config);
+	regmap = devm_regmap_init_mmio(&pdev->dev, dmac->base,
+		 &axi_dmac_regmap_config);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		goto err_free_irq;
+	}
 
 	return 0;
 
+err_free_irq:
+	free_irq(dmac->irq, dmac);
 err_unregister_of:
 	of_dma_controller_free(pdev->dev.of_node);
 err_unregister_device:
-- 
2.24.0

