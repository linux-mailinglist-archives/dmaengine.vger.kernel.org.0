Return-Path: <dmaengine+bounces-2574-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE02E91ADF7
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 19:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B784EB289DB
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4049619D88F;
	Thu, 27 Jun 2024 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7kjvhJu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADBF19CD05;
	Thu, 27 Jun 2024 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508977; cv=none; b=NralfEYFdtzv9KCKx4VWYFyMCFCxN0zOtOuwTMqSqbhxMbiyRf33UmLmra5BiS4gzD5HgjCUKoLkx+WcaYg9DggyexXGNEFORUkgpWdV50eWDw/KJs7PREl4vHf+PXW235WJELrFIV6GnNZb98NS1uIro3pBPUReyFQuSjvTcEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508977; c=relaxed/simple;
	bh=9trPxT7067agZJig5NFIevW79dFHtTF0XpemZk9R2eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7MfCPBitI0XGPMdtjFNoffL7MPSh2OK0jRvStevWVkPWlM59as5mC4tOuT7kIvYcT1TOsdOl5AF4fmUIJqAlNLSacZSO/sDUmE2riyDBew/VwOXIIZuLZ36aumeATryvWUr10f+ZC2T7yduzOucVH96qs1RND97dNTL5otY52M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7kjvhJu; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec58040f39so57325321fa.2;
        Thu, 27 Jun 2024 10:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719508974; x=1720113774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8jv7DlUuWmwKBFAeDpE74984/WTEdS+lAt5ksO5mUc=;
        b=E7kjvhJuyxv7J5TBtvDvdiTVfOfGW9ylxHih3tHOngN7AF6OyyOlceH6Uy/V5d7aEL
         zxtU+TKYt7ICEKeT154ZSP7zeOlLXyD7zMnde33V7CCTd3rBqcx3CVgtuu38M9yRSF4X
         p6cOxJ5a69sKo8JJo4/FYqhpmNcTWAyQDIdX6Mj2OVcak4Hs37yA2nX2zl9lxr50IMZS
         wr2oy/IviUWe3ChX+HghgK7vS4p2adUdWi7PavQxuw38cl4AsES0UmJGShMGRDD87Hej
         HUMaJelB0NvkeC0tO9t1J+dy3gvIa8BBG1SviFCXOt319ZMAzjYR9I3Yj7j1gNu6Cccq
         qSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508974; x=1720113774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8jv7DlUuWmwKBFAeDpE74984/WTEdS+lAt5ksO5mUc=;
        b=wqEtA/MNtRfsxm/rJ8zq/4T8LtmxyTgQPVGxubYv7kcQ5l06CIuz6sf9OBGg8SLz2Z
         ufmDyXnJo8ZHpi5XuOH0ZD8Pk2oyfv3eAuKJEcBBHCKMa0xVkU7tqX3/DE2U8NrkYsR0
         rL081P32xtf9jekMzo7P5V0GJTalODbK0UpAb0N6YS/QVzN+5ssJd6df2V1uoUkbWM3U
         BsSIDepRRhHhivgzvw8MvirK6K3bqJrHA+FcJYJB2sPWrv8wr16hR9Pt43WBFcchmGgT
         mGjf/GQkIXyTt5G1enniVN56ZtxBzaR80yfFV/lwpLBTR+XDvYsXy575plJyAkNOl1C+
         MsgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYZBlRmgfneszwN3Z2GFQk5fX3Xdi56q2Om9vWWdtO+nPoNKyT+tIgs5br+YIgDiiuFhy4BJjHdIBk1i2Vekv6AHoAXhcSQsm8jp2uVW+UpmVj0bKMCWXQoXwcoBGU3Iy1DY2VMdWFMsEntxKU2NJ/T5/5dHxkvuGw4Q2uxewIL05j2ZlZ
X-Gm-Message-State: AOJu0YxH0EmSNosTlbnWKFi2j3794Z6x31bbqR9u3Opegl1yZXE5V6UG
	4gazJYLJYDlEDsxvNbUTp5RLe04UpjSWlFlRXzZ/zoAlc5EFZiFP
X-Google-Smtp-Source: AGHT+IHGcnWVU3uZWrJira+2rU/QndOHq6hMw0pexfkmq6Vfs0ZRtEfHJDto+HPL5wXmLCqgkqqfrA==
X-Received: by 2002:a2e:3a13:0:b0:2ec:5019:bec3 with SMTP id 38308e7fff4ca-2ec593e0cd9mr95407421fa.21.1719508973571;
        Thu, 27 Jun 2024 10:22:53 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a34447fsm3237781fa.11.2024.06.27.10.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:22:53 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 6/6] dmaengine: dw: Unify ret-val local variables naming
Date: Thu, 27 Jun 2024 20:22:22 +0300
Message-ID: <20240627172231.24856-7-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627172231.24856-1-fancer.lancer@gmail.com>
References: <20240627172231.24856-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently there are two names utilized in the driver to keep the functions
call status: ret and err. For the sake of unification convert to using the
first version only.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- New patch created on v2 review stage. (Andy)
---
 drivers/dma/dw/core.c     | 20 ++++++++++----------
 drivers/dma/dw/platform.c | 20 ++++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 32a66f9effd9..dd75f97a33b3 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -1155,7 +1155,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	bool			autocfg = false;
 	unsigned int		dw_params;
 	unsigned int		i;
-	int			err;
+	int			ret;
 
 	dw->pdata = devm_kzalloc(chip->dev, sizeof(*dw->pdata), GFP_KERNEL);
 	if (!dw->pdata)
@@ -1171,7 +1171,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 
 		autocfg = dw_params >> DW_PARAMS_EN & 1;
 		if (!autocfg) {
-			err = -EINVAL;
+			ret = -EINVAL;
 			goto err_pdata;
 		}
 
@@ -1191,7 +1191,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 		pdata->chan_allocation_order = CHAN_ALLOCATION_ASCENDING;
 		pdata->chan_priority = CHAN_PRIORITY_ASCENDING;
 	} else if (chip->pdata->nr_channels > DW_DMA_MAX_NR_CHANNELS) {
-		err = -EINVAL;
+		ret = -EINVAL;
 		goto err_pdata;
 	} else {
 		memcpy(dw->pdata, chip->pdata, sizeof(*dw->pdata));
@@ -1203,7 +1203,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	dw->chan = devm_kcalloc(chip->dev, pdata->nr_channels, sizeof(*dw->chan),
 				GFP_KERNEL);
 	if (!dw->chan) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto err_pdata;
 	}
 
@@ -1221,15 +1221,15 @@ int do_dma_probe(struct dw_dma_chip *chip)
 					 sizeof(struct dw_desc), 4, 0);
 	if (!dw->desc_pool) {
 		dev_err(chip->dev, "No memory for descriptors dma pool\n");
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto err_pdata;
 	}
 
 	tasklet_setup(&dw->tasklet, dw_dma_tasklet);
 
-	err = request_irq(chip->irq, dw_dma_interrupt, IRQF_SHARED,
+	ret = request_irq(chip->irq, dw_dma_interrupt, IRQF_SHARED,
 			  dw->name, dw);
-	if (err)
+	if (ret)
 		goto err_pdata;
 
 	INIT_LIST_HEAD(&dw->dma.channels);
@@ -1341,8 +1341,8 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	 */
 	dma_set_max_seg_size(dw->dma.dev, dw->chan[0].block_size);
 
-	err = dma_async_device_register(&dw->dma);
-	if (err)
+	ret = dma_async_device_register(&dw->dma);
+	if (ret)
 		goto err_dma_register;
 
 	dev_info(chip->dev, "DesignWare DMA Controller, %d channels\n",
@@ -1356,7 +1356,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	free_irq(chip->irq, dw);
 err_pdata:
 	pm_runtime_put_sync_suspend(chip->dev);
-	return err;
+	return ret;
 }
 
 int do_dma_remove(struct dw_dma_chip *chip)
diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index 7d9d4c951724..47c58ad468cb 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -29,7 +29,7 @@ static int dw_probe(struct platform_device *pdev)
 	struct dw_dma_chip_pdata *data;
 	struct dw_dma_chip *chip;
 	struct device *dev = &pdev->dev;
-	int err;
+	int ret;
 
 	match = device_get_match_data(dev);
 	if (!match)
@@ -51,9 +51,9 @@ static int dw_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->regs))
 		return PTR_ERR(chip->regs);
 
-	err = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-	if (err)
-		return err;
+	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
 
 	if (!data->pdata)
 		data->pdata = dev_get_platdata(dev);
@@ -69,14 +69,14 @@ static int dw_probe(struct platform_device *pdev)
 	chip->clk = devm_clk_get_optional(chip->dev, "hclk");
 	if (IS_ERR(chip->clk))
 		return PTR_ERR(chip->clk);
-	err = clk_prepare_enable(chip->clk);
-	if (err)
-		return err;
+	ret = clk_prepare_enable(chip->clk);
+	if (ret)
+		return ret;
 
 	pm_runtime_enable(&pdev->dev);
 
-	err = data->probe(chip);
-	if (err)
+	ret = data->probe(chip);
+	if (ret)
 		goto err_dw_dma_probe;
 
 	platform_set_drvdata(pdev, data);
@@ -90,7 +90,7 @@ static int dw_probe(struct platform_device *pdev)
 err_dw_dma_probe:
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(chip->clk);
-	return err;
+	return ret;
 }
 
 static void dw_remove(struct platform_device *pdev)
-- 
2.43.0


