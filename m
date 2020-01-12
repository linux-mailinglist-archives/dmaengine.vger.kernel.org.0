Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1FD138782
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jan 2020 18:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733155AbgALRbf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Jan 2020 12:31:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43665 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733128AbgALRbe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Jan 2020 12:31:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id 9so5146929lfq.10;
        Sun, 12 Jan 2020 09:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YZYwRmQjEuEhcnI0jgHwdUL+48TsLbPTNE42sZnH8KA=;
        b=ckRx/zjIZyskvdQZRC0uBXbbt+Ys2YUI3OO9lw5CwxdJWiLPm76MKQqDhKCJWxH6Hl
         d0BJUTrk5IRxhv8nJOVpdXr5k5rwBcP7vQVxxw+AR6aHulFIfrUD/N0NqUxqNGo+CuXJ
         wYo8lsavKh4je+iICNhBJk6VEreyU/ppWAkQ4X0akPyUAvB+9uaOchchcFYfLcgE3seR
         e1RmZnxMpUUY4fIO/k+Fijz/lGRM9LWEfJv56mSwwCzYSnu/8OcC/kQoEsMAd63KdE0E
         RLbbr3NPN5Ek079wEGCDYlOpvgLIl5HfTRikLXwQfdyUtWCWeClNe6C7gYD5QPQZrFHc
         ykZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YZYwRmQjEuEhcnI0jgHwdUL+48TsLbPTNE42sZnH8KA=;
        b=GZ5FjdpnN//gmFdEbLJbDw/duSEXZ32zqIq6goD82RbZYKgn13zQGZKOOHXgXUkLzn
         4r1Lmh9CNkgsrhaDj6ZUSJMh7bKGasJPOLiZNoQzkdSDN9v8IxdvQkHYs+exsfNjLP5h
         RLXcKvBOV+G81E0Xql0QjaQQGSf6sBt7dgU0ej6GTUZJj1TcnKT9sGFJqw2JA/HZiY96
         x1bTLHnfKqDJFJb1yow+TJ7ATlW9ZY/c2lBr0ib+/JCUjxaybrxSOpGW1JfYf7oIN6Ro
         PkrYVdF8livFu/degCk8fKTmnzowVN4aiMTFnxXX/FUkzkqxUxeIZY8a6KK8GHSr6hX2
         K5KQ==
X-Gm-Message-State: APjAAAXe60boflwcwnL+S/asc8XmvN8oXL71k5o4VJhONmqBRCXMeybo
        cpahet1ll8643wlKbc5PMXY=
X-Google-Smtp-Source: APXvYqx3xJWT8cwcFcD+VawFDN2Xc/5qx/EW3kcM1KdqLFEkUAUMNCjpXGaFWhimLvssZ0FkFiehVg==
X-Received: by 2002:a19:3f51:: with SMTP id m78mr7482701lfa.70.1578850292504;
        Sun, 12 Jan 2020 09:31:32 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id 140sm4458888lfk.78.2020.01.12.09.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:31:32 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/14] dmaengine: tegra-apb: Clean up tasklet releasing
Date:   Sun, 12 Jan 2020 20:29:56 +0300
Message-Id: <20200112173006.29863-5-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200112173006.29863-1-digetx@gmail.com>
References: <20200112173006.29863-1-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 24ad3a5a04e3..1b8a11804962 100644
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

