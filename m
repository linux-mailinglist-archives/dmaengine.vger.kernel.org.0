Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E59130B55
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jan 2020 02:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgAFBRf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 5 Jan 2020 20:17:35 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42974 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgAFBRd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 5 Jan 2020 20:17:33 -0500
Received: by mail-lf1-f66.google.com with SMTP id y19so35292831lfl.9;
        Sun, 05 Jan 2020 17:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4vbxLY/XQdiocivNYtPxd9tQFRfFjTO1i/Gv+RTsgM=;
        b=Ofx3h1kMb4BOniKSIgNLG6DkIC9wDikdatdiieQ/CBcyUK31Bam+7TK9cZBI9pK+eg
         tSkK5iPB8lsafTprzrW1Q9/btZY6gLTBcaFT31DsixllAft4OcDeefs3fTbl2FOrkHj5
         Tfe95l8OtHqiYTREaiQ4UnsWSkmfmHapTQAPLPptH+bq74PeCeOH4kG8lrxlf8lVmKKB
         aAR23DHThmbNqAGFF0cbX0P9TNR6VfjgOdGKe9lVVN0Z2V4YHiBelcjyXc9J+pGhvtT2
         Wfi9c5kNOfJf43N/VG7lERTb4bWpHZDkvlujwgZWfRBpV7WQ/jPFIVAHQT/pGVjxoanI
         RXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4vbxLY/XQdiocivNYtPxd9tQFRfFjTO1i/Gv+RTsgM=;
        b=XJBQkiL3V2KyEtGiKIdgxqn5+L06Y+gZEC0nXPdji33JXpKwRBMKsmWUaOrYmTPB7X
         HAaWikD9fOCj4BXlUEW1J69qPJLiRn6vSt765r8DYfMEvp4ktHETKMqB9uR0wVcUTQLU
         1E22kQuouhKmaqPp05du3PlED5jC1ObEB8S0zrbkNYVlIQYtQGSfx1ezNA/TOTFNCSK2
         cfJBZqt+27uYiFkrD7aOZUbqstyTyZ0eF8RTpSlUm9tVHJqar/ahSg2maA8vLAD4AbXD
         MPPU7R8VyhaB/7OEaWcmhB59r19fMwb82vQuK3C1YC9Ui0w7YdA4c2ZBXCQgOF+BA16U
         fPyw==
X-Gm-Message-State: APjAAAUb+jXtSoGFppoJ+dIB4W4hno+OT4tkV+BcUwLWUbCP1xGWhdf4
        PNFlJKuM/J3Jr++OqA+/wmk=
X-Google-Smtp-Source: APXvYqyFLPWKafsZWNv1+8FEFNvuYJMnKuOoR7/zXOgA6uXiMQzIdyNd1gYEIogqC7uR4ACnf8EiAQ==
X-Received: by 2002:a19:f514:: with SMTP id j20mr51152852lfb.31.1578273450295;
        Sun, 05 Jan 2020 17:17:30 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y14sm28353271ljk.46.2020.01.05.17.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:17:29 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/13] dmaengine: tegra-apb: Clean up suspend-resume
Date:   Mon,  6 Jan 2020 04:17:05 +0300
Message-Id: <20200106011708.7463-11-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106011708.7463-1-digetx@gmail.com>
References: <20200106011708.7463-1-digetx@gmail.com>
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
 drivers/dma/tegra20-apb-dma.c | 122 +++++++++++++++-------------------
 1 file changed, 55 insertions(+), 67 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 840a58e782ec..a75d2dd850c7 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -220,9 +220,6 @@ struct tegra_dma {
 	 */
 	u32				global_pause_count;
 
-	/* Some register need to be cache before suspend */
-	u32				reg_gen;
-
 	/* Last member of the structure */
 	struct tegra_dma_channel channels[0];
 };
@@ -1380,6 +1377,40 @@ static const struct tegra_dma_chip_data tegra148_dma_chip_data = {
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
+	err = clk_prepare_enable(tdma->dma_clk);
+	if (err) {
+		dev_err(tdma->dev, "failed to enable clk: %d\n", err);
+		return err;
+	}
+
+	/* Reset DMA controller */
+	udelay(2);
+	reset_control_deassert(tdma->rst);
+
+	/* Enable global DMA registers */
+	tdma_write(tdma, TEGRA_APBDMA_GENERAL, TEGRA_APBDMA_GENERAL_ENABLE);
+	tdma_write(tdma, TEGRA_APBDMA_CONTROL, 0);
+	tdma_write(tdma, TEGRA_APBDMA_IRQ_MASK_SET, 0xFFFFFFFF);
+
+	return 0;
+}
+
+static void tegra_dma_deinit_hw(struct tegra_dma *tdma)
+{
+	reset_control_reset(tdma->rst);
+	clk_disable_unprepare(tdma->dma_clk);
+}
+
 static int tegra_dma_probe(struct platform_device *pdev)
 {
 	const struct tegra_dma_chip_data *cdata;
@@ -1460,19 +1491,9 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		INIT_LIST_HEAD(&tdc->cb_desc);
 	}
 
-	ret = clk_prepare_enable(tdma->dma_clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "clk_enable failed: %d\n", ret);
+	ret = tegra_dma_init_hw(tdma);
+	if (ret)
 		return ret;
-	}
-
-	/* Reset DMA controller */
-	reset_control_reset(tdma->rst);
-
-	/* Enable global DMA registers */
-	tdma_write(tdma, TEGRA_APBDMA_GENERAL, TEGRA_APBDMA_GENERAL_ENABLE);
-	tdma_write(tdma, TEGRA_APBDMA_CONTROL, 0);
-	tdma_write(tdma, TEGRA_APBDMA_IRQ_MASK_SET, 0xFFFFFFFFul);
 
 	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
 	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
@@ -1506,7 +1527,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev,
 			"Tegra20 APB DMA driver registration failed %d\n", ret);
-		goto err_clk_disable;
+		goto err_deinit_hw;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node,
@@ -1525,8 +1546,8 @@ static int tegra_dma_probe(struct platform_device *pdev)
 err_unregister_dma_dev:
 	dma_async_device_unregister(&tdma->dma_dev);
 
-err_clk_disable:
-	clk_disable_unprepare(tdma->dma_clk);
+err_deinit_hw:
+	tegra_dma_deinit_hw(tdma);
 
 	return ret;
 }
@@ -1536,7 +1557,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
 	struct tegra_dma *tdma = platform_get_drvdata(pdev);
 
 	dma_async_device_unregister(&tdma->dma_dev);
-	clk_disable_unprepare(tdma->dma_clk);
+	tegra_dma_deinit_hw(tdma);
 
 	return 0;
 }
@@ -1544,28 +1565,26 @@ static int tegra_dma_remove(struct platform_device *pdev)
 static int __maybe_unused tegra_dma_dev_suspend(struct device *dev)
 {
 	struct tegra_dma *tdma = dev_get_drvdata(dev);
+	unsigned long flags;
 	unsigned int i;
+	bool busy;
 
-	tdma->reg_gen = tdma_read(tdma, TEGRA_APBDMA_GENERAL);
 	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
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
 
-	clk_disable_unprepare(tdma->dma_clk);
+	tegra_dma_deinit_hw(tdma);
 
 	return 0;
 }
@@ -1573,39 +1592,8 @@ static int __maybe_unused tegra_dma_dev_suspend(struct device *dev)
 static int __maybe_unused tegra_dma_dev_resume(struct device *dev)
 {
 	struct tegra_dma *tdma = dev_get_drvdata(dev);
-	unsigned int i;
-	int ret;
 
-	ret = clk_prepare_enable(tdma->dma_clk);
-	if (ret < 0) {
-		dev_err(dev, "clk_enable failed: %d\n", ret);
-		return ret;
-	}
-
-	tdma_write(tdma, TEGRA_APBDMA_GENERAL, tdma->reg_gen);
-	tdma_write(tdma, TEGRA_APBDMA_CONTROL, 0);
-	tdma_write(tdma, TEGRA_APBDMA_IRQ_MASK_SET, 0xFFFFFFFFul);
-
-	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
-		struct tegra_dma_channel *tdc = &tdma->channels[i];
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
-	}
-
-	return 0;
+	return tegra_dma_init_hw(tdma);
 }
 
 static SIMPLE_DEV_PM_OPS(tegra_dma_dev_pm_ops, tegra_dma_dev_suspend,
-- 
2.24.0

