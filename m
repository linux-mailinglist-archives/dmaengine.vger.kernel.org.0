Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D861C138767
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jan 2020 18:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbgALRbm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Jan 2020 12:31:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46463 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733174AbgALRbl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Jan 2020 12:31:41 -0500
Received: by mail-lf1-f65.google.com with SMTP id f15so5136489lfl.13;
        Sun, 12 Jan 2020 09:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8T/zq5k/xWPMO4gCZc/axjNKMU4ysMZUwvQwsO3s7lU=;
        b=nzMS7xiELnwrC8S+rO6OwRanLi/RFr9g1XZEwPJpoVaI4UfuY16Q9/Dhn+yXM+kBsS
         TZYpuyN0si52MiuS4t4ibQZVv9nJzJEXv6f9yjzXymwe4cGg2lUVLvs9wycFVw7t/TIv
         cEneEoD+d6/53Yq5BjrK1JoZw+t1DhNL8O2SNI6w9BPuMgqSM0DcmspGZNBY4o/IvbPU
         snfVf/MRdkwsArKsV3HzzwYettfs2zTUDqDf1DJ7AXRZx3ZbsEu1P2aHQtLehAB1cWWL
         sT2d70ut9QtHokunCaVgI9TRxJpbt3Uv+81NA2g3QL81AQJhKDMuKrkRfollmzbt5aSA
         UC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8T/zq5k/xWPMO4gCZc/axjNKMU4ysMZUwvQwsO3s7lU=;
        b=T6AFgVCNUInas8ghs+PH5HYeadT8VY+qFnK9VtIM9MjSUnOr7jeIFv+rRluPPZFrIm
         iTzdDLXujatqEZ8XwuDpj8sXCTO2UE3KlsVlatPKmaEZr8KDaIX+C6T6NNqB/1wchK1C
         +qAEY3Mt+F4Q0/7moLgbegGikOnLpCPXejATJAbuRTzshj5BwNu/qXIGZBXEDA68QS1U
         CNy7iH9EH+VmZXbRVQdWhtHVhd73OTRu/fBQuz8A6CKAmtMFUuOaS1ZBPtYAx55/jcL2
         2PXxDKs92fCnpOjh8HovsfeWJ76Hs9qhJWUKpZ+cm8QzHokpLU27QrXjhiZCovn4H76i
         m3Hg==
X-Gm-Message-State: APjAAAXeV3UQxRD+NqXweiHtNS4ShPqtP/sfEFbmAu4w+l2N7Ria3UMB
        Bx+23A0D06Tph9T3rJexFEk=
X-Google-Smtp-Source: APXvYqxtZU95wXTpbI1wV4FBPEm3KU78F4c3msKWGsp3QrpwtRBMXBbsPs0jdzeHOWNO0ztRYYUA0w==
X-Received: by 2002:a19:5013:: with SMTP id e19mr7887769lfb.8.1578850297944;
        Sun, 12 Jan 2020 09:31:37 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id 140sm4458888lfk.78.2020.01.12.09.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:31:37 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/14] dmaengine: tegra-apb: Keep clock enabled only during of DMA transfer
Date:   Sun, 12 Jan 2020 20:30:02 +0300
Message-Id: <20200112173006.29863-11-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200112173006.29863-1-digetx@gmail.com>
References: <20200112173006.29863-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's a bit impractical to enable hardware's clock at the time of DMA
channel's allocation because most of DMA client drivers allocate DMA
channel at the time of the driver's probing and thus DMA clock is kept
always-enabled in practice, defeating the whole purpose of runtime PM.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 43 ++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index cc4a9ca20780..b9d8e57eaf54 100644
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
@@ -1280,22 +1289,15 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr,
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
@@ -1328,7 +1330,6 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 		list_del(&sg_req->node);
 		kfree(sg_req);
 	}
-	pm_runtime_put(tdma->dev);
 
 	tdc->slave_id = TEGRA_APBDMA_SLAVE_ID_INVALID;
 }
@@ -1428,11 +1429,16 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 	spin_lock_init(&tdma->global_lock);
 
+	ret = clk_prepare(tdma->dma_clk);
+	if (ret)
+		return ret;
+
+	pm_runtime_irq_safe(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = tegra_dma_runtime_resume(&pdev->dev);
 		if (ret)
-			return ret;
+			goto err_clk_unprepare;
 	} else {
 		ret = pm_runtime_get_sync(&pdev->dev);
 		if (ret < 0)
@@ -1552,6 +1558,9 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	else
 		pm_runtime_disable(&pdev->dev);
 
+err_clk_unprepare:
+	clk_unprepare(tdma->dma_clk);
+
 	return ret;
 }
 
@@ -1566,6 +1575,8 @@ static int tegra_dma_remove(struct platform_device *pdev)
 	else
 		pm_runtime_disable(&pdev->dev);
 
+	clk_unprepare(tdma->dma_clk);
+
 	return 0;
 }
 
@@ -1593,7 +1604,7 @@ static int tegra_dma_runtime_suspend(struct device *dev)
 						  TEGRA_APBDMA_CHAN_WCOUNT);
 	}
 
-	clk_disable_unprepare(tdma->dma_clk);
+	clk_disable(tdma->dma_clk);
 
 	return 0;
 }
@@ -1604,7 +1615,7 @@ static int tegra_dma_runtime_resume(struct device *dev)
 	unsigned int i;
 	int ret;
 
-	ret = clk_prepare_enable(tdma->dma_clk);
+	ret = clk_enable(tdma->dma_clk);
 	if (ret < 0) {
 		dev_err(dev, "clk_enable failed: %d\n", ret);
 		return ret;
-- 
2.24.0

