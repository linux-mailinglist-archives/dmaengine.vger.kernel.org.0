Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A29D17B1C5
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jul 2019 20:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfG3SUX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jul 2019 14:20:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46656 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbfG3SQI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Jul 2019 14:16:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id c3so7121611pfa.13
        for <dmaengine@vger.kernel.org>; Tue, 30 Jul 2019 11:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TQ0bfEJkOQYCCG+Cx9OyMOrgtW7Bz2gFbH7jUkbV298=;
        b=afizpilqWvSGRR9YYn5b0AXegYLk7sfm3tYKR2KypkJ4SQPD1mvqZ1wbiRuokjKBsu
         KYupYAHgxvsb7zTZGZkXejgKfqqW9DPRp+Jn5eqg5V6+BrpeOS8AculnmP4lGiGNNkTm
         quMcbtsJY5RqG2JkD32UXXHmf2q8E0ejf96rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQ0bfEJkOQYCCG+Cx9OyMOrgtW7Bz2gFbH7jUkbV298=;
        b=pkJpOc+BZqKD0LWXxuIzjbY/3GQcfePlBDWonMC4Kf3Jy39YVDS+Uv/xe/QE500SnW
         KrVoGD9flG20Qgk1LCfwV74pFI6L2dLFwrhkXn9nkc1iLoAVesLsybUyJx/KjihHQ9he
         uefXuy1WBxmQll9Wn57GB+T4D1YDYCqBcLUJ4QCyB39pTNByW6lrQKTSvuU/f/Jlo+TG
         SG4+PhQ/qkuXXLDZNRMdGWAmnDUcdP8pjYNM5ylzI394sdUThWSDy6wsjUYzxqeEMphO
         qLB3+pzwsqS3UebHH7k3UVQXqk1Ga85WkclmRMeWv+n6Di28UYDOXFLbe1YpmVhlwKTu
         /ihA==
X-Gm-Message-State: APjAAAUvZ+W037dIxBH+ZrOcDDgXxZ4PgzmJw6CU1c9pgOUTib1dSLoz
        PrxCNHLcEYj8dbl/WwQnT6liLA==
X-Google-Smtp-Source: APXvYqypxwMnmmLjJGdPAbWgXghEHYVqlAhjHPrPXD2IUA8vQty4EcXW+/amKA54By1Gy4OrwIuTZA==
X-Received: by 2002:a65:68c9:: with SMTP id k9mr76862223pgt.17.1564510567776;
        Tue, 30 Jul 2019 11:16:07 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:07 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 10/57] dmaengine: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:10 -0700
Message-Id: <20190730181557.90391-11-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/dma/dma-jz4780.c              | 4 +---
 drivers/dma/fsl-edma.c                | 8 ++------
 drivers/dma/fsl-qdma.c                | 9 ++-------
 drivers/dma/mediatek/mtk-uart-apdma.c | 4 +---
 drivers/dma/qcom/hidma_mgmt.c         | 1 -
 drivers/dma/s3c24xx-dma.c             | 5 +----
 drivers/dma/sh/rcar-dmac.c            | 4 +---
 drivers/dma/sh/usb-dmac.c             | 4 +---
 drivers/dma/st_fdma.c                 | 4 +---
 drivers/dma/stm32-dma.c               | 6 +-----
 drivers/dma/stm32-mdma.c              | 4 +---
 drivers/dma/sun4i-dma.c               | 4 +---
 drivers/dma/sun6i-dma.c               | 4 +---
 drivers/dma/uniphier-mdmac.c          | 5 +----
 drivers/dma/xgene-dma.c               | 8 ++------
 15 files changed, 17 insertions(+), 57 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 7fe9309a876b..b5547436ad7e 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -878,10 +878,8 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	}
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(dev, "failed to get IRQ: %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	jzdma->irq = ret;
 
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index fcbad6ae954a..71650fa01f18 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -125,16 +125,12 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
 	int ret;
 
 	fsl_edma->txirq = platform_get_irq_byname(pdev, "edma-tx");
-	if (fsl_edma->txirq < 0) {
-		dev_err(&pdev->dev, "Can't get edma-tx irq.\n");
+	if (fsl_edma->txirq < 0)
 		return fsl_edma->txirq;
-	}
 
 	fsl_edma->errirq = platform_get_irq_byname(pdev, "edma-err");
-	if (fsl_edma->errirq < 0) {
-		dev_err(&pdev->dev, "Can't get edma-err irq.\n");
+	if (fsl_edma->errirq < 0)
 		return fsl_edma->errirq;
-	}
 
 	if (fsl_edma->txirq == fsl_edma->errirq) {
 		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 8e341c0c13bc..06664fbd2d91 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -758,10 +758,8 @@ fsl_qdma_irq_init(struct platform_device *pdev,
 
 	fsl_qdma->error_irq =
 		platform_get_irq_byname(pdev, "qdma-error");
-	if (fsl_qdma->error_irq < 0) {
-		dev_err(&pdev->dev, "Can't get qdma controller irq.\n");
+	if (fsl_qdma->error_irq < 0)
 		return fsl_qdma->error_irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, fsl_qdma->error_irq,
 			       fsl_qdma_error_handler, 0,
@@ -776,11 +774,8 @@ fsl_qdma_irq_init(struct platform_device *pdev,
 		fsl_qdma->queue_irq[i] =
 				platform_get_irq_byname(pdev, irq_name);
 
-		if (fsl_qdma->queue_irq[i] < 0) {
-			dev_err(&pdev->dev,
-				"Can't get qdma queue %d irq.\n", i);
+		if (fsl_qdma->queue_irq[i] < 0)
 			return fsl_qdma->queue_irq[i];
-		}
 
 		ret = devm_request_irq(&pdev->dev,
 				       fsl_qdma->queue_irq[i],
diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index 546995c20876..f40051d6aecb 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -547,10 +547,8 @@ static int mtk_uart_apdma_probe(struct platform_device *pdev)
 		vchan_init(&c->vc, &mtkd->ddev);
 
 		rc = platform_get_irq(pdev, i);
-		if (rc < 0) {
-			dev_err(&pdev->dev, "failed to get IRQ[%d]\n", i);
+		if (rc < 0)
 			goto err_no_dma;
-		}
 		c->irq = rc;
 	}
 
diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index 3022d66e7a33..7cb81a50f3f3 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -183,7 +183,6 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "irq resources not found\n");
 		rc = irq;
 		goto out;
 	}
diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index ad30f3d2c7f6..43da8eeb18ef 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -1237,11 +1237,8 @@ static int s3c24xx_dma_probe(struct platform_device *pdev)
 		phy->host = s3cdma;
 
 		phy->irq = platform_get_irq(pdev, i);
-		if (phy->irq < 0) {
-			dev_err(&pdev->dev, "failed to get irq %d, err %d\n",
-				i, phy->irq);
+		if (phy->irq < 0)
 			continue;
-		}
 
 		ret = devm_request_irq(&pdev->dev, phy->irq, s3c24xx_dma_irq,
 				       0, pdev->name, phy);
diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 9c41a4e42575..eb6f2312a6a2 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1744,10 +1744,8 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 	/* Request the channel interrupt. */
 	sprintf(pdev_irqname, "ch%u", index);
 	rchan->irq = platform_get_irq_byname(pdev, pdev_irqname);
-	if (rchan->irq < 0) {
-		dev_err(dmac->dev, "no IRQ specified for channel %u\n", index);
+	if (rchan->irq < 0)
 		return -ENODEV;
-	}
 
 	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
 				 dev_name(dmac->dev), index);
diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index 17063aaf51bc..b218a013c260 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -717,10 +717,8 @@ static int usb_dmac_chan_probe(struct usb_dmac *dmac,
 	/* Request the channel interrupt. */
 	sprintf(pdev_irqname, "ch%u", index);
 	uchan->irq = platform_get_irq_byname(pdev, pdev_irqname);
-	if (uchan->irq < 0) {
-		dev_err(dmac->dev, "no IRQ specified for channel %u\n", index);
+	if (uchan->irq < 0)
 		return -ENODEV;
-	}
 
 	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
 				 dev_name(dmac->dev), index);
diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index a3ee0f6bb664..67087dbe2f9f 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -771,10 +771,8 @@ static int st_fdma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, fdev);
 
 	fdev->irq = platform_get_irq(pdev, 0);
-	if (fdev->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get irq resource\n");
+	if (fdev->irq < 0)
 		return -EINVAL;
-	}
 
 	ret = devm_request_irq(&pdev->dev, fdev->irq, st_fdma_irq_handler, 0,
 			       dev_name(&pdev->dev), fdev);
diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index ef4d109e7189..e4cbe38d1b83 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1366,12 +1366,8 @@ static int stm32_dma_probe(struct platform_device *pdev)
 	for (i = 0; i < STM32_DMA_MAX_CHANNELS; i++) {
 		chan = &dmadev->chan[i];
 		ret = platform_get_irq(pdev, i);
-		if (ret < 0)  {
-			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev,
-					"No irq resource for chan %d\n", i);
+		if (ret < 0)
 			goto err_unregister;
-		}
 		chan->irq = ret;
 
 		ret = devm_request_irq(&pdev->dev, chan->irq,
diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index d6e919d3936a..d492b6e19735 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1638,10 +1638,8 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 	}
 
 	dmadev->irq = platform_get_irq(pdev, 0);
-	if (dmadev->irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
+	if (dmadev->irq < 0)
 		return dmadev->irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, dmadev->irq, stm32_mdma_irq_handler,
 			       0, dev_name(&pdev->dev), dmadev);
diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index 1f80568b2613..e397a50058c8 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -1132,10 +1132,8 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq < 0) {
-		dev_err(&pdev->dev, "Cannot claim IRQ\n");
+	if (priv->irq < 0)
 		return priv->irq;
-	}
 
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index ed5b68dcfe50..06cd7f867f7c 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1251,10 +1251,8 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(sdc->base);
 
 	sdc->irq = platform_get_irq(pdev, 0);
-	if (sdc->irq < 0) {
-		dev_err(&pdev->dev, "Cannot claim IRQ\n");
+	if (sdc->irq < 0)
 		return sdc->irq;
-	}
 
 	sdc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sdc->clk)) {
diff --git a/drivers/dma/uniphier-mdmac.c b/drivers/dma/uniphier-mdmac.c
index ec65a7430dc4..fde54687856b 100644
--- a/drivers/dma/uniphier-mdmac.c
+++ b/drivers/dma/uniphier-mdmac.c
@@ -354,11 +354,8 @@ static int uniphier_mdmac_chan_init(struct platform_device *pdev,
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, chan_id);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ number for ch%d\n",
-			chan_id);
+	if (irq < 0)
 		return irq;
-	}
 
 	irq_name = devm_kasprintf(dev, GFP_KERNEL, "uniphier-mio-dmac-ch%d",
 				  chan_id);
diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index 957c269ce1fd..cd60fa6d6750 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -1678,20 +1678,16 @@ static int xgene_dma_get_resources(struct platform_device *pdev,
 
 	/* Get DMA error interrupt */
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "Failed to get Error IRQ\n");
+	if (irq <= 0)
 		return -ENXIO;
-	}
 
 	pdma->err_irq = irq;
 
 	/* Get DMA Rx ring descriptor interrupts for all DMA channels */
 	for (i = 1; i <= XGENE_DMA_MAX_CHANNEL; i++) {
 		irq = platform_get_irq(pdev, i);
-		if (irq <= 0) {
-			dev_err(&pdev->dev, "Failed to get Rx IRQ\n");
+		if (irq <= 0)
 			return -ENXIO;
-		}
 
 		pdma->chan[i - 1].rx_irq = irq;
 	}
-- 
Sent by a computer through tubes

