Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFE514FFA2
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2020 23:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgBBWaJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 17:30:09 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43156 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbgBBWaE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Feb 2020 17:30:04 -0500
Received: by mail-lf1-f66.google.com with SMTP id 9so8338535lfq.10;
        Sun, 02 Feb 2020 14:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d8axBWh0QJYGfwaPhyACM4mtObUw2JQF4mOsUMLnR20=;
        b=mJo7XMHl2rudZJvu34fqq3HMVqOKxf1zp6XD+BnLfVW2NWXEvl11CKpVxi9mJR2FDI
         LMeMEI6Kba/6p2fsuxI5gQ47z18PhpSk7DBdtqn7FbODDBDX2YkG4wf5rv6qyji4IZ+T
         c0nM+HEFCLSkAzZmwdX/rFaXhMzKx3OOgLf0+kbdRWsEVv0mZCLC8wY4gHAHnLfFVdKv
         chCVBkIkJQw2j+PAXIHeLOT/aPOFefIuaG/i7W1+JxWNjhbR0Ci+j+pOKr6UgBz1F6yV
         ouUA3DR45mfuOYSVbPVgoJlWZ2x/Kpkm28Oy1QW+4S+wKuX9t6W7WrZfAAA//JVReaOi
         ECUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8axBWh0QJYGfwaPhyACM4mtObUw2JQF4mOsUMLnR20=;
        b=nGKfUpOcpOwwNS+iwRwVvDjQ6ewvggUCUpVmlSEo6me6tfplvxRlblao7U19CbmsCa
         p3QZ4nAIZH1PhZH0k8KVdtZpgR14Hi2LoNm0lrOo9YPr1FmwU7Lqqy4iT4uMYcndUrcO
         FwYalcrwMGfZ5Ht1fFEf5Lb9sIJz/ZVWc6QPet/4VcQ+zAd8578+Sp3a7IweSVGxCFJ8
         1pLhJBqhVinRF70C0qVircbkDMop10RtB51fr7sTmDDUo3BCyQR8cEUAZSY4eXwYloVI
         05UIQjLdYpa6IfrQVQKGH38F4xuHfcnkN34KW0+mTKBs64S/5ubRrbfz4hBsg/MeA2b/
         7VYw==
X-Gm-Message-State: APjAAAX1BFLTijFFa6WgxgGnqPiVi2gQ4P5wwIepwSqDdDjnizpeoaFy
        kl8fnc2ThzgMEBK3US58wzte4Z1y
X-Google-Smtp-Source: APXvYqxnaHFQS6Cw7gGkhSyAzjOpLyRlEfQbQ19ZEWOskMQEuavOGKkcAgI3KZX5fGTGK2cTkTr4fA==
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr10513270lfp.162.1580682601837;
        Sun, 02 Feb 2020 14:30:01 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id b190sm8050307lfd.39.2020.02.02.14.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:30:01 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 14/19] dmaengine: tegra-apb: Keep clock enabled only during of DMA transfer
Date:   Mon,  3 Feb 2020 01:28:49 +0300
Message-Id: <20200202222854.18409-15-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202222854.18409-1-digetx@gmail.com>
References: <20200202222854.18409-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's a bit impractical to enable hardware's clock at the time of DMA
channel's allocation because most of DMA client drivers allocate DMA
channel at the time of the driver's probing, and thus, DMA clock is kept
always-enabled in practice, defeating the whole purpose of runtime PM.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 50abce608318..92535b962e64 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -605,9 +605,14 @@ static void handle_once_dma_done(struct tegra_dma_channel *tdc,
 	list_add_tail(&sgreq->node, &tdc->free_sg_req);
 
 	/* Do not start DMA if it is going to be terminate */
-	if (to_terminate || list_empty(&tdc->pending_sg_req))
+	if (to_terminate)
 		return;
 
+	if (list_empty(&tdc->pending_sg_req)) {
+		pm_runtime_put(tdc->tdma->dev);
+		return;
+	}
+
 	tdc_start_head_req(tdc);
 }
 
@@ -713,6 +718,7 @@ static void tegra_dma_issue_pending(struct dma_chan *dc)
 {
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
 	unsigned long flags;
+	int err;
 
 	spin_lock_irqsave(&tdc->lock, flags);
 	if (list_empty(&tdc->pending_sg_req)) {
@@ -720,6 +726,12 @@ static void tegra_dma_issue_pending(struct dma_chan *dc)
 		goto end;
 	}
 	if (!tdc->busy) {
+		err = pm_runtime_get_sync(tdc->tdma->dev);
+		if (err < 0) {
+			dev_err(tdc2dev(tdc), "Failed to enable DMA\n");
+			goto end;
+		}
+
 		tdc_start_head_req(tdc);
 
 		/* Continuous single mode: Configure next req */
@@ -778,6 +790,8 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
 	}
 	tegra_dma_resume(tdc);
 
+	pm_runtime_put(tdc->tdma->dev);
+
 skip_dma_stop:
 	tegra_dma_abort_all(tdc);
 
@@ -1272,22 +1286,15 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr,
 static int tegra_dma_alloc_chan_resources(struct dma_chan *dc)
 {
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
-	struct tegra_dma *tdma = tdc->tdma;
-	int ret;
 
 	dma_cookie_init(&tdc->dma_chan);
 
-	ret = pm_runtime_get_sync(tdma->dev);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
 static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 {
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
-	struct tegra_dma *tdma = tdc->tdma;
 	struct tegra_dma_desc *dma_desc;
 	struct tegra_dma_sg_req *sg_req;
 	struct list_head dma_desc_list;
@@ -1320,7 +1327,6 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 		list_del(&sg_req->node);
 		kfree(sg_req);
 	}
-	pm_runtime_put(tdma->dev);
 
 	tdc->slave_id = TEGRA_APBDMA_SLAVE_ID_INVALID;
 }
@@ -1420,6 +1426,11 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 	spin_lock_init(&tdma->global_lock);
 
+	ret = clk_prepare(tdma->dma_clk);
+	if (ret)
+		return ret;
+
+	pm_runtime_irq_safe(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_get_sync(&pdev->dev);
@@ -1535,6 +1546,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
+	clk_unprepare(tdma->dma_clk);
 
 	return ret;
 }
@@ -1545,6 +1557,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
 
 	dma_async_device_unregister(&tdma->dma_dev);
 	pm_runtime_disable(&pdev->dev);
+	clk_unprepare(tdma->dma_clk);
 
 	return 0;
 }
@@ -1573,7 +1586,7 @@ static int tegra_dma_runtime_suspend(struct device *dev)
 						  TEGRA_APBDMA_CHAN_WCOUNT);
 	}
 
-	clk_disable_unprepare(tdma->dma_clk);
+	clk_disable(tdma->dma_clk);
 
 	return 0;
 }
@@ -1584,7 +1597,7 @@ static int tegra_dma_runtime_resume(struct device *dev)
 	unsigned int i;
 	int ret;
 
-	ret = clk_prepare_enable(tdma->dma_clk);
+	ret = clk_enable(tdma->dma_clk);
 	if (ret < 0) {
 		dev_err(dev, "clk_enable failed: %d\n", ret);
 		return ret;
-- 
2.24.0

