Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB60CFFFA1
	for <lists+dmaengine@lfdr.de>; Mon, 18 Nov 2019 08:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfKRHhl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Nov 2019 02:37:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37480 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRHhl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Nov 2019 02:37:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id bb5so9292093plb.4;
        Sun, 17 Nov 2019 23:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ky5bDnxx6AUjjKxYULMJAA7cOyrMt7zuSBXFyQDWhek=;
        b=OBJ+QV/ft4Ji3XO8qf+lJk1uMFtal6W/+gGtRe9y5aHNrpkEG0PefkFamWnCj0uiaP
         +f8+qkEupzSRNO2by6UKCN7+YE4GkiheK4lbmGsxvI+Q4g1Sx3jr2cfzwW5hd57s8wvp
         bEt9AHBrULurCYCr5hY3h/Z1RR87aFnwiP+dmqZhv2Wh+MbKrChBxccge/NwuerAw2Jp
         NtQPBbTuLuwNWHco31ij6Qn48/nbgdn0rkzrxZZbXvjGXJDf2Yh/gyYAFlxxux/169yl
         /l8wpE4Dgf7+l8so8Fbvhnb/DPIYTL7nJ8Jgx+matKq061NCoX4cai0mEZbsMv8qwNd9
         fXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ky5bDnxx6AUjjKxYULMJAA7cOyrMt7zuSBXFyQDWhek=;
        b=Ty3zjZymLn2gkp5IREYveSiIPIa1KU+M6E1jP4jcmwaTecNYe41wwjqdbji07Kcaee
         f24G/at5uuR0FncxmnzypO2tLIWfbi8cd3DD9l4rX52VjhUo/VSTjU7URygCZuvM6I8b
         ST45on5K9GJy7oechWO/0gL4K6ciWhmUXAGc7xbbtooVMUmaqpHrqHyxZEV56QUKqVx8
         e2VUp8jwy58G1TW+fZDvrNdmDjiD92pvWX1RCnZUo6N9te9KUpQaj614y6ZGGNnkNsxU
         HsQ/VJAVpyWJNjNF7KSceYRxPmNBszrnIY8hZG2zeBDFAAMLU846jnlonVfUYW8BSgKo
         7BzA==
X-Gm-Message-State: APjAAAWd2cGCRU3rCwgaxLWtBSGEl2mvqdVrjQQlR+9R65gYc4ZusxUU
        mE4KQ6oWlPBNO/Qoc2VFH7o=
X-Google-Smtp-Source: APXvYqxDuyMB0QPSuhD3+vOpCXqc+kMBLHlUh5x28nOiEhBw21YBgd88SFXmmScokH02rF0vER36WQ==
X-Received: by 2002:a17:902:ba97:: with SMTP id k23mr27372249pls.137.1574062660255;
        Sun, 17 Nov 2019 23:37:40 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id y4sm18657504pgy.27.2019.11.17.23.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 23:37:39 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 1/2] dmaengine: ti: edma: add missed pm_runtime_disable
Date:   Mon, 18 Nov 2019 15:37:28 +0800
Message-Id: <20191118073728.28366-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver forgets to call pm_runtime_disable in probe failure and
remove.
Add the calls and modify probe failure handling to fix it.

Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under drivers/dma/")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/dma/ti/edma.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index ba7c4f07fcd6..8be32fd9f762 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2282,16 +2282,18 @@ static int edma_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
 		dev_err(dev, "pm_runtime_get_sync() failed\n");
-		return ret;
+		goto err_disable_pm;
 	}
 
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret)
-		return ret;
+		goto err_disable_pm;
 
 	ecc = devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
-	if (!ecc)
-		return -ENOMEM;
+	if (!ecc) {
+		ret = -ENOMEM;
+		goto err_disable_pm;
+	}
 
 	ecc->dev = dev;
 	ecc->id = pdev->id;
@@ -2306,30 +2308,37 @@ static int edma_probe(struct platform_device *pdev)
 		mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (!mem) {
 			dev_err(dev, "no mem resource?\n");
-			return -ENODEV;
+			ret = -ENODEV;
+			goto err_disable_pm;
 		}
 	}
 	ecc->base = devm_ioremap_resource(dev, mem);
-	if (IS_ERR(ecc->base))
-		return PTR_ERR(ecc->base);
+	if (IS_ERR(ecc->base)) {
+		ret = PTR_ERR(ecc->base);
+		goto err_disable_pm;
+	}
 
 	platform_set_drvdata(pdev, ecc);
 
 	/* Get eDMA3 configuration from IP */
 	ret = edma_setup_from_hw(dev, info, ecc);
 	if (ret)
-		return ret;
+		goto err_disable_pm;
 
 	/* Allocate memory based on the information we got from the IP */
 	ecc->slave_chans = devm_kcalloc(dev, ecc->num_channels,
 					sizeof(*ecc->slave_chans), GFP_KERNEL);
-	if (!ecc->slave_chans)
-		return -ENOMEM;
+	if (!ecc->slave_chans) {
+		ret = -ENOMEM;
+		goto err_disable_pm;
+	}
 
 	ecc->slot_inuse = devm_kcalloc(dev, BITS_TO_LONGS(ecc->num_slots),
 				       sizeof(unsigned long), GFP_KERNEL);
-	if (!ecc->slot_inuse)
-		return -ENOMEM;
+	if (!ecc->slot_inuse) {
+		ret = -ENOMEM;
+		goto err_disable_pm;
+	}
 
 	ecc->default_queue = info->default_queue;
 
@@ -2368,7 +2377,7 @@ static int edma_probe(struct platform_device *pdev)
 				       ecc);
 		if (ret) {
 			dev_err(dev, "CCINT (%d) failed --> %d\n", irq, ret);
-			return ret;
+			goto err_disable_pm;
 		}
 		ecc->ccint = irq;
 	}
@@ -2384,7 +2393,7 @@ static int edma_probe(struct platform_device *pdev)
 				       ecc);
 		if (ret) {
 			dev_err(dev, "CCERRINT (%d) failed --> %d\n", irq, ret);
-			return ret;
+			goto err_disable_pm;
 		}
 		ecc->ccerrint = irq;
 	}
@@ -2392,7 +2401,8 @@ static int edma_probe(struct platform_device *pdev)
 	ecc->dummy_slot = edma_alloc_slot(ecc, EDMA_SLOT_ANY);
 	if (ecc->dummy_slot < 0) {
 		dev_err(dev, "Can't allocate PaRAM dummy slot\n");
-		return ecc->dummy_slot;
+		ret = ecc->dummy_slot;
+		goto err_disable_pm;
 	}
 
 	queue_priority_mapping = info->queue_priority_mapping;
@@ -2473,6 +2483,8 @@ static int edma_probe(struct platform_device *pdev)
 
 err_reg1:
 	edma_free_slot(ecc, ecc->dummy_slot);
+err_disable_pm:
+	pm_runtime_disable(dev);
 	return ret;
 }
 
@@ -2503,6 +2515,7 @@ static int edma_remove(struct platform_device *pdev)
 	if (ecc->dma_memcpy)
 		dma_async_device_unregister(ecc->dma_memcpy);
 	edma_free_slot(ecc, ecc->dummy_slot);
+	pm_runtime_disable(dev);
 
 	return 0;
 }
-- 
2.24.0

