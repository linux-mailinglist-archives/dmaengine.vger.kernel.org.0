Return-Path: <dmaengine+bounces-1914-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC528AB4A6
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 19:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74431F22868
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 17:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0166C13D287;
	Fri, 19 Apr 2024 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgKerGuS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3461E13D25F;
	Fri, 19 Apr 2024 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549462; cv=none; b=Xiun+voCca57Y93ClHCZ3/5iKhjWg4TODw7qwG6F8/zruDbJubwm92LPpu4FWIxBMFBQPDcb8rf+k0wZX/4KVTZNYNDe5E+rY2BZZHQEIC+G/bZHWoiJL2BtSSzk6gGl6n13l6/embLI/PS5iUTQgJqAA+6DgxB7c4TeFAtc47s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549462; c=relaxed/simple;
	bh=9trPxT7067agZJig5NFIevW79dFHtTF0XpemZk9R2eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmCK2dKHyzP4g0wAhvKn2WHpaoXV1QEdSABgFc09JQ6IijTDF8cpgwx/QV0HQJ4VXbuER+wXeM0eKcj8TjfOpp5zYFAaYOgI39pIS2ge4SFX8X1FbDym0ePsoVBUNC9JonF7nYpD1JCDs3yn18lwLf7RlEZCWpf9YlaMj3vYDhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgKerGuS; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so2815260e87.2;
        Fri, 19 Apr 2024 10:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713549459; x=1714154259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8jv7DlUuWmwKBFAeDpE74984/WTEdS+lAt5ksO5mUc=;
        b=fgKerGuScRGkpmuJwbYDNDsCadyzUbro4RVJHtxhUE8IVbSy5hsyQDjZiZNQIkKz0C
         7MgWiH+IvIXgdIgUAFmxJVP5/A2cbpuPJWE1KhPCMVfifxTLKMLd4BrSBfKU1nzXBKVm
         UUMjsofJXqxMX4lWqKhTBEGhz6fEL5esdX3tv1lNxhDIUqOlTx0m/b98bcCw/oqpOkcf
         6+zIXy5lk84ecRX0popVtEzjXJBNjeZGTs1CW8GrkM2G9Dfj+YbYSDsE+4qNDXmJGbai
         iEmh9MVR8Ye0WTJB1mFgOqJXM3LPdF9DYpynmlq5njzEDRYHD2DMR3jP71I+fd+Zrepl
         IeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713549459; x=1714154259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8jv7DlUuWmwKBFAeDpE74984/WTEdS+lAt5ksO5mUc=;
        b=kio/cpTpn8NgMa6vWvVQeBHXpOSgp1f2v023he4Q8gtaKeXlq3r/kQH1iC5XHP/NLg
         QA+hyJf1ta0ra4AttakC57Ir1bRuBnfIgW+4pNWQrUTxJWQXPcnGZKShHt2GlS1Au098
         IaNf6CD3Jip095g4hpN7nI99yLPmTPED5hqSQFxdop4vJFbsPVCiZ9mj+j9VGCJFs3gH
         I6tGyezQIsQ5aKz7GW2ZrMT2SLCAzqJI2A8gPVcXNAjbjIUfZhQ43n/Oq12kzdpsjElr
         uflNFKs4fCDns8DNCFCpSYW394isok81+MOpE8hTmL8J3rJ2TFRz3LCzbaQJ8K4psKx4
         JeCA==
X-Forwarded-Encrypted: i=1; AJvYcCXlFYE+j87xGlQypIYGg2TuQwJjkQlOJKps9sq49pdxdWqC4xOIdZrbT7KURP9EMg2yAaTrBdkgbYutInGqFdevvzwv4Up6fmMWtgWIM4DPjOa9x1A78hBS+VvcpK0Otff013JfvTS8SJ2QXSGQJN+JQX4d9iKtxkC3QUhAkDSXcgDc+4uL
X-Gm-Message-State: AOJu0YxmTWeIOqCEsM+0xJbwU9ZQ9zpnWbhwoDfcCnm0JIdyJGT2J+Zs
	FZzjTF4Q2v9stnv1NZimJ/egoAnCsbDv3Zqt9EA4qVlaMA+KpCTZs+L4Nw==
X-Google-Smtp-Source: AGHT+IF8suakDMO3Xv4gfrfd+R0Kl8qG0Bk8QH9pxx2ndjDtkxg7LRPn+7a/YXWo5BezN6B4QexQBg==
X-Received: by 2002:a05:6512:314e:b0:518:6d2:2a8f with SMTP id s14-20020a056512314e00b0051806d22a8fmr1628805lfi.24.1713549459060;
        Fri, 19 Apr 2024 10:57:39 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id l29-20020ac2555d000000b0051929ed7b08sm794139lfk.140.2024.04.19.10.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 10:57:38 -0700 (PDT)
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
Subject: [PATCH v2 6/6] dmaengine: dw: Unify ret-val local variables naming
Date: Fri, 19 Apr 2024 20:56:48 +0300
Message-ID: <20240419175655.25547-7-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240419175655.25547-1-fancer.lancer@gmail.com>
References: <20240419175655.25547-1-fancer.lancer@gmail.com>
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


