Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC4CB2EFF
	for <lists+dmaengine@lfdr.de>; Sun, 15 Sep 2019 09:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfIOH3V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 15 Sep 2019 03:29:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40858 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfIOH3V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 15 Sep 2019 03:29:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so17535101pgj.7;
        Sun, 15 Sep 2019 00:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=feHoHeaJlwzigA+EFklJwcCVQwO/8riLigRDqPWgDLg=;
        b=NJeF3w3mqwFtxyYc6Vx7gx8+PgVwkfnoD0KpBOj8vR0ObgGYjjzTciTaOL5l7Z/10P
         TrdIuOUbmw3MglvyVpGIO6SXmJTeucjeepVZhW20jidr95rMHI6uOWyO5hzGFSvPnb9G
         2lP/cQlsUl60iujTSh10e5H6/druZQiWwgXbESiaJRerwxK+ak/KxoYjEk5dUsuYNNqf
         J8Z1KG9aKF1BbyTES6USDeMJzbqwmdJYfW1VWEvtPPIMc3md8eL6f4dk6OhNYKJ/hYBu
         AKFX2KpDm/ro/j4WFMxc4ZXkR1KuQFSHH5rEGkDHZmZLR18B2t30+0e722ksMNOR9qKT
         jwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=feHoHeaJlwzigA+EFklJwcCVQwO/8riLigRDqPWgDLg=;
        b=bL4l/jGqy+1PqKH0VvIF7MwyHc1ThBGGwCGTfTUBcsNUW8XCFibSRSsg76NKzU64fy
         z2hm4MrdD3tJOAXtMUhg2jVMdIW28285MMMR1NwuNyrJSo7n2XCywrz1oFy3bsTucxh/
         eJJXFQdpHlNvyyPH74jLnRZFuKz2C63V6AB9wbRjz7CiWwXV8E3Oe9q6wr0AP+IHoBdx
         ZuDMDhTbtyYB1A6uzuwFK25j1BQ/p5pOY/15Lo1XvZQ3Ltu3ZmjEdMVvc4bpuoxLeWRr
         d4ifPFsgkN5RqCyTKBiynwc90dFa4f4acQFJqI/1DyITn7hHa83SIWFIPoe2M7zlVv1c
         bPlA==
X-Gm-Message-State: APjAAAUbuNF/6pOKFes9CWlaqzXpQE7l4cGoQ+3ld8dfjy3STDBZnRny
        ikdi5K2i4fBmxjJ3vQ+GXyc4BXxq1GWbsg==
X-Google-Smtp-Source: APXvYqwF3YgMbjKR1jnQH7AInYrRQmHT8uS+agDXvbe9lIlt1XJpsKDqBX2oKXpQxmSoBluhKUmwZw==
X-Received: by 2002:a17:90a:3086:: with SMTP id h6mr14562263pjb.1.1568532560912;
        Sun, 15 Sep 2019 00:29:20 -0700 (PDT)
Received: from satendra-MM061.ib-wrb304n.setup.in ([103.82.150.111])
        by smtp.gmail.com with ESMTPSA id i1sm43107195pfg.2.2019.09.15.00.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 00:29:20 -0700 (PDT)
From:   Satendra Singh Thakur <sst2005@gmail.com>
Cc:     satendrasingh.thakur@hcl.com,
        Satendra Singh Thakur <sst2005@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] probe/dma/jz4740: removed redundant code from jz4740 dma controller's     probe function
Date:   Sun, 15 Sep 2019 12:59:03 +0530
Message-Id: <20190915072903.23522-1-sst2005@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190915072644.23329-1-sst2005@gmail.com>
References: <20190915072644.23329-1-sst2005@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

1. In order to remove duplicate code, following functions:
devm_kzalloc
platform_get_resource
devm_ioremap_resource
clk_get
clk_prepare_enable
platform_get_irq
are replaced with a macro devm_platform_probe_helper_clk.

2. Added irq field in the struct jz4740_dma_dev.
Removed platform_get_irq from remove method.

3. This patch depends on the file include/linux/probe-helper.h
which is pushed in previous patch [01/09].

Signed-off-by: Satendra Singh Thakur <satendrasingh.thakur@hcl.com>
Signed-off-by: Satendra Singh Thakur <sst2005@gmail.com>
---
 drivers/dma/dma-jz4740.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/dma-jz4740.c b/drivers/dma/dma-jz4740.c
index 39c676c47082..b012896d02bb 100644
--- a/drivers/dma/dma-jz4740.c
+++ b/drivers/dma/dma-jz4740.c
@@ -15,6 +15,7 @@
 #include <linux/spinlock.h>
 #include <linux/irq.h>
 #include <linux/clk.h>
+#include <linux/probe-helper.h>
 
 #include "virt-dma.h"
 
@@ -121,6 +122,7 @@ struct jz4740_dma_dev {
 	struct dma_device ddev;
 	void __iomem *base;
 	struct clk *clk;
+	int irq;
 
 	struct jz4740_dmaengine_chan chan[JZ_DMA_NR_CHANS];
 };
@@ -519,27 +521,19 @@ static int jz4740_dma_probe(struct platform_device *pdev)
 	struct jz4740_dma_dev *dmadev;
 	struct dma_device *dd;
 	unsigned int i;
-	struct resource *res;
 	int ret;
-	int irq;
 
-	dmadev = devm_kzalloc(&pdev->dev, sizeof(*dmadev), GFP_KERNEL);
-	if (!dmadev)
-		return -EINVAL;
+	/*
+	 * This macro internally combines following functions:
+	 * devm_kzalloc, platform_get_resource, devm_ioremap_resource,
+	 * devm_clk_get, platform_get_irq, clk_prepare_enable
+	 */
+	ret = devm_platform_probe_helper_clk(pdev, dmadev, "dma");
+	if (ret < 0)
+		return ret;
 
 	dd = &dmadev->ddev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dmadev->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(dmadev->base))
-		return PTR_ERR(dmadev->base);
-
-	dmadev->clk = clk_get(&pdev->dev, "dma");
-	if (IS_ERR(dmadev->clk))
-		return PTR_ERR(dmadev->clk);
-
-	clk_prepare_enable(dmadev->clk);
-
 	dma_cap_set(DMA_SLAVE, dd->cap_mask);
 	dma_cap_set(DMA_CYCLIC, dd->cap_mask);
 	dd->device_free_chan_resources = jz4740_dma_free_chan_resources;
@@ -567,8 +561,8 @@ static int jz4740_dma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk;
 
-	irq = platform_get_irq(pdev, 0);
-	ret = request_irq(irq, jz4740_dma_irq, 0, dev_name(&pdev->dev), dmadev);
+	ret = request_irq(dmadev->irq, jz4740_dma_irq, 0,
+			dev_name(&pdev->dev), dmadev);
 	if (ret)
 		goto err_unregister;
 
@@ -598,9 +592,8 @@ static void jz4740_cleanup_vchan(struct dma_device *dmadev)
 static int jz4740_dma_remove(struct platform_device *pdev)
 {
 	struct jz4740_dma_dev *dmadev = platform_get_drvdata(pdev);
-	int irq = platform_get_irq(pdev, 0);
 
-	free_irq(irq, dmadev);
+	free_irq(dmadev->irq, dmadev);
 
 	jz4740_cleanup_vchan(&dmadev->ddev);
 	dma_async_device_unregister(&dmadev->ddev);
-- 
2.17.1

