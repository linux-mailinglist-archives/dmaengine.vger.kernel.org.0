Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAD3108202
	for <lists+dmaengine@lfdr.de>; Sun, 24 Nov 2019 06:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbfKXF3J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 Nov 2019 00:29:09 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37871 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfKXF3J (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 24 Nov 2019 00:29:09 -0500
Received: by mail-pg1-f195.google.com with SMTP id b10so5448262pgd.4;
        Sat, 23 Nov 2019 21:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ON5n9I/25k32O1A/2D3MIyo2BlxDNMBzybIh7RG8xz8=;
        b=ovCu849udwskipv9/n1UhD8x9SQztBcID0T7scQUYgV/Oqa9t9ykaT5HLGPaH2OfbT
         iyXIL9hLJ+W4msEziMmzJsDwGEnQoQHZaQxdOJe3qY8OTBhbSZM4K8dGrg4zqN5EW2Ds
         xySz8L3x/m2cnLnOVjyW4SqeYEZuIXK7hIxrhZAB13CNQgVFex2YyqCg0Nqqg7zSsPzP
         KQJWNl+6OR9b7UmAW8JG/nFkmK1Dmw/+/hMxRILeHz4aZLVhzNZiGHR+kq7tH7hxdj30
         4fk6XbUxGUCqzbKE/ZHMG8GoIdA58IEt2++duGOKMGZTet3ZGg6pnLPTuB6748RUZ7mM
         qrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ON5n9I/25k32O1A/2D3MIyo2BlxDNMBzybIh7RG8xz8=;
        b=mn3QJMMuiDuF4dYn8M/nHJxatBg0B7BUP1rvz3flUKFcX3SH1FyG5dtNyRmUcgIBfq
         oextaWePwgkFONYI/846eLhIOBXLPuwzIRwlY1AVOCRvmXKzQ9O31kRIjhFTe1BJlpe9
         jLoNVQ5XxaXNpqHsakc412FsGXvHPo9LP/Xrj27N6WRuY78FZPTZRHeyoHu/HjAq7dg/
         pWIE3GhJTARADED6K//a574mf+wOCrT/E2gOxNYBc7OTOFfTCXX2A37fa76ONVsld5ME
         49f1L9FgdmoqAl5FX6d1pKqOINKWl/ADRYCu5rGU26vo4F+/f1h2/uxEnFRIwEyhJppJ
         asmQ==
X-Gm-Message-State: APjAAAXKP9i76EaZ+9/GxynnuH+upsOfmQT/dYsSIeRXBlYv3H9LtgCD
        N8WjB1MlkSiSU3ZHg3qLCk0=
X-Google-Smtp-Source: APXvYqzY/4pwBvAuCjFLW6iGX4cS5O5pnbcB2MKCL8mSMp5arnvtk+SQTE1PdNAwdvov+JskFcDtcg==
X-Received: by 2002:a62:140d:: with SMTP id 13mr26312229pfu.79.1574573348284;
        Sat, 23 Nov 2019 21:29:08 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id w2sm3453358pfj.22.2019.11.23.21.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 21:29:07 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] dmaengine: ti: edma: add missed operations
Date:   Sun, 24 Nov 2019 13:28:55 +0800
Message-Id: <20191124052855.6472-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver forgets to call pm_runtime_disable and pm_runtime_put_sync in
probe failure and remove.
Add the calls and modify probe failure handling to fix it.

To simplify the fix, the patch adjusts the calling order and merges checks
for devm_kcalloc.

Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under drivers/dma/")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Add the missed pm_runtime_put_sync.
  - Simplify the patch.
  - Rebase to dma-next.

 drivers/dma/ti/edma.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 756a3c951dc7..0628ee4bf1b4 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2289,13 +2289,6 @@ static int edma_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENODEV;
 
-	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		dev_err(dev, "pm_runtime_get_sync() failed\n");
-		return ret;
-	}
-
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
@@ -2326,27 +2319,31 @@ static int edma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ecc);
 
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm_runtime_get_sync() failed\n");
+		pm_runtime_disable(dev);
+		return ret;
+	}
+
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
 
 	ecc->slot_inuse = devm_kcalloc(dev, BITS_TO_LONGS(ecc->num_slots),
 				       sizeof(unsigned long), GFP_KERNEL);
-	if (!ecc->slot_inuse)
-		return -ENOMEM;
 
 	ecc->channels_mask = devm_kcalloc(dev,
 					   BITS_TO_LONGS(ecc->num_channels),
 					   sizeof(unsigned long), GFP_KERNEL);
-	if (!ecc->channels_mask)
-		return -ENOMEM;
+	if (!ecc->slave_chans || !ecc->slot_inuse || !ecc->channels_mask)
+		goto err_disable_pm;
 
 	/* Mark all channels available initially */
 	bitmap_fill(ecc->channels_mask, ecc->num_channels);
@@ -2388,7 +2385,7 @@ static int edma_probe(struct platform_device *pdev)
 				       ecc);
 		if (ret) {
 			dev_err(dev, "CCINT (%d) failed --> %d\n", irq, ret);
-			return ret;
+			goto err_disable_pm;
 		}
 		ecc->ccint = irq;
 	}
@@ -2404,7 +2401,7 @@ static int edma_probe(struct platform_device *pdev)
 				       ecc);
 		if (ret) {
 			dev_err(dev, "CCERRINT (%d) failed --> %d\n", irq, ret);
-			return ret;
+			goto err_disable_pm;
 		}
 		ecc->ccerrint = irq;
 	}
@@ -2412,7 +2409,8 @@ static int edma_probe(struct platform_device *pdev)
 	ecc->dummy_slot = edma_alloc_slot(ecc, EDMA_SLOT_ANY);
 	if (ecc->dummy_slot < 0) {
 		dev_err(dev, "Can't allocate PaRAM dummy slot\n");
-		return ecc->dummy_slot;
+		ret = ecc->dummy_slot;
+		goto err_disable_pm;
 	}
 
 	queue_priority_mapping = info->queue_priority_mapping;
@@ -2512,6 +2510,9 @@ static int edma_probe(struct platform_device *pdev)
 
 err_reg1:
 	edma_free_slot(ecc, ecc->dummy_slot);
+err_disable_pm:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
 	return ret;
 }
 
@@ -2542,6 +2543,8 @@ static int edma_remove(struct platform_device *pdev)
 	if (ecc->dma_memcpy)
 		dma_async_device_unregister(ecc->dma_memcpy);
 	edma_free_slot(ecc, ecc->dummy_slot);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
 
 	return 0;
 }
-- 
2.24.0

