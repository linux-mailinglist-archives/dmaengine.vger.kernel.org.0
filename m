Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED24714FF99
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2020 23:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgBBW34 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 17:29:56 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33009 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbgBBW3z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Feb 2020 17:29:55 -0500
Received: by mail-lf1-f67.google.com with SMTP id n25so8399873lfl.0;
        Sun, 02 Feb 2020 14:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GC/z2ZWZ2YFoOCLaKR682od65UK+N/gvRCg6ifsNRc4=;
        b=fCKGiLwny+rl/sC22taBWekzseGF3PfRzLzxP0yqdXO8SkO/sQFCcvL6Ov7YzP7OEH
         RWk+ESSb/Qw06cqsMpv4prFkk1fzCGnL3jZRyx5HIgDjqXkQH2s+hLaZj3x/REwim6pz
         QzePOZYIGDhZ0PQMeVEJMOCk4jVe967C1oX37qX7vmCBXg+ofKnRhlbDL9eAM0mMpi5D
         fAGWS5ap5qBJ4vga8aTWLwFG+cXwr9LtHH1BoYxQey7CgWoSbFSj9tjF1BBI/OckrJgI
         8DW9XWfxNXVeERKeWeKPr9tJXlSVlSXiUSpXLH0lI3dbk4AKKq1OW4lk/El7nAmAOxCD
         4Wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GC/z2ZWZ2YFoOCLaKR682od65UK+N/gvRCg6ifsNRc4=;
        b=Vb75NJJwzuW57lBwE5S21AQ1j7SwXhJXUNAb3vXvvdMlVqpUa4sRgNLRJKPCleWNv4
         8EwQy8fUPpIp2RdSNJTJYBzSAlHm3s+kbLcfp253lbNCbd2QsYH7uSbdlxsXJnhzJPCf
         VuctUi4dI1ZnJqo/fBmfxfOsC1SOZwmTuSTP8M8uGza5bHmVxAVQdl4rTCYi5IQ9rPUu
         PI9g1icnvX7kY6Ntjl1JrSHWrKxWsSqRNBpVXCwh/gIKxTKQjrtUN/Ur4IW6+JQJVhI2
         BMLW4Va8darktCv5T5wzp94ZMDIWdJqDIdQA4BOdFpzvCj+BesXpiW3tD2wdY0G+1hzJ
         c22w==
X-Gm-Message-State: APjAAAW5AY4KbecGgRNa0uFkz/vBDAUBAOF64d7JK7nB//1PHqCqKzTF
        jB/sr3bB/WPIYniizg8x94w=
X-Google-Smtp-Source: APXvYqyejqLOO2Cz7Nqf8FE0ab5NsMxMcHsODdW3rSsA7pZGAsTDRHR+3MILxRjru071EEBvjHe+jw==
X-Received: by 2002:a19:23d0:: with SMTP id j199mr2642264lfj.137.1580682593041;
        Sun, 02 Feb 2020 14:29:53 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id b190sm8050307lfd.39.2020.02.02.14.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:29:52 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 05/19] dmaengine: tegra-apb: Clean up tasklet releasing
Date:   Mon,  3 Feb 2020 01:28:40 +0300
Message-Id: <20200202222854.18409-6-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202222854.18409-1-digetx@gmail.com>
References: <20200202222854.18409-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no need to kill tasklet when driver's probe fails because tasklet
can't be scheduled at this time. It is also cleaner to kill tasklet on
channel's freeing rather than to kill it on driver's removal, otherwise
tasklet could perform a dummy execution after channel's releasing, which
isn't very nice.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 766c2c9eac8e..aafad50d075e 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1287,7 +1287,6 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 	struct tegra_dma_sg_req *sg_req;
 	struct list_head dma_desc_list;
 	struct list_head sg_req_list;
-	unsigned long flags;
 
 	INIT_LIST_HEAD(&dma_desc_list);
 	INIT_LIST_HEAD(&sg_req_list);
@@ -1295,15 +1294,14 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 	dev_dbg(tdc2dev(tdc), "Freeing channel %d\n", tdc->id);
 
 	tegra_dma_terminate_all(dc);
+	tasklet_kill(&tdc->tasklet);
 
-	spin_lock_irqsave(&tdc->lock, flags);
 	list_splice_init(&tdc->pending_sg_req, &sg_req_list);
 	list_splice_init(&tdc->free_sg_req, &sg_req_list);
 	list_splice_init(&tdc->free_dma_desc, &dma_desc_list);
 	INIT_LIST_HEAD(&tdc->cb_desc);
 	tdc->config_init = false;
 	tdc->isr_handler = NULL;
-	spin_unlock_irqrestore(&tdc->lock, flags);
 
 	while (!list_empty(&dma_desc_list)) {
 		dma_desc = list_first_entry(&dma_desc_list,
@@ -1542,7 +1540,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
 
 		free_irq(tdc->irq, tdc);
-		tasklet_kill(&tdc->tasklet);
 	}
 
 	pm_runtime_disable(&pdev->dev);
@@ -1562,7 +1559,6 @@ static int tegra_dma_remove(struct platform_device *pdev)
 	for (i = 0; i < tdma->chip_data->nr_channels; ++i) {
 		tdc = &tdma->channels[i];
 		free_irq(tdc->irq, tdc);
-		tasklet_kill(&tdc->tasklet);
 	}
 
 	pm_runtime_disable(&pdev->dev);
-- 
2.24.0

