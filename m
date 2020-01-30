Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B0514D5CB
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 05:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbgA3Elx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 23:41:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37414 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgA3El1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 23:41:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so2342827wru.4;
        Wed, 29 Jan 2020 20:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yq76FFCFim3K8AS/11AGvEBu3mubDIdosfsDUsVHNUU=;
        b=gkf2eEaCL5bO5zFxkHVKiYlv2MmOEo4GD5wBm/h0rqxrG7amsWkflnYD3+u5jRIBxV
         rqjvpk8qzbHBcn1rx3hsY6FiPoir0FsorCGpXkXB9T1sbD3DuMdJZNPCoAaXROzpavKI
         QqiFD6sbt2weIZFrPskVEnqZyXlgn7fcZU8a8ndQi+VwdSPgbbeEv3pshMph+xGbEdgG
         2oTsJZrGbvHxhiFmhAfBx/JffHIJbNaZX29lY4Qq4Ky7B1JfSWIrko5THdiRPWzUfQgw
         TgTa46Lj8BEfRr4jgU2lMKqObRZW7ajIjlK5XhYlRq9qM21Qw9NzRkEemud2bTtJoVQR
         ZMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yq76FFCFim3K8AS/11AGvEBu3mubDIdosfsDUsVHNUU=;
        b=V+laC4C150cBfosZyAGCGBRX2w91G6KmRVQuk6SRFiYzrFRqw+n9dF2m8KUyXyzKGN
         9e9VtMZnCq1b885iaZzf6EJ6/uyksuv/fXzMG6UWrYgk3pnUyYhwdjgKLjKZOs5ve1U/
         XL2IhO6vcUi2yxzAYM3p4Ko1guHlDSuHKxWshEX3ak/11ZVYmvcJ/hx/w+WjvDQnIiRU
         Q8uI/p2jFDtrzgn0Yn3E8hBvD80+LNDAAJ74wPJwCJ9id0z0Msz/vMAS9a/XySWkIqTE
         BOnl+vcJI/dYWUkNPzfW9BXeu1OFsxRvhq55ZHjBJZIW6DVIPEAGpAA0QObhyD0Nr1Qu
         7Pcw==
X-Gm-Message-State: APjAAAXWXv/UDmuSVwkgUZb6y+c6tdN/VzrTSAF6IhojSrzyp+DuJDL6
        1OSXiu75A/AUeVVeifAMB56K5uq0
X-Google-Smtp-Source: APXvYqxbXRxOkLoB7KX9nCo0eqSmtpJurfdPC+F40E41HfrNe6G5MPJ/brnw+2VZLmw4IG43EHONug==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr2697887wrm.131.1580359284346;
        Wed, 29 Jan 2020 20:41:24 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g128sm4494672wme.47.2020.01.29.20.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 20:41:23 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/16] dmaengine: tegra-apb: Keep clock enabled only during of DMA transfer
Date:   Thu, 30 Jan 2020 07:37:59 +0300
Message-Id: <20200130043804.32243-12-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130043804.32243-1-digetx@gmail.com>
References: <20200130043804.32243-1-digetx@gmail.com>
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
 drivers/dma/tegra20-apb-dma.c | 47 ++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 22b88ccff05d..0ee28d8e3c96 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -436,6 +436,8 @@ static void tegra_dma_stop(struct tegra_dma_channel *tdc)
 		tdc_write(tdc, TEGRA_APBDMA_CHAN_STATUS, status);
 	}
 	tdc->busy = false;
+
+	pm_runtime_put(tdc->tdma->dev);
 }
 
 static void tegra_dma_start(struct tegra_dma_channel *tdc,
@@ -500,18 +502,25 @@ static void tegra_dma_configure_for_next(struct tegra_dma_channel *tdc,
 	tegra_dma_resume(tdc);
 }
 
-static void tdc_start_head_req(struct tegra_dma_channel *tdc)
+static bool tdc_start_head_req(struct tegra_dma_channel *tdc)
 {
 	struct tegra_dma_sg_req *sg_req;
+	int err;
 
 	if (list_empty(&tdc->pending_sg_req))
-		return;
+		return false;
+
+	err = pm_runtime_get_sync(tdc->tdma->dev);
+	if (WARN_ON_ONCE(err < 0))
+		return false;
 
 	sg_req = list_first_entry(&tdc->pending_sg_req, typeof(*sg_req), node);
 	tegra_dma_start(tdc, sg_req);
 	sg_req->configured = true;
 	sg_req->words_xferred = 0;
 	tdc->busy = true;
+
+	return true;
 }
 
 static void tdc_configure_next_head_desc(struct tegra_dma_channel *tdc)
@@ -615,6 +624,8 @@ static void handle_once_dma_done(struct tegra_dma_channel *tdc,
 	}
 	list_add_tail(&sgreq->node, &tdc->free_sg_req);
 
+	pm_runtime_put(tdc->tdma->dev);
+
 	/* Do not start DMA if it is going to be terminate */
 	if (to_terminate || list_empty(&tdc->pending_sg_req))
 		return;
@@ -730,9 +741,7 @@ static void tegra_dma_issue_pending(struct dma_chan *dc)
 		dev_err(tdc2dev(tdc), "No DMA request\n");
 		goto end;
 	}
-	if (!tdc->busy) {
-		tdc_start_head_req(tdc);
-
+	if (!tdc->busy && tdc_start_head_req(tdc)) {
 		/* Continuous single mode: Configure next req */
 		if (tdc->cyclic) {
 			/*
@@ -775,6 +784,13 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
 	else
 		wcount = status;
 
+	/*
+	 * tegra_dma_stop() will drop the RPM's usage refcount, but
+	 * tegra_dma_resume() touches hardware and thus we should keep
+	 * the DMA clock active while it's needed.
+	 */
+	pm_runtime_get(tdc->tdma->dev);
+
 	was_busy = tdc->busy;
 	tegra_dma_stop(tdc);
 
@@ -786,6 +802,8 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
 	}
 	tegra_dma_resume(tdc);
 
+	pm_runtime_put(tdc->tdma->dev);
+
 skip_dma_stop:
 	tegra_dma_abort_all(tdc);
 
@@ -1280,22 +1298,15 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr,
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
@@ -1328,7 +1339,6 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 		list_del(&sg_req->node);
 		kfree(sg_req);
 	}
-	pm_runtime_put(tdma->dev);
 
 	tdc->slave_id = TEGRA_APBDMA_SLAVE_ID_INVALID;
 }
@@ -1428,6 +1438,11 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 	spin_lock_init(&tdma->global_lock);
 
+	ret = clk_prepare(tdma->dma_clk);
+	if (ret)
+		return ret;
+
+	pm_runtime_irq_safe(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_get_sync(&pdev->dev);
@@ -1543,6 +1558,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
+	clk_unprepare(tdma->dma_clk);
 
 	return ret;
 }
@@ -1553,6 +1569,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
 
 	dma_async_device_unregister(&tdma->dma_dev);
 	pm_runtime_disable(&pdev->dev);
+	clk_unprepare(tdma->dma_clk);
 
 	return 0;
 }
@@ -1581,7 +1598,7 @@ static int tegra_dma_runtime_suspend(struct device *dev)
 						  TEGRA_APBDMA_CHAN_WCOUNT);
 	}
 
-	clk_disable_unprepare(tdma->dma_clk);
+	clk_disable(tdma->dma_clk);
 
 	return 0;
 }
@@ -1592,7 +1609,7 @@ static int tegra_dma_runtime_resume(struct device *dev)
 	unsigned int i;
 	int ret;
 
-	ret = clk_prepare_enable(tdma->dma_clk);
+	ret = clk_enable(tdma->dma_clk);
 	if (ret < 0) {
 		dev_err(dev, "clk_enable failed: %d\n", ret);
 		return ret;
-- 
2.24.0

