Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC4514D5B7
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 05:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgA3Elb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 23:41:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38229 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbgA3El2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 23:41:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so2336566wrh.5;
        Wed, 29 Jan 2020 20:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qyH+MurQ1K+JP11j8j9cz8CEs+bqnCzxDejqE3pavzg=;
        b=Qw333kJFTK1oxKsVczg/lLKzEkJrRVhq5Vr8Dnih+UsOimBvxjFlyOMlklhcUtZkuM
         BNXzyZfYZDqTCEnTLxE2GBKv+OvEMWvCZgKx2uoPG8bQ7C2tHVlb+02m/GqPNtZPXOQ6
         DMnF5AZXG1bE0nrK+xnCwpfio8Cs3BlnIr6s1+Htq5WmHt1+qvNxP82zq4SX+uwvx/9a
         lmPKctsBpJKm0DP+gVfPat9gSthpkPGcib6o5FQPnYZSaPezjNTKrs5H1XGj1Ysm+8zw
         6tSXkRb7eWs56/8CK3R55GHzG+Gv3J6/S6z1U98Z+srrZsNpk0AWCzAY21bPevqh60jy
         2b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qyH+MurQ1K+JP11j8j9cz8CEs+bqnCzxDejqE3pavzg=;
        b=MtpdNv9fN/FqA6RwafhrYi4lQlxklTBIF/mcui8+b6FsdXvHSi7Jp0yipPRk+5CPAr
         63tHMPI8KInD1oPlFhnHTbhDUOKCtSkRZb0xUNYXalHAjzFfDvrcq96CbVGYUJow1U5t
         HxoHKKzU1LIWKEuwgoTKmcWvsBHV1QlOgdPsUE0ioKz5WUiEgwW+adD7PZDONSpnTVaP
         Yz0ZuzGWv/WBT4EcJL9UvXfiQTfztQ/Dh1Wy997e7CxB9Dn7n3H9wj6YaefKZ2u+tM/Z
         8Dv4m8hLojSykHzimWZQu+LMJLjOw7wrSyocIc4eJdpWvjroPkrXgn5mT5hMszZYbbvH
         hESw==
X-Gm-Message-State: APjAAAV1zq0JJPSXOLVLGt6SR06KdOAxSJGKk0ndPiyryCgi1bof9FVG
        fXBn93J3DGt/Q1nBNYPtSdo=
X-Google-Smtp-Source: APXvYqwIyo92HOte7rKM/wRElv9qg2CZPcLHS9Y3nCkppB7tundhUJKistbvUEhgNwmWOdHy0vtmdg==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr2679521wru.353.1580359285563;
        Wed, 29 Jan 2020 20:41:25 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g128sm4494672wme.47.2020.01.29.20.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 20:41:25 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/16] dmaengine: tegra-apb: Clean up suspend-resume
Date:   Thu, 30 Jan 2020 07:38:00 +0300
Message-Id: <20200130043804.32243-13-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130043804.32243-1-digetx@gmail.com>
References: <20200130043804.32243-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It is enough to check whether hardware is busy on suspend and to reset
it across of suspend-resume because channel's configuration is fully
re-programmed on each DMA transaction anyways and because save-restore
of an active channel won't end up well without pausing transfer prior to
saving of the state (note that all channels shall be idling at the time of
suspend, so save-restore is not needed at all).

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 133 ++++++++++++++++++----------------
 1 file changed, 69 insertions(+), 64 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 0ee28d8e3c96..4a371891b7c4 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1401,6 +1401,36 @@ static const struct tegra_dma_chip_data tegra148_dma_chip_data = {
 	.support_separate_wcount_reg = true,
 };
 
+static int tegra_dma_init_hw(struct tegra_dma *tdma)
+{
+	int err;
+
+	err = reset_control_assert(tdma->rst);
+	if (err) {
+		dev_err(tdma->dev, "failed to assert reset: %d\n", err);
+		return err;
+	}
+
+	err = clk_enable(tdma->dma_clk);
+	if (err) {
+		dev_err(tdma->dev, "failed to enable clk: %d\n", err);
+		return err;
+	}
+
+	/* reset DMA controller */
+	udelay(2);
+	reset_control_deassert(tdma->rst);
+
+	/* enable global DMA registers */
+	tdma_write(tdma, TEGRA_APBDMA_GENERAL, TEGRA_APBDMA_GENERAL_ENABLE);
+	tdma_write(tdma, TEGRA_APBDMA_CONTROL, 0);
+	tdma_write(tdma, TEGRA_APBDMA_IRQ_MASK_SET, 0xFFFFFFFF);
+
+	clk_disable(tdma->dma_clk);
+
+	return 0;
+}
+
 static int tegra_dma_probe(struct platform_device *pdev)
 {
 	const struct tegra_dma_chip_data *cdata;
@@ -1442,25 +1472,13 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = tegra_dma_init_hw(tdma);
+	if (ret)
+		goto err_clk_unprepare;
+
 	pm_runtime_irq_safe(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
-		goto err_pm_disable;
-
-	/* Reset DMA controller */
-	reset_control_assert(tdma->rst);
-	udelay(2);
-	reset_control_deassert(tdma->rst);
-
-	/* Enable global DMA registers */
-	tdma_write(tdma, TEGRA_APBDMA_GENERAL, TEGRA_APBDMA_GENERAL_ENABLE);
-	tdma_write(tdma, TEGRA_APBDMA_CONTROL, 0);
-	tdma_write(tdma, TEGRA_APBDMA_IRQ_MASK_SET, 0xFFFFFFFFul);
-
-	pm_runtime_put(&pdev->dev);
-
 	INIT_LIST_HEAD(&tdma->dma_dev.channels);
 	for (i = 0; i < cdata->nr_channels; i++) {
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
@@ -1558,6 +1576,8 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
+
+err_clk_unprepare:
 	clk_unprepare(tdma->dma_clk);
 
 	return ret;
@@ -1577,26 +1597,6 @@ static int tegra_dma_remove(struct platform_device *pdev)
 static int tegra_dma_runtime_suspend(struct device *dev)
 {
 	struct tegra_dma *tdma = dev_get_drvdata(dev);
-	unsigned int i;
-
-	tdma->reg_gen = tdma_read(tdma, TEGRA_APBDMA_GENERAL);
-	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
-		struct tegra_dma_channel *tdc = &tdma->channels[i];
-		struct tegra_dma_channel_regs *ch_reg = &tdc->channel_reg;
-
-		/* Only save the state of DMA channels that are in use */
-		if (!tdc->config_init)
-			continue;
-
-		ch_reg->csr = tdc_read(tdc, TEGRA_APBDMA_CHAN_CSR);
-		ch_reg->ahb_ptr = tdc_read(tdc, TEGRA_APBDMA_CHAN_AHBPTR);
-		ch_reg->apb_ptr = tdc_read(tdc, TEGRA_APBDMA_CHAN_APBPTR);
-		ch_reg->ahb_seq = tdc_read(tdc, TEGRA_APBDMA_CHAN_AHBSEQ);
-		ch_reg->apb_seq = tdc_read(tdc, TEGRA_APBDMA_CHAN_APBSEQ);
-		if (tdma->chip_data->support_separate_wcount_reg)
-			ch_reg->wcount = tdc_read(tdc,
-						  TEGRA_APBDMA_CHAN_WCOUNT);
-	}
 
 	clk_disable(tdma->dma_clk);
 
@@ -1606,46 +1606,51 @@ static int tegra_dma_runtime_suspend(struct device *dev)
 static int tegra_dma_runtime_resume(struct device *dev)
 {
 	struct tegra_dma *tdma = dev_get_drvdata(dev);
-	unsigned int i;
-	int ret;
 
-	ret = clk_enable(tdma->dma_clk);
-	if (ret < 0) {
-		dev_err(dev, "clk_enable failed: %d\n", ret);
-		return ret;
-	}
+	return clk_enable(tdma->dma_clk);
+}
 
-	tdma_write(tdma, TEGRA_APBDMA_GENERAL, tdma->reg_gen);
-	tdma_write(tdma, TEGRA_APBDMA_CONTROL, 0);
-	tdma_write(tdma, TEGRA_APBDMA_IRQ_MASK_SET, 0xFFFFFFFFul);
+static int __maybe_unused tegra_dma_dev_suspend(struct device *dev)
+{
+	struct tegra_dma *tdma = dev_get_drvdata(dev);
+	unsigned long flags;
+	unsigned int i;
+	bool busy;
 
 	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
-		struct tegra_dma_channel_regs *ch_reg = &tdc->channel_reg;
-
-		/* Only restore the state of DMA channels that are in use */
-		if (!tdc->config_init)
-			continue;
-
-		if (tdma->chip_data->support_separate_wcount_reg)
-			tdc_write(tdc, TEGRA_APBDMA_CHAN_WCOUNT,
-				  ch_reg->wcount);
-		tdc_write(tdc, TEGRA_APBDMA_CHAN_APBSEQ, ch_reg->apb_seq);
-		tdc_write(tdc, TEGRA_APBDMA_CHAN_APBPTR, ch_reg->apb_ptr);
-		tdc_write(tdc, TEGRA_APBDMA_CHAN_AHBSEQ, ch_reg->ahb_seq);
-		tdc_write(tdc, TEGRA_APBDMA_CHAN_AHBPTR, ch_reg->ahb_ptr);
-		tdc_write(tdc, TEGRA_APBDMA_CHAN_CSR,
-			  ch_reg->csr & ~TEGRA_APBDMA_CSR_ENB);
+
+		tasklet_kill(&tdc->tasklet);
+
+		spin_lock_irqsave(&tdc->lock, flags);
+		busy = tdc->busy;
+		spin_unlock_irqrestore(&tdc->lock, flags);
+
+		if (busy) {
+			dev_err(tdma->dev, "channel %u busy\n", i);
+			return -EBUSY;
+		}
 	}
 
-	return 0;
+	return pm_runtime_force_suspend(dev);
+}
+
+static int __maybe_unused tegra_dma_dev_resume(struct device *dev)
+{
+	struct tegra_dma *tdma = dev_get_drvdata(dev);
+	int err;
+
+	err = tegra_dma_init_hw(tdma);
+	if (err)
+		return err;
+
+	return pm_runtime_force_resume(dev);
 }
 
 static const struct dev_pm_ops tegra_dma_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra_dma_runtime_suspend, tegra_dma_runtime_resume,
 			   NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(tegra_dma_dev_suspend, tegra_dma_dev_resume)
 };
 
 static const struct of_device_id tegra_dma_of_match[] = {
-- 
2.24.0

