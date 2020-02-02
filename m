Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6012214FFAF
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2020 23:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgBBWaZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 17:30:25 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34083 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgBBWaF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Feb 2020 17:30:05 -0500
Received: by mail-lf1-f65.google.com with SMTP id l18so8393191lfc.1;
        Sun, 02 Feb 2020 14:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2j5TnyT9E2pH02me679r+cBH2fO12rifIiKw/FrWAIE=;
        b=V8u+C3G7q8darhXwMIRPufo6v+Tj0VNbio4D7IK9SF/JYya3dxlpIxfKvEKOoz8gMy
         E55uweydS/IisDJW93zATrVOVxCsV5xRgywCJZ8mLE0qyrXV8LciF6k85M6sxcrxtcv+
         Yz2mPXzR24UfAFLIry1WZNTtPk7wz/BlPhIJHfOrHjxwWUY5UDyf9U1BE+tDhiEv2l8d
         ryTcA1G95LRUNKscyp+Gw0BfZ5tRc1fKvclXKG75H7Kr1+sX1KNTngyMEBi4PJemEVy8
         8tzR84xs0JIzLTefaJo83lJvmy2qSHSdWf1OJWbRPxJT64Ckhm2XnLO5AVcKTImJ2Hsp
         3iCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2j5TnyT9E2pH02me679r+cBH2fO12rifIiKw/FrWAIE=;
        b=gEPubZocX/zQ1CEY6NTLjkXJf8YbZ/VrdLKm5ElQAKCUaMixORRjg7xQfw7pbiLx7S
         BG4f86tu3FxaZDCPXmyAQnMFPx7heVHO3ys5QBxrvpYwdLJ8CTktMFNBULtmwFCBPgk3
         IUt3fPZIvwNwCkmLochXPLYlMnpg/LTw/luWvvh/hJm2OMzD3r0iHM9b4P6mfxBuWJtT
         BK5McUJA7ADysn2ojGQF9AXiggLZv+s56IoNUi3m2tQTemzPvYQlLWo1r1feH3KMpxgA
         o5NGsPILQibakMWTKOgjAM5zdeIrCdypGwadFC4kMxdL2Aj2V9JTBnicOQ/ds8Q+EX2i
         fQ7Q==
X-Gm-Message-State: APjAAAUQSXikMFQrIfZKsIIMkq04NKucNMHvMX/VmOtA/tzixpKJpDyW
        b1ryLyTkJrdM1OCfIza2q10=
X-Google-Smtp-Source: APXvYqwqpxUNS2YFG5IKr+6dcq70/wQ4n9hWJcxzkKqBKvQG4veHeFgQfiBCqxn6sei1HBIFCGKfDA==
X-Received: by 2002:ac2:555c:: with SMTP id l28mr10401780lfk.52.1580682602769;
        Sun, 02 Feb 2020 14:30:02 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id b190sm8050307lfd.39.2020.02.02.14.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:30:02 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 15/19] dmaengine: tegra-apb: Clean up suspend-resume
Date:   Mon,  3 Feb 2020 01:28:50 +0300
Message-Id: <20200202222854.18409-16-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202222854.18409-1-digetx@gmail.com>
References: <20200202222854.18409-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It is enough to check whether hardware is busy on suspend and to reset
it across of suspend-resume because:

  1. Channel's configuration is fully re-programmed on each DMA
     transfer anyways.

  2. Context save-restore of an active channel won't end up well without
     pausing transfer prior to the context's saving, but note that every
     channel shall be idling at the time of suspend, so save-restore is
     not needed at all.

  3. The only case where context save-restore may be useful is when
     channel is in a paused state during suspend. But channel's pausing
     could be supported only on Tegra114+ and this functionality wasn't
     implemented by the driver for years now because there is no need for
     it in upstream kernel.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 136 +++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 67 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 92535b962e64..db726e635048 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -221,9 +221,6 @@ struct tegra_dma {
 	 */
 	u32				global_pause_count;
 
-	/* Some register need to be cache before suspend */
-	u32				reg_gen;
-
 	/* Last member of the structure */
 	struct tegra_dma_channel channels[0];
 };
@@ -1389,6 +1386,36 @@ static const struct tegra_dma_chip_data tegra148_dma_chip_data = {
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
@@ -1430,25 +1457,13 @@ static int tegra_dma_probe(struct platform_device *pdev)
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
@@ -1546,6 +1561,8 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
+
+err_clk_unprepare:
 	clk_unprepare(tdma->dma_clk);
 
 	return ret;
@@ -1565,26 +1582,6 @@ static int tegra_dma_remove(struct platform_device *pdev)
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
 
@@ -1594,46 +1591,51 @@ static int tegra_dma_runtime_suspend(struct device *dev)
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

