Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA6F138775
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jan 2020 18:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbgALRcG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Jan 2020 12:32:06 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42255 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733181AbgALRbl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Jan 2020 12:31:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so5143165lfl.9;
        Sun, 12 Jan 2020 09:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hP6SWGBrH3rl2FCQVrqhJx1xeutc1Bk8aKbd+Ff6RwI=;
        b=ITKybEv1+OYMi4vf5MY2izQ8qFZzQ/0JQOAfPReknecvap6sAqT3vRjrsBzsvj/II0
         OxIdqONU+jLgycxO5bzoZqTxP21gyw8imfbzbgdZVASQuCv6GERPin5sLoJ1JYfy9zVq
         u3N+tmnMg+6zbSLIrGgHeXuLXJHEI0tUVdzmPox5QIevyAsHJ9UWI2i/BOuZB4oJYrmG
         IoJ+labmiOrZtUuigDDXnN41gvocRgDO5SY/OeWyjrXL7V6x1ytFKFg1HI+mSGeVhpjU
         bi6a+3QDrprdR5pHMjE8nMuSXk0As9PV/siVenMufIFdhyHauhlWOkGMKdOJHQBaNSo3
         KXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hP6SWGBrH3rl2FCQVrqhJx1xeutc1Bk8aKbd+Ff6RwI=;
        b=IYEJ0UBFXEpU7QJwPaJckRhpzlOGDThSN3wxj+5Nh5Kd9cUJATmuH+cycIrRIFSwid
         nkWvYDPSmiYf0oXatfkcKUz+B8NV7sdAdUUijmRlShFMqGsl2yNxDCWJS0wP4kvHhCIf
         Dk8vnvlOV/muNKPaqk+KQXe92MF3wkiGiLxW6TqW2f8ifLMaMOKt43hZOVSySk+ynJ2t
         /L/zSxyLRoDWevcwAWWQbwGJpDH0iBWczR2cvYSbkj5TSd/jQ5KrTgsFxH6aQoE3zEue
         oiJG9VWj5a77lORko88WPhXutJIjoqbSm5kdd3FgukpEbkUiasHKEWFhTuJmpX0Wg3l1
         Vokw==
X-Gm-Message-State: APjAAAWR0ji2da8jxDHHLR367w35T30eUqmIL7PbbSSVmRYp99yQQl3Y
        JUFmC5BL1hjsXdX0/Vij3lo=
X-Google-Smtp-Source: APXvYqxI8HEqTA+Q5aa+7pgwN5jbKuySr1LKoNjZorR7At1ZdT2HYN+M3lQhD7RUbPlJeZnQFXA/yg==
X-Received: by 2002:a19:c648:: with SMTP id w69mr7571785lff.44.1578850298922;
        Sun, 12 Jan 2020 09:31:38 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id 140sm4458888lfk.78.2020.01.12.09.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:31:38 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/14] dmaengine: tegra-apb: Clean up suspend-resume
Date:   Sun, 12 Jan 2020 20:30:03 +0300
Message-Id: <20200112173006.29863-12-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200112173006.29863-1-digetx@gmail.com>
References: <20200112173006.29863-1-digetx@gmail.com>
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
 drivers/dma/tegra20-apb-dma.c | 131 +++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 64 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index b9d8e57eaf54..398a0e1d6506 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1392,6 +1392,36 @@ static const struct tegra_dma_chip_data tegra148_dma_chip_data = {
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
@@ -1433,30 +1463,18 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = tegra_dma_init_hw(tdma);
+	if (ret)
+		goto err_clk_unprepare;
+
 	pm_runtime_irq_safe(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = tegra_dma_runtime_resume(&pdev->dev);
 		if (ret)
 			goto err_clk_unprepare;
-	} else {
-		ret = pm_runtime_get_sync(&pdev->dev);
-		if (ret < 0)
-			goto err_pm_disable;
 	}
 
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
@@ -1583,26 +1601,6 @@ static int tegra_dma_remove(struct platform_device *pdev)
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
 
@@ -1612,46 +1610,51 @@ static int tegra_dma_runtime_suspend(struct device *dev)
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
+		spin_lock_irqsave(&tdc->lock, flags);
+		busy = tdc->busy;
+		spin_unlock_irqrestore(&tdc->lock, flags);
+
+		if (busy) {
+			dev_err(tdma->dev, "channel %u busy\n", i);
+			return -EBUSY;
+		}
+
+		tasklet_kill(&tdc->tasklet);
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

