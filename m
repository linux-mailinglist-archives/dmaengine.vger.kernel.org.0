Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E706156B7D
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2020 17:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgBIQlc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Feb 2020 11:41:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46673 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgBIQlb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Feb 2020 11:41:31 -0500
Received: by mail-lj1-f195.google.com with SMTP id x14so4360102ljd.13;
        Sun, 09 Feb 2020 08:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVFUklfHD48WiyaHqn5Vu2aXZlgCxqhFWuMeCStOnrY=;
        b=cK7VAG/LNChw2Yh22dWPK+/4bC+Q30JkkGuLZujOfP40FmzJ+IBLn4X9QOacjFsxdi
         MZO8cRi5D9fyQHthGnOhzA0W4u5HHBcg9PClXTvBkcXJfVHONEzHOPqY+ozYBm2GczGa
         Q8wgWww8PgVLc4WJLDNOpSCqDEVxxItiJ/wsT/AuNI8dt3xZG3qWwNQ/811H4vPX6SQS
         rhaO/iA9PNelKWf3VRd0GmpMYP2tlSYhiZkqo28DwCd9eb1O88CstGrByQi6EFARGVog
         VJtnL6rg0cV15tWa26gZ5xXeHRvZ7Y3EMeissGDROkSOiVTZ5SNlnrvDg/vfcyLAXO1I
         GhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVFUklfHD48WiyaHqn5Vu2aXZlgCxqhFWuMeCStOnrY=;
        b=p0fv6eTLR8VmAEVzJcVBsSargLERy80BR3QBgVbyIqP0y08dXhF4D6Dx/WpxQ0uoKq
         167J246MmscJ8zWPTmZh47yTZiLZkG2X9eOUgInYbohVE4f4yjpjUPkH43iANxHZl1HU
         6wen/oEyypiA9B3LztxvJ7Rk1qM3HnZiGZHFO/jfwchgV6m7GgxHvrcpX4Igp14jyJHg
         dW/fGr/sEN8gn6O0HRfS4g1uLKI6S0dzIeZKhfUnxto+unLA9CHp4kjbWveF+weLOOCt
         iVVdaoAmAfk09+MfQD67UiE4muhrWdH99k5xp/HhlUnTRpg4MBBLSFCAtjYTxOvM3+GU
         Pplg==
X-Gm-Message-State: APjAAAWXsXQxJDF2LSHn4lM3av7PmpbEcvkbF0DsnfbofLMX0V0umFhG
        y+KDHMSlvYiUGz0Xq7315f8=
X-Google-Smtp-Source: APXvYqxw51aDGXoQcyXUuWpGsTMkqehq6EZmr9xBTeB/1TP7NmlQ0PPnIldbXmVocWMjwg8N/X0i8w==
X-Received: by 2002:a2e:99da:: with SMTP id l26mr5395679ljj.272.1581266488104;
        Sun, 09 Feb 2020 08:41:28 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:27 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 12/19] dmaengine: tegra-apb: Keep clock enabled only during of DMA transfer
Date:   Sun,  9 Feb 2020 19:33:49 +0300
Message-Id: <20200209163356.6439-13-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
References: <20200209163356.6439-1-digetx@gmail.com>
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
 drivers/dma/tegra20-apb-dma.c | 36 ++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 049e98ae1240..6e057a9f0e46 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -569,6 +569,7 @@ static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
 	hsgreq = list_first_entry(&tdc->pending_sg_req, typeof(*hsgreq), node);
 	if (!hsgreq->configured) {
 		tegra_dma_stop(tdc);
+		pm_runtime_put(tdc->tdma->dev);
 		dev_err(tdc2dev(tdc), "Error in DMA transfer, aborting DMA\n");
 		tegra_dma_abort_all(tdc);
 		return false;
@@ -604,9 +605,14 @@ static void handle_once_dma_done(struct tegra_dma_channel *tdc,
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
 
@@ -712,6 +718,7 @@ static void tegra_dma_issue_pending(struct dma_chan *dc)
 {
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
 	unsigned long flags;
+	int err;
 
 	spin_lock_irqsave(&tdc->lock, flags);
 	if (list_empty(&tdc->pending_sg_req)) {
@@ -719,6 +726,12 @@ static void tegra_dma_issue_pending(struct dma_chan *dc)
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
@@ -774,6 +787,8 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
 	}
 	tegra_dma_resume(tdc);
 
+	pm_runtime_put(tdc->tdma->dev);
+
 skip_dma_stop:
 	tegra_dma_abort_all(tdc);
 
@@ -1268,22 +1283,15 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr,
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
@@ -1316,7 +1324,6 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 		list_del(&sg_req->node);
 		kfree(sg_req);
 	}
-	pm_runtime_put(tdma->dev);
 
 	tdc->slave_id = TEGRA_APBDMA_SLAVE_ID_INVALID;
 }
@@ -1416,6 +1423,11 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 	spin_lock_init(&tdma->global_lock);
 
+	ret = clk_prepare(tdma->dma_clk);
+	if (ret)
+		return ret;
+
+	pm_runtime_irq_safe(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_get_sync(&pdev->dev);
@@ -1531,6 +1543,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
+	clk_unprepare(tdma->dma_clk);
 
 	return ret;
 }
@@ -1541,6 +1554,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
 
 	dma_async_device_unregister(&tdma->dma_dev);
 	pm_runtime_disable(&pdev->dev);
+	clk_unprepare(tdma->dma_clk);
 
 	return 0;
 }
@@ -1569,7 +1583,7 @@ static int tegra_dma_runtime_suspend(struct device *dev)
 						  TEGRA_APBDMA_CHAN_WCOUNT);
 	}
 
-	clk_disable_unprepare(tdma->dma_clk);
+	clk_disable(tdma->dma_clk);
 
 	return 0;
 }
@@ -1580,7 +1594,7 @@ static int tegra_dma_runtime_resume(struct device *dev)
 	unsigned int i;
 	int ret;
 
-	ret = clk_prepare_enable(tdma->dma_clk);
+	ret = clk_enable(tdma->dma_clk);
 	if (ret < 0) {
 		dev_err(dev, "clk_enable failed: %d\n", ret);
 		return ret;
-- 
2.24.0

