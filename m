Return-Path: <dmaengine+bounces-2778-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0BF945944
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 09:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B371B228F5
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 07:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169341C379C;
	Fri,  2 Aug 2024 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIZ2Xqyj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB31C3784;
	Fri,  2 Aug 2024 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585095; cv=none; b=NyFsPTnkQ0Ww4BD94BCsOlzQ+yAmMhiGPgWuUO7n56In5s8VzjOCgZPyElIZuwh5aLllVTdEApBW3MI6S8Us+8+50iuEjY8xFJ4iIPiciuOtOvPljPj76/B/6/7/3M6nWH1VxY2t5bBl2z0BpVj7koC6fK/5GKRySFJ4RNq1kn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585095; c=relaxed/simple;
	bh=fes4+PALn4aJD0RUIggf2YkD7O8aHh0ck1WvSCbST4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSGaXiYIOCS8w1tGPQ4bJ7WTc0EN7rFwajjOupQ9nzCsrB0IG5ZxHDbTg301H3yOpujQS6VfVNbQbXfBX8vVDcJqS+Wap7YtdYc/PpxkvUR5x4xYjdVYgYc71Z/rf6Xs2C1ckWhKQu+tXNbePMHSlbra2XMsAzjDjXDeQ6Sg3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIZ2Xqyj; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52fc4388a64so13002528e87.1;
        Fri, 02 Aug 2024 00:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722585091; x=1723189891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHiD9v1JsXXcE41UkTPqhgsLCw9iYgVEo+i0Dc9T+lk=;
        b=HIZ2XqyjBcrLbc3nMyw1EC1Tw5HxCaJzM8M4wKpyE/nFWZ6/70UDRog+90VYyRV0fS
         MBlsdzk+Ebo9af+5ElX6TbdHmecK34Zm7BxYhkShyJIe8Sdyfcs/6apgXoOBTKifrOL9
         1Sdp3quPw6DXVu+hzWuCikO6azgjRE0n/tsV/glbCQYTBL4Uh+NUYMYgXg4IH7yQCYKZ
         Ba3hSEWHNHYk28GFoCqaKE5BuNmexjiQHEMce7GWFK4UFqyE4TeXg23KCqIamrm/vQMA
         /S/aCxsH8KF0ciHtq0wiugbuxAYHv9Ea7jjzp5OTaa6hEyiJ4LN33CzJQDWPwnyLZyAz
         mKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585091; x=1723189891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHiD9v1JsXXcE41UkTPqhgsLCw9iYgVEo+i0Dc9T+lk=;
        b=sxQki1E9Tw9oFcqoZl2MvR77lMw8pAnDTJ3AdbhEWW/w/aI2Nh4O/hRAh1rpiLk8XL
         cXJQulwkJwaP6sOt4dUbFJ8s2xnbwgPACyqtV7cNrjQEyxphERZuxIg4dGIiUuHsAF3/
         OR5RW5CKnaCp+G8wauy8gp+0y9x4A0ZiSab42RvpFbOrvEZGE6RlFME2241ADxPQsZSB
         D9o8A9Dz1DzBE82jq9pJc4kYI/Zj7mQN0HAb620Wsvs+XnH5FBcbYzdXsLo5SCAlJUBk
         ROBPAr/7qc7dGdRiwt6gYoHSiF69yPW91/QgAkCzXJxvTWgaxEBRNWtaEpetjrkvtR0i
         Ouuw==
X-Forwarded-Encrypted: i=1; AJvYcCVj7uTfP1h+cwlj2Uip54oCsrWJI67LX0vV3x4ZD8TPW3pFiaNwDglYI1zRkeCWveuUdloQ3G/pY88vOJNpFLbP6mguhim93qfr8qsw56OUhvbbg4I9VbkXUF87gmmfYzgUzmE8050uUAiePl45Gbz+fTZ5SHLbzSwOdgFB7gS/MKP9QB4W
X-Gm-Message-State: AOJu0YzxrzS+VBenR4cC84ISANeX6wsIe1aIMstw6Y7apsxhi3+ktIvG
	qgYIDgFMd/0wf9f1sVTIjqDSwJs//+MK1hrvq0QUpUbnxOACKaAB
X-Google-Smtp-Source: AGHT+IEMxf4N4s3xFraxbRmN9YP31vVSJKb9vVw4lnrxgYP2s4t4P5fTafWSGlWROhVsyRlaGnRdOA==
X-Received: by 2002:a05:6512:685:b0:52f:c2fa:b213 with SMTP id 2adb3069b0e04-530bb3b1210mr1771229e87.55.1722585091141;
        Fri, 02 Aug 2024 00:51:31 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba29fd9sm158725e87.122.2024.08.02.00.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 00:51:30 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 6/6] dmaengine: dw: Unify ret-val local variables naming
Date: Fri,  2 Aug 2024 10:50:51 +0300
Message-ID: <20240802075100.6475-7-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802075100.6475-1-fancer.lancer@gmail.com>
References: <20240802075100.6475-1-fancer.lancer@gmail.com>
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
index c696d79b911a..602f1208ab9b 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -1149,7 +1149,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	bool			autocfg = false;
 	unsigned int		dw_params;
 	unsigned int		i;
-	int			err;
+	int			ret;
 
 	dw->pdata = devm_kzalloc(chip->dev, sizeof(*dw->pdata), GFP_KERNEL);
 	if (!dw->pdata)
@@ -1165,7 +1165,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 
 		autocfg = dw_params >> DW_PARAMS_EN & 1;
 		if (!autocfg) {
-			err = -EINVAL;
+			ret = -EINVAL;
 			goto err_pdata;
 		}
 
@@ -1185,7 +1185,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 		pdata->chan_allocation_order = CHAN_ALLOCATION_ASCENDING;
 		pdata->chan_priority = CHAN_PRIORITY_ASCENDING;
 	} else if (chip->pdata->nr_channels > DW_DMA_MAX_NR_CHANNELS) {
-		err = -EINVAL;
+		ret = -EINVAL;
 		goto err_pdata;
 	} else {
 		memcpy(dw->pdata, chip->pdata, sizeof(*dw->pdata));
@@ -1197,7 +1197,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	dw->chan = devm_kcalloc(chip->dev, pdata->nr_channels, sizeof(*dw->chan),
 				GFP_KERNEL);
 	if (!dw->chan) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto err_pdata;
 	}
 
@@ -1215,15 +1215,15 @@ int do_dma_probe(struct dw_dma_chip *chip)
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
@@ -1335,8 +1335,8 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	 */
 	dma_set_max_seg_size(dw->dma.dev, dw->chan[0].block_size);
 
-	err = dma_async_device_register(&dw->dma);
-	if (err)
+	ret = dma_async_device_register(&dw->dma);
+	if (ret)
 		goto err_dma_register;
 
 	dev_info(chip->dev, "DesignWare DMA Controller, %d channels\n",
@@ -1350,7 +1350,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
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


