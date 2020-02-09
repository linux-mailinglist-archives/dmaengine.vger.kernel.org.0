Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDAEA156B69
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2020 17:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgBIQlY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Feb 2020 11:41:24 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36434 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgBIQlX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Feb 2020 11:41:23 -0500
Received: by mail-lf1-f65.google.com with SMTP id f24so2495359lfh.3;
        Sun, 09 Feb 2020 08:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GC/z2ZWZ2YFoOCLaKR682od65UK+N/gvRCg6ifsNRc4=;
        b=gshb6gEhnz7BeoU0uub0aOTkPfdejG3WZ39FZtUdIuddBlIr8A8ToDXPPsSnlOCmOQ
         hUDEv0HD+AuI6dn2DN39PGEh2BxONsfdYpNhl0kk+6wIjvxhDC/dCmnUhjoY0QD6h0UP
         FhrKDjbXSpSJxtK0zRm6wSmerhom4+CJMZC7IcPgh7joFcuMJ9U3QJniwsa+dbtGq7Df
         YY0/FF6SFMYCpNvzTq2wiLUYjZKxtlhtVZuuwkPixD/874rd1HmT8t+/3mKOsdaPD59g
         Y3KWX9aD+oGc3zOxLBsuc16Q0Wl2aRxhpTyxD6773E9DbFrFxGzSfVA8BmDPnz50nNqD
         Ptjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GC/z2ZWZ2YFoOCLaKR682od65UK+N/gvRCg6ifsNRc4=;
        b=AmT4tbjqCv17XwJIjpH2FU+3SeiwObvvRTZRBHMGHjizzX3JRCkwIWCk7geN0GL9D0
         9JTaFIdAb6cJ6wguPW8m0h7VKKVMaxI4d588XdXAH5bMpr3WueJhwx4kcMfX+vR8a+gF
         PPHLYzfMonbud1FyeMJOVreFaSC2BISha+O31HHIBJ5vtL09mPLCRWZ7uInGpkFNs3s+
         KjWdVZu59iaDGLxNZr6i2/ocDCwTEL9jzYgvNEM4X5hLzFSY8wo0Kl6RGmMwl9o8GMYq
         clQjTteYgLEw9L9CeEkzyexwDkWBPzIgpsSN86ISo0K+bs4tXcUvW+sMkozLycjV6UmM
         58YA==
X-Gm-Message-State: APjAAAXGUB3Jfg4GEcE9ZgWAe/brOLK7RtkTUyxjple50d9fEgWZasAO
        MiJbq+B5rtaApvjVUdApGNk=
X-Google-Smtp-Source: APXvYqzVMCfJOVGPstddKX8Uc/ho7iF//aZ4jMvu0wfuWUGfEnP2/0UGUffxzo86ulAjSSoj3WDljQ==
X-Received: by 2002:ac2:46dc:: with SMTP id p28mr4131765lfo.23.1581266481310;
        Sun, 09 Feb 2020 08:41:21 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:20 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/19] dmaengine: tegra-apb: Clean up tasklet releasing
Date:   Sun,  9 Feb 2020 19:33:42 +0300
Message-Id: <20200209163356.6439-6-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
References: <20200209163356.6439-1-digetx@gmail.com>
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

