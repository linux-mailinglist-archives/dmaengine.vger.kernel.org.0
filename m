Return-Path: <dmaengine+bounces-6973-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F853C035CF
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 22:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA2CD504F5B
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 20:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA072D027F;
	Thu, 23 Oct 2025 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6TFqteg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3532C2349
	for <dmaengine@vger.kernel.org>; Thu, 23 Oct 2025 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250915; cv=none; b=YEHwJpIWPRGkpNidcb2pdlo0Rd9IKSNrB71GyabHnT2wy4+DfB02GfETA6Mft4gJvSJX1soCORmuzDvYPJxikBwQmkfN5/V7zDxVtHlf0/BhFvqFVjvS9yNTIuk95re1/2Yp9OSwdYWKHkSdygEBWrdo+nQrAZaCJBcklVlRl7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250915; c=relaxed/simple;
	bh=ZshlhFU+130KpNZl7SbxKIZLMlFg+UY+PEn/qv5bpYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sV3jdTG33AJ0dnSJriKvmGIeQLU4VOFb6EMHKzPLmwqXIwSSNcvFtGuvtpWunNNVaPiGV0NLImaDls2YjloDj7WwyQ750g/st3uzY577fIftL55XgpK3oPLwl+lQrMBMQsY4I02pI23xPXW5aR9nsD5ACe+0AqmzEDteeliIR1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6TFqteg; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-592eead6f94so1479173e87.0
        for <dmaengine@vger.kernel.org>; Thu, 23 Oct 2025 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761250911; x=1761855711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQXoHBuAfOI4QMAsJ0wqP6b/BYbUIIdTmKEZ+WCDuV0=;
        b=k6TFqtegl6mewOFWDXQNIr/FB8MnoWzfonAzFW/ZzWwhj7NIkJGyh5gQ4ECQWPpdvW
         qdUv1e6zgBWkt9rjztq4Lg8ZvMO49laxcUKcRt336w8Rbs5z4NRFFOXKzbdGSb3sZpcZ
         u8N/rYzfWc3XekffYNC6k74R2HXQUdZnFOWFcrRM7eonD7ouKdCdpVst8brN6pDYwoyk
         3byhNXX1GucCEf4j2QBN8cQM9HUdDTRlnEBPqc4BO96Js6ejCM/We1Z6CwQzp7MxH9Lv
         rsPJjdtLUeMsJ845Z5xmlEE1Je+bEFuBKiu/98rHxJ4ZM7j/R653Fw09RPXp5B1iAy7x
         g/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250911; x=1761855711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQXoHBuAfOI4QMAsJ0wqP6b/BYbUIIdTmKEZ+WCDuV0=;
        b=B+ZEC99M++CKnORCjCYk66lXGfQ7oQCiehr5SNemnET6fiOr3silVVwcFsBesTAHLZ
         lYYVr/tX8zv9cYmN+igFBdr+jMPaXZm1mUc5h1rV6M3OLxO7xb2dgn8hlEID6k14Ga3h
         l33v/mIxlScxTpC9nZxRMlrkPrnUm5felFZUR2vJHr/VEXmRebXlNVUCiqOW4dfQO4D0
         Zn7tHhwbNmfEoob5p93I7LJWOD/DhbFdGxELDBTN5LTl/kaaSqISjbE5Y7zkSF6a7sY6
         gtdMpOzrMqOQFhWgF3ar0dO58YCwRcrc1IVVClqCRfAwu2urNdif/tGxbJLsvZWUMeX4
         ghmw==
X-Forwarded-Encrypted: i=1; AJvYcCWTc+iWvI78/LOfsSprmbZpcsb0L8M5ptCl6YYAapMl17Y2xTjTlrlg+5NyCuXpIO5XgI9AX/dLMwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0NnEAOd1iRTWWVLrodl7zWLfOQuPu6YlrSVfS2XKCeAsG/NRa
	qdK6TsI8k4OlQUXQVoXAvhugmLWEKLBnOdpfA1DaM/I1nW86UXK71Qty
X-Gm-Gg: ASbGnctaeH8Bngj9mNg+B+b6uAihreXaTa4yFXVz04yNtlvLk62mlUxGRYfoGdLd8U3
	46FNH3L/zw2HrrFUtngtTMGfLSeE47vq8PtW1cJRdb+87hzfmFITnjwVYxtlLB/+xggqNDZkYoM
	wWoapjf/5vi5tUu7qumlTypvIcF2vOZRRMOaVMjf1Ju0BMS1PDT7ziwZXxCSulB1zCOGNrSU4qS
	juSVRq6bXxQtjriEwHzOyBRkZTsM+GybwB0Q6Wo5qv1XWTVCKPJhQoeYYgChR59e/1DaITsxYeF
	9S8gESaBs6Sbo23gClFFHlEMkmrwJWZ1I4Slb6o1Yiyc2nJbZuKq6hMWJS/a3EKU2QaS5mL4Bf6
	Agzk5glLpL7Rx5RWfPdFiVeFahCt8e8bnKL8PQ+XjG2WZ9UXDImklMfwbzN4U7eyVRcWhimwz7V
	ZCsd1qvMM0DY/CA7j6LMv7Jj6Kjn//
X-Google-Smtp-Source: AGHT+IH/VHEFuO9PkUk4ZVAC793jcjVlbvfbJgFsOQrIqPJh2C4ri8F60HTj5mCSD/KGfO1spzuq5Q==
X-Received: by 2002:a05:6512:1546:20b0:592:ed2d:4cc4 with SMTP id 2adb3069b0e04-592ed2d4e6amr2305088e87.16.1761250911196;
        Thu, 23 Oct 2025 13:21:51 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d2cf30sm977522e87.97.2025.10.23.13.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:21:50 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: dan.carpenter@linaro.org,
	a.shimko.dev@gmail.com,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v5 2/3] dmaengine: dw-axi-dmac: add reset control support
Date: Thu, 23 Oct 2025 23:21:32 +0300
Message-ID: <20251023202134.1291034-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023202134.1291034-1-a.shimko.dev@gmail.com>
References: <20251023202134.1291034-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add proper reset control handling to the AXI DMA driver to ensure
reliable initialization and power management. The driver now manages
resets during probe, remove, and system suspend/resume operations.

The implementation stores reset control in the chip structure and adds
reset assert/deassert calls at the appropriate points: resets are
deasserted during probe after clock acquisition, asserted during remove
and error cleanup, and properly managed during suspend/resume cycles.
Additionally, proper error handling is implemented for reset control
operations to ensure robust behavior.

This ensures the controller is properly reset during power transitions
and prevents potential issues with incomplete initialization.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 59 +++++++++++++------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 8b7cf3baf5d3..1496c52f47a6 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1316,11 +1316,16 @@ static int dma_chan_resume(struct dma_chan *dchan)
 
 static int axi_dma_suspend(struct device *dev)
 {
+	int ret;
 	struct axi_dma_chip *chip = dev_get_drvdata(dev);
 
 	axi_dma_irq_disable(chip);
 	axi_dma_disable(chip);
 
+	ret = reset_control_assert(chip->resets);
+	if (ret)
+		dev_warn(dev, "Failed to assert resets, but continuing suspend\n");
+
 	clk_disable_unprepare(chip->core_clk);
 	clk_disable_unprepare(chip->cfgr_clk);
 
@@ -1338,12 +1343,23 @@ static int axi_dma_resume(struct device *dev)
 
 	ret = clk_prepare_enable(chip->core_clk);
 	if (ret < 0)
-		return ret;
+		goto cfgr_clk_disable;
+
+	ret = reset_control_deassert(chip->resets);
+	if (ret)
+		goto core_clk_disable;
 
 	axi_dma_enable(chip);
 	axi_dma_irq_enable(chip);
 
 	return 0;
+
+core_clk_disable:
+	clk_disable_unprepare(chip->core_clk);
+cfgr_clk_disable:
+	clk_disable_unprepare(chip->cfgr_clk);
+
+	return ret;
 }
 
 static struct dma_chan *dw_axi_dma_of_xlate(struct of_phandle_args *dma_spec,
@@ -1455,7 +1471,6 @@ static int dw_probe(struct platform_device *pdev)
 	struct axi_dma_chip *chip;
 	struct dw_axi_dma *dw;
 	struct dw_axi_dma_hcfg *hdata;
-	struct reset_control *resets;
 	unsigned int flags;
 	u32 i;
 	int ret;
@@ -1487,16 +1502,6 @@ static int dw_probe(struct platform_device *pdev)
 			return PTR_ERR(chip->apb_regs);
 	}
 
-	if (flags & AXI_DMA_FLAG_HAS_RESETS) {
-		resets = devm_reset_control_array_get_exclusive(&pdev->dev);
-		if (IS_ERR(resets))
-			return PTR_ERR(resets);
-
-		ret = reset_control_deassert(resets);
-		if (ret)
-			return ret;
-	}
-
 	chip->dw->hdata->use_cfg2 = !!(flags & AXI_DMA_FLAG_USE_CFG2);
 
 	chip->core_clk = devm_clk_get(chip->dev, "core-clk");
@@ -1507,18 +1512,28 @@ static int dw_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->cfgr_clk))
 		return PTR_ERR(chip->cfgr_clk);
 
+	chip->resets = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
+	if (IS_ERR(chip->resets))
+		return PTR_ERR(chip->resets);
+
+	ret = reset_control_deassert(chip->resets);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to deassert resets\n");
+
 	ret = parse_device_properties(chip);
 	if (ret)
-		return ret;
+		goto err_exit;
 
 	dw->chan = devm_kcalloc(chip->dev, hdata->nr_channels,
 				sizeof(*dw->chan), GFP_KERNEL);
-	if (!dw->chan)
-		return -ENOMEM;
+	if (!dw->chan) {
+		ret = -ENOMEM;
+		goto err_exit;
+	}
 
 	ret = axi_req_irqs(pdev, chip);
 	if (ret)
-		return ret;
+		goto err_exit;
 
 	INIT_LIST_HEAD(&dw->dma.channels);
 	for (i = 0; i < hdata->nr_channels; i++) {
@@ -1605,20 +1620,30 @@ static int dw_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(chip->dev);
+err_exit:
+	reset_control_assert(chip->resets);
 
 	return ret;
 }
 
 static void dw_remove(struct platform_device *pdev)
 {
+	int ret;
 	struct axi_dma_chip *chip = platform_get_drvdata(pdev);
 	struct dw_axi_dma *dw = chip->dw;
 	struct axi_dma_chan *chan, *_chan;
 	u32 i;
 
-	/* Enable clk before accessing to registers */
+	/*
+	 * The peripheral must be clocked and out of reset
+	 * before its registers can be accessed.
+	 */
 	clk_prepare_enable(chip->cfgr_clk);
 	clk_prepare_enable(chip->core_clk);
+	ret = reset_control_deassert(chip->resets);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to deassert resets\n");
+
 	axi_dma_irq_disable(chip);
 	for (i = 0; i < dw->hdata->nr_channels; i++) {
 		axi_chan_disable(&chip->dw->chan[i]);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index b842e6a8d90d..c74affb9f344 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -71,6 +71,7 @@ struct axi_dma_chip {
 	struct clk		*core_clk;
 	struct clk		*cfgr_clk;
 	struct dw_axi_dma	*dw;
+	struct reset_control	*resets;
 };
 
 /* LLI == Linked List Item */
-- 
2.43.0


