Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474B1156B7B
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2020 17:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgBIQlc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Feb 2020 11:41:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39781 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBIQlc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Feb 2020 11:41:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id o15so4401461ljg.6;
        Sun, 09 Feb 2020 08:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PR7kND5WGCl4qe2HrJG7gultd9IUdWTi068VoCdYyos=;
        b=F6FCyvX09G5u1aWHdENuO+qUz/FONkUquowY6d5nP9d7l8AzSlTuSxbHIO9JGilBuV
         9I5J2uNiFZtHoADC4OMKFFKwL2jkbcFUALGRyiNuogLR/PmSKNkuoTNh8CHZDhMaWFgX
         FyLq4EzKIkg7I9/WDbDqHcBU/lKsRunHr9l1qYJXhkjtAkqvkLsQNLVMA7zIIQo9+JOT
         0UG4OBIxBdXX1RFCsYBMNjLLw/VW9dnpXuF4RPI3l4Dq8xa66QsJUkYwRwzeskqWqolf
         vukjbwKVSaOyv/qenvmV42lVX8c9JXdBPNSjRw44cFWTX44sOmmEfZch37GvgyR5S8Yf
         DtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PR7kND5WGCl4qe2HrJG7gultd9IUdWTi068VoCdYyos=;
        b=PeKA1ajlqUEdZ8Z960zgCSeUWJBYqq9Bdm53xF2oTqU2wbd3wDcMJRAE4klXdKNTFJ
         Kw0JU6Yc+8K295TYm9d5SD+R4JJQk02jDMgN02fFi+jqzqMmA2igaxMOCXxAra9z3hXG
         ybznOPpjSpBpS33bG2U2P9ujeIGCRna2OKxvbCFrbMgjCYWC0mkNKVZiUQv5nWDp/XAA
         8lDLM15xJztSRvTNVsEqx0NcAsuPOPXEIncI3Pw68dGJaqIvp7arsQprDrNaCvYshVr+
         DKpsai+xYWKlui4TIG0Kpk2ry345s5nWPiN4BHfa+y/QeYOmJ05E5zkGZ+LO8JK2iFlN
         Cbvg==
X-Gm-Message-State: APjAAAUhdo2YTkInTVAsfQ2+Lh7awtUOjZmWHvYy/J5I6kZB1h759mbz
        GY5etjm0xceNmJ3uHYqfEaE=
X-Google-Smtp-Source: APXvYqxYZKL4ZR71jE8AayZS1pAmRGDq7aI01IlBBNWyKuaO5Z8BJampJ7yLUfwKJLB/AUkeaMsCSA==
X-Received: by 2002:a2e:98a:: with SMTP id 132mr5559789ljj.170.1581266489020;
        Sun, 09 Feb 2020 08:41:29 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:28 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 13/19] dmaengine: tegra-apb: Clean up suspend-resume
Date:   Sun,  9 Feb 2020 19:33:50 +0300
Message-Id: <20200209163356.6439-14-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
References: <20200209163356.6439-1-digetx@gmail.com>
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
index 6e057a9f0e46..7fa0430503d4 100644
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
@@ -1386,6 +1383,36 @@ static const struct tegra_dma_chip_data tegra148_dma_chip_data = {
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
@@ -1427,25 +1454,13 @@ static int tegra_dma_probe(struct platform_device *pdev)
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
@@ -1543,6 +1558,8 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
+
+err_clk_unprepare:
 	clk_unprepare(tdma->dma_clk);
 
 	return ret;
@@ -1562,26 +1579,6 @@ static int tegra_dma_remove(struct platform_device *pdev)
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
 
@@ -1591,46 +1588,51 @@ static int tegra_dma_runtime_suspend(struct device *dev)
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

