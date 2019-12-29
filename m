Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2B6712C2EC
	for <lists+dmaengine@lfdr.de>; Sun, 29 Dec 2019 15:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfL2O5G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Dec 2019 09:57:06 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46661 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfL2O4z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 Dec 2019 09:56:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id m26so28649474ljc.13;
        Sun, 29 Dec 2019 06:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zJ3tlxXbP7QQrpYAm8owyCW2cUGn+abpGH2dAN9Fzyw=;
        b=gZ8ytL+mcaooqdmrm1bj3UsjEMUuUVDvQz9DLLpFYZkpL90JfK9uzZ0iEEob3i9mDB
         ZQcZqAD7tlN308LPeOeu0/ZrowhHasmlyLziSMLVfyiFTteanIuTpjKnxnZ4DadL+Tg5
         b0yv53lSJEiOASG86LNCpcB8lTpwMvbCEUkJMMvjQP166ekpfnj4w1ZRdjMBx+8wUjLH
         5sSJD+cDm5cfPMhF8bvxHQBirj9M/5AyEqIk/wv6GVqorotsf+/3yjBHr5g0H8oLWgo0
         g6ROPpF7KqzgFjXjR2Rull67cMxy7hv7Pt33yY6qrGM0f8tczxZtVEH6lYkuhHTA7di/
         Zhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zJ3tlxXbP7QQrpYAm8owyCW2cUGn+abpGH2dAN9Fzyw=;
        b=fh5f9bLYBykM6dTArhbqWDQeLVU1v+c9/ib5BaLrwyRquKzGLQ40XRoMNquckmZkSK
         vJAv6sDv1R0+2Jobb8NFX7Cg8Ot4u0taSjUTK1Iy7b+VLOGJLbBxGyENLjAmp5Svgcy8
         k47rmp5bKTu2U9o9UBWXJ5hu7brO1RXo0Xtx30lBfV2vMrANnbKQH7xTDRQhchSzwEah
         bdc7fvQy+Ts/MSqb1lJEu/SENuOe9T0Yjop8NEtCg+RTTZrjz1tOSRLkogtZ1C0cA1fY
         jCuoA+6JMHwIMdvy8nRAxiNNyjcBibU9aCTOUk7emCdYKmHibnUd6fOimXNbwTFovwAk
         a1Mw==
X-Gm-Message-State: APjAAAWTKME1wh5XlwLixr5RLV+y83sC5wKO76+SzNLidiNUeoY5wIuq
        ghNYLarnMmOI+X8Hi8UYCeQ=
X-Google-Smtp-Source: APXvYqwJwNjTQqKM+OwLDqUp9P0VvQ6Ys3gDT+6yqZc7Em4DuJDUrrgU0OhhzazYvCCbl/x+e3tFUA==
X-Received: by 2002:a2e:9248:: with SMTP id v8mr28855098ljg.189.1577631412560;
        Sun, 29 Dec 2019 06:56:52 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm11563944ljl.10.2019.12.29.06.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 06:56:52 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/12] dmaengine: tegra-apb: Clean up suspend-resume
Date:   Sun, 29 Dec 2019 17:55:22 +0300
Message-Id: <20191229145525.533-10-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191229145525.533-1-digetx@gmail.com>
References: <20191229145525.533-1-digetx@gmail.com>
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
index f52feca05f09..ad54a55e2f24 100644
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
@@ -1383,6 +1380,40 @@ static const struct tegra_dma_chip_data tegra148_dma_chip_data = {
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
@@ -1463,19 +1494,9 @@ static int tegra_dma_probe(struct platform_device *pdev)
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
@@ -1509,7 +1530,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev,
 			"Tegra20 APB DMA driver registration failed %d\n", ret);
-		goto err_clk_disable;
+		goto err_deinit_hw;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node,
@@ -1528,8 +1549,8 @@ static int tegra_dma_probe(struct platform_device *pdev)
 err_unregister_dma_dev:
 	dma_async_device_unregister(&tdma->dma_dev);
 
-err_clk_disable:
-	clk_disable_unprepare(tdma->dma_clk);
+err_deinit_hw:
+	tegra_dma_deinit_hw(tdma);
 
 	return ret;
 }
@@ -1539,7 +1560,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
 	struct tegra_dma *tdma = platform_get_drvdata(pdev);
 
 	dma_async_device_unregister(&tdma->dma_dev);
-	clk_disable_unprepare(tdma->dma_clk);
+	tegra_dma_deinit_hw(tdma);
 
 	return 0;
 }
@@ -1547,28 +1568,26 @@ static int tegra_dma_remove(struct platform_device *pdev)
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
@@ -1576,39 +1595,8 @@ static int __maybe_unused tegra_dma_dev_suspend(struct device *dev)
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

